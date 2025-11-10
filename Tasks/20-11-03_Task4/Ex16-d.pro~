;===============================================================
; Programa: Ex16_c.pro
; Propósito: 
;   Hacer un histograma del dark current (dd0), comparar con im0 
;   y calcular su magnitud relativa en porcentaje.
; Ejercicio 16(c)
;===============================================================

pro Ex16_c

  compile_opt idl2
  ; Activa reglas modernas de IDL

  ;-------------------------------------------------------------
  ; 1. Cargar el archivo con las imágenes
  ;-------------------------------------------------------------
  restore, 'q_data.sav'
  ; Variables restauradas: im0 (imagen original), ff0 (flat), dd0 (dark)

  ;-------------------------------------------------------------
  ; 2. Calcular rango de valores de dd0
  ;-------------------------------------------------------------
  min_dd = min(dd0)
  max_dd = max(dd0)
  print, 'Rango de valores en dd0 (dark current):', min_dd, 'a', max_dd

  ;-------------------------------------------------------------
  ; 3. Calcular rango de valores de im0 (para comparación)
  ;-------------------------------------------------------------
  min_im = min(im0)
  max_im = max(im0)
  print, 'Rango de valores en im0 (original):', min_im, 'a', max_im

  ;-------------------------------------------------------------
  ; 4. Comparar el dark current con la imagen original (%)
  ;-------------------------------------------------------------
  percent = 100.0 * max_dd / max_im
  print, 'El dark current representa aproximadamente ', percent, '% del valor máximo de im0'

  ;-------------------------------------------------------------
  ; 5. Definir binsize válido para HISTOGRAM
  ;-------------------------------------------------------------
  binsize = 1.0
  ; Usamos binsize = 1 porque los valores de dd0 son enteros pequeños (11 a 31)
  ; Evita el error "Illegal binsize" de IDL

  ;-------------------------------------------------------------
  ; 6. Calcular histograma del dark current
  ;-------------------------------------------------------------
  h_dd = histogram(dd0, binsize=binsize, min=min_dd, max=max_dd)

  ;-------------------------------------------------------------
  ; 7. Crear eje de intensidades para el histograma
  ;-------------------------------------------------------------
  bin_centers = findgen(n_elements(h_dd)) * binsize + min_dd
  ; Vector de valores centrales de cada bin, para graficar en X

  ;-------------------------------------------------------------
  ; 8. Mostrar histograma
  ;-------------------------------------------------------------
  window, 1, xsize=800, ysize=500
  plot, bin_centers, h_dd, $
        title='Histogram of Dark Current (dd0)', $
        xtitle='Intensity Value', ytitle='Number of Pixels', $
        thick=2, color=!p.color

  ;-------------------------------------------------------------
  ; 9. Interpretación
  ;-------------------------------------------------------------
  print, 'El histograma muestra la distribución del ruido térmico del CCD.'
  print, 'Comparando con im0, podemos ver que el dark current es relativamente pequeño (~1%).'
  
end
;===============================================================



