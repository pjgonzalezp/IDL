;===============================================================
; Programa: Ex16_d.pro
; Propósito: 
;   Aplicar la reducción astronómica a la imagen solar.
;   Corrección por dark current y flat field.
;   Mostrar la imagen corregida y compararla con la original.
; Ejercicio 16(d)
;===============================================================

pro Ex16_d

  compile_opt idl2
  ; Activa reglas modernas de IDL

  ;-------------------------------------------------------------
  ; 1. Cargar las imágenes
  ;-------------------------------------------------------------
  restore, 'q_data.sav'
  ; im0 -> imagen original
  ; dd0 -> dark current
  ; ff0 -> flat field
  
  ;-------------------------------------------------------------
  ; 2. Aplicar la corrección astronómica
  ;-------------------------------------------------------------
  ; Fórmula: I_corrected = (I_raw - dark) / flat
  im_corrected = (im0 - dd0) / ff0
  ; Se resta el dark current (ruido) y se corrige por la sensibilidad variable del detector (flat field)

  ;-------------------------------------------------------------
  ; 3. Crear ventana para mostrar la imagen corregida
  ;-------------------------------------------------------------
  window, 0, xsize=600, ysize=600
  tvscl, im_corrected
  xyouts, 0.05, 0.95, 'Imagen corregida (im_corrected)', /normal, color=255
  ; tvscl -> muestra la imagen escalada automáticamente al rango de píxeles
  ; xyouts -> etiqueta la imagen con texto en la parte superior

  ;-------------------------------------------------------------
  ; 4. Mostrar información comparativa
  ;-------------------------------------------------------------
  print, 'Imagen original: im0'
  print, 'Imagen corregida: im_corrected'
  print, 'La imagen corregida elimina el patrón de dark current y las variaciones de sensibilidad (flat field).'
  print, 'Se observa la granulación solar más uniforme y sin artefactos del detector.'

end
;===============================================================




