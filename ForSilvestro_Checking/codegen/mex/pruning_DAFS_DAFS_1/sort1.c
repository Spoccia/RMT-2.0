/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sort1.c
 *
 * Code generation for function 'sort1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pruning_DAFS_DAFS_1.h"
#include "sort1.h"
#include "eml_int_forloop_overflow_check.h"
#include "sortIdx.h"
#include "pruning_DAFS_DAFS_1_emxutil.h"
#include "pruning_DAFS_DAFS_1_mexutil.h"
#include "pruning_DAFS_DAFS_1_data.h"

/* Variable Definitions */
static emlrtRSInfo o_emlrtRSI = { 66, "sort",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sort.m"
};

static emlrtRSInfo p_emlrtRSI = { 70, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo q_emlrtRSI = { 331, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo r_emlrtRSI = { 339, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo s_emlrtRSI = { 340, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo t_emlrtRSI = { 348, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo u_emlrtRSI = { 356, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo v_emlrtRSI = { 361, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo w_emlrtRSI = { 413, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo x_emlrtRSI = { 441, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo y_emlrtRSI = { 448, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo ab_emlrtRSI = { 608, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo bb_emlrtRSI = { 610, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo cb_emlrtRSI = { 638, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo eb_emlrtRSI = { 527, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo jb_emlrtRSI = { 375, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRSInfo kb_emlrtRSI = { 384, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRTEInfo i_emlrtRTEI = { 1, 20, "sort",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sort.m"
};

static emlrtRTEInfo l_emlrtRTEI = { 406, 9, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRTEInfo m_emlrtRTEI = { 408, 9, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRTEInfo n_emlrtRTEI = { 331, 14, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

static emlrtRTEInfo o_emlrtRTEI = { 331, 20, "sortIdx",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\sortIdx.m"
};

/* Function Definitions */
void b_sort(const emlrtStack *sp, real_T x[4], int32_T idx[4])
{
  real_T x4[4];
  int32_T idx4[4];
  real_T xwork[4];
  int32_T m;
  int32_T nNaNs;
  int32_T ib;
  int32_T k;
  int32_T bLen;
  int32_T nPairs;
  int32_T i4;
  int8_T perm[4];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &o_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &p_emlrtRSI;
  c_st.site = &q_emlrtRSI;
  for (m = 0; m < 4; m++) {
    idx[m] = 0;
    x4[m] = 0.0;
    idx4[m] = 0;
    xwork[m] = 0.0;
  }

  nNaNs = 0;
  ib = 0;
  for (k = 0; k < 4; k++) {
    if (muDoubleScalarIsNaN(x[k])) {
      idx[3 - nNaNs] = k + 1;
      xwork[3 - nNaNs] = x[k];
      nNaNs++;
    } else {
      ib++;
      idx4[ib - 1] = k + 1;
      x4[ib - 1] = x[k];
      if (ib == 4) {
        ib = k - nNaNs;
        if (x4[0] <= x4[1]) {
          m = 1;
          bLen = 2;
        } else {
          m = 2;
          bLen = 1;
        }

        if (x4[2] <= x4[3]) {
          nPairs = 3;
          i4 = 4;
        } else {
          nPairs = 4;
          i4 = 3;
        }

        if (x4[m - 1] <= x4[nPairs - 1]) {
          if (x4[bLen - 1] <= x4[nPairs - 1]) {
            perm[0] = (int8_T)m;
            perm[1] = (int8_T)bLen;
            perm[2] = (int8_T)nPairs;
            perm[3] = (int8_T)i4;
          } else if (x4[bLen - 1] <= x4[i4 - 1]) {
            perm[0] = (int8_T)m;
            perm[1] = (int8_T)nPairs;
            perm[2] = (int8_T)bLen;
            perm[3] = (int8_T)i4;
          } else {
            perm[0] = (int8_T)m;
            perm[1] = (int8_T)nPairs;
            perm[2] = (int8_T)i4;
            perm[3] = (int8_T)bLen;
          }
        } else if (x4[m - 1] <= x4[i4 - 1]) {
          if (x4[bLen - 1] <= x4[i4 - 1]) {
            perm[0] = (int8_T)nPairs;
            perm[1] = (int8_T)m;
            perm[2] = (int8_T)bLen;
            perm[3] = (int8_T)i4;
          } else {
            perm[0] = (int8_T)nPairs;
            perm[1] = (int8_T)m;
            perm[2] = (int8_T)i4;
            perm[3] = (int8_T)bLen;
          }
        } else {
          perm[0] = (int8_T)nPairs;
          perm[1] = (int8_T)i4;
          perm[2] = (int8_T)m;
          perm[3] = (int8_T)bLen;
        }

        idx[ib - 3] = idx4[perm[0] - 1];
        idx[ib - 2] = idx4[perm[1] - 1];
        idx[ib - 1] = idx4[perm[2] - 1];
        idx[ib] = idx4[perm[3] - 1];
        x[ib - 3] = x4[perm[0] - 1];
        x[ib - 2] = x4[perm[1] - 1];
        x[ib - 1] = x4[perm[2] - 1];
        x[ib] = x4[perm[3] - 1];
        ib = 0;
      }
    }
  }

  if (ib > 0) {
    for (m = 0; m < 4; m++) {
      perm[m] = 0;
    }

    if (ib == 1) {
      perm[0] = 1;
    } else if (ib == 2) {
      if (x4[0] <= x4[1]) {
        perm[0] = 1;
        perm[1] = 2;
      } else {
        perm[0] = 2;
        perm[1] = 1;
      }
    } else if (x4[0] <= x4[1]) {
      if (x4[1] <= x4[2]) {
        perm[0] = 1;
        perm[1] = 2;
        perm[2] = 3;
      } else if (x4[0] <= x4[2]) {
        perm[0] = 1;
        perm[1] = 3;
        perm[2] = 2;
      } else {
        perm[0] = 3;
        perm[1] = 1;
        perm[2] = 2;
      }
    } else if (x4[0] <= x4[2]) {
      perm[0] = 2;
      perm[1] = 1;
      perm[2] = 3;
    } else if (x4[1] <= x4[2]) {
      perm[0] = 2;
      perm[1] = 3;
      perm[2] = 1;
    } else {
      perm[0] = 3;
      perm[1] = 2;
      perm[2] = 1;
    }

    d_st.site = &x_emlrtRSI;
    if (ib > 2147483646) {
      e_st.site = &m_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (k = 4; k - 3 <= ib; k++) {
      idx[(k - nNaNs) - ib] = idx4[perm[k - 4] - 1];
      x[(k - nNaNs) - ib] = x4[perm[k - 4] - 1];
    }
  }

  m = asr_s32(nNaNs, 1U);
  d_st.site = &y_emlrtRSI;
  for (k = 1; k <= m; k++) {
    ib = idx[(k - nNaNs) + 3];
    idx[(k - nNaNs) + 3] = idx[4 - k];
    idx[4 - k] = ib;
    x[(k - nNaNs) + 3] = xwork[4 - k];
    x[4 - k] = xwork[(k - nNaNs) + 3];
  }

  if ((nNaNs & 1) != 0) {
    x[(m - nNaNs) + 4] = xwork[(m - nNaNs) + 4];
  }

  if (4 - nNaNs > 1) {
    c_st.site = &u_emlrtRSI;
    for (m = 0; m < 4; m++) {
      idx4[m] = 0;
    }

    nPairs = asr_s32(4 - nNaNs, 2U);
    bLen = 4;
    while (nPairs > 1) {
      if ((nPairs & 1) != 0) {
        nPairs--;
        ib = bLen * nPairs;
        m = 4 - (nNaNs + ib);
        if (m > bLen) {
          d_st.site = &db_emlrtRSI;
          b_merge(&d_st, idx, x, ib, bLen, m - bLen, idx4, xwork);
        }
      }

      ib = bLen << 1;
      nPairs = asr_s32(nPairs, 1U);
      d_st.site = &eb_emlrtRSI;
      for (k = 1; k <= nPairs; k++) {
        d_st.site = &fb_emlrtRSI;
        b_merge(&d_st, idx, x, (k - 1) * ib, bLen, bLen, idx4, xwork);
      }

      bLen = ib;
    }

    if (4 - nNaNs > bLen) {
      d_st.site = &gb_emlrtRSI;
      b_merge(&d_st, idx, x, 0, bLen, 4 - (nNaNs + bLen), idx4, xwork);
    }
  }
}

void sort(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx)
{
  emxArray_real_T *b_x;
  int32_T ib;
  int32_T m;
  int32_T n;
  real_T x4[4];
  int32_T idx4[4];
  emxArray_int32_T *iwork;
  emxArray_real_T *xwork;
  int32_T nNaNs;
  boolean_T overflow;
  int32_T k;
  int32_T wOffset;
  int32_T p;
  int32_T i4;
  int8_T perm[4];
  int32_T nNonNaN;
  int32_T nBlocks;
  int32_T b_iwork[256];
  real_T b_xwork[256];
  int32_T b;
  int32_T bLen;
  int32_T bLen2;
  int32_T nPairs;
  int32_T exitg1;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &b_x, 2, &i_emlrtRTEI, true);
  st.site = &o_emlrtRSI;
  b_st.site = &p_emlrtRSI;
  c_st.site = &q_emlrtRSI;
  ib = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 1;
  b_x->size[1] = x->size[1];
  emxEnsureCapacity(&c_st, (emxArray__common *)b_x, ib, (int32_T)sizeof(real_T),
                    &i_emlrtRTEI);
  m = x->size[0] * x->size[1];
  for (ib = 0; ib < m; ib++) {
    b_x->data[ib] = x->data[ib];
  }

  ib = idx->size[0] * idx->size[1];
  idx->size[0] = 1;
  idx->size[1] = x->size[1];
  emxEnsureCapacity(&c_st, (emxArray__common *)idx, ib, (int32_T)sizeof(int32_T),
                    &i_emlrtRTEI);
  m = x->size[1];
  for (ib = 0; ib < m; ib++) {
    idx->data[ib] = 0;
  }

  n = x->size[1];
  for (m = 0; m < 4; m++) {
    x4[m] = 0.0;
    idx4[m] = 0;
  }

  emxInit_int32_T1(&c_st, &iwork, 1, &n_emlrtRTEI, true);
  m = x->size[1];
  ib = iwork->size[0];
  iwork->size[0] = m;
  emxEnsureCapacity(&c_st, (emxArray__common *)iwork, ib, (int32_T)sizeof
                    (int32_T), &l_emlrtRTEI);
  m = iwork->size[0];
  ib = iwork->size[0];
  iwork->size[0] = m;
  emxEnsureCapacity(&c_st, (emxArray__common *)iwork, ib, (int32_T)sizeof
                    (int32_T), &i_emlrtRTEI);
  for (ib = 0; ib < m; ib++) {
    iwork->data[ib] = 0;
  }

  emxInit_real_T1(&c_st, &xwork, 1, &o_emlrtRTEI, true);
  m = x->size[1];
  ib = xwork->size[0];
  xwork->size[0] = m;
  emxEnsureCapacity(&c_st, (emxArray__common *)xwork, ib, (int32_T)sizeof(real_T),
                    &m_emlrtRTEI);
  m = xwork->size[0];
  ib = xwork->size[0];
  xwork->size[0] = m;
  emxEnsureCapacity(&c_st, (emxArray__common *)xwork, ib, (int32_T)sizeof(real_T),
                    &i_emlrtRTEI);
  for (ib = 0; ib < m; ib++) {
    xwork->data[ib] = 0.0;
  }

  nNaNs = 0;
  ib = 0;
  d_st.site = &w_emlrtRSI;
  if (1 > x->size[1]) {
    overflow = false;
  } else {
    overflow = (x->size[1] > 2147483646);
  }

  if (overflow) {
    e_st.site = &m_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  for (k = 0; k + 1 <= n; k++) {
    if (muDoubleScalarIsNaN(b_x->data[k])) {
      idx->data[(n - nNaNs) - 1] = k + 1;
      xwork->data[(n - nNaNs) - 1] = b_x->data[k];
      nNaNs++;
    } else {
      ib++;
      idx4[ib - 1] = k + 1;
      x4[ib - 1] = b_x->data[k];
      if (ib == 4) {
        ib = k - nNaNs;
        if (x4[0] >= x4[1]) {
          m = 1;
          wOffset = 2;
        } else {
          m = 2;
          wOffset = 1;
        }

        if (x4[2] >= x4[3]) {
          p = 3;
          i4 = 4;
        } else {
          p = 4;
          i4 = 3;
        }

        if (x4[m - 1] >= x4[p - 1]) {
          if (x4[wOffset - 1] >= x4[p - 1]) {
            perm[0] = (int8_T)m;
            perm[1] = (int8_T)wOffset;
            perm[2] = (int8_T)p;
            perm[3] = (int8_T)i4;
          } else if (x4[wOffset - 1] >= x4[i4 - 1]) {
            perm[0] = (int8_T)m;
            perm[1] = (int8_T)p;
            perm[2] = (int8_T)wOffset;
            perm[3] = (int8_T)i4;
          } else {
            perm[0] = (int8_T)m;
            perm[1] = (int8_T)p;
            perm[2] = (int8_T)i4;
            perm[3] = (int8_T)wOffset;
          }
        } else if (x4[m - 1] >= x4[i4 - 1]) {
          if (x4[wOffset - 1] >= x4[i4 - 1]) {
            perm[0] = (int8_T)p;
            perm[1] = (int8_T)m;
            perm[2] = (int8_T)wOffset;
            perm[3] = (int8_T)i4;
          } else {
            perm[0] = (int8_T)p;
            perm[1] = (int8_T)m;
            perm[2] = (int8_T)i4;
            perm[3] = (int8_T)wOffset;
          }
        } else {
          perm[0] = (int8_T)p;
          perm[1] = (int8_T)i4;
          perm[2] = (int8_T)m;
          perm[3] = (int8_T)wOffset;
        }

        idx->data[ib - 3] = idx4[perm[0] - 1];
        idx->data[ib - 2] = idx4[perm[1] - 1];
        idx->data[ib - 1] = idx4[perm[2] - 1];
        idx->data[ib] = idx4[perm[3] - 1];
        b_x->data[ib - 3] = x4[perm[0] - 1];
        b_x->data[ib - 2] = x4[perm[1] - 1];
        b_x->data[ib - 1] = x4[perm[2] - 1];
        b_x->data[ib] = x4[perm[3] - 1];
        ib = 0;
      }
    }
  }

  wOffset = (x->size[1] - nNaNs) - 1;
  if (ib > 0) {
    for (m = 0; m < 4; m++) {
      perm[m] = 0;
    }

    if (ib == 1) {
      perm[0] = 1;
    } else if (ib == 2) {
      if (x4[0] >= x4[1]) {
        perm[0] = 1;
        perm[1] = 2;
      } else {
        perm[0] = 2;
        perm[1] = 1;
      }
    } else if (x4[0] >= x4[1]) {
      if (x4[1] >= x4[2]) {
        perm[0] = 1;
        perm[1] = 2;
        perm[2] = 3;
      } else if (x4[0] >= x4[2]) {
        perm[0] = 1;
        perm[1] = 3;
        perm[2] = 2;
      } else {
        perm[0] = 3;
        perm[1] = 1;
        perm[2] = 2;
      }
    } else if (x4[0] >= x4[2]) {
      perm[0] = 2;
      perm[1] = 1;
      perm[2] = 3;
    } else if (x4[1] >= x4[2]) {
      perm[0] = 2;
      perm[1] = 3;
      perm[2] = 1;
    } else {
      perm[0] = 3;
      perm[1] = 2;
      perm[2] = 1;
    }

    d_st.site = &x_emlrtRSI;
    if (ib > 2147483646) {
      e_st.site = &m_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (k = 1; k <= ib; k++) {
      idx->data[(wOffset - ib) + k] = idx4[perm[k - 1] - 1];
      b_x->data[(wOffset - ib) + k] = x4[perm[k - 1] - 1];
    }
  }

  m = asr_s32(nNaNs, 1U) + 1;
  d_st.site = &y_emlrtRSI;
  for (k = 1; k < m; k++) {
    ib = idx->data[wOffset + k];
    idx->data[wOffset + k] = idx->data[n - k];
    idx->data[n - k] = ib;
    b_x->data[wOffset + k] = xwork->data[n - k];
    b_x->data[n - k] = xwork->data[wOffset + k];
  }

  if ((nNaNs & 1) != 0) {
    b_x->data[wOffset + m] = xwork->data[wOffset + m];
  }

  nNonNaN = x->size[1] - nNaNs;
  m = 2;
  if (nNonNaN > 1) {
    if (x->size[1] >= 256) {
      nBlocks = asr_s32(nNonNaN, 8U);
      if (nBlocks > 0) {
        c_st.site = &r_emlrtRSI;
        for (i4 = 1; i4 <= nBlocks; i4++) {
          c_st.site = &s_emlrtRSI;
          n = (i4 - 1) << 8;
          for (b = 0; b < 6; b++) {
            bLen = 1 << (b + 2);
            bLen2 = bLen << 1;
            nPairs = asr_s32(256, (uint32_T)(b + 3));
            d_st.site = &ab_emlrtRSI;
            for (k = 1; k <= nPairs; k++) {
              m = n + (k - 1) * bLen2;
              d_st.site = &bb_emlrtRSI;
              for (ib = 0; ib + 1 <= bLen2; ib++) {
                b_iwork[ib] = idx->data[m + ib];
                b_xwork[ib] = b_x->data[m + ib];
              }

              p = 0;
              wOffset = bLen;
              ib = m - 1;
              do {
                exitg1 = 0;
                ib++;
                if (b_xwork[p] >= b_xwork[wOffset]) {
                  idx->data[ib] = b_iwork[p];
                  b_x->data[ib] = b_xwork[p];
                  if (p + 1 < bLen) {
                    p++;
                  } else {
                    exitg1 = 1;
                  }
                } else {
                  idx->data[ib] = b_iwork[wOffset];
                  b_x->data[ib] = b_xwork[wOffset];
                  if (wOffset + 1 < bLen2) {
                    wOffset++;
                  } else {
                    ib = (ib - p) + 1;
                    d_st.site = &cb_emlrtRSI;
                    while (p + 1 <= bLen) {
                      idx->data[ib + p] = b_iwork[p];
                      b_x->data[ib + p] = b_xwork[p];
                      p++;
                    }

                    exitg1 = 1;
                  }
                }
              } while (exitg1 == 0);
            }
          }
        }

        m = nBlocks << 8;
        ib = nNonNaN - m;
        if (ib > 0) {
          c_st.site = &t_emlrtRSI;
          merge_block(&c_st, idx, b_x, m, ib, 2, iwork, xwork);
        }

        m = 8;
      }
    }

    c_st.site = &u_emlrtRSI;
    merge_block(&c_st, idx, b_x, 0, nNonNaN, m, iwork, xwork);
  }

  if ((nNaNs > 0) && (nNonNaN > 0)) {
    c_st.site = &v_emlrtRSI;
    d_st.site = &jb_emlrtRSI;
    if (nNaNs > 2147483646) {
      e_st.site = &m_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (k = 0; k + 1 <= nNaNs; k++) {
      xwork->data[k] = b_x->data[nNonNaN + k];
      iwork->data[k] = idx->data[nNonNaN + k];
    }

    for (k = nNonNaN - 1; k + 1 > 0; k--) {
      b_x->data[nNaNs + k] = b_x->data[k];
      idx->data[nNaNs + k] = idx->data[k];
    }

    d_st.site = &kb_emlrtRSI;
    for (k = 0; k + 1 <= nNaNs; k++) {
      b_x->data[k] = xwork->data[k];
      idx->data[k] = iwork->data[k];
    }
  }

  emxFree_real_T(&xwork);
  emxFree_int32_T(&iwork);
  ib = x->size[0] * x->size[1];
  x->size[0] = 1;
  x->size[1] = b_x->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)x, ib, (int32_T)sizeof(real_T),
                    &i_emlrtRTEI);
  m = b_x->size[1];
  for (ib = 0; ib < m; ib++) {
    x->data[x->size[0] * ib] = b_x->data[b_x->size[0] * ib];
  }

  emxFree_real_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (sort1.c) */
