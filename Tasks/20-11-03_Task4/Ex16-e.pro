;+ 
; Nombre: Ex16-e.pro
; Descripción: Ejercicio 16e - Volver a unidades físicas y comparar histogramas
;-

pro Ex16_e

  ; Cargar datos
  restore, 'q_data.sav'
  
  ; =============================================
  ; PASO 1: APLICAR REDUCCIÓN ASTRONÓMICA BÁSICA
  ; =============================================
  
  ; Calcular flat field corregido (flat - dark)
  flat_minus_dark = ff0 - dd0
  
  ; Aplicar corrección estándar: (imagen - dark) / (flat - dark)
  im_corrected_normalized = (im0 - dd0) / flat_minus_dark
  
  ; =============================================
  ; PASO 2: VOLVER A UNIDADES FÍSICAS
  ; =============================================
  
  ; Calcular el valor medio del flat field corregido
  mean_flat_dark = mean(flat_minus_dark)
  print, 'Valor medio de (flat - dark):', mean_flat_dark
  
  ; Multiplicar la imagen normalizada por el valor medio para recuperar unidades físicas
  im_corrected_physical = im_corrected_normalized * mean_flat_dark
  
  print, 'Imagen convertida de vuelta a unidades físicas'
  
  ; =============================================
  ; PASO 3: CALCULAR HISTOGRAMAS COMPARATIVOS - CORREGIDO
  ; =============================================
  
  ; Definir rango común para ambos histogramas
  data_min = min(im0)
  data_max = max(im0)
  binsize = 50  ; Tamaño de bin apropiado
  
  print, 'Rango de datos - Min:', data_min, 'Max:', data_max
  
  ; Calcular histograma de la imagen ORIGINAL
  hist_original = histogram(im0, min=data_min, max=data_max, binsize=binsize)
  
  ; Calcular histograma de la imagen CORREGIDA
  hist_corrected = histogram(im_corrected_physical, min=data_min, max=data_max, binsize=binsize)
  
  ; Crear array de valores X para el plot (centros de los bins) - CORREGIDO
  n_bins = n_elements(hist_original)
  x_values = data_min + (findgen(n_bins)) * binsize  ; Sin +0.5
  
  ; =============================================
  ; PASO 4: PLOT SUPERPUESTO - VERSIÓN MÁS ROBUSTA
  ; =============================================
  
  window, 5, xsize=800, ysize=600
  
  ; Verificar que los arrays tengan las mismas dimensiones
  if n_elements(hist_original) ne n_elements(hist_corrected) then begin
    print, 'ERROR: Histogramas tienen diferentes tamaños'
    return
  endif
  
  if n_elements(hist_original) ne n_elements(x_values) then begin
    print, 'ERROR: x_values no coincide con histogramas'
    return
  endif
  
  ; Encontrar el rango Y máximo para escalar el plot
  y_max = max([max(hist_original), max(hist_corrected)]) * 1.1
  
  ; Plot del histograma ORIGINAL - VERSIÓN SIMPLE
  plot, x_values, hist_original, $
        title='Comparación de Histogramas', $
        xTitle='Valor del Pixel', $
        yTitle='Frecuencia', $
        color=0, thick=2, $  ; Negro
        yrange=[0, y_max]
  
  ; Superponer histograma CORREGIDO
  oplot, x_values, hist_corrected, color=255, thick=2  ; Rojo
  
  ; Añadir texto en lugar de leyenda (más robusto)
  xyouts, 0.6, 0.85, 'Imagen Original (RAW)', /normal, color=0
  xyouts, 0.6, 0.80, 'Imagen Corregida', /normal, color=255
  
  ; =============================================
  ; PASO 5: ANÁLISIS COMPARATIVO
  ; =============================================
  
  print, ''
  print, '=== ANÁLISIS COMPARATIVO DE HISTOGRAMAS ==='
  print, 'Rango de datos:', data_min, 'a', data_max
  print, 'Número de bins:', n_bins
  print, 'Tamaño de bin:', binsize
  print, ''
  
  ; Calcular estadísticas comparativas
  mean_orig = mean(im0)
  mean_corr = mean(im_corrected_physical)
  std_orig = stddev(im0)
  std_corr = stddev(im_corrected_physical)
  
  print, 'ESTADÍSTICAS ORIGINAL:'
  print, '  Media:', mean_orig
  print, '  Desviación estándar:', std_orig
  print, ''
  
  print, 'ESTADÍSTICAS CORREGIDA:'
  print, '  Media:', mean_corr
  print, '  Desviación estándar:', std_corr
  print, ''
  
  ; Calcular diferencias porcentuales
  mean_diff_pct = ((mean_corr - mean_orig) / mean_orig) * 100
  std_diff_pct = ((std_corr - std_orig) / std_orig) * 100
  
  print, 'DIFERENCIAS PORCENTUALES:'
  print, '  Media:', mean_diff_pct, '%'
  print, '  Desviación estándar:', std_diff_pct, '%'
  print, ''
  
  ; Mostrar también las imágenes finales para referencia
  window, 6, xsize=1000, ysize=400
  !p.multi = [0, 2, 1]
  
  tv, im0, 0
  xyouts, 0.1, 0.95, 'Original (RAW)', /normal, color=255
  
  tv, im_corrected_physical, 1
  xyouts, 0.1, 0.95, 'Corregida (Unidades Físicas)', /normal, color=255
  
  !p.multi = 0

end
