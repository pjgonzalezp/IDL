;+ 
; Nombre: Ex17-completo.pro
; Descripción: Ejercicio 17 - Análisis de imágenes MDI SOHO (campo magnético y continuo)
;-

pro Ex17_completo

  ; =============================================
  ; PASO 0: CARGAR LOS DATOS
  ; =============================================
  
  ; Cargar imagen de campo magnético
  openr, lun, 'mdi_mf.dat', /get_lun
  mf_image = intarr(355, 254)
  readu, lun, mf_image
  free_lun, lun
  
  ; Cargar imagen de continuo
  openr, lun, 'mdi_cont.dat', /get_lun
  cont_image = intarr(355, 254)
  readu, lun, cont_image
  free_lun, lun
  
  print, '=== DATOS CARGADOS ==='
  print, 'Dimensión mf_image:', size(mf_image, /dimensions)
  print, 'Dimensión cont_image:', size(cont_image, /dimensions)
  print, 'Rango MF [Gauss]:', min(mf_image), 'a', max(mf_image)
  print, 'Rango Continuo:', min(cont_image), 'a', max(cont_image)
  print, ''
  
  ; Crear coordenadas en arcsegundos
  x_arcsec = findgen(355) * 2.0
  y_arcsec = findgen(254) * 2.0
  
  ; =============================================
  ; (a) DISPLAY CAMPO MAGNÉTICO CON TV
  ; =============================================
  
  window, 0, xsize=600, ysize=500
  loadct, 0  ; Tabla de colores gris
  tv, mf_image
  xyouts, 0.1, 0.95, '(a) Mapa de Campo Magnético MDI', /normal, color=255
  xyouts, 0.1, 0.90, 'Rango: ' + string(min(mf_image)) + ' a ' + string(max(mf_image)) + ' Gauss', /normal, color=255
  
  ; =============================================
  ; (b) EJES EN ARCSECONDS (2"/pixel)
  ; =============================================
  
  window, 1, xsize=600, ysize=500
  
  ; Mostrar imagen
  tv, mf_image
  
  ; Configurar ejes en arcsegundos
  !p.position = [0.15, 0.15, 0.85, 0.85]
  plot, [0, 710], [0, 508], /nodata, $  ; 355*2=710, 254*2=508
        xstyle=1, ystyle=1, $
        xTitle='Arcsegundos', yTitle='Arcsegundos', $
        title='(b) Campo Magnético - Escala Arcseconds'
  
  ; =============================================
  ; (c) IMÁGENES LADO A LADO
  ; =============================================
  
  window, 2, xsize=1000, ysize=500
  !p.multi = [0, 2, 1]
  
  ; Panel izquierdo: Continuo
  tv, cont_image
  xyouts, 0.1, 0.95, '(c) Imagen Continuo', /normal, color=255
  
  ; Panel derecho: Campo magnético
  tv, mf_image
  xyouts, 0.1, 0.95, '(c) Campo Magnético', /normal, color=255
  
  !p.multi = 0
  
  ; =============================================
  ; (d) CAMPO MAGNÉTICO CON BARRA DE COLORES
  ; =============================================
  
  window, 3, xsize=700, ysize=500
  loadct, 33  ; Rainbow color table
  
  ; Mostrar imagen en color
  tv, mf_image
  xyouts, 0.1, 0.95, '(d) Campo Magnético - Escala de Colores', /normal, color=255
  
  ; Información sobre la escala de colores
  xyouts, 0.1, 0.05, 'Azul: ' + string(min(mf_image)) + ' Gauss', /normal, color=180
  xyouts, 0.1, 0.02, 'Rojo: ' + string(max(mf_image)) + ' Gauss', /normal, color=255
  
  ; =============================================
  ; (e) CONTOURS DEL CAMPO MAGNÉTICO
  ; =============================================
  
  window, 4, xsize=600, ysize=500
  
  ; Definir niveles de contorno
  mf_min = min(mf_image)
  mf_max = max(mf_image)
  n_levels = 8
  levels = mf_min + (findgen(n_levels)/(n_levels-1)) * (mf_max - mf_min)
  
  ; Contornos básicos
  contour, mf_image, x_arcsec, y_arcsec, $
          levels=levels, $
          title='(e) Contornos Campo Magnético', $
          xTitle='Arcsegundos', yTitle='Arcsegundos'
  
  ; =============================================
  ; (f) CONTINUO + CONTOURS DEL CONTINUO
  ; =============================================
  
  window, 5, xsize=600, ysize=500
  
  ; Mostrar imagen de continuo primero
  tv, cont_image
  
  ; Luego superponer contornos del continuo
  cont_min = min(cont_image)
  cont_max = max(cont_image)
  cont_levels = cont_min + (findgen(6)/(6-1)) * (cont_max - cont_min)
  
  contour, cont_image, x_arcsec, y_arcsec, $
          levels=cont_levels, $
          /overplot, color=255, thick=2
  
  xyouts, 0.1, 0.95, '(f) Continuo + Contornos Continuo', /normal, color=255
  
  ; =============================================
  ; (g) CONTINUO + CONTOURS CAMPO MAGNÉTICO (ZOOM)
  ; =============================================
  
  window, 6, xsize=600, ysize=500
  
  ; Definir región de zoom (centro de la imagen)
  x_center = 355 * 2.0 / 2.0  ; Centro en arcsegundos
  y_center = 254 * 2.0 / 2.0
  zoom_width = 300  ; Ancho del zoom en arcsegundos
  
  xrange_zoom = [x_center - zoom_width/2, x_center + zoom_width/2]
  yrange_zoom = [y_center - zoom_width/2, y_center + zoom_width/2]
  
  ; Mostrar imagen de continuo
  tv, cont_image
  
  ; Superponer contornos de campo magnético
  contour, mf_image, x_arcsec, y_arcsec, $
          levels=levels, $
          /overplot, color=255, thick=2
  
  ; Configurar el zoom
  !x.range = xrange_zoom
  !y.range = yrange_zoom
  
  xyouts, 0.1, 0.95, '(g) Continuo + Contornos MF (Zoom)', /normal, color=255
  
  ; =============================================
  ; (h) CONTOURS POR POLARIDAD - CORREGIDO
  ; =============================================
  
  window, 7, xsize=600, ysize=500
  
  ; Umbrales para diferentes regiones
  strong_threshold = 800  ; Gauss para campos fuertes
  medium_threshold = 400  ; Gauss para campos medios
  
  ; Imagen de continuo como fondo
  tv, cont_image
  
  ; Contornos para polaridad positiva (blanco)
  positive_levels = [medium_threshold, strong_threshold]
  contour, mf_image, x_arcsec, y_arcsec, $
          levels=positive_levels, $
          /overplot, color=255, thick=2  ; Blanco
  
  ; Contornos para polaridad negativa (rojo) - CORREGIDO: sin LABELS
  negative_levels = [-strong_threshold, -medium_threshold]
  contour, mf_image, x_arcsec, y_arcsec, $
          levels=negative_levels, $
          /overplot, color=200, thick=2  ; Rojo
  
  !x.range = xrange_zoom
  !y.range = yrange_zoom
  xyouts, 0.1, 0.95, '(h) Polaridades Magnéticas', /normal, color=255
  xyouts, 0.1, 0.90, 'Blanco: Positiva, Rojo: Negativa', /normal, color=255
  
  ; =============================================
  ; (i) AÑADIR TÍTULO CON TEXT
  ; =============================================
  
  window, 8, xsize=600, ysize=500
  
  ; Display final
  tv, cont_image
  
  ; Contornos simétricos para ambas polaridades
  contour, mf_image, x_arcsec, y_arcsec, $
          levels=[-800, -400, 400, 800], $
          /overplot, color=255, thick=2
  
  !x.range = xrange_zoom
  !y.range = yrange_zoom
  
  ; Añadir título personalizado
  text_x = xrange_zoom[0] + 50
  text_y = yrange_zoom[1] - 30
  
  xyouts, text_x, text_y, $
          '(i) MDI/SOHO - Análisis de Manchas Solares', $
          /normal, color=255, /bold
  
  ; Información adicional
  text_y2 = text_y - 40
  xyouts, text_x, text_y2, $
          'Contornos: Campo Magnético ±400, ±800 Gauss', $
          /normal, color=255
  
  ; =============================================
  ; RESUMEN FINAL
  ; =============================================
  
  print, ''
  print, '=== EJERCICIO 17 COMPLETADO ==='
  print, 'Se han generado 9 ventanas con todos los incisos:'
  print, ' (a) Campo magnético básico'
  print, ' (b) Escala en arcsegundos' 
  print, ' (c) Comparación lado a lado'
  print, ' (d) Representación en color'
  print, ' (e) Contornos campo magnético'
  print, ' (f) Continuo + contornos continuo'
  print, ' (g) Zoom a regiones activas'
  print, ' (h) Polaridades magnéticas'
  print, ' (i) Título personalizado'
  print, ''
  print, 'Rango campo magnético detectado:', mf_min, 'a', mf_max, 'Gauss'

end
