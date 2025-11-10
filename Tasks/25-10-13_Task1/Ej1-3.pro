;;Exercise 1: Write a program that asks for and reads a number (from 1 to 7)
;from the keyboard, and that gives as output the corresponding day of the week
;(MON, TUE, etc.), using a CASE statement. In case that the input is not in the
;correct range (1 – 7), give a corresponding error message.
;Expand and change the example above with a GOTO statement: In case that the
;input number is not in the range 1 – 7, give an error message and start again
;with asking for the input.
;This can also be solved with a loop, use the REPEAT
;statement to implement the same functionality.

PRO days_of_the_week3
  ;Pide un número y muestra el día de la semana correspondiente
  ;Pide el número usando un bucle REPEAT ... UNTIL

  REPEAT BEGIN
     PRINT, 'Write a number between 1 to 7:'
     READ, n                    ;lee el número y lo asigna a n
          ;LT: less than, GT: Greater than
     IF (n LT 1) OR (n GT 7) THEN
     PRINT, 'Error: The number must be between 1 and 7. Try again'
  ENDREPEAT UNTIL (n GE 1) and (n LE 7)
                    ; GE: Greater or equal, LE: Less or equal
  
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

     


