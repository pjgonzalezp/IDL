;+ 
; Nombre: Ex16-a.pro
; Descripción: Ejercicio 16a - Mostrar imágenes original, flat field y dark current
;-

pro Ex16_a

  ; Cargar el archivo .sav
  restore, 'q_data.sav'
  
  ; Crear ventana para las tres imágenes
  window, 0, xsize=1200, ysize=400
  !p.multi = [0, 3, 1]

  ; Mostrar imagen original
  tv, im0, 0
  xyouts, 0.1, 0.95, 'Imagen Original (im0)', /normal, color=255

  ; Mostrar flat field
  tv, ff0, 1
  xyouts, 0.1, 0.95, 'Flat Field (ff0)', /normal, color=255

  ; Mostrar dark current
  tv, dd0, 2
  xyouts, 0.1, 0.95, 'Dark Current (dd0)', /normal, color=255

  !p.multi = 0
  
  ; Información sobre lo que vemos
  print, 'im0: Imagen del Sol en el continuo rojo, muestra la granulación solar y posiblemente algunas manchas'
  print, 'ff0: Flat field que muestra las variaciones de sensibilidad del detector'
  print, 'dd0: Dark current que representa el ruido térmico del CCD'

end

