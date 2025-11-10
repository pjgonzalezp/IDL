;; Exercise 4: Use an implementation for calculating the exponential function
;; based on variant b) above. But now use a WHILE loop. The calculation shall
;; stop when the new term that is calculated is smaller than a given accuracy,
;; say ε = 10–6. (In IDL the command for this assignment would be, e.g., eps =
;; 1E-6). At the end of the program print as output the result, the number of
;; terms that were needed in the calculation as well as the difference between the
;; result from your Taylor series calculations and the IDL function EXP. Test the
;; program for different values of x. Discuss how the results behave for different
;; values of x in terms of accuracy and number of terms needed.

PRO exp_taylor_while
  ; Pedir valor de x
  PRINT, 'Enter a value for x:'
  READ, x
  ;x = FLOAT(INPUT('Enter a value for x: '))
  
  ; Definir precisión
  eps = 1E-6

  ; Inicializar variables
  term = 1.0
  sum = term
  n = 1

  ; Calcular mientras el término sea mayor que la precisión
  WHILE ABS(term) GT eps DO BEGIN
    term = term * x / n
    sum = sum + term
    n = n + 1
  ENDWHILE

  ; Calcular el valor exacto con la función IDL
  exact = EXP(x)

  ; Calcular diferencia
  diff = ABS(sum - exact)

  ; Imprimir resultados
  PRINT, 'Value of x: ', x
  PRINT, 'Taylor series result: ', sum
  PRINT, 'IDL EXP(x): ', exact
  PRINT, 'Difference: ', diff
  PRINT, 'Number of terms used: ', n

END

