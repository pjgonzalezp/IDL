;===============================================================
; Programa: Ex16_b.pro
; Propósito: 
;   Inspeccionar el rango de valores de la imagen original (im0)
;   mediante un histograma, para estimar el rango dinámico del CCD.
; Ejercicio 16(b)
;===============================================================

pro Ex16_b

  compile_opt idl2
  ; Activa las reglas modernas de IDL para evitar errores comunes.

  ;-------------------------------------------------------------
  ; 1. Cargar el archivo con las imágenes
  ;-------------------------------------------------------------
  restore, 'q_data.sav'
  ; Restaura las variables guardadas: im0, ff0, dd0.
  ; Aquí solo nos interesa im0 (imagen original).

  ;-------------------------------------------------------------
  ; 2. Calcular el rango de valores en la imagen original
  ;-------------------------------------------------------------
  min_val = min(im0)
  max_val = max(im0)
  print, 'Rango de valores en im0: ', min_val, ' a ', max_val

  ;-------------------------------------------------------------
  ; 3. Seleccionar un tamaño de bin apropiado para el histograma
  ;-------------------------------------------------------------
  binsize = (max_val - min_val) / 256.0
  ; Usamos 256 bins para una visualización suave pero no excesiva.
  ; Puedes ajustar este número si el histograma sale muy ruidoso.

  ;-------------------------------------------------------------
  ; 4. Calcular el histograma
  ;-------------------------------------------------------------
  h = histogram(im0, binsize=binsize, min=min_val, max=max_val)
  ; Calcula la frecuencia de aparición de cada rango de intensidad.

  ;-------------------------------------------------------------
  ; 5. Crear el eje de intensidades correspondiente
  ;-------------------------------------------------------------
  bin_centers = findgen(n_elements(h)) * binsize + min_val
  ; Genera un vector con los valores centrales de cada bin.

  ;-------------------------------------------------------------
  ; 6. Mostrar el histograma
  ;-------------------------------------------------------------
  window, 1, xsize=800, ysize=500
  plot, bin_centers, h, $
        title='Histogram of Original Image (im0)', $
        xtitle='Intensity Value', ytitle='Number of Pixels', $
        thick=2, color=!p.color

  ;-------------------------------------------------------------
  ; 7. Mostrar información interpretativa
  ;-------------------------------------------------------------
  print, 'El histograma muestra la distribución de intensidades de píxeles.'
  print, 'Ahora podemos estimar el rango dinámico del CCD:'

  ; El rango dinámico depende del valor máximo:
  if max_val le 255 then print, 'Probablemente un CCD de 8 bits (0–255).'
  if max_val gt 255 and max_val le 1023 then print, 'Probablemente un CCD de 10 bits (0–1023).'
  if max_val gt 1023 and max_val le 4095 then print, 'Probablemente un CCD de 12 bits (0–4095).'
  if max_val gt 4095 and max_val le 16383 then print, 'Probablemente un CCD de 14 bits (0–16383).'

end
;===============================================================


