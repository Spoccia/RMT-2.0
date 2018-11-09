/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pruning_DAFS_DAFS_1_terminate.c
 *
 * Code generation for function 'pruning_DAFS_DAFS_1_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pruning_DAFS_DAFS_1.h"
#include "pruning_DAFS_DAFS_1_terminate.h"
#include "_coder_pruning_DAFS_DAFS_1_mex.h"
#include "pruning_DAFS_DAFS_1_data.h"

/* Function Definitions */
void pruning_DAFS_DAFS_1_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void pruning_DAFS_DAFS_1_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (pruning_DAFS_DAFS_1_terminate.c) */
