// Copyright 2021 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// Samuel Riedel  <sriedel@iis.ee.ethz.ch>

`include "common_cells/registers.svh"

/// An actual cache lookup.
module snitch_icache_lookup_serial #(
  parameter snitch_icache_pkg::config_t CFG = '0,
  /// Configuration input types for SRAMs used in implementation.
  parameter type sram_cfg_data_t  = logic,
  parameter type sram_cfg_tag_t   = logic
)(
  input  logic                       clk_i,
  input  logic                       rst_ni,

  input  logic                       flush_valid_i,
  output logic                       flush_ready_o,

  input  logic [CFG.FETCH_AW-1:0]    in_addr_i,
  input  logic [CFG.ID_WIDTH-1:0]    in_id_i,
  input  logic                       in_valid_i,
  output logic                       in_ready_o,

  output logic [CFG.FETCH_AW-1:0]    out_addr_o,
  output logic [CFG.ID_WIDTH-1:0]    out_id_o,
  output logic [CFG.SET_ALIGN-1:0]   out_set_o,
  output logic                       out_hit_o,
  output logic [CFG.LINE_WIDTH-1:0]  out_data_o,
  output logic                       out_error_o,
  output logic                       out_valid_o,
  input  logic                       out_ready_i,

  input  logic [CFG.COUNT_ALIGN-1:0] write_addr_i,
  input  logic [CFG.SET_ALIGN-1:0]   write_set_i,
  input  logic [CFG.LINE_WIDTH-1:0]  write_data_i,
  input  logic [CFG.TAG_WIDTH-1:0]   write_tag_i,
  input  logic                       write_error_i,
  input  logic                       write_valid_i,
  output logic                       write_ready_o,

  input  sram_cfg_data_t  sram_cfg_data_i,
  input  sram_cfg_tag_t   sram_cfg_tag_i
);

  localparam int unsigned DataAddrWidth = $clog2(CFG.SET_COUNT) + CFG.COUNT_ALIGN;

`ifndef SYNTHESIS
  initial assert(CFG != '0);
`endif

  logic [CFG.COUNT_ALIGN:0] init_count_q;
  logic                     init_phase;

  // We are always ready to flush
  assign flush_ready_o = 1'b1;
  assign init_phase = init_count_q != $unsigned(CFG.LINE_COUNT);
  // Initialization and flush FSM
  always_ff @(posedge clk_i, negedge rst_ni) begin
    if (!rst_ni)
      init_count_q <= '0;
    else if (init_count_q != $unsigned(CFG.LINE_COUNT))
      init_count_q <= init_count_q + 1;
    else if (flush_valid_i)
      init_count_q <= '0;
  end

  // --------------------------------------------------
  // Tag stage
  // --------------------------------------------------
  typedef struct packed {
    logic [CFG.FETCH_AW-1:0] addr;
    logic [CFG.ID_WIDTH-1:0] id;
  } tag_req_t;

  typedef struct packed {
    logic [CFG.SET_ALIGN-1:0] cset;
    logic                     hit;
    logic                     error;
  } tag_rsp_t;

  logic                       req_valid, req_ready;
  logic                       req_handshake;

  logic [CFG.COUNT_ALIGN-1:0] tag_addr;
  logic [CFG.SET_COUNT-1:0]   tag_enable;
  logic [CFG.TAG_WIDTH+1:0]   tag_wdata, tag_rdata [CFG.SET_COUNT];
  logic                       tag_write;

  tag_req_t                   tag_req_d, tag_req_q;
  tag_rsp_t                   tag_rsp_s, tag_rsp_d, tag_rsp_q, tag_rsp;
  logic                       tag_valid, tag_ready;
  logic                       tag_handshake;

  logic [CFG.TAG_WIDTH-1:0]   required_tag;
  logic [CFG.SET_COUNT-1:0]   line_hit;

  logic [DataAddrWidth-1:0]   lookup_addr;
  logic [DataAddrWidth-1:0]   write_addr;

  // Connect input requests to tag stage
  assign tag_req_d.addr = in_addr_i;
  assign tag_req_d.id   = in_id_i;

  // Multiplex read and write access to the tag banks onto one port, prioritizing write accesses
  always_comb begin
    tag_addr   = in_addr_i[CFG.LINE_ALIGN +: CFG.COUNT_ALIGN];
    tag_enable = '0;
    tag_wdata  = {1'b1, write_error_i, write_tag_i};
    tag_write  = 1'b0;

    write_ready_o = 1'b0;
    in_ready_o    = 1'b0;
    req_valid     = 1'b0;

    if (init_phase) begin
      tag_addr   = init_count_q;
      tag_enable = '1;
      tag_wdata  = '0;
      tag_write  = 1'b1;
    end else if (write_valid_i) begin
      // Write a refill request
      tag_addr      = write_addr_i;
      tag_enable    = $unsigned(1 << write_set_i);
      tag_write     = 1'b1;
      write_ready_o = 1'b1;
    end else if (in_valid_i) begin
      // Check cache
      tag_enable = '1;
      in_ready_o = req_ready;
      // Request to store data in pipeline
      req_valid  = 1'b1;
    end
  end

  // Instantiate the tag sets.
  if (CFG.L1_TAG_SCM) begin : gen_scm
    for (genvar i = 0; i < CFG.SET_COUNT; i++) begin : g_sets
      register_file_1r_1w #(
        .ADDR_WIDTH ($clog2(CFG.LINE_COUNT)),
        .DATA_WIDTH (CFG.TAG_WIDTH+2       )
      ) i_tag (
        .clk         ( clk_i                       ),
        .ReadEnable  ( tag_enable[i] && !tag_write ),
        .ReadAddr    ( tag_addr                    ),
        .ReadData    ( tag_rdata[i]                ),
        .WriteEnable ( tag_enable[i] && tag_write  ),
        .WriteAddr   ( tag_addr                    ),
        .WriteData   ( tag_wdata                   )
      );
    end
  end else begin : gen_sram
    logic [CFG.SET_COUNT*(CFG.TAG_WIDTH+2)-1:0] tag_rdata_flat;
    for (genvar i = 0; i < CFG.SET_COUNT; i++) begin : g_sets_rdata
      assign tag_rdata[i] = tag_rdata_flat[i*(CFG.TAG_WIDTH+2)+:CFG.TAG_WIDTH+2];
    end
    tc_sram_impl #(
      .DataWidth ( (CFG.TAG_WIDTH+2) * CFG.SET_COUNT ),
      .ByteWidth ( CFG.TAG_WIDTH+2                   ),
      .NumWords  ( CFG.LINE_COUNT                    ),
      .NumPorts  ( 1                                 ),
      .impl_in_t ( sram_cfg_tag_t                    )
    ) i_tag (
      .clk_i   ( clk_i                      ),
      .rst_ni  ( rst_ni                     ),
      .impl_i  ( sram_cfg_tag_i             ),
      .impl_o  (  ),
      .req_i   ( |tag_enable                ),
      .we_i    ( tag_write                  ),
      .addr_i  ( tag_addr                   ),
      .wdata_i ( {CFG.SET_COUNT{tag_wdata}} ),
      .be_i    ( tag_enable                 ),
      .rdata_o ( tag_rdata_flat             )
    );
  end

  // Determine which set hit
  logic [CFG.SET_COUNT-1:0] errors;
  assign required_tag = tag_req_q.addr[CFG.FETCH_AW-1:CFG.LINE_ALIGN + CFG.COUNT_ALIGN];
  for (genvar i = 0; i < CFG.SET_COUNT; i++) begin : gen_line_hit
    assign line_hit[i] = tag_rdata[i][CFG.TAG_WIDTH+1] &&
                         tag_rdata[i][CFG.TAG_WIDTH-1:0] == required_tag; // check valid bit and tag
    assign errors[i] = tag_rdata[i][CFG.TAG_WIDTH] && line_hit[i]; // check error bit
  end
  assign tag_rsp_s.hit = |line_hit;
  assign tag_rsp_s.error = |errors;

  lzc #(.WIDTH(CFG.SET_COUNT)) i_lzc (
    .in_i     ( line_hit       ),
    .cnt_o    ( tag_rsp_s.cset ),
    .empty_o  (                )
  );

  // Buffer the metadata on a valid handshake. Stall on write (implicit in req_valid/ready)
  `FFL(tag_req_q, tag_req_d, req_valid && req_ready, '0, clk_i, rst_ni)
  `FF(tag_valid, req_valid ? 1'b1 : tag_ready ? 1'b0 : tag_valid, '0, clk_i, rst_ni)
  // Ready if buffer is empy or downstream is reading. Stall on write
  assign req_ready = (!tag_valid || tag_ready) && !tag_write;

  // Register the handshake of the reg stage to buffer the tag output data in the next cycle
  `FF(req_handshake, req_valid && req_ready, 1'b0, clk_i, rst_ni)

  // Fall-through buffer the tag data: Store the tag data if the SRAM bank accepted a request in
  // the previous cycle and if we actually have to buffer them because the receiver is not ready
  `FF(tag_rsp_q, tag_rsp_d, '0, clk_i, rst_ni)
  assign tag_rsp = req_handshake ? tag_rsp_s : tag_rsp_q;
  always_comb begin
    tag_rsp_d = tag_rsp_q;
    // Load the FF if new data is incoming and downstream is not ready
    if (req_handshake && !tag_ready) begin
      tag_rsp_d = tag_rsp_s;
    end
    // Override the hit if the write that stalled us invalidated the data
    if (lookup_addr == write_addr && write_valid_i) begin
      tag_rsp_d.hit = 1'b0;
    end
  end

  // --------------------------------------------------
  // Data stage
  // --------------------------------------------------

  typedef struct packed {
    logic [CFG.FETCH_AW-1:0]  addr;
    logic [CFG.ID_WIDTH-1:0]  id;
    logic [CFG.SET_ALIGN-1:0] cset;
    logic                     hit;
    logic                     error;
  } data_req_t;

  typedef logic [CFG.LINE_WIDTH-1:0] data_rsp_t;

  logic [DataAddrWidth-1:0] data_addr;
  logic                     data_enable;
  data_rsp_t                data_wdata, data_rdata;
  logic                     data_write;

  data_req_t                data_req_d, data_req_q;
  data_rsp_t                data_rsp_q;
  logic                     data_valid, data_ready;

  logic                     refill_hit_d, refill_hit_q;
  data_rsp_t                refill_wdata_q, proper_rdata;
  logic [CFG.SET_ALIGN-1:0] write_set_q;
  logic                     write_error_q;

  // Connect tag stage response to data stage request
  assign data_req_d.addr  = tag_req_q.addr;
  assign data_req_d.id    = tag_req_q.id;
  assign data_req_d.cset  = tag_rsp.cset;
  assign data_req_d.hit   = tag_rsp.hit;
  assign data_req_d.error = tag_rsp.error;

  assign lookup_addr = {tag_rsp.cset, tag_req_q.addr[CFG.LINE_ALIGN +: CFG.COUNT_ALIGN]};
  assign write_addr  = {write_set_i, write_addr_i};

  // Data bank port mux
  always_comb begin
    // Default read request
    data_addr   = lookup_addr;
    data_enable = tag_valid && tag_rsp.hit; // Only read data on hit
    data_wdata  = write_data_i;
    data_write  = 1'b0;
    // Write takes priority
    if (!init_phase && write_valid_i) begin
      data_addr   = write_addr;
      data_enable = 1'b1;
      data_write  = 1'b1;
    end
  end

  tc_sram_impl #(
    .DataWidth ( CFG.LINE_WIDTH                 ),
    .NumWords  ( CFG.LINE_COUNT * CFG.SET_COUNT ),
    .NumPorts  ( 1                              ),
    .impl_in_t ( sram_cfg_data_t                )
  ) i_data (
    .clk_i   ( clk_i           ),
    .rst_ni  ( rst_ni          ),
    .impl_i  ( sram_cfg_data_i ),
    .impl_o  (  ),
    .req_i   ( data_enable     ),
    .we_i    ( data_write      ),
    .addr_i  ( data_addr       ),
    .wdata_i ( data_wdata      ),
    .be_i    ( '1              ),
    .rdata_o ( data_rdata      )
  );

  // Buffer the metadata on a valid handshake. Stall on write (implicit in tag_ready)
  `FFL(data_req_q, data_req_d, tag_valid && tag_ready, '0, clk_i, rst_ni)
  `FF(data_valid, (tag_valid && (!data_write || refill_hit_d)) ?
                  1'b1 : data_ready ? 1'b0 : data_valid, '0, clk_i, rst_ni)
  // Ready if buffer is empty or downstream is reading. Stall on write
  assign tag_ready = (!data_valid || data_ready) && (!data_write || refill_hit_d);

  // Register the handshake of the tag stage to buffer the data output data in the next cycle
  // but only if it was a hit. Otherwise, the data is not read anyway.
  `FF(tag_handshake, tag_valid && tag_ready && (data_req_d.hit || refill_hit_d),
      1'b0, clk_i, rst_ni)

  // Fall-through buffer the read data: Store the read data if the SRAM bank accepted a request in
  // the previous cycle and if we actually have to buffer them because the receiver is not ready
  `FFL(data_rsp_q, proper_rdata, tag_handshake && !data_ready, '0, clk_i, rst_ni)
  assign proper_rdata = refill_hit_q && !data_req_q.hit ? refill_wdata_q : data_rdata;
  assign out_data_o = tag_handshake ? proper_rdata : data_rsp_q;

  // Check immediate refill for possible match
  assign refill_hit_d = write_valid_i &&
                        write_tag_i == required_tag &&
                        write_addr_i == data_req_d.addr[CFG.LINE_ALIGN +: CFG.COUNT_ALIGN];
  `FFL(refill_hit_q, refill_hit_d, tag_valid && tag_ready, '0, clk_i, rst_ni)
  `FFL(refill_wdata_q, write_data_i, refill_hit_d, '0, clk_i, rst_ni)
  `FFL(write_set_q, write_set_i, refill_hit_d, '0, clk_i, rst_ni)
  `FFL(write_error_q, write_error_i, refill_hit_d, '0, clk_i, rst_ni)

  // Generate the remaining output signals.
  assign out_addr_o  = data_req_q.addr;
  assign out_id_o    = data_req_q.id;
  assign out_set_o   = refill_hit_q && !data_req_q.hit ? write_set_q : data_req_q.cset;
  assign out_hit_o   = refill_hit_q || data_req_q.hit;
  assign out_error_o = refill_hit_q && !data_req_q.hit ? write_error_q : data_req_q.error;
  assign out_valid_o = data_valid;
  assign data_ready  = out_ready_i;

endmodule
