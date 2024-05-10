// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package cluster_icache_ctrl_perfctr_reg_pkg;

  // Param list
  parameter int NumCores = 8;
  parameter int NumL0Events = 5;
  parameter int NumL1Events = 6;
  parameter int NumAvailableCounters = 6;

  // Address widths within the block
  parameter int BlockAw = 6;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    logic        q;
  } cluster_icache_ctrl_perfctr_reg2hw_enable_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } cluster_icache_ctrl_perfctr_reg2hw_flush_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } cluster_icache_ctrl_perfctr_reg2hw_flush_l1_only_reg_t;

  typedef struct packed {
    logic [7:0]  q;
    logic        qe;
  } cluster_icache_ctrl_perfctr_reg2hw_sel_flush_icache_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } cluster_icache_ctrl_perfctr_reg2hw_clear_counters_reg_t;

  typedef struct packed {
    logic        q;
  } cluster_icache_ctrl_perfctr_reg2hw_enable_counters_reg_t;

  typedef struct packed {
    logic        q;
  } cluster_icache_ctrl_perfctr_reg2hw_enable_prefetch_reg_t;

  typedef struct packed {
    logic [31:0] q;
  } cluster_icache_ctrl_perfctr_reg2hw_counters_mreg_t;

  typedef struct packed {
    logic        d;
  } cluster_icache_ctrl_perfctr_hw2reg_flush_reg_t;

  typedef struct packed {
    logic        d;
  } cluster_icache_ctrl_perfctr_hw2reg_flush_l1_only_reg_t;

  typedef struct packed {
    logic [7:0]  d;
  } cluster_icache_ctrl_perfctr_hw2reg_sel_flush_icache_reg_t;

  typedef struct packed {
    logic        d;
  } cluster_icache_ctrl_perfctr_hw2reg_clear_counters_reg_t;

  typedef struct packed {
    logic [31:0] d;
    logic        de;
  } cluster_icache_ctrl_perfctr_hw2reg_counters_mreg_t;

  // Register -> HW type
  typedef struct packed {
    cluster_icache_ctrl_perfctr_reg2hw_enable_reg_t enable; // [209:209]
    cluster_icache_ctrl_perfctr_reg2hw_flush_reg_t flush; // [208:207]
    cluster_icache_ctrl_perfctr_reg2hw_flush_l1_only_reg_t flush_l1_only; // [206:205]
    cluster_icache_ctrl_perfctr_reg2hw_sel_flush_icache_reg_t sel_flush_icache; // [204:196]
    cluster_icache_ctrl_perfctr_reg2hw_clear_counters_reg_t clear_counters; // [195:194]
    cluster_icache_ctrl_perfctr_reg2hw_enable_counters_reg_t enable_counters; // [193:193]
    cluster_icache_ctrl_perfctr_reg2hw_enable_prefetch_reg_t enable_prefetch; // [192:192]
    cluster_icache_ctrl_perfctr_reg2hw_counters_mreg_t [5:0] counters; // [191:0]
  } cluster_icache_ctrl_perfctr_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    cluster_icache_ctrl_perfctr_hw2reg_flush_reg_t flush; // [208:208]
    cluster_icache_ctrl_perfctr_hw2reg_flush_l1_only_reg_t flush_l1_only; // [207:207]
    cluster_icache_ctrl_perfctr_hw2reg_sel_flush_icache_reg_t sel_flush_icache; // [206:199]
    cluster_icache_ctrl_perfctr_hw2reg_clear_counters_reg_t clear_counters; // [198:198]
    cluster_icache_ctrl_perfctr_hw2reg_counters_mreg_t [5:0] counters; // [197:0]
  } cluster_icache_ctrl_perfctr_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE_OFFSET = 6'h 0;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_OFFSET = 6'h 4;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_L1_ONLY_OFFSET = 6'h 8;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_SEL_FLUSH_ICACHE_OFFSET = 6'h c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_CLEAR_COUNTERS_OFFSET = 6'h 10;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE_COUNTERS_OFFSET = 6'h 14;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE_PREFETCH_OFFSET = 6'h 1c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_0_OFFSET = 6'h 20;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_1_OFFSET = 6'h 24;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_2_OFFSET = 6'h 28;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_3_OFFSET = 6'h 2c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_4_OFFSET = 6'h 30;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_5_OFFSET = 6'h 34;

  // Reset values for hwext registers and their fields
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_FLUSH_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_L1_ONLY_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_L1_ONLY_FLUSH_RESVAL = 1'h 0;
  parameter logic [7:0] CLUSTER_ICACHE_CTRL_PERFCTR_SEL_FLUSH_ICACHE_RESVAL = 8'h 0;
  parameter logic [7:0] CLUSTER_ICACHE_CTRL_PERFCTR_SEL_FLUSH_ICACHE_FLUSH_RESVAL = 8'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_PERFCTR_CLEAR_COUNTERS_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_PERFCTR_CLEAR_COUNTERS_CLEAR_RESVAL = 1'h 0;

  // Register index
  typedef enum int {
    CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE,
    CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH,
    CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_L1_ONLY,
    CLUSTER_ICACHE_CTRL_PERFCTR_SEL_FLUSH_ICACHE,
    CLUSTER_ICACHE_CTRL_PERFCTR_CLEAR_COUNTERS,
    CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE_COUNTERS,
    CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE_PREFETCH,
    CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_0,
    CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_1,
    CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_2,
    CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_3,
    CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_4,
    CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_5
  } cluster_icache_ctrl_perfctr_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] CLUSTER_ICACHE_CTRL_PERFCTR_PERMIT [13] = '{
    4'b 0001, // index[ 0] CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE
    4'b 0001, // index[ 1] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH
    4'b 0001, // index[ 2] CLUSTER_ICACHE_CTRL_PERFCTR_FLUSH_L1_ONLY
    4'b 0001, // index[ 3] CLUSTER_ICACHE_CTRL_PERFCTR_SEL_FLUSH_ICACHE
    4'b 0001, // index[ 4] CLUSTER_ICACHE_CTRL_PERFCTR_CLEAR_COUNTERS
    4'b 0001, // index[ 5] CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE_COUNTERS
    4'b 0001, // index[ 6] CLUSTER_ICACHE_CTRL_PERFCTR_ENABLE_PREFETCH
    4'b 1111, // index[ 7] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_0
    4'b 1111, // index[ 8] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_1
    4'b 1111, // index[ 9] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_2
    4'b 1111, // index[10] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_3
    4'b 1111, // index[11] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_4
    4'b 1111  // index[12] CLUSTER_ICACHE_CTRL_PERFCTR_COUNTERS_5
  };

endpackage

