;+ 
; Nombre: Ex16-d2.pro
; Descripción: Ejercicio 16d - Reducción astronómica (flat field y dark current)
;-

pro Ex16_d2

  ; Cargar datos si no están cargados - SINTÁXIS CORREGIDA
  dims = size(im0, /dimensions)
  if dims[0] eq 0 then restore, 'q_data.sav'
  ; =============================================
  ; APLICAR REDUCCIÓN ASTRONÓMICA
  ; Fórmula: imagen_corregida = (imagen_original - dark_current) / (flat_field - dark_current)
  ; =============================================
  ; Paso 1: Calcular el flat field normalizado
  ; Restamos el dark current al flat field para eliminar el bias
  flat_corrected = ff0 - dd0
  ; Paso 2: Aplicar la corrección completa a la imagen científica
  ; Primero restamos el dark current, luego dividimos por el flat field corregido
  im_corrected = (im0 - dd0) / flat_corrected
  ; =============================================
  ; MOSTRAR COMPARACIÓN: IMAGEN ORIGINAL vs CORREGIDA
  ; =============================================
  ; Crear ventana para comparación lado a lado
  window, 3, xsize=1000, ysize=500
  !p.multi = [0, 2, 1]  ; 2 columnas, 1 fila
  ; Mostrar imagen original (raw)
  tv, im0, 0
  xyouts, 0.1, 0.95, 'Imagen Original (RAW)', /normal, color=255, /bold
  xyouts, 0.1, 0.90, 'Sin correcciones', /normal, color=255
  ; Mostrar imagen corregida
  tv, im_corrected, 1
  xyouts, 0.1, 0.95, 'Imagen Corregida', /normal, color=255, /bold
  xyouts, 0.1, 0.90, 'Flat field + Dark current', /normal, color=255
  !p.multi = 0  ; Regresar a modo de ventana simple
  ; =============================================
  ; ANÁLISIS DE LAS DIFERENCIAS
  ; =============================================
  ; Calcular estadísticas para comparar
  mean_original = mean(im0)
  mean_corrected = mean(im_corrected)
  std_original = stddev(im0)
  std_corrected = stddev(im_corrected)
 print, '=== COMPARACIÓN ESTADÍSTICA ==='
  print, 'Imagen ORIGINAL - Media:', mean_original, 'Desviación estándar:', std_original
  print, 'Imagen CORREGIDA - Media:', mean_corrected, 'Desviación estándar:', std_corrected
  print, ''
  ; =============================================
  ; EXPLICACIÓN DE LAS DIFERENCIAS OBSERVADAS
  ; =============================================
  print, '=== ¿QUÉ DIFERENCIAS SE OBSERVAN? ==='
  print, '1. Se eliminan las variaciones de sensibilidad del detector (flat field)'
  print, '2. Se remueve el ruido térmico (dark current)'
  print, '3. La imagen corregida muestra mejor contraste real de las estructuras solares'
  print, '4. Se eliminan artefactos como manchas, rayas o gradientes del detector'
  print, '5. La granulación solar y estructuras se ven más nítidas y reales'
  print, ''
  
  ; Mostrar una tercera ventana con la imagen corregida en grande
  window, 4
  loadct, 0  ; Tabla de colores gris
  tv, im_corrected
  xyouts, 0.1, 0.95, 'IMAGEN FINAL CORREGIDA - Estructuras solares reales', /normal, color=255, /bold
  
  print, 'Reducción astronómica completada exitosamente!'

end


