;Exercise 2: Define two vectors: x = 0, 0.05, 0.1, . . . 5 and f(x) = x^0.5
;a) Make a graph of f as function of x (use the routine PLOT, x, y).
;b) Calculate for which entries of x the function f has a value larger than 1.5 (use
;the WHERE function). Print the corresponding x values and check the obtained
;results against the graphics.
;c) For how many data points is f(x) larger than 1.5? (Hint: check the IDL help
;or online IDL search for the WHERE function and for N ELEMENTS.)

;se define el vector y función

x = FINDGEN(101)*0.05 ;  genera 101 valores: 0, 0.05, 0.1, ..., 5
f = SQRT(x) ; función raíz cuadrada

;Gráfica f(x) vs x

PLOT, x, f, TITLE = 'f(x) = sqrt(x)', XTITLE = 'x', YTITLE = 'f(x)

;b) índices donde f es mayor que 1.5
index = WHERE(f GT 1.5, count) ;GT: Greater than

; Imprimimos los valores correspondientes de x y f
PRINT, 'x values where f(x) > 1.5: ', x[index]
PRINT, 'f(x) values: ', f[index]

; c) número total de puntos que cumplen f(x) > 1.5
PRINT, 'Number of points with f(x) > 1.5: ', count

end
