/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pruning_DAFS_DAFS_1_mexutil.c
 *
 * Code generation for function 'pruning_DAFS_DAFS_1_mexutil'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pruning_DAFS_DAFS_1.h"
#include "pruning_DAFS_DAFS_1_mexutil.h"

/* Function Definitions */
int32_T asr_s32(int32_T u, uint32_T n)
{
  int32_T y;
  if (u >= 0) {
    y = (int32_T)((uint32_T)u >> n);
  } else {
    y = -(int32_T)((uint32_T)-(u + 1) >> n) - 1;
  }

  return y;
}

const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m0;
  y = NULL;
  m0 = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m0);
  return y;
}

/* End of code generation (pruning_DAFS_DAFS_1_mexutil.c) */
