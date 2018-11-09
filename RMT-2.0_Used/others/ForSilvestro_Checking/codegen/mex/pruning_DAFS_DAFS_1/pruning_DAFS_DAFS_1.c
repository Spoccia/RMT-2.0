/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pruning_DAFS_DAFS_1.c
 *
 * Code generation for function 'pruning_DAFS_DAFS_1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pruning_DAFS_DAFS_1.h"
#include "pruning_DAFS_DAFS_1_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "sort1.h"
#include "eml_setop.h"
#include "pruning_DAFS_DAFS_1_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 98, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo b_emlrtRSI = { 77, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo c_emlrtRSI = { 76, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo d_emlrtRSI = { 75, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo e_emlrtRSI = { 74, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo f_emlrtRSI = { 73, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo g_emlrtRSI = { 72, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo h_emlrtRSI = { 38, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo i_emlrtRSI = { 10, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRSInfo j_emlrtRSI = { 6, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

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

static emlrtRTEInfo emlrtRTEI = { 1, 33, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRTEInfo b_emlrtRTEI = { 253, 13, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRTEInfo c_emlrtRTEI = { 6, 13, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRTEInfo d_emlrtRTEI = { 7, 13, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRTEInfo e_emlrtRTEI = { 11, 13, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRTEInfo f_emlrtRTEI = { 34, 17, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRTEInfo g_emlrtRTEI = { 36, 17, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRTEInfo h_emlrtRTEI = { 36, 6, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtRTEInfo j_emlrtRTEI = { 1, 14, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtBCInfo emlrtBCI = { -1, -1, 83, 80, "rankmend",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 83, 66, "rankcend",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 83, 49, "rankmstart",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 83, 32, "rankcstart",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 53, 50, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 52, 50, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 51, 50, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo emlrtDCI = { 51, 50, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 51, 48, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 50, 50, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo b_emlrtDCI = { 50, 50, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo j_emlrtBCI = { -1, -1, 50, 48, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo k_emlrtBCI = { -1, -1, 36, 40, "depdScale2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo c_emlrtDCI = { 36, 40, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo l_emlrtBCI = { -1, -1, 34, 40, "depdScale1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo d_emlrtDCI = { 34, 40, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo m_emlrtBCI = { -1, -1, 25, 38, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo n_emlrtBCI = { -1, -1, 24, 38, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo o_emlrtBCI = { -1, -1, 23, 38, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo e_emlrtDCI = { 23, 38, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo p_emlrtBCI = { -1, -1, 23, 36, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo q_emlrtBCI = { -1, -1, 22, 38, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo f_emlrtDCI = { 22, 38, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo r_emlrtBCI = { -1, -1, 22, 36, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtECInfo emlrtECI = { 2, 6, 27, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtBCInfo s_emlrtBCI = { -1, -1, 6, 58, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo t_emlrtBCI = { -1, -1, 6, 36, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtRTEInfo p_emlrtRTEI = { 5, 9, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtRTEInfo q_emlrtRTEI = { 4, 5, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m" };

static emlrtDCInfo g_emlrtDCI = { 2, 33, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtDCInfo h_emlrtDCI = { 2, 33, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 4 };

static emlrtDCInfo i_emlrtDCI = { 2, 25, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtDCInfo j_emlrtDCI = { 2, 25, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 4 };

static emlrtRTEInfo r_emlrtRTEI = { 243, 9, "find",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\find.m"
};

static emlrtBCInfo u_emlrtBCI = { -1, -1, 112, 24, "depdin1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo v_emlrtBCI = { -1, -1, 112, 37, "depdin2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo w_emlrtBCI = { -1, -1, 7, 36, "matches",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo x_emlrtBCI = { -1, -1, 8, 30, "combineScore",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo y_emlrtBCI = { -1, -1, 11, 37, "matches11",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo ab_emlrtBCI = { -1, -1, 106, 27, "remainQOctave",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo bb_emlrtBCI = { -1, -1, 106, 30, "remainQOctave",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo cb_emlrtBCI = { -1, -1, 22, 56, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo db_emlrtBCI = { -1, -1, 23, 56, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo eb_emlrtBCI = { -1, -1, 24, 40, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo k_emlrtDCI = { 24, 40, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo fb_emlrtBCI = { -1, -1, 24, 58, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo gb_emlrtBCI = { -1, -1, 25, 40, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo l_emlrtDCI = { 25, 40, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo hb_emlrtBCI = { -1, -1, 25, 58, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo ib_emlrtBCI = { -1, -1, 34, 58, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo jb_emlrtBCI = { -1, -1, 36, 58, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo kb_emlrtBCI = { -1, -1, 50, 68, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo lb_emlrtBCI = { -1, -1, 51, 68, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo mb_emlrtBCI = { -1, -1, 52, 52, "feature1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo m_emlrtDCI = { 52, 52, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo nb_emlrtBCI = { -1, -1, 52, 70, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo ob_emlrtBCI = { -1, -1, 53, 52, "feature2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtDCInfo n_emlrtDCI = { 53, 52, "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 1 };

static emlrtBCInfo pb_emlrtBCI = { -1, -1, 53, 70, "diagRemainMatch",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo qb_emlrtBCI = { -1, -1, 95, 35, "diagY",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo rb_emlrtBCI = { -1, -1, 37, 27, "depdin2",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtBCInfo sb_emlrtBCI = { -1, -1, 35, 27, "depdin1",
  "pruning_DAFS_DAFS_1",
  "D:\\RMT 2_0\\RMT-2.0\\ForSilvestro_Checking\\pruning_DAFS_DAFS_1.m", 0 };

static emlrtRTEInfo t_emlrtRTEI = { 77, 27, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

static emlrtRTEInfo u_emlrtRTEI = { 370, 1, "eml_null_assignment",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\eml\\eml_null_assignment.m"
};

/* Function Declarations */
static void eml_null_assignment(const emlrtStack *sp, emxArray_real_T *x, real_T
  idx);

/* Function Definitions */
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

  emxInit_real_T(&st, &b_x, 2, &j_emlrtRTEI, true);
  j = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 2;
  b_x->size[1] = ncolx;
  emxEnsureCapacity(&st, (emxArray__common *)b_x, j, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  for (j = 0; j < ncolx; j++) {
    for (i = 0; i < 2; i++) {
      b_x->data[i + b_x->size[0] * j] = x->data[i + x->size[0] * j];
    }
  }

  j = x->size[0] * x->size[1];
  x->size[0] = 2;
  x->size[1] = b_x->size[1];
  emxEnsureCapacity(&st, (emxArray__common *)x, j, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  ncolx = b_x->size[1];
  for (j = 0; j < ncolx; j++) {
    for (i = 0; i < 2; i++) {
      x->data[i + x->size[0] * j] = b_x->data[i + b_x->size[0] * j];
    }
  }

  emxFree_real_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void pruning_DAFS_DAFS_1(const emlrtStack *sp, const emxArray_real_T *feature1,
  const emxArray_real_T *depdScale1, const emxArray_real_T *matches, const
  emxArray_real_T *combineScore, const emxArray_real_T *feature2, const
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
  emxArray_real_T *diagMatch;
  emxArray_real_T *depdin1;
  emxArray_real_T *depdin2;
  emxArray_real_T *diagY;
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
  boolean_T guard5 = false;
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
  boolean_T guard4 = false;
  int8_T rankcstart_data[4];
  boolean_T exitg4;
  boolean_T guard3 = false;
  int32_T b_loop_ub;
  int8_T rankcend_data[4];
  int32_T b_unusedExpr[4];
  boolean_T exitg3;
  boolean_T guard2 = false;
  int8_T rankmstart_data[4];
  boolean_T exitg2;
  boolean_T b_guard1 = false;
  int8_T rankmend_data[4];
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
  emxInit_real_T(sp, &diagMatch, 2, &e_emlrtRTEI, true);
  emxInit_real_T1(sp, &depdin1, 1, &f_emlrtRTEI, true);
  emxInit_real_T1(sp, &depdin2, 1, &g_emlrtRTEI, true);
  emxInit_real_T(sp, &diagY, 2, &emlrtRTEI, true);
  emxInit_boolean_T(sp, &r0, 2, &emlrtRTEI, true);
  emxInit_boolean_T(sp, &x, 2, &emlrtRTEI, true);
  emxInit_int32_T(sp, &b_ii, 2, &h_emlrtRTEI, true);
  emxInit_real_T1(sp, &b_index1, 1, &emlrtRTEI, true);
  emxInit_real_T1(sp, &c_ii, 1, &emlrtRTEI, true);
  while (ii <= (int32_T)doctave - 1) {
    emlrtForLoopVectorCheckR2012b(1.0, 1.0, toctave, mxDOUBLE_CLASS, (int32_T)
      toctave, &p_emlrtRTEI, sp);
    jj = 0;
    while (jj <= (int32_T)toctave - 1) {
      i0 = feature1->size[0];
      if (!(5 <= i0)) {
        emlrtDynamicBoundsCheckR2012b(5, 1, i0, &t_emlrtBCI, sp);
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
        emlrtDynamicBoundsCheckR2012b(6, 1, i0, &s_emlrtBCI, sp);
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
        guard5 = false;
        if (x->data[d_ii - 1]) {
          idx++;
          b_ii->data[idx - 1] = d_ii;
          if (idx >= nx) {
            exitg6 = true;
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
            emlrtDynamicBoundsCheckR2012b(nx, 1, d_ii, &w_emlrtBCI, sp);
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
          emlrtDynamicBoundsCheckR2012b(end, 1, d_ii, &x_emlrtBCI, sp);
        }
      }

      st.site = &i_emlrtRSI;
      i0 = diagY->size[0] * diagY->size[1];
      diagY->size[0] = 1;
      diagY->size[1] = index1->size[1];
      emxEnsureCapacity(&st, (emxArray__common *)diagY, i0, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      loop_ub = index1->size[0] * index1->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        diagY->data[i0] = combineScore->data[(int32_T)index1->data[i0] - 1];
      }

      b_st.site = &n_emlrtRSI;
      sort(&b_st, diagY, b_ii);
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
            emlrtDynamicBoundsCheckR2012b(nx, 1, d_ii, &y_emlrtBCI, sp);
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
        /*                  if(i== 24) */
        /*                      disp(i); */
        /*                  end */
        i0 = feature1->size[0];
        if (!(2 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(2, 1, i0, &r_emlrtBCI, sp);
        }

        i0 = feature1->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &cb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &f_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &q_emlrtBCI, sp);
        }

        i0 = feature2->size[0];
        if (!(2 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(2, 1, i0, &p_emlrtBCI, sp);
        }

        i0 = feature2->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &db_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &e_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &o_emlrtBCI, sp);
        }

        i0 = feature1->size[0];
        if (!(4 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(4, 1, i0, &n_emlrtBCI, sp);
        }

        i0 = feature1->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &fb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &k_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &eb_emlrtBCI, sp);
        }

        rangec = 3.0 * feature1->data[3 + feature1->size[0] * (end - 1)];
        i0 = feature2->size[0];
        if (!(4 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(4, 1, i0, &m_emlrtBCI, sp);
        }

        i0 = feature2->size[1];
        end = diagMatch->size[1];
        nx = (int32_T)i;
        if (!(nx <= end)) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &hb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &l_emlrtDCI, sp);
        }

        end = (int32_T)d0;
        if (!((end >= 1) && (end <= i0))) {
          emlrtDynamicBoundsCheckR2012b(end, 1, i0, &gb_emlrtBCI, sp);
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
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &ib_emlrtBCI, sp);
        }

        d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &d_emlrtDCI, sp);
        }

        nx = (int32_T)d0;
        if (!((nx >= 1) && (nx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, i0, &l_emlrtBCI, sp);
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
              emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, i0, &sb_emlrtBCI, sp);
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
          emlrtDynamicBoundsCheckR2012b(nx, 1, end, &jb_emlrtBCI, sp);
        }

        d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
        if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
          emlrtIntegerCheckR2012b(d0, &c_emlrtDCI, sp);
        }

        nx = (int32_T)d0;
        if (!((nx >= 1) && (nx <= i0))) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, i0, &k_emlrtBCI, sp);
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
              emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, i0, &rb_emlrtBCI, sp);
            }

            depdin2->data[d_ii] = depdin2->data[b_i];
            d_ii++;
          }
        }

        i0 = depdin2->size[0];
        depdin2->size[0] = idx;
        emxEnsureCapacity(sp, (emxArray__common *)depdin2, i0, (int32_T)sizeof
                          (real_T), &emlrtRTEI);
        st.site = &h_emlrtRSI;
        i0 = depdin1->size[0];
        if (!(1 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(1, 1, i0, &u_emlrtBCI, &st);
        }

        i0 = depdin2->size[0];
        if (!(1 <= i0)) {
          emlrtDynamicBoundsCheckR2012b(1, 1, i0, &v_emlrtBCI, &st);
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
          if (!(2 <= i0)) {
            emlrtDynamicBoundsCheckR2012b(2, 1, i0, &j_emlrtBCI, sp);
          }

          i0 = feature1->size[1];
          end = diagMatch->size[1];
          nx = (int32_T)j;
          if (!((nx >= 1) && (nx <= end))) {
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &kb_emlrtBCI, sp);
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
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &lb_emlrtBCI, sp);
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
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &nb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &m_emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &mb_emlrtBCI, sp);
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
            emlrtDynamicBoundsCheckR2012b(nx, 1, end, &pb_emlrtBCI, sp);
          }

          d0 = diagMatch->data[1 + diagMatch->size[0] * (nx - 1)];
          if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
            emlrtIntegerCheckR2012b(d0, &n_emlrtDCI, sp);
          }

          end = (int32_T)d0;
          if (!((end >= 1) && (end <= i0))) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &ob_emlrtBCI, sp);
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
          st.site = &g_emlrtRSI;
          for (b_i = 0; b_i < 4; b_i++) {
            c[b_i] = list1[b_i];
          }

          b_st.site = &n_emlrtRSI;
          b_sort(&b_st, c, unusedExpr);
          st.site = &f_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg5 = false;
          while ((!exitg5) && (d_ii < 5)) {
            guard4 = false;
            if (c[d_ii - 1] == startc) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg5 = true;
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
            loop_ub = 0;
          } else {
            loop_ub = idx;
          }

          c_st.site = &lb_emlrtRSI;
          for (i0 = 0; i0 < loop_ub; i0++) {
            rankcstart_data[i0] = ii_data[i0];
          }

          st.site = &e_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg4 = false;
          while ((!exitg4) && (d_ii < 5)) {
            guard3 = false;
            if (c[d_ii - 1] == endc) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg4 = true;
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
            rankcend_data[i0] = ii_data[i0];
          }

          st.site = &d_emlrtRSI;
          for (b_i = 0; b_i < 4; b_i++) {
            c[b_i] = list2[b_i];
          }

          b_st.site = &n_emlrtRSI;
          b_sort(&b_st, c, b_unusedExpr);
          st.site = &c_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg3 = false;
          while ((!exitg3) && (d_ii < 5)) {
            guard2 = false;
            if (c[d_ii - 1] == startm) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg3 = true;
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

          if (1 > idx) {
            end = 0;
          } else {
            end = idx;
          }

          c_st.site = &lb_emlrtRSI;
          for (i0 = 0; i0 < end; i0++) {
            rankmstart_data[i0] = ii_data[i0];
          }

          st.site = &b_emlrtRSI;
          b_st.site = &k_emlrtRSI;
          idx = 0;
          d_ii = 1;
          exitg2 = false;
          while ((!exitg2) && (d_ii < 5)) {
            b_guard1 = false;
            if (c[d_ii - 1] == endm) {
              idx++;
              ii_data[idx - 1] = (int8_T)d_ii;
              if (idx >= 4) {
                exitg2 = true;
              } else {
                b_guard1 = true;
              }
            } else {
              b_guard1 = true;
            }

            if (b_guard1) {
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

          if ((startc == rem_startc) && (endc == rem_endc) && (startm ==
               rem_startm) && (endm == rem_endm)) {
            keept = false;
            exitg1 = true;
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
                j++;
                if (*emlrtBreakCheckR2012bFlagVar != 0) {
                  emlrtBreakCheckR2012b(sp);
                }

                guard1 = false;
              } else {
                guard1 = true;
                exitg1 = true;
              }
            } else {
              guard1 = true;
              exitg1 = true;
            }
          }
        }

        if (guard1) {
          keept = false;
        }

        if (keept && keepd) {
          /*                      diagRemainMatch(i) =1;% [diagRemainMatch diagMatch(:,i)]; */
          i0 = diagY->size[1];
          end = (int32_T)i;
          if (!(end <= i0)) {
            emlrtDynamicBoundsCheckR2012b(end, 1, i0, &qb_emlrtBCI, sp);
          }

          *Dist += diagY->data[end - 1];
          counter++;
        } else {
          st.site = &emlrtRSI;
          eml_null_assignment(&st, diagMatch, i);
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
  emxFree_real_T(&diagY);
  emxFree_real_T(&depdin2);
  emxFree_real_T(&depdin1);
  emxFree_real_T(&diagMatch);
  emxFree_real_T(&matches11);
  emxFree_real_T(&index1);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (pruning_DAFS_DAFS_1.c) */
