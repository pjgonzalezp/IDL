;===============================================================
; Programa: show_images.pro
; Propósito: Mostrar las tres imágenes (im0, ff0, dd0) contenidas
;             en el archivo q_data.sav en una sola ventana.
; Ejercicio 16(a) - Observaciones solares (VTT)
;===============================================================

pro show_images

  compile_opt idl2  
  ; Activa las reglas modernas del lenguaje IDL (desde la versión 6 en adelante).
  ; Esto ayuda a detectar errores comunes y a usar sintaxis más segura.

  ;-------------------------------------------------------------
  ; 1. Cargar los datos del archivo .sav
  ;-------------------------------------------------------------
  restore, 'q_data.sav'
  ; Restaura las variables guardadas en el archivo q_data.sav.
  ; Este archivo contiene: 
  ;   im0 → imagen original del Sol
  ;   ff0 → flat field (variación de sensibilidad del detector)
  ;   dd0 → dark current (ruido térmico del CCD)

  ;-------------------------------------------------------------
  ; 2. Obtener y mostrar las dimensiones de la imagen
  ;-------------------------------------------------------------
  dims = size(im0, /dimensions)
  print, 'Image size:', dims[0], 'x', dims[1]
  ; La función SIZE devuelve la forma del arreglo.
  ; Con el modificador /DIMENSIONS, solo devuelve las dimensiones (sin metadatos).
  ; dims[0] = número de columnas (pixeles en X)
  ; dims[1] = número de filas (pixeles en Y)
  ; Se imprime el tamaño en consola para verificar los datos cargados.

  ;-------------------------------------------------------------
  ; 3. Crear una ventana de visualización
  ;-------------------------------------------------------------
  window, 0, xsize=1200, ysize=400
  ; Abre una nueva ventana gráfica de 1200x400 píxeles.
  ; El primer parámetro (0) es el número de ventana (puede omitirse si usas /FREE).

  !p.multi = [0, 3, 1]
  ; Configura el modo de visualización múltiple.
  ; [0, 3, 1] → 0 filas automáticas, 3 columnas, empezando en el primer panel.
  ; Esto permite mostrar tres imágenes una al lado de la otra en la misma ventana.

  ;-------------------------------------------------------------
  ; 4. Mostrar la imagen original (im0)
  ;-------------------------------------------------------------
  tv, im0, 0
  ; Muestra la imagen im0 en el primer panel (índice 0).

  xyouts, 0.05, 0.95, 'Original (im0)', /normal, color=255
  ; Escribe un texto sobre la imagen en coordenadas normalizadas (0–1).
  ; /NORMAL → las coordenadas 0.0–1.0 se refieren a la fracción del panel.
  ; color=255 → texto blanco (útil si el fondo es oscuro).

  ;-------------------------------------------------------------
  ; 5. Mostrar el flat field (ff0)
  ;-------------------------------------------------------------
  tv, ff0, 1
  ; Muestra el flat field en el segundo panel (índice 1).

  xyouts, 0.05, 0.95, 'Flat field (ff0)', /normal, color=255
  ; Añade una etiqueta descriptiva en la parte superior de la imagen.

  ;-------------------------------------------------------------
  ; 6. Mostrar el dark current (dd0)
  ;-------------------------------------------------------------
  tv, dd0, 2
  ; Muestra el dark current en el tercer panel (índice 2).

  xyouts, 0.05, 0.95, 'Dark current (dd0)', /normal, color=255
  ; Añade una etiqueta a la imagen del dark current.

  ;-------------------------------------------------------------
  ; 7. Volver al modo gráfico normal
  ;-------------------------------------------------------------
  !p.multi = 0
  ; Restablece el modo de gráficos para volver a mostrar una sola figura a la vez.

end
;===============================================================

