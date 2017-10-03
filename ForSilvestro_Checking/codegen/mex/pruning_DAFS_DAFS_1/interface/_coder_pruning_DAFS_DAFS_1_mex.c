/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_pruning_DAFS_DAFS_1_mex.c
 *
 * Code generation for function '_coder_pruning_DAFS_DAFS_1_mex'
 *
 */

/* Include files */
#include "pruning_DAFS_DAFS_1.h"
#include "_coder_pruning_DAFS_DAFS_1_mex.h"
#include "pruning_DAFS_DAFS_1_terminate.h"
#include "_coder_pruning_DAFS_DAFS_1_api.h"
#include "pruning_DAFS_DAFS_1_initialize.h"
#include "pruning_DAFS_DAFS_1_data.h"

/* Function Declarations */
static void pruning_DAFS_DAFS_1_mexFunction(int32_T nlhs, mxArray *plhs[2],
  int32_T nrhs, const mxArray *prhs[8]);

/* Function Definitions */
static void pruning_DAFS_DAFS_1_mexFunction(int32_T nlhs, mxArray *plhs[2],
  int32_T nrhs, const mxArray *prhs[8])
{
  int32_T n;
  const mxArray *inputs[8];
  const mxArray *outputs[2];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 8) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 8, 4,
                        19, "pruning_DAFS_DAFS_1");
  }

  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 19,
                        "pruning_DAFS_DAFS_1");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  pruning_DAFS_DAFS_1_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  pruning_DAFS_DAFS_1_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(pruning_DAFS_DAFS_1_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  pruning_DAFS_DAFS_1_initialize();

  /* Dispatch the entry-point. */
  pruning_DAFS_DAFS_1_mexFunction(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_pruning_DAFS_DAFS_1_mex.c) */
