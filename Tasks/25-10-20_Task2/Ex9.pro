;=========================================================
; Exercise 9 - Fibonacci Series
;---------------------------------------------------------
; This program defines functions to calculate the Fibonacci
; sequence up to the n-th element.
;
; Includes:
;   1. fibonacci(n)       → iterative version
;   2. fib_recursive(k)   → recursive helper
;   3. main test block
;=========================================================

;---------------------------------------------------------
; Iterative version: Efficient
;---------------------------------------------------------
FUNCTION fibonacci, n
    COMPILE_OPT idl2

    ; Validate input
    IF n LE 0 THEN RETURN, -1

    ; Initialize vector
    fib = LONARR(n)
    fib[0] = 1
    IF n GT 1 THEN fib[1] = 1

    ; Compute sequence
    FOR i = 2, n-1 DO fib[i] = fib[i-1] + fib[i-2]

    RETURN, fib
END


;---------------------------------------------------------
; Recursive version: Educational (not efficient)
;---------------------------------------------------------
FUNCTION fib_recursive, k
    IF k LE 2 THEN RETURN, 1
    RETURN, fib_recursive(k-1) + fib_recursive(k-2)
END


;---------------------------------------------------------
; Main test procedure
;---------------------------------------------------------
PRO test_fibonacci
    COMPILE_OPT idl2

    PRINT, '=============================================='
    PRINT, ' Exercise 9: Fibonacci Series '
    PRINT, '=============================================='

    ;------------------------------
    ; Test iterative version
    ;------------------------------
    n = 10
    PRINT, 'Iterative Fibonacci, n = ', n
    fib_vec = fibonacci(n)
    PRINT, 'Result: ', fib_vec

    ;------------------------------
    ; Timing comparison
    ;------------------------------
    n = 25
    PRINT, ''
    PRINT, 'Timing comparison for n = ', n

    t0 = systime(/seconds)
    fib_vec = fibonacci(n)
    t_iter = systime(/seconds) - t0

    t0 = systime(/seconds)
    fib_rec = fib_recursive(n)
    t_rec = systime(/seconds) - t0

    PRINT, 'Iterative result (last term): ', fib_vec[n-1]
    PRINT, 'Recursive result (last term): ', fib_rec
    PRINT, FORMAT='(A, F6.3, A)', 'Iterative time: ', t_iter, ' s'
    PRINT, FORMAT='(A, F6.3, A)', 'Recursive time: ', t_rec, ' s'

    PRINT, ''
    PRINT, 'Note: Recursive grows exponentially slower for large n.'
END

