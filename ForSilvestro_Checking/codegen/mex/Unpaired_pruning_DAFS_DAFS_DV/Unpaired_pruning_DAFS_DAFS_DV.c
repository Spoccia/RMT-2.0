/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Unpaired_pruning_DAFS_DAFS_DV.c
 *
 * Code generation for function 'Unpaired_pruning_DAFS_DAFS_DV'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Unpaired_pruning_DAFS_DAFS_DV.h"
#include "Unpaired_pruning_DAFS_DAFS_DV_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "sort1.h"
#include "Unpaired_pruning_DAFS_DAFS_DV_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 103, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo b_emlrtRSI = { 102, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo c_emlrtRSI = { 77, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo d_emlrtRSI = { 76, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo e_emlrtRSI = { 75, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo f_emlrtRSI = { 74, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo g_emlrtRSI = { 73, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo h_emlrtRSI = { 72, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo i_emlrtRSI = { 10, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo j_emlrtRSI = { 6, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRSInfo k_emlrtRSI = { 44, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRSInfo l_emlrtRSI = { 234, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRSInfo n_emlrtRSI = { 26, "sort",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\datafun\\sort.m"
};

static emlrtRSInfo lb_emlrtRSI = { 253, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRSInfo nb_emlrtRSI = { 26, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRSInfo ob_emlrtRSI = { 30, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRSInfo pb_emlrtRSI = { 347, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 33, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRTEInfo b_emlrtRTEI = { 253, 13, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRTEInfo c_emlrtRTEI = { 6, 13, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRTEInfo d_emlrtRTEI = { 7, 13, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRTEInfo e_emlrtRTEI = { 11, 13, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRTEInfo f_emlrtRTEI = { 12, 13, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRTEInfo g_emlrtRTEI = { 36, 6, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRTEInfo i_emlrtRTEI = { 1, 14, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRTEInfo o_emlrtRTEI = { 371, 1, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtBCInfo emlrtBCI = { -1, -1, 87, 80, "rankmend",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 87, 66, "rankcend",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 87, 49, "rankmstart",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 87, 32, "rankcstart",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 58, 48, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo emlrtDCI = { 58, 48, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 58, 46, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 57, 48, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo b_emlrtDCI = { 57, 48, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 57, 46, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 51, 50, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo j_emlrtBCI = { -1, -1, 50, 50, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo k_emlrtBCI = { -1, -1, 49, 50, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo c_emlrtDCI = { 49, 50, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo l_emlrtBCI = { -1, -1, 49, 48, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo m_emlrtBCI = { -1, -1, 48, 50, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo d_emlrtDCI = { 48, 50, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo n_emlrtBCI = { -1, -1, 48, 48, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo o_emlrtBCI = { -1, -1, 23, 38, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo p_emlrtBCI = { -1, -1, 22, 38, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo q_emlrtBCI = { -1, -1, 21, 38, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo e_emlrtDCI = { 21, 38, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo r_emlrtBCI = { -1, -1, 21, 36, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo s_emlrtBCI = { -1, -1, 20, 38, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo f_emlrtDCI = { 20, 38, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo t_emlrtBCI = { -1, -1, 20, 36, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtECInfo emlrtECI = { 2, 6, 27, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtBCInfo u_emlrtBCI = { -1, -1, 6, 58, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo v_emlrtBCI = { -1, -1, 6, 36, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtRTEInfo p_emlrtRTEI = { 5, 9, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtRTEInfo q_emlrtRTEI = { 4, 5, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m"
};

static emlrtDCInfo g_emlrtDCI = { 2, 33, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtDCInfo h_emlrtDCI = { 2, 33, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  4 };

static emlrtDCInfo i_emlrtDCI = { 2, 25, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtDCInfo j_emlrtDCI = { 2, 25, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  4 };

static emlrtRTEInfo r_emlrtRTEI = { 243, 9, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtBCInfo w_emlrtBCI = { -1, -1, 7, 36, "matches",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo x_emlrtBCI = { -1, -1, 8, 30, "combineScore",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo y_emlrtBCI = { -1, -1, 12, 37, "matches11",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo ab_emlrtBCI = { -1, -1, 111, 27, "remainQOctave",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo bb_emlrtBCI = { -1, -1, 111, 30, "remainQOctave",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo cb_emlrtBCI = { -1, -1, 20, 56, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo db_emlrtBCI = { -1, -1, 21, 56, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo eb_emlrtBCI = { -1, -1, 22, 40, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo k_emlrtDCI = { 22, 40, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo fb_emlrtBCI = { -1, -1, 22, 58, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo gb_emlrtBCI = { -1, -1, 23, 40, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo l_emlrtDCI = { 23, 40, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo hb_emlrtBCI = { -1, -1, 23, 58, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo ib_emlrtBCI = { -1, -1, 48, 68, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo jb_emlrtBCI = { -1, -1, 49, 68, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo kb_emlrtBCI = { -1, -1, 50, 52, "feature1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo m_emlrtDCI = { 50, 52, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo lb_emlrtBCI = { -1, -1, 50, 70, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo mb_emlrtBCI = { -1, -1, 51, 52, "feature2",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo n_emlrtDCI = { 51, 52, "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo nb_emlrtBCI = { -1, -1, 51, 70, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo ob_emlrtBCI = { -1, -1, 57, 66, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo pb_emlrtBCI = { -1, -1, 58, 66, "diagRemainMatch",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo qb_emlrtBCI = { -1, -1, 99, 35, "diagY_1",
  "Unpaired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Unpaired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtRTEInfo t_emlrtRTEI = { 77, 27, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRTEInfo u_emlrtRTEI = { 370, 1, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

/* Function Declarations */
static void b_eml_null_assignment(const emlrtStack *sp, emxArray_real_T *x,
  real_T idx);
static void eml_null_assignment(const emlrtStack *sp, emxArray_real_T *x, real_T
  idx);

/* Function Definitions */
static void b_eml_null_assignment(const emlrtStack *sp, emxArray_real_T *x,
  real_T idx)
{
  boolean_T overflow;
  int32_T ncolx;
  int32_T j;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &nb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  overflow = true;
  if (((int32_T)idx > x->size[1]) || (idx != idx)) {
    overflow = false;
  }

  if (overflow) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &t_emlrtRTEI, "MATLAB:subsdeldimmismatch",
      0);
  }

  st.site = &ob_emlrtRSI;
  ncolx = x->size[1] - 1;
  b_st.site = &pb_emlrtRSI;
  if ((int32_T)idx > x->size[1] - 1) {
    overflow = false;
  } else {
    overflow = (x->size[1] - 1 > 2147483646);
  }

  if (overflow) {
    c_st.site = &m_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (j = (int32_T)idx; j <= ncolx; j++) {
    x->data[x->size[0] * (j - 1)] = x->data[x->size[0] * j];
  }

  if (ncolx <= ncolx + 1) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &u_emlrtRTEI,
      "Coder:builtins:AssertionFailed", 0);
  }

  j = x->size[0] * x->size[1];
  if (1 > ncolx) {
    x->size[1] = 0;
  } else {
    x->size[1] = ncolx;
  }

  emxEnsureCapacity(&st, (emxArray__common *)x, j, (int32_T)sizeof(real_T),
                    &o_emlrtRTEI);
}

static void eml_null_assignment(const emlrtStack *sp, emxArray_real_T *x, real_T
  idx)
{
  boolean_T overflow;
  int32_T ncolx;
  int32_T j;
  int32_T i;
  emxArray_real_T *b_x;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &nb_emlrtRSI;
  overflow = true;
  if (((int32_T)idx > x->size[1]) || (idx != idx)) {
    overflow = false;
  }

  if (overflow) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &t_emlrtRTEI, "MATLAB:subsdeldimmismatch",
      0);
  }

  st.site = &ob_emlrtRSI;
  ncolx = x->size[1] - 1;
  b_st.site = &pb_emlrtRSI;
  if ((int32_T)idx > x->size[1] - 1) {
    overflow = false;
  } else {
    overflow = (x->size[1] - 1 > 2147483646);
  }

  if (overflow) {
    c_st.site = &m_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (j = (int32_T)idx; j <= ncolx; j++) {
    for (i = 0; i < 2; i++) {
      x->data[i + x->size[0] * (j - 1)] = x->data[i + x->size[0] * j];
    }
  }

  if (ncolx <= ncolx + 1) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &u_emlrtRTEI,
      "Coder:builtins:AssertionFailed", 0);
  }

  if (1 > ncolx) {
    ncolx = 0;
  }

  emxInit_real_T(&st, &b_x, 2, &i_emlrtRTEI, true);
  j = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 2;
  b_x->size[1] = ncolx;
  emxEnsureCapacity(&st, (emxArray__common *)b_x, j, (int32_T)sizeof(real_T),
                    &i_emlrtRTEI);
  for (j = 0; j < ncolx; j++) {
    for (i = 0; i < 2; i++) {
      b_x->data[i + b_x->size[0] * j] = x->data[i + x->size[0] * j];
    }
  }

  j = x->size[0] * x->size[1];
  x->size[0] = 2;
  x->size[1] = b_x->size[1];
  emxEnsureCapacity(&st, (emxArray__common *)x, j, (int32_T)sizeof(real_T),
                    &i_emlrtRTEI);
  ncolx = b_x->size[1];
  for (j = 0; j < ncolx; j++) {
    for (i = 0; i < 2; i++) {
      x->data[i + x->size[0] * j] = b_x->data[i + b_x->size[0] * j];
    }
  }

  emxFree_real_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void Unpaired_pruning_DAFS_DAFS_DV(const emlrtStack *sp, const emxArray_real_T
  *feature1, const emxArray_real_T *depdScale1, const emxArray_real_T *matches,
  const emxArray_real_T *combineScore, const emxArray_real_T *feature2, const
  emxArray_real_T *depdScale2, real_T doctave, real_T toctave, emxArray_real_T
  *remainQOctave, real_T *Dist)
{
  int32_T i0;
  real_T d0;
  real_T d1;
  int32_T loop_ub;
  int32_T ii;
  emxArray_real_T *index1;
  emxArray_real_T *matches11;
  emxArray_real_T *diagY_1;
  emxArray_real_T *diagMatch;
  emxArray_boolean_T *r0;
  emxArray_boolean_T *x;
  emxArray_int32_T *b_ii;
  emxArray_real_T *b_index1;
  emxArray_real_T *c_ii;
  int32_T jj;
  int32_T b_x[2];
  int32_T iv0[2];
  int32_T nx;
  int32_T d_ii;
  int32_T idx;
  boolean_T overflow;
  boolean_T exitg6;
  boolean_T guard6 = false;
  int32_T b_loop_ub;
  real_T counter;
  int32_T dimention;
  uint32_T i;
  real_T rangec;
  real_T rangem;
  real_T startc;
  real_T endc;
  real_T startm;
  real_T endm;
  boolean_T keept;
  real_T j;
  boolean_T guard1 = false;
  boolean_T exitg1;
  real_T rem_rangec;
  real_T rem_rangem;
  real_T rem_startc;
  real_T rem_endc;
  real_T rem_startm;
  real_T rem_endm;
  real_T list1[4];
  real_T list2[4];
  real_T c[4];
  int32_T unusedExpr[4];
  int8_T ii_data[4];
  boolean_T exitg5;
  boolean_T guard5 = false;
  int8_T rankcstart_data[4];
  boolean_T exitg4;
  boolean_T guard4 = false;
  int32_T c_loop_ub;
  int8_T rankcend_data[4];
  int32_T b_unusedExpr[4];
  boolean_T exitg3;
  boolean_T guard3 = false;
  int8_T rankmstart_data[4];
  boolean_T exitg2;
  boolean_T guard2 = false;
  int8_T rankmend_data[4];
  boolean_T b_guard1 = false;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  (void)depdScale1;
  (void)depdScale2;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  i0 = remainQOctave->size[0] * remainQOctave->size[1];
  if (!(doctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(doctave, &j_emlrtDCI, sp);
  }

  d0 = doctave;
  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &i_emlrtDCI, sp);
  }

  remainQOctave->size[0] = (int32_T)d0;
  if (!(toctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(toctave, &h_emlrtDCI, sp);
  }

  d0 = toctave;
  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &g_emlrtDCI, sp);
  }

  remainQOctave->size[1] = (int32_T)d0;
  emxEnsureCapacity(sp, (emxArray__common *)remainQOctave, i0, (int32_T)sizeof
                    (real_T), &emlrtRTEI);
  if (!(doctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(doctave, &j_emlrtDCI, sp);
  }

  d0 = doctave;
  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &i_emlrtDCI, sp);
  }

  if (!(toctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(toctave, &h_emlrtDCI, sp);
  }

  d1 = toctave;
  if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
    emlrtIntegerCheckR2012b(d1, &g_emlrtDCI, sp);
  }

  loop_ub = (int32_T)d0 * (int32_T)d1;
  for (i0 = 0; i0 < loop_ub; i0++) {
    remainQOctave->data[i0] = 0.0;
  }

  *Dist = 0.0;
  emlrtForLoopVectorCheckR2012b(1.0, 1.0, doctave, mxDOUBLE_CLASS, (int32_T)
    doctave, &q_emlrtRTEI, sp);
  ii = 0;
  emxInit_real_T(sp, &index1, 2, &c_emlrtRTEI, true);
  emxInit_real_T(sp, &matches11, 2, &d_emlrtRTEI, true);
  emxInit_real_T(sp, &diagY_1, 2, &e_emlrtRTEI, true);
  emxInit_real_T(sp, &diagMatch, 2, &f_emlrtRTEI, true);
  emxInit_boolean_T(sp, &r0, 2, &emlrtRTEI, true);
  emxInit_boolean_T(sp, &x, 2, &emlrtRTEI, true);
  emxInit_int32_T(sp, &b_ii, 2, &g_emlrtRTEI, true);
  emxInit_real_T1(sp, &b_index1, 1, &emlrtRTEI, true);
  emxInit_real_T1(sp, &c_ii, 1, &emlrtRTEI, true);
  while (ii <= (int32_T)doctave - 1) {
    emlrtForLoopVectorCheckR2012b(1.0, 1.0, toctave, mxDOUBLE_CLASS, (int32_T)
      toctave, &p_emlrtRTEI, sp);
    jj = 0;
    while (jj <= (int32_T)toctave - 1) {
      i0 = feature1->size[0];
      if (!(5 <= i0)) {
        emlrtDynamicBoundsCheckR2012b(5, 1, i0, &v_emlrtBCI, sp);
      }

      loop_ub = feature1->size[1];
      i0 = x->size[0] * x->size[1];
      x->size[0] = 1;
      x->size[1] = loop_ub;
      emxEnsureCapacity(sp, (emxArray__common *)x, i0, (int32_T)sizeof(boolean_T),
                        &emlrtRTEI);
      for (i0 = 0; i0 < loop_ub; i0++) {
        x->data[x->size[0] * i0] = (feature1->data[4 + feature1->size[0] * i0] ==
          1.0 + (real_T)ii);
      }

      i0 = feature1->size[0];
      if (!(6 <= i0)) {
        emlrtDynamicBoundsCheckR2012b(6, 1, i0, &u_emlrtBCI, sp);
      }

      loop_ub = feature1->size[1];
      i0 = r0->size[0] * r0->size[1];
      r0->size[0] = 1;
      r0->size[1] = loop_ub;
      emxEnsureCapacity(sp, (emxArray__common *)r0, i0, (int32_T)sizeof
                        (boolean_T), &emlrtRTEI);
      for (i0 = 0; i0 < loop_ub; i0++) {
        r0->data[r0->size[0] * i0] = (feature1->data[5 + feature1->size[0] * i0]
          == 1.0 + (real_T)jj);
      }

      for (i0 = 0; i0 < 2; i0++) {
        b_x[i0] = x->size[i0];
      }

      for (i0 = 0; i0 < 2; i0++) {
        iv0[i0] = r0->size[i0];
      }

      if ((b_x[0] != iv0[0]) || (b_x[1] != iv0[1])) {
        emlrtSizeEqCheckNDR2012b(&b_x[0], &iv0[0], &emlrtECI, sp);
      }

      st.site = &j_emlrtRSI;
      i0 = x->size[0] * x->size[1];
      x->size[0] = 1;
      emxEnsureCapacity(&st, (emxArray__common *)x, i0, (int32_T)sizeof
                        (boolean_T), &emlrtRTEI);
      nx = x->size[0];
      d_ii = x->size[1];
      loop_ub = nx * d_ii;
      for (i0 = 0; i0 < loop_ub; i0++) {
        x->data[i0] = (x->data[i0] && r0->data[i0]);
      }

      b_st.site = &k_emlrtRSI;
      nx = x->size[1];
      idx = 0;
      i0 = b_ii->size[0] * b_ii->size[1];
      b_ii->size[0] = 1;
      b_ii->size[1] = x->size[1];
      emxEnsureCapacity(&b_st, (emxArray__common *)b_ii, i0, (int32_T)sizeof
                        (int32_T), &emlrtRTEI);
      c_st.site = &l_emlrtRSI;
      if (1 > x->size[1]) {
        overflow = false;
      } else {
        overflow = (x->size[1] > 2147483646);
      }

      if (overflow) {
        d_st.site = &m_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      d_ii = 1;
      exitg6 = false;
      while ((!exitg6) && (d_ii <= nx)) {
        guard6 = false;
        if (x->data[d_ii - 1]) {
          idx++;
          b_ii->data[idx - 1] = d_ii;
          if (idx >= nx) {
            exitg6 = true;
          } else {
            guard6 = true;
          }
        } else {
          guard6 = true;
        }

        if (guard6) {
          d_ii++;
        }
      }

      if (idx <= x->size[1]) {
      } else {
        emlrtErrorWithMessageIdR2012b(&b_st, &r_emlrtRTEI,
          "Coder:builtins:AssertionFailed", 0);
      }

      if (x->size[1] == 1) {
        if (idx == 0) {
          i0 = b_ii->size[0] * b_ii->size[1];
          b_ii->size[0] = 1;
          b_ii->size[1] = 0;
          emxEnsureCapacity(&b_st, (emxArray__common *)b_ii, i0, (int32_T)sizeof
                            (int32_T), &emlrtRTEI);
        }
      } else {
        i0 = b_ii->size[0] * b_ii->size[1];
        if (1 > idx) {
          b_ii->size[1] = 0;
        } else {
          b_ii->size[1] = idx;
        }

        emxEnsureCapacity(&b_st, (emxArray__common *)b_ii, i0, (int32_T)sizeof
                          (int32_T), &b_emlrtRTEI);
      }

      i0 = index1->size[0] * index1->size[1];
      index1->size[0] = 1;
      index1->size[1] = b_ii->size[1];
      emxEnsureCapacity(&st, (emxArray__common *)index1, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = b_ii->size[0] * b_ii->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        index1->data[i0] = b_ii->data[i0];
      }

      nx = matches->size[1];
      i0 = matches11->size[0] * matches11->size[1];
      matches11->size[0] = 2;
      matches11->size[1] = index1->size[1];
      emxEnsureCapacity(sp, (emxArray__common *)matches11, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        for (b_loop_ub = 0; b_loop_ub < 2; b_loop_ub++) {
          d_ii = (int32_T)index1->data[index1->size[0] * i0];
          if (!((d_ii >= 1) && (d_ii <= nx))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, nx, &w_emlrtBCI, sp);
          }

          matches11->data[b_loop_ub + matches11->size[0] * i0] = matches->
            data[b_loop_ub + matches->size[0] * (d_ii - 1)];
        }
      }

      d_ii = combineScore->size[1];
      loop_ub = index1->size[0] * index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_loop_ub = (int32_T)index1->data[i0];
        if (!((b_loop_ub >= 1) && (b_loop_ub <= d_ii))) {
          emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, d_ii, &x_emlrtBCI, sp);
        }
      }

      st.site = &i_emlrtRSI;
      i0 = diagY_1->size[0] * diagY_1->size[1];
      diagY_1->size[0] = 1;
      diagY_1->size[1] = index1->size[1];
      emxEnsureCapacity(&st, (emxArray__common *)diagY_1, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = index1->size[0] * index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        diagY_1->data[i0] = combineScore->data[(int32_T)index1->data[i0] - 1];
      }

      b_st.site = &n_emlrtRSI;
      sort(&b_st, diagY_1, b_ii);
      i0 = b_index1->size[0];
      b_index1->size[0] = index1->size[1];
      emxEnsureCapacity(sp, (emxArray__common *)b_index1, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_index1->data[i0] = index1->data[index1->size[0] * i0];
      }

      nx = b_index1->size[0];
      i0 = diagMatch->size[0] * diagMatch->size[1];
      diagMatch->size[0] = 2;
      diagMatch->size[1] = b_ii->size[1];
      emxEnsureCapacity(sp, (emxArray__common *)diagMatch, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = b_ii->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        for (b_loop_ub = 0; b_loop_ub < 2; b_loop_ub++) {
          d_ii = b_ii->data[b_ii->size[0] * i0];
          if (!((d_ii >= 1) && (d_ii <= nx))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, nx, &y_emlrtBCI, sp);
          }

          diagMatch->data[b_loop_ub + diagMatch->size[0] * i0] = matches11->
            data[b_loop_ub + matches11->size[0] * (d_ii - 1)];
        }
      }

      counter = 0.0;

      /*              Counteroccurrences= 0 */
      /*      i=1; */
      i0 = c_ii->size[0];
      c_ii->size[0] = b_ii->size[1];
      emxEnsureCapacity(sp, (emxArray__common *)c_ii, i0, (int32_T)sizeof(real_T),
                        &emlrtRTEI);
      loop_ub = b_ii->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        c_ii->data[i0] = b_ii->data[b_ii->size[0] * i0];
      }

      dimention = c_ii->size[0];
      i = 1U;
      while ((real_T)i <= dimention) {
        i0 = feature1->size[0];
        if (!(2 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(2, 1, i0, &t_emlrtBCI, sp);
        }

        i0 = feature1->size[1];
        b_loop_ub = diagMatch->size[1];
        d_ii = (int32_T)i;
        if (!(d_ii <= b_loop_ub)) {
          emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &cb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (d_ii - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &f_emlrtDCI, sp);
        }

        b_loop_ub = (int32_T)d0;
        if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
          emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &s_emlrtBCI, sp);
        }

        i0 = feature2->size[0];
        if (!(2 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(2, 1, i0, &r_emlrtBCI, sp);
        }

        i0 = feature2->size[1];
        b_loop_ub = diagMatch->size[1];
        d_ii = (int32_T)i;
        if (!(d_ii <= b_loop_ub)) {
          emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &db_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (d_ii - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &e_emlrtDCI, sp);
        }

        b_loop_ub = (int32_T)d0;
        if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
          emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &q_emlrtBCI, sp);
        }

        i0 = feature1->size[0];
        if (!(4 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(4, 1, i0, &p_emlrtBCI, sp);
        }

        i0 = feature1->size[1];
        b_loop_ub = diagMatch->size[1];
        d_ii = (int32_T)i;
        if (!(d_ii <= b_loop_ub)) {
          emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &fb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (d_ii - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &k_emlrtDCI, sp);
        }

        b_loop_ub = (int32_T)d0;
        if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
          emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &eb_emlrtBCI, sp);
        }

        rangec = 3.0 * feature1->data[3 + feature1->size[0] * (b_loop_ub - 1)];
        i0 = feature2->size[0];
        if (!(4 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(4, 1, i0, &o_emlrtBCI, sp);
        }

        i0 = feature2->size[1];
        b_loop_ub = diagMatch->size[1];
        d_ii = (int32_T)i;
        if (!(d_ii <= b_loop_ub)) {
          emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &hb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (d_ii - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &l_emlrtDCI, sp);
        }

        b_loop_ub = (int32_T)d0;
        if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
          emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &gb_emlrtBCI, sp);
        }

        rangem = 3.0 * feature2->data[3 + feature2->size[0] * (b_loop_ub - 1)];
        startc = feature1->data[1 + feature1->size[0] * ((int32_T)
          diagMatch->data[diagMatch->size[0] * ((int32_T)i - 1)] - 1)] - rangec;
        endc = feature1->data[1 + feature1->size[0] * ((int32_T)diagMatch->
          data[diagMatch->size[0] * ((int32_T)i - 1)] - 1)] + rangec;
        startm = feature2->data[1 + feature2->size[0] * ((int32_T)
          diagMatch->data[1 + diagMatch->size[0] * ((int32_T)i - 1)] - 1)] -
          rangem;
        endm = feature2->data[1 + feature2->size[0] * ((int32_T)diagMatch->data
          [1 + diagMatch->size[0] * ((int32_T)i - 1)] - 1)] + rangem;
        keept = true;

        /*                  depdin1 = depdScale1(:,diagRemainMatch(1,i)); */
        /*                  depdin1 = depdin1(depdin1~=0); */
        /*                  depdin2 = depdScale2(:,diagRemainMatch(2,i)); */
        /*                  depdin2 = depdin2(depdin2~=0); */
        /*                  over = overlap (depdin1,depdin2); */
        /*                  if(over < 0.5) */
        /*                      keepd = false; */
        /*                  end */
        j = 1.0;
        guard1 = false;
        exitg1 = false;
        while ((!exitg1) && (j <= counter)) {
          /* (j<=size(diagRemainMatch,2)) && (keept == true)&& (keepd == true) */
          /*  first step check only time */
          i0 = feature1->size[0];
          if (!(2 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(2, 1, i0, &n_emlrtBCI, sp);
          }

          i0 = feature1->size[1];
          b_loop_ub = diagMatch->size[1];
          d_ii = (int32_T)j;
          if (!((d_ii >= 1) && (d_ii <= b_loop_ub))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &ib_emlrtBCI, sp);
          }

          d0 = diagMatch->data[diagMatch->size[0] * (d_ii - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &d_emlrtDCI, sp);
          }

          b_loop_ub = (int32_T)d0;
          if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
            emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &m_emlrtBCI, sp);
          }

          i0 = feature2->size[0];
          if (!(2 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(2, 1, i0, &l_emlrtBCI, sp);
          }

          i0 = feature2->size[1];
          b_loop_ub = diagMatch->size[1];
          d_ii = (int32_T)j;
          if (!((d_ii >= 1) && (d_ii <= b_loop_ub))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &jb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[1 + diagMatch->size[0] * (d_ii - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &c_emlrtDCI, sp);
          }

          b_loop_ub = (int32_T)d0;
          if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
            emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &k_emlrtBCI, sp);
          }

          i0 = feature1->size[0];
          if (!(4 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(4, 1, i0, &j_emlrtBCI, sp);
          }

          i0 = feature1->size[1];
          b_loop_ub = diagMatch->size[1];
          d_ii = (int32_T)j;
          if (!((d_ii >= 1) && (d_ii <= b_loop_ub))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &lb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[diagMatch->size[0] * (d_ii - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &m_emlrtDCI, sp);
          }

          b_loop_ub = (int32_T)d0;
          if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
            emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &kb_emlrtBCI, sp);
          }

          rem_rangec = 3.0 * feature1->data[3 + feature1->size[0] * (b_loop_ub -
            1)];
          i0 = feature2->size[0];
          if (!(4 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(4, 1, i0, &i_emlrtBCI, sp);
          }

          i0 = feature2->size[1];
          b_loop_ub = diagMatch->size[1];
          d_ii = (int32_T)j;
          if (!((d_ii >= 1) && (d_ii <= b_loop_ub))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &nb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[1 + diagMatch->size[0] * (d_ii - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &n_emlrtDCI, sp);
          }

          b_loop_ub = (int32_T)d0;
          if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
            emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &mb_emlrtBCI, sp);
          }

          rem_rangem = 3.0 * feature2->data[3 + feature2->size[0] * (b_loop_ub -
            1)];
          rem_startc = feature1->data[1 + feature1->size[0] * ((int32_T)
            diagMatch->data[diagMatch->size[0] * ((int32_T)j - 1)] - 1)] -
            rem_rangec;
          rem_endc = feature1->data[1 + feature1->size[0] * ((int32_T)
            diagMatch->data[diagMatch->size[0] * ((int32_T)j - 1)] - 1)] +
            rem_rangec;
          rem_startm = feature2->data[1 + feature2->size[0] * ((int32_T)
            diagMatch->data[1 + diagMatch->size[0] * ((int32_T)j - 1)] - 1)] -
            rem_rangem;
          rem_endm = feature2->data[1 + feature2->size[0] * ((int32_T)
            diagMatch->data[1 + diagMatch->size[0] * ((int32_T)j - 1)] - 1)] +
            rem_rangem;
          i0 = feature1->size[0];
          if (!(1 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(1, 1, i0, &h_emlrtBCI, sp);
          }

          i0 = feature1->size[1];
          b_loop_ub = diagMatch->size[1];
          d_ii = (int32_T)j;
          if (!((d_ii >= 1) && (d_ii <= b_loop_ub))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &ob_emlrtBCI, sp);
          }

          d0 = diagMatch->data[diagMatch->size[0] * (d_ii - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &b_emlrtDCI, sp);
          }

          b_loop_ub = (int32_T)d0;
          if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
            emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &g_emlrtBCI, sp);
          }

          i0 = feature2->size[0];
          if (!(1 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(1, 1, i0, &f_emlrtBCI, sp);
          }

          i0 = feature2->size[1];
          b_loop_ub = diagMatch->size[1];
          d_ii = (int32_T)j;
          if (!((d_ii >= 1) && (d_ii <= b_loop_ub))) {
            emlrtDynamicBoundsCheckR2012b(d_ii, 1, b_loop_ub, &pb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[1 + diagMatch->size[0] * (d_ii - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &emlrtDCI, sp);
          }

          b_loop_ub = (int32_T)d0;
          if (!((b_loop_ub >= 1) && (b_loop_ub <= i0))) {
            emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &e_emlrtBCI, sp);
          }

          /* []; */
          /* []; */
          list1[0] = rem_startc;

          /*  [list1;rem_startc;rem_endc]; */
          list1[1] = rem_endc;
          list2[0] = rem_startm;

          /* [list2;rem_startm;rem_endm]; */
          list2[1] = rem_endm;
          list1[2] = startc;

          /*  [list1;startc;endc]; */
          list1[3] = endc;

          /*  */
          list2[2] = startm;

          /* [list2;startm;endm]; */
          list2[3] = endm;

          /*  */
          st.site = &h_emlrtRSI;
          for (d_ii = 0; d_ii < 4; d_ii++) {
            c[d_ii] = list1[d_ii];
          }

          b_st.site = &n_emlrtRSI;
          b_sort(&b_st, c, unusedExpr);
          st.site = &g_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg5 = false;
          while ((!exitg5) && (d_ii < 5)) {
            guard5 = false;
            if (c[d_ii - 1] == startc) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg5 = true;
              } else {
                guard5 = true;
              }
            } else {
              guard5 = true;
            }

            if (guard5) {
              d_ii++;
            }
          }

          if (1 > idx) {
            loop_ub = 0;
          } else {
            loop_ub = idx;
          }

          c_st.site = &lb_emlrtRSI;
          for (i0 = 0; i0 < loop_ub; i0++) {
            rankcstart_data[i0] = ii_data[i0];
          }

          st.site = &f_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg4 = false;
          while ((!exitg4) && (d_ii < 5)) {
            guard4 = false;
            if (c[d_ii - 1] == endc) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg4 = true;
              } else {
                guard4 = true;
              }
            } else {
              guard4 = true;
            }

            if (guard4) {
              d_ii++;
            }
          }

          if (1 > idx) {
            c_loop_ub = 0;
          } else {
            c_loop_ub = idx;
          }

          c_st.site = &lb_emlrtRSI;
          for (i0 = 0; i0 < c_loop_ub; i0++) {
            rankcend_data[i0] = ii_data[i0];
          }

          st.site = &e_emlrtRSI;
          for (d_ii = 0; d_ii < 4; d_ii++) {
            c[d_ii] = list2[d_ii];
          }

          b_st.site = &n_emlrtRSI;
          b_sort(&b_st, c, b_unusedExpr);
          st.site = &d_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg3 = false;
          while ((!exitg3) && (d_ii < 5)) {
            guard3 = false;
            if (c[d_ii - 1] == startm) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg3 = true;
              } else {
                guard3 = true;
              }
            } else {
              guard3 = true;
            }

            if (guard3) {
              d_ii++;
            }
          }

          if (1 > idx) {
            b_loop_ub = 0;
          } else {
            b_loop_ub = idx;
          }

          c_st.site = &lb_emlrtRSI;
          for (i0 = 0; i0 < b_loop_ub; i0++) {
            rankmstart_data[i0] = ii_data[i0];
          }

          st.site = &c_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg2 = false;
          while ((!exitg2) && (d_ii < 5)) {
            guard2 = false;
            if (c[d_ii - 1] == endm) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg2 = true;
              } else {
                guard2 = true;
              }
            } else {
              guard2 = true;
            }

            if (guard2) {
              d_ii++;
            }
          }

          c_st.site = &lb_emlrtRSI;
          if (1 > idx) {
            nx = 0;
          } else {
            nx = idx;
          }

          for (i0 = 0; i0 < nx; i0++) {
            rankmend_data[i0] = ii_data[i0];
          }

          b_guard1 = false;
          if ((startc == rem_startc) && (endc == rem_endc) && (startm ==
               rem_startm) && (endm == rem_endm)) {
            if (feature1->data[feature1->size[0] * ((int32_T)diagMatch->
                 data[diagMatch->size[0] * ((int32_T)j - 1)] - 1)] ==
                feature2->data[feature2->size[0] * ((int32_T)diagMatch->data[1 +
                 diagMatch->size[0] * ((int32_T)j - 1)] - 1)]) {
              keept = false;
              exitg1 = true;
            } else {
              b_guard1 = true;
            }
          } else {
            if (!(1 <= loop_ub)) {
              emlrtDynamicBoundsCheckR2012b(1, 1, loop_ub, &d_emlrtBCI, sp);
            }

            if (!(1 <= b_loop_ub)) {
              emlrtDynamicBoundsCheckR2012b(1, 1, b_loop_ub, &c_emlrtBCI, sp);
            }

            if (rankcstart_data[0] == rankmstart_data[0]) {
              if (!(1 <= c_loop_ub)) {
                emlrtDynamicBoundsCheckR2012b(1, 1, c_loop_ub, &b_emlrtBCI, sp);
              }

              if (1 > idx) {
                i0 = 0;
              } else {
                i0 = idx;
              }

              if (!(1 <= i0)) {
                emlrtDynamicBoundsCheckR2012b(1, 1, i0, &emlrtBCI, sp);
              }

              if (rankcend_data[0] == rankmend_data[0]) {
                b_guard1 = true;
              } else {
                guard1 = true;
                exitg1 = true;
              }
            } else {
              guard1 = true;
              exitg1 = true;
            }
          }

          if (b_guard1) {
            j++;
            if (*emlrtBreakCheckR2012bFlagVar != 0) {
              emlrtBreakCheckR2012b(sp);
            }

            guard1 = false;
          }
        }

        if (guard1) {
          keept = false;
        }

        if (keept) {
          /*                      diagRemainMatch(i) =1;% [diagRemainMatch diagMatch(:,i)]; */
          i0 = diagY_1->size[1];
          b_loop_ub = (int32_T)i;
          if (!(b_loop_ub <= i0)) {
            emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i0, &qb_emlrtBCI, sp);
          }

          *Dist += diagY_1->data[b_loop_ub - 1];
          counter++;
        } else {
          st.site = &b_emlrtRSI;
          eml_null_assignment(&st, diagMatch, i);
          st.site = &emlrtRSI;
          b_eml_null_assignment(&st, diagY_1, i);
          i = (uint32_T)((int32_T)i - 1);
          dimention = diagMatch->size[1];
        }

        i++;
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }

      /*  diagRemainFeature = feature1(:,diagRemainMatch(1,:)); */
      /*  size(diagRemainMatch, 2); */
      i0 = remainQOctave->size[0];
      if (!((ii + 1 >= 1) && (ii + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(ii + 1, 1, i0, &ab_emlrtBCI, sp);
      }

      i0 = remainQOctave->size[1];
      if (!((jj + 1 >= 1) && (jj + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(jj + 1, 1, i0, &bb_emlrtBCI, sp);
      }

      remainQOctave->data[ii + remainQOctave->size[0] * jj] = counter;

      /* [remainQOctave TT]; */
      jj++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    ii++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&c_ii);
  emxFree_real_T(&b_index1);
  emxFree_int32_T(&b_ii);
  emxFree_boolean_T(&x);
  emxFree_boolean_T(&r0);
  emxFree_real_T(&diagMatch);
  emxFree_real_T(&diagY_1);
  emxFree_real_T(&matches11);
  emxFree_real_T(&index1);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (Unpaired_pruning_DAFS_DAFS_DV.c) */
