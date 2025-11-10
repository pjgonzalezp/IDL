;+ 
; Nombre: Ex16-b.pro
; Descripción: Ejercicio 16b - Histograma y rango dinámico
;-

pro Ex16_b

  ; Cargar datos si no están cargados
  if ~size(im0, /dimensions)[0] then restore, 'q_data.sav'
  
  ; Histograma de la imagen original
  window, 1
  hist = histogram(im0, binsize=50)  ; Ajustar binsize según necesidad
  plot, histogram(im0, binsize=50), title='Histograma im0', $
        xTitle='Valor del pixel', yTitle='Frecuencia'

  ; Encontrar el valor máximo para determinar el rango dinámico
  max_val = max(im0)
  print, 'Valor máximo en im0:', max_val

  ; Determinar rango dinámico
  if max_val le 255 then dynamic_range = '8-bit'
  if max_val gt 255 and max_val le 1023 then dynamic_range = '10-bit'  
  if max_val gt 1023 and max_val le 4095 then dynamic_range = '12-bit'
  if max_val gt 4095 then dynamic_range = '14-bit'

  print, 'Rango dinámico estimado:', dynamic_range

end

