;; Exercise 3: Write a program that calculates the exponential function of a
;; number x by using its Taylor series expansion:
;; exp(x) = 1 + x1/1! + x2/2! + x3/3! + x4/4! + x5/5! . . . (1)

;; a) Implement such Taylor series using a FOR loop. Test the program first for
;; x = 1 (as you know the result) and vary the number of elements of the series
;; used for the calculation. Compare the accuracy of the result for different number
;; of terms used in calculating the series (e.g., 5, 10, 100, 1000). You can compare
;; your results with the one from the IDL function EXP. When the program works,
;; test it also for other values of x.
;; Note 1: Make sure you use floating point numbers and not integers in the
;; calculation.
;; Note 2: For the calculation of the series you could use the IDL function FACTORIAL.
;; But this will lead to some problems – which ones? why? Implement and test it
;; for different x.

;; b) You can implement a better solution which does not need the FACTORIAL
;; function. Looking into the series, one can see that each new (i) term can be
;; written as a product involving the preceding (i − 1) term. This means, saving
;; at each step the new term in a variable as well as the sum of the series so far in
;; a separate variable, allows us to calculate the series more efficiently.
;; Implement, test and discuss these two different approaches and their pro’s and
;; con’s.


PRO exp_taylor_iterative
  x = 1.0
  n_terms = [5, 10, 100, 1000]

  FOR j = 0, N_ELEMENTS(n_terms)-1 DO BEGIN
    n = n_terms[j]
    term = 1.0
    exp_approx = 1.0

    FOR i = 1, n DO BEGIN
      term = term * x / i   ; cada nuevo término depende del anterior
      exp_approx = exp_approx + term
    ENDFOR

    PRINT, 'Number of terms:', n
    PRINT, 'Approximation:', exp_approx
    PRINT, 'Actual value EXP(x)', EXP(x)
    PRINT, 'Absolute error:', ABS(exp_approx - EXP(x))
  ENDFOR
END

