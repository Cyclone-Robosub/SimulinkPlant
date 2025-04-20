//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: Controller.cpp
//
// Code generated for Simulink model 'Controller'.
//
// Model version                  : 1.65
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Sat Apr 19 20:41:16 2025
//
// Target selection: ert.tlc
// Embedded hardware selection: Intel->x86-64 (Windows64)
// Code generation objectives:
//    1. Debugging
//    2. Traceability
// Validation result: Not run
//
#include "Controller.h"
#include "rtwtypes.h"
#include <emmintrin.h>
#include <cmath>
#include <cstring>
#include "cmath"
#include "limits"

// private model entry point functions
extern void Controller_derivatives();
extern "C"
{
  real_T rtNaN { -std::numeric_limits<real_T>::quiet_NaN() };

  real_T rtInf { std::numeric_limits<real_T>::infinity() };

  real_T rtMinusInf { -std::numeric_limits<real_T>::infinity() };

  real32_T rtNaNF { -std::numeric_limits<real32_T>::quiet_NaN() };

  real32_T rtInfF { std::numeric_limits<real32_T>::infinity() };

  real32_T rtMinusInfF { -std::numeric_limits<real32_T>::infinity() };
}

extern "C"
{
  // Return rtNaN needed by the generated code.
  static real_T rtGetNaN(void)
  {
    return rtNaN;
  }

  // Return rtNaNF needed by the generated code.
  static real32_T rtGetNaNF(void)
  {
    return rtNaNF;
  }
}

extern "C"
{
  // Test if value is infinite
  static boolean_T rtIsInf(real_T value)
  {
    return std::isinf(value);
  }

  // Test if single-precision value is infinite
  static boolean_T rtIsInfF(real32_T value)
  {
    return std::isinf(value);
  }

  // Test if value is not a number
  static boolean_T rtIsNaN(real_T value)
  {
    return std::isnan(value);
  }

  // Test if single-precision value is not a number
  static boolean_T rtIsNaNF(real32_T value)
  {
    return std::isnan(value);
  }
}

