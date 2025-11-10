;+ 
; Nombre: Ex16-f.pro
; Descripción: Ejercicio 16f - Calcular campo de visión
;-

pro Ex16_f

  ; Cargar datos
  restore, 'q_data.sav'
  
  ; =============================================
  ; PASO 1: OBTENER DIMENSIONES DE LA IMAGEN - CORREGIDO
  ; =============================================
  
  ; FORMA CORRECTA de obtener dimensiones
  dims = size(im0)
  ; dims[0] = número de dimensiones
  ; dims[1] = tamaño en X
  ; dims[2] = tamaño en Y
  
  nx = dims[1]  ; Número de píxeles en X
  ny = dims[2]  ; Número de píxeles en Y
  
  print, '=== DIMENSIONES DE LA IMAGEN ==='
  print, 'Estructura del array dims:', dims
  print, 'Número de píxeles (nx x ny):', nx, 'x', ny
  print, ''
  
  ; =============================================
  ; PASO 2: CALCULAR CAMPO DE VISIÓN EN ARCSECONDS
  ; =============================================
  
  ; Escala de píxel dada en el problema: 0.1 arcsec/pixel
  pixel_scale = 0.1  ; arcsec/pixel
  
  ; Campo de visión en arcsegundos
  fov_arcsec_x = nx * pixel_scale
  fov_arcsec_y = ny * pixel_scale
  fov_arcsec_diag = sqrt(fov_arcsec_x^2 + fov_arcsec_y^2)
  
  print, '=== CAMPO DE VISIÓN EN ARCSECONDS ==='
  print, 'Escala de píxel:', pixel_scale, 'arcsec/pixel'
  print, 'FOV en X:', fov_arcsec_x, 'arcsec'
  print, 'FOV en Y:', fov_arcsec_y, 'arcsec' 
  print, 'FOV diagonal:', fov_arcsec_diag, 'arcsec'
  print, ''
  
  ; =============================================
  ; PASO 3: CONVERTIR A KILÓMETROS EN EL SOL
  ; =============================================
  
  ; Factor de conversión dado: 1 arcsec ≈ 736 km en el Sol (19-Jun-2004)
  arcsec_to_km = 736.0  ; km/arcsec
  
  ; Campo de visión en kilómetros
  fov_km_x = fov_arcsec_x * arcsec_to_km
  fov_km_y = fov_arcsec_y * arcsec_to_km
  fov_km_diag = fov_arcsec_diag * arcsec_to_km
  
  print, '=== CAMPO DE VISIÓN EN KILÓMETROS ==='
  print, 'Factor de conversión:', arcsec_to_km, 'km/arcsec'
  print, 'FOV en X:', fov_km_x, 'km'
  print, 'FOV en Y:', fov_km_y, 'km'
  print, 'FOV diagonal:', fov_km_diag, 'km'
  print, ''
  
  ; =============================================
  ; PASO 4: CONVERTIR A RADIOS SOLARES
  ; =============================================
  
  ; Radio solar estándar
  solar_radius_km = 696000.0  ; km
  
  ; Campo de visión en unidades de radio solar
  fov_rs_x = fov_km_x / solar_radius_km
  fov_rs_y = fov_km_y / solar_radius_km
  fov_rs_diag = fov_km_diag / solar_radius_km
  
  ; También en porcentaje del diámetro solar
  fov_percent_x = (fov_km_x / (2 * solar_radius_km)) * 100
  fov_percent_y = (fov_km_y / (2 * solar_radius_km)) * 100
  
  print, '=== CAMPO DE VISIÓN EN UNIDADES SOLARES ==='
  print, 'Radio solar:', solar_radius_km, 'km'
  print, 'FOV en X:', fov_rs_x, 'radios solares'
  print, 'FOV en Y:', fov_rs_y, 'radios solares'
  print, 'FOV diagonal:', fov_rs_diag, 'radios solares'
  print, 'FOV en X:', fov_percent_x, '% del diámetro solar'
  print, 'FOV en Y:', fov_percent_y, '% del diámetro solar'
  print, ''
  
  ; =============================================
  ; PASO 5: VISUALIZACIÓN COMPARATIVA
  ; =============================================
  
  print, '=== COMPARACIONES PARA CONTEXTUALIZAR ==='
  print, 'El campo de visión observa una pequeña región de la fotosfera solar'
  print, 'Equivalente a aproximadamente', fov_percent_x, '% del diámetro solar'
  print, 'Esto permite estudiar estructuras finas como la granulación'
  print, 'y posibles manchas solares en alta resolución'

end
