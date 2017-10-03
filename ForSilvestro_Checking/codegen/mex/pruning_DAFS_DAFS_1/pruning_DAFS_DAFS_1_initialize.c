/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pruning_DAFS_DAFS_1_initialize.c
 *
 * Code generation for function 'pruning_DAFS_DAFS_1_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pruning_DAFS_DAFS_1.h"
#include "pruning_DAFS_DAFS_1_initialize.h"
#include "_coder_pruning_DAFS_DAFS_1_mex.h"
#include "pruning_DAFS_DAFS_1_data.h"

/* Function Definitions */
void pruning_DAFS_DAFS_1_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (pruning_DAFS_DAFS_1_initialize.c) */
