;;Exercise 1: Write a program that asks for and reads a number (from 1 to 7)
;from the keyboard, and that gives as output the corresponding day of the week
;(MON, TUE, etc.), using a CASE statement. In case that the input is not in the
;correct range (1 – 7), give a corresponding error message.
;Expand and change the example above with a GOTO statement: In case that the
;input number is not in the range 1 – 7, give an error message and start again
;with asking for the input.


PRO days_of_the_week2
  ;Pide un número y muestra el día de la semana correspondiente
  ;Repite la petición usando GOTO si el número no es válido

  read_input:  ; etiqueta
  PRINT, 'Write a number between 1 to 7:'
  READ, n  ;lee el número y lo asigna a n

  IF (n LT 1) OR (n GT 7) THEN BEGIN  ;LT: less than, GT: Greater than
     PRINT, 'Error: The number must be between 1 and 7. Try again'
     GOTO, read_input
  ENDIF
  
  CASE n OF    ; selecciona segun el n
     1: PRINT, 'Monday'
     2: PRINT, 'Tuesday'
     3: PRINT, 'Wednesday'
     4: PRINT, 'Thursday'
     5: PRINT, 'Friday'
     6: PRINT, 'Saturday'
     7: PRINT, 'Sunday'
  ENDCASE
END

     


