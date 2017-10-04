/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Paired_pruning_DAFS_DAFS_DV_mexutil.c
 *
 * Code generation for function 'Paired_pruning_DAFS_DAFS_DV_mexutil'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Paired_pruning_DAFS_DAFS_DV.h"
#include "Paired_pruning_DAFS_DAFS_DV_mexutil.h"

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

/* End of code generation (Paired_pruning_DAFS_DAFS_DV_mexutil.c) */
