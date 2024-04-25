// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package cluster_icache_ctrl_reg_pkg;

  // Param list
  parameter int NumCores = 8;
  parameter int NumAvailableCounters = 44;

  // Address widths within the block
  parameter int BlockAw = 8;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    logic        q;
  } cluster_icache_ctrl_reg2hw_enable_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } cluster_icache_ctrl_reg2hw_flush_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } cluster_icache_ctrl_reg2hw_flush_l1_only_reg_t;

  typedef struct packed {
    logic [7:0]  q;
    logic        qe;
  } cluster_icache_ctrl_reg2hw_sel_flush_icache_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } cluster_icache_ctrl_reg2hw_clear_counters_reg_t;

  typedef struct packed {
    logic        q;
  } cluster_icache_ctrl_reg2hw_enable_counters_reg_t;

  typedef struct packed {
    logic        q;
  } cluster_icache_ctrl_reg2hw_enable_prefetch_reg_t;

  typedef struct packed {
    logic [31:0] q;
  } cluster_icache_ctrl_reg2hw_counters_mreg_t;

  typedef struct packed {
    logic        d;
  } cluster_icache_ctrl_hw2reg_flush_reg_t;

  typedef struct packed {
    logic        d;
  } cluster_icache_ctrl_hw2reg_flush_l1_only_reg_t;

  typedef struct packed {
    logic [7:0]  d;
  } cluster_icache_ctrl_hw2reg_sel_flush_icache_reg_t;

  typedef struct packed {
    logic        d;
  } cluster_icache_ctrl_hw2reg_clear_counters_reg_t;

  typedef struct packed {
    logic [31:0] d;
    logic        de;
  } cluster_icache_ctrl_hw2reg_counters_mreg_t;

  // Register -> HW type
  typedef struct packed {
    cluster_icache_ctrl_reg2hw_enable_reg_t enable; // [1425:1425]
    cluster_icache_ctrl_reg2hw_flush_reg_t flush; // [1424:1423]
    cluster_icache_ctrl_reg2hw_flush_l1_only_reg_t flush_l1_only; // [1422:1421]
    cluster_icache_ctrl_reg2hw_sel_flush_icache_reg_t sel_flush_icache; // [1420:1412]
    cluster_icache_ctrl_reg2hw_clear_counters_reg_t clear_counters; // [1411:1410]
    cluster_icache_ctrl_reg2hw_enable_counters_reg_t enable_counters; // [1409:1409]
    cluster_icache_ctrl_reg2hw_enable_prefetch_reg_t enable_prefetch; // [1408:1408]
    cluster_icache_ctrl_reg2hw_counters_mreg_t [43:0] counters; // [1407:0]
  } cluster_icache_ctrl_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    cluster_icache_ctrl_hw2reg_flush_reg_t flush; // [1462:1462]
    cluster_icache_ctrl_hw2reg_flush_l1_only_reg_t flush_l1_only; // [1461:1461]
    cluster_icache_ctrl_hw2reg_sel_flush_icache_reg_t sel_flush_icache; // [1460:1453]
    cluster_icache_ctrl_hw2reg_clear_counters_reg_t clear_counters; // [1452:1452]
    cluster_icache_ctrl_hw2reg_counters_mreg_t [43:0] counters; // [1451:0]
  } cluster_icache_ctrl_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_ENABLE_OFFSET = 8'h 0;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_FLUSH_OFFSET = 8'h 4;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_FLUSH_L1_ONLY_OFFSET = 8'h 8;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_SEL_FLUSH_ICACHE_OFFSET = 8'h c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_CLEAR_COUNTERS_OFFSET = 8'h 10;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_ENABLE_COUNTERS_OFFSET = 8'h 14;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_ENABLE_PREFETCH_OFFSET = 8'h 1c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_0_OFFSET = 8'h 20;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_1_OFFSET = 8'h 24;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_2_OFFSET = 8'h 28;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_3_OFFSET = 8'h 2c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_4_OFFSET = 8'h 30;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_5_OFFSET = 8'h 34;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_6_OFFSET = 8'h 38;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_7_OFFSET = 8'h 3c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_8_OFFSET = 8'h 40;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_9_OFFSET = 8'h 44;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_10_OFFSET = 8'h 48;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_11_OFFSET = 8'h 4c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_12_OFFSET = 8'h 50;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_13_OFFSET = 8'h 54;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_14_OFFSET = 8'h 58;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_15_OFFSET = 8'h 5c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_16_OFFSET = 8'h 60;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_17_OFFSET = 8'h 64;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_18_OFFSET = 8'h 68;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_19_OFFSET = 8'h 6c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_20_OFFSET = 8'h 70;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_21_OFFSET = 8'h 74;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_22_OFFSET = 8'h 78;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_23_OFFSET = 8'h 7c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_24_OFFSET = 8'h 80;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_25_OFFSET = 8'h 84;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_26_OFFSET = 8'h 88;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_27_OFFSET = 8'h 8c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_28_OFFSET = 8'h 90;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_29_OFFSET = 8'h 94;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_30_OFFSET = 8'h 98;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_31_OFFSET = 8'h 9c;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_32_OFFSET = 8'h a0;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_33_OFFSET = 8'h a4;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_34_OFFSET = 8'h a8;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_35_OFFSET = 8'h ac;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_36_OFFSET = 8'h b0;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_37_OFFSET = 8'h b4;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_38_OFFSET = 8'h b8;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_39_OFFSET = 8'h bc;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_40_OFFSET = 8'h c0;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_41_OFFSET = 8'h c4;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_42_OFFSET = 8'h c8;
  parameter logic [BlockAw-1:0] CLUSTER_ICACHE_CTRL_COUNTERS_43_OFFSET = 8'h cc;

  // Reset values for hwext registers and their fields
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_FLUSH_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_FLUSH_FLUSH_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_FLUSH_L1_ONLY_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_FLUSH_L1_ONLY_FLUSH_RESVAL = 1'h 0;
  parameter logic [7:0] CLUSTER_ICACHE_CTRL_SEL_FLUSH_ICACHE_RESVAL = 8'h 0;
  parameter logic [7:0] CLUSTER_ICACHE_CTRL_SEL_FLUSH_ICACHE_FLUSH_RESVAL = 8'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_CLEAR_COUNTERS_RESVAL = 1'h 0;
  parameter logic [0:0] CLUSTER_ICACHE_CTRL_CLEAR_COUNTERS_CLEAR_RESVAL = 1'h 0;

  // Register index
  typedef enum int {
    CLUSTER_ICACHE_CTRL_ENABLE,
    CLUSTER_ICACHE_CTRL_FLUSH,
    CLUSTER_ICACHE_CTRL_FLUSH_L1_ONLY,
    CLUSTER_ICACHE_CTRL_SEL_FLUSH_ICACHE,
    CLUSTER_ICACHE_CTRL_CLEAR_COUNTERS,
    CLUSTER_ICACHE_CTRL_ENABLE_COUNTERS,
    CLUSTER_ICACHE_CTRL_ENABLE_PREFETCH,
    CLUSTER_ICACHE_CTRL_COUNTERS_0,
    CLUSTER_ICACHE_CTRL_COUNTERS_1,
    CLUSTER_ICACHE_CTRL_COUNTERS_2,
    CLUSTER_ICACHE_CTRL_COUNTERS_3,
    CLUSTER_ICACHE_CTRL_COUNTERS_4,
    CLUSTER_ICACHE_CTRL_COUNTERS_5,
    CLUSTER_ICACHE_CTRL_COUNTERS_6,
    CLUSTER_ICACHE_CTRL_COUNTERS_7,
    CLUSTER_ICACHE_CTRL_COUNTERS_8,
    CLUSTER_ICACHE_CTRL_COUNTERS_9,
    CLUSTER_ICACHE_CTRL_COUNTERS_10,
    CLUSTER_ICACHE_CTRL_COUNTERS_11,
    CLUSTER_ICACHE_CTRL_COUNTERS_12,
    CLUSTER_ICACHE_CTRL_COUNTERS_13,
    CLUSTER_ICACHE_CTRL_COUNTERS_14,
    CLUSTER_ICACHE_CTRL_COUNTERS_15,
    CLUSTER_ICACHE_CTRL_COUNTERS_16,
    CLUSTER_ICACHE_CTRL_COUNTERS_17,
    CLUSTER_ICACHE_CTRL_COUNTERS_18,
    CLUSTER_ICACHE_CTRL_COUNTERS_19,
    CLUSTER_ICACHE_CTRL_COUNTERS_20,
    CLUSTER_ICACHE_CTRL_COUNTERS_21,
    CLUSTER_ICACHE_CTRL_COUNTERS_22,
    CLUSTER_ICACHE_CTRL_COUNTERS_23,
    CLUSTER_ICACHE_CTRL_COUNTERS_24,
    CLUSTER_ICACHE_CTRL_COUNTERS_25,
    CLUSTER_ICACHE_CTRL_COUNTERS_26,
    CLUSTER_ICACHE_CTRL_COUNTERS_27,
    CLUSTER_ICACHE_CTRL_COUNTERS_28,
    CLUSTER_ICACHE_CTRL_COUNTERS_29,
    CLUSTER_ICACHE_CTRL_COUNTERS_30,
    CLUSTER_ICACHE_CTRL_COUNTERS_31,
    CLUSTER_ICACHE_CTRL_COUNTERS_32,
    CLUSTER_ICACHE_CTRL_COUNTERS_33,
    CLUSTER_ICACHE_CTRL_COUNTERS_34,
    CLUSTER_ICACHE_CTRL_COUNTERS_35,
    CLUSTER_ICACHE_CTRL_COUNTERS_36,
    CLUSTER_ICACHE_CTRL_COUNTERS_37,
    CLUSTER_ICACHE_CTRL_COUNTERS_38,
    CLUSTER_ICACHE_CTRL_COUNTERS_39,
    CLUSTER_ICACHE_CTRL_COUNTERS_40,
    CLUSTER_ICACHE_CTRL_COUNTERS_41,
    CLUSTER_ICACHE_CTRL_COUNTERS_42,
    CLUSTER_ICACHE_CTRL_COUNTERS_43
  } cluster_icache_ctrl_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] CLUSTER_ICACHE_CTRL_PERMIT [51] = '{
    4'b 0001, // index[ 0] CLUSTER_ICACHE_CTRL_ENABLE
    4'b 0001, // index[ 1] CLUSTER_ICACHE_CTRL_FLUSH
    4'b 0001, // index[ 2] CLUSTER_ICACHE_CTRL_FLUSH_L1_ONLY
    4'b 0001, // index[ 3] CLUSTER_ICACHE_CTRL_SEL_FLUSH_ICACHE
    4'b 0001, // index[ 4] CLUSTER_ICACHE_CTRL_CLEAR_COUNTERS
    4'b 0001, // index[ 5] CLUSTER_ICACHE_CTRL_ENABLE_COUNTERS
    4'b 0001, // index[ 6] CLUSTER_ICACHE_CTRL_ENABLE_PREFETCH
    4'b 1111, // index[ 7] CLUSTER_ICACHE_CTRL_COUNTERS_0
    4'b 1111, // index[ 8] CLUSTER_ICACHE_CTRL_COUNTERS_1
    4'b 1111, // index[ 9] CLUSTER_ICACHE_CTRL_COUNTERS_2
    4'b 1111, // index[10] CLUSTER_ICACHE_CTRL_COUNTERS_3
    4'b 1111, // index[11] CLUSTER_ICACHE_CTRL_COUNTERS_4
    4'b 1111, // index[12] CLUSTER_ICACHE_CTRL_COUNTERS_5
    4'b 1111, // index[13] CLUSTER_ICACHE_CTRL_COUNTERS_6
    4'b 1111, // index[14] CLUSTER_ICACHE_CTRL_COUNTERS_7
    4'b 1111, // index[15] CLUSTER_ICACHE_CTRL_COUNTERS_8
    4'b 1111, // index[16] CLUSTER_ICACHE_CTRL_COUNTERS_9
    4'b 1111, // index[17] CLUSTER_ICACHE_CTRL_COUNTERS_10
    4'b 1111, // index[18] CLUSTER_ICACHE_CTRL_COUNTERS_11
    4'b 1111, // index[19] CLUSTER_ICACHE_CTRL_COUNTERS_12
    4'b 1111, // index[20] CLUSTER_ICACHE_CTRL_COUNTERS_13
    4'b 1111, // index[21] CLUSTER_ICACHE_CTRL_COUNTERS_14
    4'b 1111, // index[22] CLUSTER_ICACHE_CTRL_COUNTERS_15
    4'b 1111, // index[23] CLUSTER_ICACHE_CTRL_COUNTERS_16
    4'b 1111, // index[24] CLUSTER_ICACHE_CTRL_COUNTERS_17
    4'b 1111, // index[25] CLUSTER_ICACHE_CTRL_COUNTERS_18
    4'b 1111, // index[26] CLUSTER_ICACHE_CTRL_COUNTERS_19
    4'b 1111, // index[27] CLUSTER_ICACHE_CTRL_COUNTERS_20
    4'b 1111, // index[28] CLUSTER_ICACHE_CTRL_COUNTERS_21
    4'b 1111, // index[29] CLUSTER_ICACHE_CTRL_COUNTERS_22
    4'b 1111, // index[30] CLUSTER_ICACHE_CTRL_COUNTERS_23
    4'b 1111, // index[31] CLUSTER_ICACHE_CTRL_COUNTERS_24
    4'b 1111, // index[32] CLUSTER_ICACHE_CTRL_COUNTERS_25
    4'b 1111, // index[33] CLUSTER_ICACHE_CTRL_COUNTERS_26
    4'b 1111, // index[34] CLUSTER_ICACHE_CTRL_COUNTERS_27
    4'b 1111, // index[35] CLUSTER_ICACHE_CTRL_COUNTERS_28
    4'b 1111, // index[36] CLUSTER_ICACHE_CTRL_COUNTERS_29
    4'b 1111, // index[37] CLUSTER_ICACHE_CTRL_COUNTERS_30
    4'b 1111, // index[38] CLUSTER_ICACHE_CTRL_COUNTERS_31
    4'b 1111, // index[39] CLUSTER_ICACHE_CTRL_COUNTERS_32
    4'b 1111, // index[40] CLUSTER_ICACHE_CTRL_COUNTERS_33
    4'b 1111, // index[41] CLUSTER_ICACHE_CTRL_COUNTERS_34
    4'b 1111, // index[42] CLUSTER_ICACHE_CTRL_COUNTERS_35
    4'b 1111, // index[43] CLUSTER_ICACHE_CTRL_COUNTERS_36
    4'b 1111, // index[44] CLUSTER_ICACHE_CTRL_COUNTERS_37
    4'b 1111, // index[45] CLUSTER_ICACHE_CTRL_COUNTERS_38
    4'b 1111, // index[46] CLUSTER_ICACHE_CTRL_COUNTERS_39
    4'b 1111, // index[47] CLUSTER_ICACHE_CTRL_COUNTERS_40
    4'b 1111, // index[48] CLUSTER_ICACHE_CTRL_COUNTERS_41
    4'b 1111, // index[49] CLUSTER_ICACHE_CTRL_COUNTERS_42
    4'b 1111  // index[50] CLUSTER_ICACHE_CTRL_COUNTERS_43
  };

endpackage

