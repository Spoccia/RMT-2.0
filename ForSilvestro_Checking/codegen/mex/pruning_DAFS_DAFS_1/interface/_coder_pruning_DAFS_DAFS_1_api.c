/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_pruning_DAFS_DAFS_1_api.c
 *
 * Code generation for function '_coder_pruning_DAFS_DAFS_1_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pruning_DAFS_DAFS_1.h"
#include "_coder_pruning_DAFS_DAFS_1_api.h"
#include "pruning_DAFS_DAFS_1_emxutil.h"
#include "pruning_DAFS_DAFS_1_mexutil.h"
#include "pruning_DAFS_DAFS_1_data.h"

/* Variable Definitions */
static emlrtRTEInfo k_emlrtRTEI = { 1, 1, "_coder_pruning_DAFS_DAFS_1_api", "" };

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *matches,
  const char_T *identifier, emxArray_real_T *y);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static const mxArray *d_emlrt_marshallOut(const emxArray_real_T *u);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *combineScore,
  const char_T *identifier, emxArray_real_T *y);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *feature1,
  const char_T *identifier, emxArray_real_T *y);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *doctave,
  const char_T *identifier);
static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static real_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *matches,
  const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(matches), &thisId, y);
  emlrtDestroyArray(&matches);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  j_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *d_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv1[2] = { 0, 0 };

  const mxArray *m3;
  y = NULL;
  m3 = emlrtCreateNumericArray(2, iv1, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m3, (void *)u->data);
  emlrtSetDimensions((mxArray *)m3, u->size, 2);
  emlrtAssign(&y, m3);
  return y;
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *combineScore,
  const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(combineScore), &thisId, y);
  emlrtDestroyArray(&combineScore);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *feature1,
  const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(feature1), &thisId, y);
  emlrtDestroyArray(&feature1);
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  k_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *doctave,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = h_emlrt_marshallIn(sp, emlrtAlias(doctave), &thisId);
  emlrtDestroyArray(&doctave);
  return y;
}

static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = l_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  int32_T iv2[2];
  boolean_T bv0[2] = { true, true };

  static const int32_T dims[2] = { -1, -1 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv0[0],
    iv2);
  ret->size[0] = iv2[0];
  ret->size[1] = iv2[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  int32_T iv3[2];
  boolean_T bv1[2] = { false, true };

  static const int32_T dims[2] = { 2, -1 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv1[0],
    iv3);
  ret->size[0] = iv3[0];
  ret->size[1] = iv3[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  int32_T iv4[2];
  boolean_T bv2[2] = { false, true };

  static const int32_T dims[2] = { 1, -1 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv2[0],
    iv4);
  ret->size[0] = iv4[0];
  ret->size[1] = iv4[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static real_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void pruning_DAFS_DAFS_1_api(const mxArray * const prhs[8], const mxArray *plhs
  [2])
{
  emxArray_real_T *feature1;
  emxArray_real_T *depdScale1;
  emxArray_real_T *matches;
  emxArray_real_T *combineScore;
  emxArray_real_T *feature2;
  emxArray_real_T *depdScale2;
  emxArray_real_T *remainQOctave;
  real_T doctave;
  real_T toctave;
  real_T Dist;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &feature1, 2, &k_emlrtRTEI, true);
  emxInit_real_T(&st, &depdScale1, 2, &k_emlrtRTEI, true);
  emxInit_real_T(&st, &matches, 2, &k_emlrtRTEI, true);
  emxInit_real_T(&st, &combineScore, 2, &k_emlrtRTEI, true);
  emxInit_real_T(&st, &feature2, 2, &k_emlrtRTEI, true);
  emxInit_real_T(&st, &depdScale2, 2, &k_emlrtRTEI, true);
  emxInit_real_T(&st, &remainQOctave, 2, &k_emlrtRTEI, true);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "feature1", feature1);
  emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "depdScale1", depdScale1);
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "matches", matches);
  e_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "combineScore", combineScore);
  emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "feature2", feature2);
  emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "depdScale2", depdScale2);
  doctave = g_emlrt_marshallIn(&st, emlrtAliasP(prhs[6]), "doctave");
  toctave = g_emlrt_marshallIn(&st, emlrtAliasP(prhs[7]), "toctave");

  /* Invoke the target function */
  pruning_DAFS_DAFS_1(&st, feature1, depdScale1, matches, combineScore, feature2,
                      depdScale2, doctave, toctave, remainQOctave, &Dist);

  /* Marshall function outputs */
  plhs[0] = d_emlrt_marshallOut(remainQOctave);
  plhs[1] = emlrt_marshallOut(Dist);
  remainQOctave->canFreeData = false;
  emxFree_real_T(&remainQOctave);
  depdScale2->canFreeData = false;
  emxFree_real_T(&depdScale2);
  feature2->canFreeData = false;
  emxFree_real_T(&feature2);
  combineScore->canFreeData = false;
  emxFree_real_T(&combineScore);
  matches->canFreeData = false;
  emxFree_real_T(&matches);
  depdScale1->canFreeData = false;
  emxFree_real_T(&depdScale1);
  feature1->canFreeData = false;
  emxFree_real_T(&feature1);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_pruning_DAFS_DAFS_1_api.c) */
