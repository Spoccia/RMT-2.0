/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Paired_pruning_DAFS_DAFS_DV_initialize.c
 *
 * Code generation for function 'Paired_pruning_DAFS_DAFS_DV_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Paired_pruning_DAFS_DAFS_DV.h"
#include "Paired_pruning_DAFS_DAFS_DV_initialize.h"
#include "_coder_Paired_pruning_DAFS_DAFS_DV_mex.h"
#include "Paired_pruning_DAFS_DAFS_DV_data.h"

/* Function Definitions */
void Paired_pruning_DAFS_DAFS_DV_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (Paired_pruning_DAFS_DAFS_DV_initialize.c) */
