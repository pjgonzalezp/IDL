;; Exercise 5: Calculate the sine function of a number x by using its Taylor series
;; expansion. Use an implementation with a REPEAT loop. Do the same analysis
;; as in exercise no. 4.


PRO sine_taylor_repeat

  ; Pide el valor de x
  PRINT, 'Enter value of x'
  READ, x
;x = FLOAT(INPUT('Enter value of x (in radians): '))

  ; Define precisión
  eps = 1E-6

  ; Variables iniciales
  term = x        ; primer término
  sinx = term
  n = 1

  ; Bucle REPEAT
  REPEAT BEGIN
    ; Calcular el siguiente término de la serie
    term = -term * x^2 / ((2*n)*(2*n+1))
    
    ; Sumarlo al resultado
    sinx = sinx + term
    
    ; Incrementar n
    n = n + 1

  ENDREP UNTIL (ABS(term) LT eps)

  PRINT, 'Sine calculated by Taylor series = ', sinx
  PRINT, 'IDL built-in SIN(x) = ', SIN(x)
  PRINT, 'Number of terms used = ', n

END