//
// This function updates continuous states using the ODE3 fixed-step
// solver algorithm
//
void Controller::rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  // Solver Matrices
  static const real_T rt_ODE3_A[3]{
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3]{
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t { rtsiGetT(si) };

  time_T tnew { rtsiGetSolverStopTime(si) };

  time_T h { rtsiGetStepSize(si) };

  real_T *x { rtsiGetContStates(si) };

  ODE3_IntgData *id { static_cast<ODE3_IntgData *>(rtsiGetSolverData(si)) };

  real_T *y { id->y };

  real_T *f0 { id->f[0] };

  real_T *f1 { id->f[1] };

  real_T *f2 { id->f[2] };

  real_T hB[3];
  int_T i;
  int_T nXc { 12 };

  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  // Save the state values at time t in y, we'll use x as ynew.
  (void) std::memcpy(y, x,
                     static_cast<uint_T>(nXc)*sizeof(real_T));

  // Assumes that rtsiSetT and ModelOutputs are up-to-date
  // f0 = f(t,y)
  rtsiSetdX(si, f0);
  Controller_derivatives();

  // f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*));
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  this->step();
  Controller_derivatives();

  // f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*));
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  this->step();
  Controller_derivatives();

  // tnew = t + hA(3);
  // ynew = y + f*hB(:,3);
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
real_T Controller::xzlangeM(const real_T x[48])
{
  real_T y;
  int32_T k;
  boolean_T exitg1;
  y = 0.0;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 48)) {
    real_T absxk;
    absxk = std::abs(x[k]);
    if (std::isnan(absxk)) {
      y = (rtNaN);
      exitg1 = true;
    } else {
      if (absxk > y) {
        y = absxk;
      }

      k++;
    }
  }

  return y;
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xzlascl(real_T cfrom, real_T cto, int32_T m, int32_T n, real_T
  A[48], int32_T iA0, int32_T lda)
{
  real_T cfromc;
  real_T ctoc;
  boolean_T notdone;
  cfromc = cfrom;
  ctoc = cto;
  notdone = true;
  while (notdone) {
    real_T cfrom1;
    real_T cto1;
    real_T mul;
    cfrom1 = cfromc * 2.0041683600089728E-292;
    cto1 = ctoc / 4.9896007738368E+291;
    if ((std::abs(cfrom1) > std::abs(ctoc)) && (ctoc != 0.0)) {
      mul = 2.0041683600089728E-292;
      cfromc = cfrom1;
    } else if (std::abs(cto1) > std::abs(cfromc)) {
      mul = 4.9896007738368E+291;
      ctoc = cto1;
    } else {
      mul = ctoc / cfromc;
      notdone = false;
    }

    for (int32_T j{0}; j < n; j++) {
      int32_T offset;
      int32_T scalarLB;
      int32_T tmp_0;
      int32_T vectorUB;
      offset = (j * lda + iA0) - 2;
      scalarLB = (m / 2) << 1;
      vectorUB = scalarLB - 2;
      for (int32_T b_i{0}; b_i <= vectorUB; b_i += 2) {
        __m128d tmp;
        tmp_0 = (b_i + offset) + 1;
        tmp = _mm_loadu_pd(&A[tmp_0]);
        _mm_storeu_pd(&A[tmp_0], _mm_mul_pd(tmp, _mm_set1_pd(mul)));
      }

      for (int32_T b_i{scalarLB}; b_i < m; b_i++) {
        tmp_0 = (b_i + offset) + 1;
        A[tmp_0] *= mul;
      }
    }
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
real_T Controller::xnrm2(int32_T n, const real_T x[48], int32_T ix0)
{
  real_T y;
  y = 0.0;
  if (n >= 1) {
    if (n == 1) {
      y = std::abs(x[ix0 - 1]);
    } else {
      real_T scale;
      int32_T kend;
      scale = 3.3121686421112381E-170;
      kend = ix0 + n;
      for (int32_T k{ix0}; k < kend; k++) {
        real_T absxk;
        absxk = std::abs(x[k - 1]);
        if (absxk > scale) {
          real_T t;
          t = scale / absxk;
          y = y * t * t + 1.0;
          scale = absxk;
        } else {
          real_T t;
          t = absxk / scale;
          y += t * t;
        }
      }

      y = scale * std::sqrt(y);
    }
  }

  return y;
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
real_T Controller::xdotc(int32_T n, const real_T x[48], int32_T ix0, const
  real_T y[48], int32_T iy0)
{
  real_T d;
  d = 0.0;
  if (n >= 1) {
    for (int32_T k{0}; k < n; k++) {
      d += x[(ix0 + k) - 1] * y[(iy0 + k) - 1];
    }
  }

  return d;
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xaxpy(int32_T n, real_T a, int32_T ix0, real_T y[48], int32_T
  iy0)
{
  if ((n >= 1) && (!(a == 0.0))) {
    for (int32_T k{0}; k < n; k++) {
      int32_T tmp;
      tmp = (iy0 + k) - 1;
      y[tmp] += y[(ix0 + k) - 1] * a;
    }
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
real_T Controller::xnrm2_g(int32_T n, const real_T x[6], int32_T ix0)
{
  real_T y;
  y = 0.0;
  if (n >= 1) {
    if (n == 1) {
      y = std::abs(x[ix0 - 1]);
    } else {
      real_T scale;
      int32_T kend;
      scale = 3.3121686421112381E-170;
      kend = ix0 + n;
      for (int32_T k{ix0}; k < kend; k++) {
        real_T absxk;
        absxk = std::abs(x[k - 1]);
        if (absxk > scale) {
          real_T t;
          t = scale / absxk;
          y = y * t * t + 1.0;
          scale = absxk;
        } else {
          real_T t;
          t = absxk / scale;
          y += t * t;
        }
      }

      y = scale * std::sqrt(y);
    }
  }

  return y;
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xaxpy_i(int32_T n, real_T a, const real_T x[48], int32_T ix0,
  real_T y[8], int32_T iy0)
{
  if ((n >= 1) && (!(a == 0.0))) {
    int32_T scalarLB;
    int32_T tmp_0;
    int32_T vectorUB;
    scalarLB = (n / 2) << 1;
    vectorUB = scalarLB - 2;
    for (int32_T k{0}; k <= vectorUB; k += 2) {
      __m128d tmp;
      tmp_0 = (iy0 + k) - 1;
      tmp = _mm_loadu_pd(&y[tmp_0]);
      _mm_storeu_pd(&y[tmp_0], _mm_add_pd(_mm_mul_pd(_mm_loadu_pd(&x[(ix0 + k) -
        1]), _mm_set1_pd(a)), tmp));
    }

    for (int32_T k{scalarLB}; k < n; k++) {
      tmp_0 = (iy0 + k) - 1;
      y[tmp_0] += x[(ix0 + k) - 1] * a;
    }
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xaxpy_iv(int32_T n, real_T a, const real_T x[8], int32_T ix0,
  real_T y[48], int32_T iy0)
{
  if ((n >= 1) && (!(a == 0.0))) {
    int32_T scalarLB;
    int32_T tmp_0;
    int32_T vectorUB;
    scalarLB = (n / 2) << 1;
    vectorUB = scalarLB - 2;
    for (int32_T k{0}; k <= vectorUB; k += 2) {
      __m128d tmp;
      tmp_0 = (iy0 + k) - 1;
      tmp = _mm_loadu_pd(&y[tmp_0]);
      _mm_storeu_pd(&y[tmp_0], _mm_add_pd(_mm_mul_pd(_mm_loadu_pd(&x[(ix0 + k) -
        1]), _mm_set1_pd(a)), tmp));
    }

    for (int32_T k{scalarLB}; k < n; k++) {
      tmp_0 = (iy0 + k) - 1;
      y[tmp_0] += x[(ix0 + k) - 1] * a;
    }
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
real_T Controller::xdotc_l(int32_T n, const real_T x[36], int32_T ix0, const
  real_T y[36], int32_T iy0)
{
  real_T d;
  d = 0.0;
  if (n >= 1) {
    for (int32_T k{0}; k < n; k++) {
      d += x[(ix0 + k) - 1] * y[(iy0 + k) - 1];
    }
  }

  return d;
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xaxpy_ivt(int32_T n, real_T a, int32_T ix0, real_T y[36],
  int32_T iy0)
{
  if ((n >= 1) && (!(a == 0.0))) {
    for (int32_T k{0}; k < n; k++) {
      int32_T tmp;
      tmp = (iy0 + k) - 1;
      y[tmp] += y[(ix0 + k) - 1] * a;
    }
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xzlascl_h(real_T cfrom, real_T cto, int32_T m, int32_T n,
  real_T A[6], int32_T iA0, int32_T lda)
{
  real_T cfromc;
  real_T ctoc;
  boolean_T notdone;
  cfromc = cfrom;
  ctoc = cto;
  notdone = true;
  while (notdone) {
    real_T cfrom1;
    real_T cto1;
    real_T mul;
    cfrom1 = cfromc * 2.0041683600089728E-292;
    cto1 = ctoc / 4.9896007738368E+291;
    if ((std::abs(cfrom1) > std::abs(ctoc)) && (ctoc != 0.0)) {
      mul = 2.0041683600089728E-292;
      cfromc = cfrom1;
    } else if (std::abs(cto1) > std::abs(cfromc)) {
      mul = 4.9896007738368E+291;
      ctoc = cto1;
    } else {
      mul = ctoc / cfromc;
      notdone = false;
    }

    for (int32_T j{0}; j < n; j++) {
      int32_T offset;
      int32_T scalarLB;
      int32_T tmp_0;
      int32_T vectorUB;
      offset = (j * lda + iA0) - 2;
      scalarLB = (m / 2) << 1;
      vectorUB = scalarLB - 2;
      for (int32_T b_i{0}; b_i <= vectorUB; b_i += 2) {
        __m128d tmp;
        tmp_0 = (b_i + offset) + 1;
        tmp = _mm_loadu_pd(&A[tmp_0]);
        _mm_storeu_pd(&A[tmp_0], _mm_mul_pd(tmp, _mm_set1_pd(mul)));
      }

      for (int32_T b_i{scalarLB}; b_i < m; b_i++) {
        tmp_0 = (b_i + offset) + 1;
        A[tmp_0] *= mul;
      }
    }
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xswap(real_T x[36], int32_T ix0, int32_T iy0)
{
  for (int32_T k{0}; k < 6; k++) {
    real_T temp;
    int32_T temp_tmp;
    int32_T tmp;
    temp_tmp = (ix0 + k) - 1;
    temp = x[temp_tmp];
    tmp = (iy0 + k) - 1;
    x[temp_tmp] = x[tmp];
    x[tmp] = temp;
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xswap_j(real_T x[48], int32_T ix0, int32_T iy0)
{
  for (int32_T k{0}; k < 8; k++) {
    real_T temp;
    int32_T temp_tmp;
    int32_T tmp;
    temp_tmp = (ix0 + k) - 1;
    temp = x[temp_tmp];
    tmp = (iy0 + k) - 1;
    x[temp_tmp] = x[tmp];
    x[tmp] = temp;
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xrotg(real_T *a, real_T *b, real_T *c, real_T *s)
{
  real_T absa;
  real_T absb;
  real_T roe;
  real_T scale;
  roe = *b;
  absa = std::abs(*a);
  absb = std::abs(*b);
  if (absa > absb) {
    roe = *a;
  }

  scale = absa + absb;
  if (scale == 0.0) {
    *s = 0.0;
    *c = 1.0;
    *a = 0.0;
    *b = 0.0;
  } else {
    real_T ads;
    real_T bds;
    ads = absa / scale;
    bds = absb / scale;
    scale *= std::sqrt(ads * ads + bds * bds);
    if (roe < 0.0) {
      scale = -scale;
    }

    *c = *a / scale;
    *s = *b / scale;
    if (absa > absb) {
      *b = *s;
    } else if (*c != 0.0) {
      *b = 1.0 / *c;
    } else {
      *b = 1.0;
    }

    *a = scale;
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xrot(real_T x[36], int32_T ix0, int32_T iy0, real_T c, real_T s)
{
  for (int32_T k{0}; k < 6; k++) {
    real_T temp_tmp;
    real_T temp_tmp_0;
    int32_T temp_tmp_tmp;
    int32_T temp_tmp_tmp_0;
    temp_tmp_tmp = (iy0 + k) - 1;
    temp_tmp = x[temp_tmp_tmp];
    temp_tmp_tmp_0 = (ix0 + k) - 1;
    temp_tmp_0 = x[temp_tmp_tmp_0];
    x[temp_tmp_tmp] = temp_tmp * c - temp_tmp_0 * s;
    x[temp_tmp_tmp_0] = temp_tmp_0 * c + temp_tmp * s;
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::xrot_c(real_T x[48], int32_T ix0, int32_T iy0, real_T c, real_T
  s)
{
  for (int32_T k{0}; k < 8; k++) {
    real_T temp_tmp;
    real_T temp_tmp_0;
    int32_T temp_tmp_tmp;
    int32_T temp_tmp_tmp_0;
    temp_tmp_tmp = (iy0 + k) - 1;
    temp_tmp = x[temp_tmp_tmp];
    temp_tmp_tmp_0 = (ix0 + k) - 1;
    temp_tmp_0 = x[temp_tmp_tmp_0];
    x[temp_tmp_tmp] = temp_tmp * c - temp_tmp_0 * s;
    x[temp_tmp_tmp_0] = temp_tmp_0 * c + temp_tmp * s;
  }
}

// Function for MATLAB Function: '<S1>/MATLAB Function'
void Controller::svd(const real_T A[48], real_T U[48], real_T s[6], real_T V[36])
{
  __m128d tmp;
  real_T b_A[48];
  real_T work[8];
  real_T b_s[6];
  real_T e[6];
  real_T tmp_0[2];
  real_T anrm;
  real_T cscale;
  real_T nrm;
  real_T rt;
  real_T shift;
  real_T smm1;
  real_T sqds;
  real_T ztest;
  int32_T exitg1;
  int32_T i;
  int32_T qjj;
  int32_T qp1;
  int32_T qp1jj;
  int32_T qq;
  int32_T qq_tmp;
  int32_T qq_tmp_tmp;
  int32_T scalarLB;
  int32_T vectorUB;
  boolean_T apply_transform;
  boolean_T doscale;
  boolean_T exitg2;
  std::memcpy(&b_A[0], &A[0], 48U * sizeof(real_T));
  for (i = 0; i < 6; i++) {
    b_s[i] = 0.0;
    e[i] = 0.0;
  }

  std::memset(&work[0], 0, sizeof(real_T) << 3U);
  std::memset(&U[0], 0, 48U * sizeof(real_T));
  std::memset(&V[0], 0, 36U * sizeof(real_T));
  doscale = false;
  anrm = xzlangeM(A);
  cscale = anrm;
  if ((anrm > 0.0) && (anrm < 6.7178761075670888E-139)) {
    doscale = true;
    cscale = 6.7178761075670888E-139;
    xzlascl(anrm, cscale, 8, 6, b_A, 1, 8);
  } else if (anrm > 1.4885657073574029E+138) {
    doscale = true;
    cscale = 1.4885657073574029E+138;
    xzlascl(anrm, cscale, 8, 6, b_A, 1, 8);
  }

  for (i = 0; i < 6; i++) {
    qp1 = i + 2;
    qq_tmp_tmp = i << 3;
    qq_tmp = qq_tmp_tmp + i;
    qq = qq_tmp + 1;
    apply_transform = false;
    nrm = xnrm2(8 - i, b_A, qq_tmp + 1);
    if (nrm > 0.0) {
      apply_transform = true;
      if (b_A[qq_tmp] < 0.0) {
        nrm = -nrm;
      }

      b_s[i] = nrm;
      if (std::abs(nrm) >= 1.0020841800044864E-292) {
        nrm = 1.0 / nrm;
        qjj = (qq_tmp - i) + 8;
        scalarLB = ((((qjj - qq_tmp) / 2) << 1) + qq_tmp) + 1;
        vectorUB = scalarLB - 2;
        for (qp1jj = qq; qp1jj <= vectorUB; qp1jj += 2) {
          tmp = _mm_loadu_pd(&b_A[qp1jj - 1]);
          _mm_storeu_pd(&b_A[qp1jj - 1], _mm_mul_pd(tmp, _mm_set1_pd(nrm)));
        }

        for (qp1jj = scalarLB; qp1jj <= qjj; qp1jj++) {
          b_A[qp1jj - 1] *= nrm;
        }
      } else {
        qjj = (qq_tmp - i) + 8;
        scalarLB = ((((qjj - qq_tmp) / 2) << 1) + qq_tmp) + 1;
        vectorUB = scalarLB - 2;
        for (qp1jj = qq; qp1jj <= vectorUB; qp1jj += 2) {
          tmp = _mm_loadu_pd(&b_A[qp1jj - 1]);
          _mm_storeu_pd(&b_A[qp1jj - 1], _mm_div_pd(tmp, _mm_set1_pd(b_s[i])));
        }

        for (qp1jj = scalarLB; qp1jj <= qjj; qp1jj++) {
          b_A[qp1jj - 1] /= b_s[i];
        }
      }

      b_A[qq_tmp]++;
      b_s[i] = -b_s[i];
    } else {
      b_s[i] = 0.0;
    }

    for (qp1jj = qp1; qp1jj < 7; qp1jj++) {
      qjj = ((qp1jj - 1) << 3) + i;
      if (apply_transform) {
        xaxpy(8 - i, -(xdotc(8 - i, b_A, qq_tmp + 1, b_A, qjj + 1) / b_A[qq_tmp]),
              qq_tmp + 1, b_A, qjj + 1);
      }

      e[qp1jj - 1] = b_A[qjj];
    }

    for (qq = i + 1; qq < 9; qq++) {
      qp1jj = (qq_tmp_tmp + qq) - 1;
      U[qp1jj] = b_A[qp1jj];
    }

    if (i + 1 <= 4) {
      nrm = xnrm2_g(5 - i, e, i + 2);
      if (nrm == 0.0) {
        e[i] = 0.0;
      } else {
        if (e[i + 1] < 0.0) {
          e[i] = -nrm;
        } else {
          e[i] = nrm;
        }

        nrm = e[i];
        if (std::abs(e[i]) >= 1.0020841800044864E-292) {
          nrm = 1.0 / e[i];
          scalarLB = ((((5 - i) / 2) << 1) + i) + 2;
          vectorUB = scalarLB - 2;
          for (qjj = qp1; qjj <= vectorUB; qjj += 2) {
            tmp = _mm_loadu_pd(&e[qjj - 1]);
            _mm_storeu_pd(&e[qjj - 1], _mm_mul_pd(tmp, _mm_set1_pd(nrm)));
          }

          for (qjj = scalarLB; qjj < 7; qjj++) {
            e[qjj - 1] *= nrm;
          }
        } else {
          scalarLB = ((((5 - i) / 2) << 1) + i) + 2;
          vectorUB = scalarLB - 2;
          for (qjj = qp1; qjj <= vectorUB; qjj += 2) {
            tmp = _mm_loadu_pd(&e[qjj - 1]);
            _mm_storeu_pd(&e[qjj - 1], _mm_div_pd(tmp, _mm_set1_pd(nrm)));
          }

          for (qjj = scalarLB; qjj < 7; qjj++) {
            e[qjj - 1] /= nrm;
          }
        }

        e[i + 1]++;
        e[i] = -e[i];
        for (qq = qp1; qq < 9; qq++) {
          work[qq - 1] = 0.0;
        }

        for (qq = qp1; qq < 7; qq++) {
          xaxpy_i(7 - i, e[qq - 1], b_A, (i + ((qq - 1) << 3)) + 2, work, i + 2);
        }

        for (qq = qp1; qq < 7; qq++) {
          xaxpy_iv(7 - i, -e[qq - 1] / e[i + 1], work, i + 2, b_A, (i + ((qq - 1)
                     << 3)) + 2);
        }
      }

      for (qq = qp1; qq < 7; qq++) {
        V[(qq + 6 * i) - 1] = e[qq - 1];
      }
    }
  }

  i = 4;
  e[4] = b_A[44];
  e[5] = 0.0;
  for (qp1 = 5; qp1 >= 0; qp1--) {
    qq_tmp = qp1 << 3;
    qq = qq_tmp + qp1;
    if (b_s[qp1] != 0.0) {
      for (qp1jj = qp1 + 2; qp1jj < 7; qp1jj++) {
        qjj = (((qp1jj - 1) << 3) + qp1) + 1;
        xaxpy(8 - qp1, -(xdotc(8 - qp1, U, qq + 1, U, qjj) / U[qq]), qq + 1, U,
              qjj);
      }

      for (qjj = qp1 + 1; qjj < 9; qjj++) {
        qp1jj = (qq_tmp + qjj) - 1;
        U[qp1jj] = -U[qp1jj];
      }

      U[qq]++;
      for (qq = 0; qq < qp1; qq++) {
        U[qq + qq_tmp] = 0.0;
      }
    } else {
      std::memset(&U[qq_tmp], 0, sizeof(real_T) << 3U);
      U[qq] = 1.0;
    }
  }

  for (qp1 = 5; qp1 >= 0; qp1--) {
    if ((qp1 + 1 <= 4) && (e[qp1] != 0.0)) {
      qq = (6 * qp1 + qp1) + 2;
      for (qjj = qp1 + 2; qjj < 7; qjj++) {
        qp1jj = ((qjj - 1) * 6 + qp1) + 2;
        xaxpy_ivt(5 - qp1, -(xdotc_l(5 - qp1, V, qq, V, qp1jj) / V[qq - 1]), qq,
                  V, qp1jj);
      }
    }

    for (qq = 0; qq < 6; qq++) {
      V[qq + 6 * qp1] = 0.0;
    }

    V[qp1 + 6 * qp1] = 1.0;
  }

  for (qp1 = 0; qp1 < 6; qp1++) {
    nrm = b_s[qp1];
    if (nrm != 0.0) {
      rt = std::abs(nrm);
      nrm /= rt;
      b_s[qp1] = rt;
      if (qp1 + 1 < 6) {
        e[qp1] /= nrm;
      }

      qq = (qp1 << 3) + 1;
      scalarLB = 8 + qq;
      vectorUB = qq + 6;
      for (qjj = qq; qjj <= vectorUB; qjj += 2) {
        tmp = _mm_loadu_pd(&U[qjj - 1]);
        _mm_storeu_pd(&U[qjj - 1], _mm_mul_pd(tmp, _mm_set1_pd(nrm)));
      }

      for (qjj = scalarLB; qjj <= qq + 7; qjj++) {
        U[qjj - 1] *= nrm;
      }
    }

    if (qp1 + 1 < 6) {
      smm1 = e[qp1];
      if (smm1 != 0.0) {
        rt = std::abs(smm1);
        nrm = rt / smm1;
        e[qp1] = rt;
        b_s[qp1 + 1] *= nrm;
        qq = (qp1 + 1) * 6 + 1;
        scalarLB = 6 + qq;
        vectorUB = qq + 4;
        for (qjj = qq; qjj <= vectorUB; qjj += 2) {
          tmp = _mm_loadu_pd(&V[qjj - 1]);
          _mm_storeu_pd(&V[qjj - 1], _mm_mul_pd(tmp, _mm_set1_pd(nrm)));
        }

        for (qjj = scalarLB; qjj <= qq + 5; qjj++) {
          V[qjj - 1] *= nrm;
        }
      }
    }
  }

  qp1 = 0;
  nrm = 0.0;
  for (qq = 0; qq < 6; qq++) {
    nrm = std::fmax(nrm, std::fmax(std::abs(b_s[qq]), std::abs(e[qq])));
  }

  while ((i + 2 > 0) && (qp1 < 75)) {
    qp1jj = i + 1;
    do {
      exitg1 = 0;
      qq = qp1jj;
      if (qp1jj == 0) {
        exitg1 = 1;
      } else {
        rt = std::abs(e[qp1jj - 1]);
        if ((rt <= (std::abs(b_s[qp1jj - 1]) + std::abs(b_s[qp1jj])) *
             2.2204460492503131E-16) || ((rt <= 1.0020841800044864E-292) ||
             ((qp1 > 20) && (rt <= 2.2204460492503131E-16 * nrm)))) {
          e[qp1jj - 1] = 0.0;
          exitg1 = 1;
        } else {
          qp1jj--;
        }
      }
    } while (exitg1 == 0);

    if (i + 1 == qp1jj) {
      qp1jj = 4;
    } else {
      qjj = i + 2;
      qq_tmp_tmp = i + 2;
      exitg2 = false;
      while ((!exitg2) && (qq_tmp_tmp >= qp1jj)) {
        qjj = qq_tmp_tmp;
        if (qq_tmp_tmp == qp1jj) {
          exitg2 = true;
        } else {
          rt = 0.0;
          if (qq_tmp_tmp < i + 2) {
            rt = std::abs(e[qq_tmp_tmp - 1]);
          }

          if (qq_tmp_tmp > qp1jj + 1) {
            rt += std::abs(e[qq_tmp_tmp - 2]);
          }

          ztest = std::abs(b_s[qq_tmp_tmp - 1]);
          if ((ztest <= 2.2204460492503131E-16 * rt) || (ztest <=
               1.0020841800044864E-292)) {
            b_s[qq_tmp_tmp - 1] = 0.0;
            exitg2 = true;
          } else {
            qq_tmp_tmp--;
          }
        }
      }

      if (qjj == qp1jj) {
        qp1jj = 3;
      } else if (i + 2 == qjj) {
        qp1jj = 1;
      } else {
        qp1jj = 2;
        qq = qjj;
      }
    }

    switch (qp1jj) {
     case 1:
      rt = e[i];
      e[i] = 0.0;
      for (qjj = i + 1; qjj >= qq + 1; qjj--) {
        xrotg(&b_s[qjj - 1], &rt, &ztest, &sqds);
        if (qjj > qq + 1) {
          smm1 = e[qjj - 2];
          rt = -sqds * smm1;
          e[qjj - 2] = smm1 * ztest;
        }

        xrot(V, 6 * (qjj - 1) + 1, 6 * (i + 1) + 1, ztest, sqds);
      }
      break;

     case 2:
      rt = e[qq - 1];
      e[qq - 1] = 0.0;
      for (qjj = qq + 1; qjj <= i + 2; qjj++) {
        xrotg(&b_s[qjj - 1], &rt, &ztest, &sqds);
        smm1 = e[qjj - 1];
        rt = -sqds * smm1;
        e[qjj - 1] = smm1 * ztest;
        xrot_c(U, ((qjj - 1) << 3) + 1, ((qq - 1) << 3) + 1, ztest, sqds);
      }
      break;

     case 3:
      rt = b_s[i + 1];
      ztest = std::fmax(std::fmax(std::fmax(std::fmax(std::abs(rt), std::abs
        (b_s[i])), std::abs(e[i])), std::abs(b_s[qq])), std::abs(e[qq]));
      tmp = _mm_set1_pd(ztest);
      _mm_storeu_pd(&tmp_0[0], _mm_div_pd(_mm_set_pd(b_s[i], rt), tmp));
      rt = tmp_0[0];
      smm1 = tmp_0[1];
      _mm_storeu_pd(&tmp_0[0], _mm_div_pd(_mm_set_pd(b_s[qq], e[i]), tmp));
      smm1 = ((smm1 + rt) * (smm1 - rt) + tmp_0[0] * tmp_0[0]) / 2.0;
      sqds = rt * tmp_0[0];
      sqds *= sqds;
      if ((smm1 != 0.0) || (sqds != 0.0)) {
        shift = std::sqrt(smm1 * smm1 + sqds);
        if (smm1 < 0.0) {
          shift = -shift;
        }

        shift = sqds / (smm1 + shift);
      } else {
        shift = 0.0;
      }

      rt = (tmp_0[1] + rt) * (tmp_0[1] - rt) + shift;
      ztest = e[qq] / ztest * tmp_0[1];
      for (qjj = qq + 1; qjj <= i + 1; qjj++) {
        xrotg(&rt, &ztest, &sqds, &smm1);
        if (qjj > qq + 1) {
          e[qjj - 2] = rt;
        }

        shift = e[qjj - 1];
        rt = b_s[qjj - 1];
        e[qjj - 1] = shift * sqds - rt * smm1;
        ztest = smm1 * b_s[qjj];
        b_s[qjj] *= sqds;
        xrot(V, 6 * (qjj - 1) + 1, 6 * qjj + 1, sqds, smm1);
        b_s[qjj - 1] = rt * sqds + shift * smm1;
        xrotg(&b_s[qjj - 1], &ztest, &sqds, &smm1);
        ztest = e[qjj - 1];
        rt = ztest * sqds + smm1 * b_s[qjj];
        b_s[qjj] = ztest * -smm1 + sqds * b_s[qjj];
        ztest = smm1 * e[qjj];
        e[qjj] *= sqds;
        xrot_c(U, ((qjj - 1) << 3) + 1, (qjj << 3) + 1, sqds, smm1);
      }

      e[i] = rt;
      qp1++;
      break;

     default:
      if (b_s[qq] < 0.0) {
        b_s[qq] = -b_s[qq];
        qp1 = 6 * qq + 1;
        scalarLB = 6 + qp1;
        vectorUB = qp1 + 4;
        for (qjj = qp1; qjj <= vectorUB; qjj += 2) {
          tmp = _mm_loadu_pd(&V[qjj - 1]);
          _mm_storeu_pd(&V[qjj - 1], _mm_mul_pd(tmp, _mm_set1_pd(-1.0)));
        }

        for (qjj = scalarLB; qjj <= qp1 + 5; qjj++) {
          V[qjj - 1] = -V[qjj - 1];
        }
      }

      qp1 = qq + 1;
      while ((qq + 1 < 6) && (b_s[qq] < b_s[qp1])) {
        rt = b_s[qq];
        b_s[qq] = b_s[qp1];
        b_s[qp1] = rt;
        xswap(V, 6 * qq + 1, 6 * (qq + 1) + 1);
        xswap_j(U, (qq << 3) + 1, ((qq + 1) << 3) + 1);
        qq = qp1;
        qp1++;
      }

      qp1 = 0;
      i--;
      break;
    }
  }

  for (i = 0; i < 6; i++) {
    s[i] = b_s[i];
  }

  if (doscale) {
    xzlascl_h(cscale, anrm, 6, 1, s, 1, 6);
  }
}

// Model step function
void Controller::step()
{
  __m128d tmp;
  __m128d tmp_1;
  __m128d tmp_2;
  __m128d tmp_3;
  __m128d tmp_4;
  real_T U[48];
  real_T inv_wrench[48];
  real_T V[36];
  real_T s[6];
  real_T tmp_0[2];
  real_T absx;
  int32_T ar;
  int32_T b_ic;
  int32_T ib;
  int32_T j;
  int32_T r;
  int32_T scalarLB;
  int32_T scalarLB_tmp;
  int32_T vcol;
  int32_T vectorUB;
  boolean_T exitg1;
  boolean_T p;
  if ((&rtM)->isMajorTimeStep()) {
    // set solver stop time
    rtsiSetSolverStopTime(&(&rtM)->solverInfo,(((&rtM)->Timing.clockTick0+1)*
      (&rtM)->Timing.stepSize0));
  }                                    // end MajorTimeStep

  // Update absolute time of base rate at minor time step
  if ((&rtM)->isMinorTimeStep()) {
    (&rtM)->Timing.t[0] = rtsiGetT(&(&rtM)->solverInfo);
  }

  // Outputs for Atomic SubSystem: '<Root>/Controller'
  // Gain: '<S46>/Filter Coefficient'
  tmp_1 = _mm_set1_pd(100.0);

  // Inport: '<Root>/Error' incorporates:
  //   Gain: '<S36>/Derivative Gain'

  tmp_3 = _mm_loadu_pd(&rtU.Error[0]);

  // Gain: '<S88>/Derivative Gain' incorporates:
  //   Gain: '<S36>/Derivative Gain'
  //   Integrator: '<S38>/Filter'
  //   Integrator: '<S90>/Filter'

  _mm_storeu_pd(&tmp_0[0], _mm_mul_pd(_mm_sub_pd(_mm_mul_pd(_mm_set_pd(20.0,
    80.0), tmp_3), _mm_set_pd(rtX.Filter_CSTATE_i, rtX.Filter_CSTATE)), tmp_1));

  // End of Outputs for SubSystem: '<Root>/Controller'

  // Gain: '<S46>/Filter Coefficient'
  rtDW.FilterCoefficient = tmp_0[0];

  // Gain: '<S98>/Filter Coefficient'
  rtDW.FilterCoefficient_d = tmp_0[1];

  // Outputs for Atomic SubSystem: '<Root>/Controller'
  // Gain: '<S192>/Derivative Gain' incorporates:
  //   Gain: '<S140>/Derivative Gain'

  tmp_2 = _mm_set_pd(20.0, 40.0);

  // Inport: '<Root>/Error' incorporates:
  //   Gain: '<S140>/Derivative Gain'

  tmp_2 = _mm_mul_pd(tmp_2, _mm_loadu_pd(&rtU.Error[2]));

  // Integrator: '<S194>/Filter' incorporates:
  //   Integrator: '<S142>/Filter'

  _mm_storeu_pd(&tmp_0[0], _mm_mul_pd(_mm_sub_pd(tmp_2, _mm_set_pd
    (rtX.Filter_CSTATE_j, rtX.Filter_CSTATE_e)), tmp_1));

  // End of Outputs for SubSystem: '<Root>/Controller'

  // Gain: '<S150>/Filter Coefficient'
  rtDW.FilterCoefficient_g = tmp_0[0];

  // Gain: '<S202>/Filter Coefficient'
  rtDW.FilterCoefficient_p = tmp_0[1];

  // Outputs for Atomic SubSystem: '<Root>/Controller'
  // Inport: '<Root>/Error' incorporates:
  //   Gain: '<S244>/Derivative Gain'

  tmp_4 = _mm_loadu_pd(&rtU.Error[4]);

  // Gain: '<S296>/Derivative Gain' incorporates:
  //   Gain: '<S244>/Derivative Gain'
  //   Integrator: '<S246>/Filter'
  //   Integrator: '<S298>/Filter'

  _mm_storeu_pd(&tmp_0[0], _mm_mul_pd(_mm_sub_pd(_mm_mul_pd(_mm_set_pd(5.0, 50.0),
    tmp_4), _mm_set_pd(rtX.Filter_CSTATE_a, rtX.Filter_CSTATE_o)), tmp_1));

  // End of Outputs for SubSystem: '<Root>/Controller'

  // Gain: '<S254>/Filter Coefficient'
  rtDW.FilterCoefficient_m = tmp_0[0];

  // Gain: '<S306>/Filter Coefficient'
  rtDW.FilterCoefficient_j = tmp_0[1];

  // Outputs for Atomic SubSystem: '<Root>/Controller'
  // MATLAB Function: '<S1>/MATLAB Function'
  p = true;
  for (r = 0; r < 48; r++) {
    inv_wrench[r] = 0.0;
    if (p && ((!std::isinf(rtConstP.MATLABFunction_wrench[r])) && (!std::isnan
          (rtConstP.MATLABFunction_wrench[r])))) {
    } else {
      p = false;
    }
  }

  if (!p) {
    for (r = 0; r < 48; r++) {
      inv_wrench[r] = (rtNaN);
    }
  } else {
    svd(rtConstP.MATLABFunction_wrench, U, s, V);
    absx = std::abs(s[0]);
    if (std::isinf(absx) || std::isnan(absx)) {
      absx = (rtNaN);
    } else if (absx < 4.4501477170144028E-308) {
      absx = 4.94065645841247E-324;
    } else {
      std::frexp(absx, &vcol);
      absx = std::ldexp(1.0, vcol - 53);
    }

    absx *= 8.0;
    r = 0;
    exitg1 = false;
    while ((!exitg1) && (r < 6)) {
      if (std::isinf(s[r]) || std::isnan(s[r])) {
        absx = 1.7976931348623157E+308;
        exitg1 = true;
      } else {
        r++;
      }
    }

    r = -1;
    vcol = 0;
    while ((vcol < 6) && (s[vcol] > absx)) {
      r++;
      vcol++;
    }

    if (r + 1 > 0) {
      vcol = 1;
      for (j = 0; j <= r; j++) {
        absx = 1.0 / s[j];
        scalarLB_tmp = 6 + vcol;
        vectorUB = vcol + 4;
        for (ar = vcol; ar <= vectorUB; ar += 2) {
          tmp_1 = _mm_loadu_pd(&V[ar - 1]);
          _mm_storeu_pd(&V[ar - 1], _mm_mul_pd(tmp_1, _mm_set1_pd(absx)));
        }

        for (ar = scalarLB_tmp; ar <= vcol + 5; ar++) {
          V[ar - 1] *= absx;
        }

        vcol += 6;
      }

      vcol = 0;
      for (j = 0; j <= 42; j += 6) {
        for (ar = j + 1; ar <= j + 6; ar++) {
          inv_wrench[ar - 1] = 0.0;
        }
      }

      for (j = 0; j <= 42; j += 6) {
        ar = -1;
        vcol++;
        scalarLB_tmp = (r << 3) + vcol;
        for (ib = vcol; ib <= scalarLB_tmp; ib += 8) {
          scalarLB = j + 7;
          vectorUB = j + 5;
          for (b_ic = j + 1; b_ic <= vectorUB; b_ic += 2) {
            tmp_1 = _mm_loadu_pd(&V[(ar + b_ic) - j]);
            tmp = _mm_loadu_pd(&inv_wrench[b_ic - 1]);
            _mm_storeu_pd(&inv_wrench[b_ic - 1], _mm_add_pd(_mm_mul_pd(tmp_1,
              _mm_set1_pd(U[ib - 1])), tmp));
          }

          for (b_ic = scalarLB; b_ic <= j + 6; b_ic++) {
            inv_wrench[b_ic - 1] += V[(ar + b_ic) - j] * U[ib - 1];
          }

          ar += 6;
        }
      }
    }
  }

  // SignalConversion generated from: '<S2>/ SFunction ' incorporates:
  //   Gain: '<S100>/Proportional Gain'
  //   Gain: '<S256>/Proportional Gain'
  //   Gain: '<S308>/Proportional Gain'
  //   Gain: '<S48>/Proportional Gain'
  //   Integrator: '<S147>/Integrator'
  //   Integrator: '<S199>/Integrator'
  //   Integrator: '<S251>/Integrator'
  //   Integrator: '<S303>/Integrator'
  //   Integrator: '<S43>/Integrator'
  //   Integrator: '<S95>/Integrator'
  //   MATLAB Function: '<S1>/MATLAB Function'
  //   Sum: '<S104>/Sum'
  //   Sum: '<S156>/Sum'
  //   Sum: '<S208>/Sum'
  //   Sum: '<S260>/Sum'
  //   Sum: '<S312>/Sum'
  //   Sum: '<S52>/Sum'

  _mm_storeu_pd(&s[0], _mm_add_pd(_mm_add_pd(_mm_mul_pd(_mm_set_pd(20.0, 50.0),
    tmp_3), _mm_set_pd(rtX.Integrator_CSTATE_m, rtX.Integrator_CSTATE)),
    _mm_set_pd(rtDW.FilterCoefficient_d, rtDW.FilterCoefficient)));
  _mm_storeu_pd(&s[2], _mm_add_pd(_mm_add_pd(tmp_2, _mm_set_pd
    (rtX.Integrator_CSTATE_k, rtX.Integrator_CSTATE_j)), _mm_set_pd
    (rtDW.FilterCoefficient_p, rtDW.FilterCoefficient_g)));
  _mm_storeu_pd(&s[4], _mm_add_pd(_mm_add_pd(_mm_mul_pd(_mm_set_pd(5.0, 20.0),
    tmp_4), _mm_set_pd(rtX.Integrator_CSTATE_h, rtX.Integrator_CSTATE_p)),
    _mm_set_pd(rtDW.FilterCoefficient_j, rtDW.FilterCoefficient_m)));
  for (r = 0; r < 8; r++) {
    // MATLAB Function: '<S1>/MATLAB Function'
    absx = 0.0;
    for (vcol = 0; vcol < 6; vcol++) {
      absx += inv_wrench[6 * r + vcol] * s[vcol];
    }

    // Saturate: '<S1>/Saturation' incorporates:
    //   Constant: '<S1>/PWM Stop'
    //   Gain: '<S1>/Gain'
    //   MATLAB Function: '<S1>/MATLAB Function'
    //   Sum: '<S1>/Sum1'

    absx = 10.0 * absx + 1500.0;
    if (absx > 1900.0) {
      // Outport: '<Root>/PWM'
      rtY.PWM[r] = 1900.0;
    } else if (absx < 1100.0) {
      // Outport: '<Root>/PWM'
      rtY.PWM[r] = 1100.0;
    } else {
      // Outport: '<Root>/PWM'
      rtY.PWM[r] = absx;
    }

    // End of Saturate: '<S1>/Saturation'
  }

  // End of Outputs for SubSystem: '<Root>/Controller'
  if ((&rtM)->isMajorTimeStep()) {
    rt_ertODEUpdateContinuousStates(&(&rtM)->solverInfo);

    // Update absolute time for base rate
    // The "clockTick0" counts the number of times the code of this task has
    //  been executed. The absolute time is the multiplication of "clockTick0"
    //  and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
    //  overflow during the application lifespan selected.

    ++(&rtM)->Timing.clockTick0;
    (&rtM)->Timing.t[0] = rtsiGetSolverStopTime(&(&rtM)->solverInfo);

    {
      // Update absolute timer for sample time: [1.2s, 0.0s]
      // The "clockTick1" counts the number of times the code of this task has
      //  been executed. The resolution of this integer timer is 1.2, which is the step size
      //  of the task. Size of "clockTick1" ensures timer will not overflow during the
      //  application lifespan selected.

      (&rtM)->Timing.clockTick1++;
    }
  }                                    // end MajorTimeStep
}

// Derivatives for root system: '<Root>'
void Controller::Controller_derivatives()
{
  Controller::XDot *_rtXdot;
  _rtXdot = ((XDot *) (&rtM)->derivs);

  // Derivatives for Atomic SubSystem: '<Root>/Controller'
  // Derivatives for Integrator: '<S43>/Integrator' incorporates:
  //   Inport: '<Root>/Error'

  _rtXdot->Integrator_CSTATE = rtU.Error[0];

  // Derivatives for Integrator: '<S38>/Filter'
  _rtXdot->Filter_CSTATE = rtDW.FilterCoefficient;

  // Derivatives for Integrator: '<S95>/Integrator' incorporates:
  //   Inport: '<Root>/Error'

  _rtXdot->Integrator_CSTATE_m = rtU.Error[1];

  // Derivatives for Integrator: '<S90>/Filter'
  _rtXdot->Filter_CSTATE_i = rtDW.FilterCoefficient_d;

  // Derivatives for Integrator: '<S147>/Integrator' incorporates:
  //   Inport: '<Root>/Error'

  _rtXdot->Integrator_CSTATE_j = rtU.Error[2];

  // Derivatives for Integrator: '<S142>/Filter'
  _rtXdot->Filter_CSTATE_e = rtDW.FilterCoefficient_g;

  // Derivatives for Integrator: '<S199>/Integrator' incorporates:
  //   Inport: '<Root>/Error'

  _rtXdot->Integrator_CSTATE_k = rtU.Error[3];

  // Derivatives for Integrator: '<S194>/Filter'
  _rtXdot->Filter_CSTATE_j = rtDW.FilterCoefficient_p;

  // Derivatives for Integrator: '<S251>/Integrator' incorporates:
  //   Inport: '<Root>/Error'

  _rtXdot->Integrator_CSTATE_p = rtU.Error[4];

  // Derivatives for Integrator: '<S246>/Filter'
  _rtXdot->Filter_CSTATE_o = rtDW.FilterCoefficient_m;

  // Derivatives for Integrator: '<S303>/Integrator' incorporates:
  //   Inport: '<Root>/Error'

  _rtXdot->Integrator_CSTATE_h = rtU.Error[5];

  // Derivatives for Integrator: '<S298>/Filter'
  _rtXdot->Filter_CSTATE_a = rtDW.FilterCoefficient_j;

  // End of Derivatives for SubSystem: '<Root>/Controller'
}

// Model initialize function
void Controller::initialize()
{
  // Registration code
  {
    // Setup solver object
    rtsiSetSimTimeStepPtr(&(&rtM)->solverInfo, &(&rtM)->Timing.simTimeStep);
    rtsiSetTPtr(&(&rtM)->solverInfo, (&rtM)->getTPtrPtr());
    rtsiSetStepSizePtr(&(&rtM)->solverInfo, &(&rtM)->Timing.stepSize0);
    rtsiSetdXPtr(&(&rtM)->solverInfo, &(&rtM)->derivs);
    rtsiSetContStatesPtr(&(&rtM)->solverInfo, (real_T **) &(&rtM)->contStates);
    rtsiSetNumContStatesPtr(&(&rtM)->solverInfo, &(&rtM)->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&(&rtM)->solverInfo, &(&rtM)
      ->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&(&rtM)->solverInfo, &(&rtM)
      ->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&(&rtM)->solverInfo, &(&rtM)
      ->periodicContStateRanges);
    rtsiSetContStateDisabledPtr(&(&rtM)->solverInfo, (boolean_T**) &(&rtM)
      ->contStateDisabled);
    rtsiSetErrorStatusPtr(&(&rtM)->solverInfo, (&rtM)->getErrorStatusPtr());
    rtsiSetRTModelPtr(&(&rtM)->solverInfo, (&rtM));
  }

  rtsiSetSimTimeStep(&(&rtM)->solverInfo, MAJOR_TIME_STEP);
  rtsiSetIsMinorTimeStepWithModeChange(&(&rtM)->solverInfo, false);
  rtsiSetIsContModeFrozen(&(&rtM)->solverInfo, false);
  (&rtM)->intgData.y = (&rtM)->odeY;
  (&rtM)->intgData.f[0] = (&rtM)->odeF[0];
  (&rtM)->intgData.f[1] = (&rtM)->odeF[1];
  (&rtM)->intgData.f[2] = (&rtM)->odeF[2];
  (&rtM)->contStates = ((X *) &rtX);
  (&rtM)->contStateDisabled = ((XDis *) &rtXDis);
  (&rtM)->Timing.tStart = (0.0);
  rtsiSetSolverData(&(&rtM)->solverInfo, static_cast<void *>(&(&rtM)->intgData));
  rtsiSetSolverName(&(&rtM)->solverInfo,"ode3");
  (&rtM)->setTPtr(&(&rtM)->Timing.tArray[0]);
  (&rtM)->Timing.stepSize0 = 1.2;

  // SystemInitialize for Atomic SubSystem: '<Root>/Controller'
  // InitializeConditions for Integrator: '<S43>/Integrator'
  rtX.Integrator_CSTATE = 0.0;

  // InitializeConditions for Integrator: '<S38>/Filter'
  rtX.Filter_CSTATE = 0.0;

  // InitializeConditions for Integrator: '<S95>/Integrator'
  rtX.Integrator_CSTATE_m = 0.0;

  // InitializeConditions for Integrator: '<S90>/Filter'
  rtX.Filter_CSTATE_i = 0.0;

  // InitializeConditions for Integrator: '<S147>/Integrator'
  rtX.Integrator_CSTATE_j = 0.0;

  // InitializeConditions for Integrator: '<S142>/Filter'
  rtX.Filter_CSTATE_e = 0.0;

  // InitializeConditions for Integrator: '<S199>/Integrator'
  rtX.Integrator_CSTATE_k = 0.0;

  // InitializeConditions for Integrator: '<S194>/Filter'
  rtX.Filter_CSTATE_j = 0.0;

  // InitializeConditions for Integrator: '<S251>/Integrator'
  rtX.Integrator_CSTATE_p = 0.0;

  // InitializeConditions for Integrator: '<S246>/Filter'
  rtX.Filter_CSTATE_o = 0.0;

  // InitializeConditions for Integrator: '<S303>/Integrator'
  rtX.Integrator_CSTATE_h = 0.0;

  // InitializeConditions for Integrator: '<S298>/Filter'
  rtX.Filter_CSTATE_a = 0.0;

  // End of SystemInitialize for SubSystem: '<Root>/Controller'
}

time_T** Controller::RT_MODEL::getTPtrPtr()
{
  return &(Timing.t);
}

boolean_T Controller::RT_MODEL::getStopRequested() const
{
  return (Timing.stopRequestedFlag);
}

void Controller::RT_MODEL::setStopRequested(boolean_T aStopRequested)
{
  (Timing.stopRequestedFlag = aStopRequested);
}

const char_T* Controller::RT_MODEL::getErrorStatus() const
{
  return (errorStatus);
}

void Controller::RT_MODEL::setErrorStatus(const char_T* const aErrorStatus)
{
  (errorStatus = aErrorStatus);
}

time_T* Controller::RT_MODEL::getTPtr() const
{
  return (Timing.t);
}

void Controller::RT_MODEL::setTPtr(time_T* aTPtr)
{
  (Timing.t = aTPtr);
}

boolean_T* Controller::RT_MODEL::getStopRequestedPtr()
{
  return (&(Timing.stopRequestedFlag));
}

const char_T** Controller::RT_MODEL::getErrorStatusPtr()
{
  return &errorStatus;
}

boolean_T Controller::RT_MODEL::isMajorTimeStep() const
{
  return ((Timing.simTimeStep) == MAJOR_TIME_STEP);
}

boolean_T Controller::RT_MODEL::isMinorTimeStep() const
{
  return ((Timing.simTimeStep) == MINOR_TIME_STEP);
}

time_T Controller::RT_MODEL::getTStart() const
{
  return (Timing.tStart);
}

// Constructor
Controller::Controller() :
  rtU(),
  rtY(),
  rtDW(),
  rtX(),
  rtXDis(),
  rtM()
{
  // Currently there is no constructor body generated.
}

// Destructor
// Currently there is no destructor body generated.
Controller::~Controller() = default;

// Real-Time Model get method
Controller::RT_MODEL * Controller::getRTM()
{
  return (&rtM);
}

//
// File trailer for generated code.
//
// [EOF]
//
