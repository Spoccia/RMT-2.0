/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Paired_pruning_DAFS_DAFS_DV.c
 *
 * Code generation for function 'Paired_pruning_DAFS_DAFS_DV'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Paired_pruning_DAFS_DAFS_DV.h"
#include "Paired_pruning_DAFS_DAFS_DV_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "sort1.h"
#include "eml_setop.h"
#include "Paired_pruning_DAFS_DAFS_DV_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 111, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo b_emlrtRSI = { 110, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo c_emlrtRSI = { 85, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo d_emlrtRSI = { 84, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo e_emlrtRSI = { 83, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo f_emlrtRSI = { 82, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo g_emlrtRSI = { 81, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo h_emlrtRSI = { 80, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo i_emlrtRSI = { 42, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo j_emlrtRSI = { 12, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo k_emlrtRSI = { 8, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRSInfo l_emlrtRSI = { 44, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRSInfo m_emlrtRSI = { 234, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRSInfo o_emlrtRSI = { 26, "sort",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\datafun\\sort.m"
};

static emlrtRSInfo mb_emlrtRSI = { 253, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRSInfo ob_emlrtRSI = { 26, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRSInfo pb_emlrtRSI = { 30, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRSInfo qb_emlrtRSI = { 347, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 33, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo b_emlrtRTEI = { 253, 13, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRTEInfo c_emlrtRTEI = { 8, 13, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo d_emlrtRTEI = { 9, 13, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo e_emlrtRTEI = { 13, 13, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo f_emlrtRTEI = { 14, 13, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo g_emlrtRTEI = { 38, 17, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo h_emlrtRTEI = { 40, 17, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo i_emlrtRTEI = { 36, 6, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRTEInfo k_emlrtRTEI = { 1, 14, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRTEInfo q_emlrtRTEI = { 371, 1, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtBCInfo emlrtBCI = { -1, -1, 95, 80, "rankmend",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 95, 66, "rankcend",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 95, 49, "rankmstart",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 95, 32, "rankcstart",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 59, 50, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 58, 50, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 57, 50, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo emlrtDCI = { 57, 50, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 57, 48, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 56, 50, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo b_emlrtDCI = { 56, 50, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo j_emlrtBCI = { -1, -1, 56, 48, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo k_emlrtBCI = { -1, -1, 54, 51, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo c_emlrtDCI = { 54, 51, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo l_emlrtBCI = { -1, -1, 54, 49, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo m_emlrtBCI = { -1, -1, 53, 51, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo d_emlrtDCI = { 53, 51, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo n_emlrtBCI = { -1, -1, 53, 49, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo o_emlrtBCI = { -1, -1, 40, 40, "depdScale2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo e_emlrtDCI = { 40, 40, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo p_emlrtBCI = { -1, -1, 38, 40, "depdScale1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo f_emlrtDCI = { 38, 40, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo q_emlrtBCI = { -1, -1, 29, 38, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo r_emlrtBCI = { -1, -1, 28, 38, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo s_emlrtBCI = { -1, -1, 27, 38, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo g_emlrtDCI = { 27, 38, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo t_emlrtBCI = { -1, -1, 27, 36, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo u_emlrtBCI = { -1, -1, 26, 38, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo h_emlrtDCI = { 26, 38, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo v_emlrtBCI = { -1, -1, 26, 36, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo w_emlrtBCI = { -1, -1, 24, 46, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo i_emlrtDCI = { 24, 46, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo x_emlrtBCI = { -1, -1, 24, 44, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo y_emlrtBCI = { -1, -1, 23, 46, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo j_emlrtDCI = { 23, 46, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo ab_emlrtBCI = { -1, -1, 23, 44, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtECInfo emlrtECI = { 2, 8, 27, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtBCInfo bb_emlrtBCI = { -1, -1, 8, 58, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo cb_emlrtBCI = { -1, -1, 8, 36, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtRTEInfo r_emlrtRTEI = { 7, 9, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtRTEInfo s_emlrtRTEI = { 6, 5, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m" };

static emlrtDCInfo k_emlrtDCI = { 4, 33, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtDCInfo l_emlrtDCI = { 4, 33, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  4 };

static emlrtDCInfo m_emlrtDCI = { 4, 25, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtDCInfo n_emlrtDCI = { 4, 25, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  4 };

static emlrtRTEInfo t_emlrtRTEI = { 243, 9, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtBCInfo db_emlrtBCI = { -1, -1, 125, 24, "depdin1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo eb_emlrtBCI = { -1, -1, 125, 37, "depdin2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo fb_emlrtBCI = { -1, -1, 9, 36, "matches",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo gb_emlrtBCI = { -1, -1, 10, 30, "combineScore",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo hb_emlrtBCI = { -1, -1, 14, 37, "matches11",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo ib_emlrtBCI = { -1, -1, 119, 27, "remainQOctave",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo jb_emlrtBCI = { -1, -1, 119, 30, "remainQOctave",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo kb_emlrtBCI = { -1, -1, 23, 64, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo lb_emlrtBCI = { -1, -1, 24, 64, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo mb_emlrtBCI = { -1, -1, 26, 56, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo nb_emlrtBCI = { -1, -1, 27, 56, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo ob_emlrtBCI = { -1, -1, 28, 40, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo o_emlrtDCI = { 28, 40, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo pb_emlrtBCI = { -1, -1, 28, 58, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo qb_emlrtBCI = { -1, -1, 29, 40, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo p_emlrtDCI = { 29, 40, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo rb_emlrtBCI = { -1, -1, 29, 58, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo sb_emlrtBCI = { -1, -1, 38, 58, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo tb_emlrtBCI = { -1, -1, 40, 58, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo ub_emlrtBCI = { -1, -1, 53, 69, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo vb_emlrtBCI = { -1, -1, 54, 69, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo wb_emlrtBCI = { -1, -1, 56, 68, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo xb_emlrtBCI = { -1, -1, 57, 68, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo yb_emlrtBCI = { -1, -1, 58, 52, "feature1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo q_emlrtDCI = { 58, 52, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo ac_emlrtBCI = { -1, -1, 58, 70, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo bc_emlrtBCI = { -1, -1, 59, 52, "feature2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtDCInfo r_emlrtDCI = { 59, 52, "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  1 };

static emlrtBCInfo cc_emlrtBCI = { -1, -1, 59, 70, "diagRemainMatch",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo dc_emlrtBCI = { -1, -1, 107, 35, "diagY_1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo ec_emlrtBCI = { -1, -1, 41, 27, "depdin2",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtBCInfo fc_emlrtBCI = { -1, -1, 39, 27, "depdin1",
  "Paired_pruning_DAFS_DAFS_DV",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\Paired_pruning_DAFS_DAFS_DV.m",
  0 };

static emlrtRTEInfo v_emlrtRTEI = { 77, 27, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRTEInfo w_emlrtRTEI = { 370, 1, "eml_null_assignment",
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
  st.site = &ob_emlrtRSI;
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
    emlrtErrorWithMessageIdR2012b(&st, &v_emlrtRTEI, "MATLAB:subsdeldimmismatch",
      0);
  }

  st.site = &pb_emlrtRSI;
  ncolx = x->size[1] - 1;
  b_st.site = &qb_emlrtRSI;
  if ((int32_T)idx > x->size[1] - 1) {
    overflow = false;
  } else {
    overflow = (x->size[1] - 1 > 2147483646);
  }

  if (overflow) {
    c_st.site = &n_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (j = (int32_T)idx; j <= ncolx; j++) {
    x->data[x->size[0] * (j - 1)] = x->data[x->size[0] * j];
  }

  if (ncolx <= ncolx + 1) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &w_emlrtRTEI,
      "Coder:builtins:AssertionFailed", 0);
  }

  j = x->size[0] * x->size[1];
  if (1 > ncolx) {
    x->size[1] = 0;
  } else {
    x->size[1] = ncolx;
  }

  emxEnsureCapacity(&st, (emxArray__common *)x, j, (int32_T)sizeof(real_T),
                    &q_emlrtRTEI);
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
  st.site = &ob_emlrtRSI;
  overflow = true;
  if (((int32_T)idx > x->size[1]) || (idx != idx)) {
    overflow = false;
  }

  if (overflow) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &v_emlrtRTEI, "MATLAB:subsdeldimmismatch",
      0);
  }

  st.site = &pb_emlrtRSI;
  ncolx = x->size[1] - 1;
  b_st.site = &qb_emlrtRSI;
  if ((int32_T)idx > x->size[1] - 1) {
    overflow = false;
  } else {
    overflow = (x->size[1] - 1 > 2147483646);
  }

  if (overflow) {
    c_st.site = &n_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (j = (int32_T)idx; j <= ncolx; j++) {
    for (i = 0; i < 2; i++) {
      x->data[i + x->size[0] * (j - 1)] = x->data[i + x->size[0] * j];
    }
  }

  if (ncolx <= ncolx + 1) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &w_emlrtRTEI,
      "Coder:builtins:AssertionFailed", 0);
  }

  if (1 > ncolx) {
    ncolx = 0;
  }

  emxInit_real_T(&st, &b_x, 2, &k_emlrtRTEI, true);
  j = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 2;
  b_x->size[1] = ncolx;
  emxEnsureCapacity(&st, (emxArray__common *)b_x, j, (int32_T)sizeof(real_T),
                    &k_emlrtRTEI);
  for (j = 0; j < ncolx; j++) {
    for (i = 0; i < 2; i++) {
      b_x->data[i + b_x->size[0] * j] = x->data[i + x->size[0] * j];
    }
  }

  j = x->size[0] * x->size[1];
  x->size[0] = 2;
  x->size[1] = b_x->size[1];
  emxEnsureCapacity(&st, (emxArray__common *)x, j, (int32_T)sizeof(real_T),
                    &k_emlrtRTEI);
  ncolx = b_x->size[1];
  for (j = 0; j < ncolx; j++) {
    for (i = 0; i < 2; i++) {
      x->data[i + x->size[0] * j] = b_x->data[i + b_x->size[0] * j];
    }
  }

  emxFree_real_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void Paired_pruning_DAFS_DAFS_DV(const emlrtStack *sp, const emxArray_real_T
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
  emxArray_real_T *depdin1;
  emxArray_real_T *depdin2;
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
  int32_T end;
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
  boolean_T keepd;
  int32_T b_i;
  int32_T ib_size[1];
  int32_T ib_data[1];
  int32_T ia_size[1];
  int32_T ia_data[1];
  int32_T ov_size[2];
  real_T ov_data[1];
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
  int32_T b_loop_ub;
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
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);

  /*  pruning considering that two feature overlapping in time should have also */
  /*  same variate */
  i0 = remainQOctave->size[0] * remainQOctave->size[1];
  if (!(doctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(doctave, &n_emlrtDCI, sp);
  }

  d0 = doctave;
  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &m_emlrtDCI, sp);
  }

  remainQOctave->size[0] = (int32_T)d0;
  if (!(toctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(toctave, &l_emlrtDCI, sp);
  }

  d0 = toctave;
  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &k_emlrtDCI, sp);
  }

  remainQOctave->size[1] = (int32_T)d0;
  emxEnsureCapacity(sp, (emxArray__common *)remainQOctave, i0, (int32_T)sizeof
                    (real_T), &emlrtRTEI);
  if (!(doctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(doctave, &n_emlrtDCI, sp);
  }

  d0 = doctave;
  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &m_emlrtDCI, sp);
  }

  if (!(toctave > 0.0)) {
    emlrtNonNegativeCheckR2012b(toctave, &l_emlrtDCI, sp);
  }

  d1 = toctave;
  if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
    emlrtIntegerCheckR2012b(d1, &k_emlrtDCI, sp);
  }

  loop_ub = (int32_T)d0 * (int32_T)d1;
  for (i0 = 0; i0 < loop_ub; i0++) {
    remainQOctave->data[i0] = 0.0;
  }

  *Dist = 0.0;
  emlrtForLoopVectorCheckR2012b(1.0, 1.0, doctave, mxDOUBLE_CLASS, (int32_T)
    doctave, &s_emlrtRTEI, sp);
  ii = 0;
  emxInit_real_T(sp, &index1, 2, &c_emlrtRTEI, true);
  emxInit_real_T(sp, &matches11, 2, &d_emlrtRTEI, true);
  emxInit_real_T(sp, &diagY_1, 2, &e_emlrtRTEI, true);
  emxInit_real_T(sp, &diagMatch, 2, &f_emlrtRTEI, true);
  emxInit_real_T1(sp, &depdin1, 1, &g_emlrtRTEI, true);
  emxInit_real_T1(sp, &depdin2, 1, &h_emlrtRTEI, true);
  emxInit_boolean_T(sp, &r0, 2, &emlrtRTEI, true);
  emxInit_boolean_T(sp, &x, 2, &emlrtRTEI, true);
  emxInit_int32_T(sp, &b_ii, 2, &i_emlrtRTEI, true);
  emxInit_real_T1(sp, &b_index1, 1, &emlrtRTEI, true);
  emxInit_real_T1(sp, &c_ii, 1, &emlrtRTEI, true);
  while (ii <= (int32_T)doctave - 1) {
    emlrtForLoopVectorCheckR2012b(1.0, 1.0, toctave, mxDOUBLE_CLASS, (int32_T)
      toctave, &r_emlrtRTEI, sp);
    jj = 0;
    while (jj <= (int32_T)toctave - 1) {
      i0 = feature1->size[0];
      if (!(5 <= i0)) {
        emlrtDynamicBoundsCheckR2012b(5, 1, i0, &cb_emlrtBCI, sp);
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
        emlrtDynamicBoundsCheckR2012b(6, 1, i0, &bb_emlrtBCI, sp);
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

      st.site = &k_emlrtRSI;
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

      b_st.site = &l_emlrtRSI;
      nx = x->size[1];
      idx = 0;
      i0 = b_ii->size[0] * b_ii->size[1];
      b_ii->size[0] = 1;
      b_ii->size[1] = x->size[1];
      emxEnsureCapacity(&b_st, (emxArray__common *)b_ii, i0, (int32_T)sizeof
                        (int32_T), &emlrtRTEI);
      c_st.site = &m_emlrtRSI;
      if (1 > x->size[1]) {
        overflow = false;
      } else {
        overflow = (x->size[1] > 2147483646);
      }

      if (overflow) {
        d_st.site = &n_emlrtRSI;
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
        emlrtErrorWithMessageIdR2012b(&b_st, &t_emlrtRTEI,
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

      d_ii = matches->size[1];
      i0 = matches11->size[0] * matches11->size[1];
      matches11->size[0] = 2;
      matches11->size[1] = index1->size[1];
      emxEnsureCapacity(sp, (emxArray__common *)matches11, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        for (end = 0; end < 2; end++) {
          nx = (int32_T)index1->data[index1->size[0] * i0];
          if (!((nx >= 1) && (nx <= d_ii))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, d_ii, &fb_emlrtBCI, sp);
          }

          matches11->data[end + matches11->size[0] * i0] = matches->data[end +
            matches->size[0] * (nx - 1)];
        }
      }

      d_ii = combineScore->size[1];
      loop_ub = index1->size[0] * index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        end = (int32_T)index1->data[i0];
        if (!((end >= 1) && (end <= d_ii))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, d_ii, &gb_emlrtBCI, sp);
        }
      }

      st.site = &j_emlrtRSI;
      i0 = diagY_1->size[0] * diagY_1->size[1];
      diagY_1->size[0] = 1;
      diagY_1->size[1] = index1->size[1];
      emxEnsureCapacity(&st, (emxArray__common *)diagY_1, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = index1->size[0] * index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        diagY_1->data[i0] = combineScore->data[(int32_T)index1->data[i0] - 1];
      }

      b_st.site = &o_emlrtRSI;
      sort(&b_st, diagY_1, b_ii);
      i0 = b_index1->size[0];
      b_index1->size[0] = index1->size[1];
      emxEnsureCapacity(sp, (emxArray__common *)b_index1, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_index1->data[i0] = index1->data[index1->size[0] * i0];
      }

      d_ii = b_index1->size[0];
      i0 = diagMatch->size[0] * diagMatch->size[1];
      diagMatch->size[0] = 2;
      diagMatch->size[1] = b_ii->size[1];
      emxEnsureCapacity(sp, (emxArray__common *)diagMatch, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = b_ii->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        for (end = 0; end < 2; end++) {
          nx = b_ii->data[b_ii->size[0] * i0];
          if (!((nx >= 1) && (nx <= d_ii))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, d_ii, &hb_emlrtBCI, sp);
          }

          diagMatch->data[end + diagMatch->size[0] * i0] = matches11->data[end +
            matches11->size[0] * (nx - 1)];
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
        if (!(1 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(1, 1, i0, &ab_emlrtBCI, sp);
        }

        i0 = feature1->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &kb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &j_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &y_emlrtBCI, sp);
        }

        i0 = feature2->size[0];
        if (!(1 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(1, 1, i0, &x_emlrtBCI, sp);
        }

        i0 = feature2->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &lb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &i_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &w_emlrtBCI, sp);
        }

        i0 = feature1->size[0];
        if (!(2 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(2, 1, i0, &v_emlrtBCI, sp);
        }

        i0 = feature1->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &mb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &h_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &u_emlrtBCI, sp);
        }

        i0 = feature2->size[0];
        if (!(2 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(2, 1, i0, &t_emlrtBCI, sp);
        }

        i0 = feature2->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &nb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &g_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &s_emlrtBCI, sp);
        }

        i0 = feature1->size[0];
        if (!(4 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(4, 1, i0, &r_emlrtBCI, sp);
        }

        i0 = feature1->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &pb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &o_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &ob_emlrtBCI, sp);
        }

        rangec = 3.0 * feature1->data[3 + feature1->size[0] * (end - 1)];
        i0 = feature2->size[0];
        if (!(4 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(4, 1, i0, &q_emlrtBCI, sp);
        }

        i0 = feature2->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &rb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &p_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &qb_emlrtBCI, sp);
        }

        rangem = 3.0 * feature2->data[3 + feature2->size[0] * (end - 1)];
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
        keepd = true;
        loop_ub = depdScale1->size[0];
        i0 = depdScale1->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &sb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &f_emlrtDCI, sp);
        }

        nx = (int32_T)d0;
        if (!((nx >= 1) && (nx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, i0, &p_emlrtBCI, sp);
        }

        i0 = depdin1->size[0];
        depdin1->size[0] = loop_ub;
        emxEnsureCapacity(sp, (emxArray__common *)depdin1, i0, (int32_T)sizeof
                          (real_T), &emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          depdin1->data[i0] = depdScale1->data[i0 + depdScale1->size[0] * (nx -
            1)];
        }

        end = depdScale1->size[0] - 1;
        idx = 0;
        for (b_i = 0; b_i <= end; b_i++) {
          nx = (int32_T)diagMatch->data[diagMatch->size[0] * ((int32_T)i - 1)];
          if (depdScale1->data[b_i + depdScale1->size[0] * (nx - 1)] != 0.0) {
            idx++;
          }
        }

        d_ii = 0;
        for (b_i = 0; b_i <= end; b_i++) {
          if (depdin1->data[b_i] != 0.0) {
            i0 = depdin1->size[0];
            if (!((b_i + 1 >= 1) && (b_i + 1 <= i0))) {
              emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, i0, &fc_emlrtBCI, sp);
            }

            depdin1->data[d_ii] = depdin1->data[b_i];
            d_ii++;
          }
        }

        i0 = depdin1->size[0];
        depdin1->size[0] = idx;
        emxEnsureCapacity(sp, (emxArray__common *)depdin1, i0, (int32_T)sizeof
                          (real_T), &emlrtRTEI);
        loop_ub = depdScale2->size[0];
        i0 = depdScale2->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &tb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &e_emlrtDCI, sp);
        }

        nx = (int32_T)d0;
        if (!((nx >= 1) && (nx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, i0, &o_emlrtBCI, sp);
        }

        i0 = depdin2->size[0];
        depdin2->size[0] = loop_ub;
        emxEnsureCapacity(sp, (emxArray__common *)depdin2, i0, (int32_T)sizeof
                          (real_T), &emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          depdin2->data[i0] = depdScale2->data[i0 + depdScale2->size[0] * (nx -
            1)];
        }

        end = depdScale2->size[0] - 1;
        idx = 0;
        for (b_i = 0; b_i <= end; b_i++) {
          nx = (int32_T)diagMatch->data[1 + diagMatch->size[0] * ((int32_T)i - 1)];
          if (depdScale2->data[b_i + depdScale2->size[0] * (nx - 1)] != 0.0) {
            idx++;
          }
        }

        d_ii = 0;
        for (b_i = 0; b_i <= end; b_i++) {
          if (depdin2->data[b_i] != 0.0) {
            i0 = depdin2->size[0];
            if (!((b_i + 1 >= 1) && (b_i + 1 <= i0))) {
              emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, i0, &ec_emlrtBCI, sp);
            }

            depdin2->data[d_ii] = depdin2->data[b_i];
            d_ii++;
          }
        }

        i0 = depdin2->size[0];
        depdin2->size[0] = idx;
        emxEnsureCapacity(sp, (emxArray__common *)depdin2, i0, (int32_T)sizeof
                          (real_T), &emlrtRTEI);
        st.site = &i_emlrtRSI;
        i0 = depdin1->size[0];
        if (!(1 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(1, 1, i0, &db_emlrtBCI, &st);
        }

        i0 = depdin2->size[0];
        if (!(1 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(1, 1, i0, &eb_emlrtBCI, &st);
        }

        do_vectors(depdin1->data[0], depdin2->data[0], ov_data, ov_size, ia_data,
                   ia_size, ib_data, ib_size);
        if (ov_size[1] < 0.5) {
          keepd = false;
        }

        j = 1.0;
        guard1 = false;
        exitg1 = false;
        while ((!exitg1) && ((j <= counter) && keepd)) {
          /* (j<=size(diagRemainMatch,2)) && (keept == true)&& (keepd == true) */
          /*  first step check only time */
          i0 = feature1->size[0];
          if (!(1 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(1, 1, i0, &n_emlrtBCI, sp);
          }

          i0 = feature1->size[1];
          end = diagMatch->size[1];
          nx = (int32_T)j;
          if (!((nx >= 1) && (nx <= end))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &ub_emlrtBCI, sp);
          }

          d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &d_emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &m_emlrtBCI, sp);
          }

          i0 = feature2->size[0];
          if (!(1 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(1, 1, i0, &l_emlrtBCI, sp);
          }

          i0 = feature2->size[1];
          end = diagMatch->size[1];
          nx = (int32_T)j;
          if (!((nx >= 1) && (nx <= end))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &vb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &c_emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &k_emlrtBCI, sp);
          }

          i0 = feature1->size[0];
          if (!(2 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(2, 1, i0, &j_emlrtBCI, sp);
          }

          i0 = feature1->size[1];
          end = diagMatch->size[1];
          nx = (int32_T)j;
          if (!((nx >= 1) && (nx <= end))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &wb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &b_emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &i_emlrtBCI, sp);
          }

          i0 = feature2->size[0];
          if (!(2 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(2, 1, i0, &h_emlrtBCI, sp);
          }

          i0 = feature2->size[1];
          end = diagMatch->size[1];
          nx = (int32_T)j;
          if (!((nx >= 1) && (nx <= end))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &xb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &g_emlrtBCI, sp);
          }

          i0 = feature1->size[0];
          if (!(4 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(4, 1, i0, &f_emlrtBCI, sp);
          }

          i0 = feature1->size[1];
          end = diagMatch->size[1];
          nx = (int32_T)j;
          if (!((nx >= 1) && (nx <= end))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &ac_emlrtBCI, sp);
          }

          d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &q_emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &yb_emlrtBCI, sp);
          }

          rem_rangec = 3.0 * feature1->data[3 + feature1->size[0] * (end - 1)];
          i0 = feature2->size[0];
          if (!(4 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(4, 1, i0, &e_emlrtBCI, sp);
          }

          i0 = feature2->size[1];
          end = diagMatch->size[1];
          nx = (int32_T)j;
          if (!((nx >= 1) && (nx <= end))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &cc_emlrtBCI, sp);
          }

          d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &r_emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &bc_emlrtBCI, sp);
          }

          rem_rangem = 3.0 * feature2->data[3 + feature2->size[0] * (end - 1)];
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

          /*                           */
          /*                          VariateF1 = feature1(1,diagRemainMatch(1,j)); */
          /*                          VariateF2 = feature2(1,diagRemainMatch(2,j)); */
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
          for (b_i = 0; b_i < 4; b_i++) {
            c[b_i] = list1[b_i];
          }

          b_st.site = &o_emlrtRSI;
          b_sort(&b_st, c, unusedExpr);
          st.site = &g_emlrtRSI;
          b_st.site = &l_emlrtRSI;
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

          c_st.site = &mb_emlrtRSI;
          for (i0 = 0; i0 < loop_ub; i0++) {
            rankcstart_data[i0] = ii_data[i0];
          }

          st.site = &f_emlrtRSI;
          b_st.site = &l_emlrtRSI;
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
            b_loop_ub = 0;
          } else {
            b_loop_ub = idx;
          }

          c_st.site = &mb_emlrtRSI;
          for (i0 = 0; i0 < b_loop_ub; i0++) {
            rankcend_data[i0] = ii_data[i0];
          }

          st.site = &e_emlrtRSI;
          for (b_i = 0; b_i < 4; b_i++) {
            c[b_i] = list2[b_i];
          }

          b_st.site = &o_emlrtRSI;
          b_sort(&b_st, c, b_unusedExpr);
          st.site = &d_emlrtRSI;
          b_st.site = &l_emlrtRSI;
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
            end = 0;
          } else {
            end = idx;
          }

          c_st.site = &mb_emlrtRSI;
          for (i0 = 0; i0 < end; i0++) {
            rankmstart_data[i0] = ii_data[i0];
          }

          st.site = &c_emlrtRSI;
          b_st.site = &l_emlrtRSI;
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

          c_st.site = &mb_emlrtRSI;
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
                 data[diagMatch->size[0] * ((int32_T)i - 1)] - 1)] ==
                feature1->data[feature1->size[0] * ((int32_T)diagMatch->
                 data[diagMatch->size[0] * ((int32_T)j - 1)] - 1)]) {
              keept = false;
              exitg1 = true;
            } else {
              b_guard1 = true;
            }
          } else {
            if (!(1 <= loop_ub)) {
              emlrtDynamicBoundsCheckR2012b(1, 1, loop_ub, &d_emlrtBCI, sp);
            }

            if (!(1 <= end)) {
              emlrtDynamicBoundsCheckR2012b(1, 1, end, &c_emlrtBCI, sp);
            }

            if (rankcstart_data[0] == rankmstart_data[0]) {
              if (!(1 <= b_loop_ub)) {
                emlrtDynamicBoundsCheckR2012b(1, 1, b_loop_ub, &b_emlrtBCI, sp);
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

        if (keept && keepd) {
          /*                      diagRemainMatch(i) =1;% [diagRemainMatch diagMatch(:,i)]; */
          i0 = diagY_1->size[1];
          end = (int32_T)i;
          if (!(end <= i0)) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &dc_emlrtBCI, sp);
          }

          *Dist += diagY_1->data[end - 1];
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
        emlrtDynamicBoundsCheckR2012b(ii + 1, 1, i0, &ib_emlrtBCI, sp);
      }

      i0 = remainQOctave->size[1];
      if (!((jj + 1 >= 1) && (jj + 1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(jj + 1, 1, i0, &jb_emlrtBCI, sp);
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
  emxFree_real_T(&depdin2);
  emxFree_real_T(&depdin1);
  emxFree_real_T(&diagMatch);
  emxFree_real_T(&diagY_1);
  emxFree_real_T(&matches11);
  emxFree_real_T(&index1);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (Paired_pruning_DAFS_DAFS_DV.c) */
