;+ 
; Nombre: Ex16-g.pro
; Descripción: Ejercicio 16g - Resolución de difracción y relación con escala de píxel
;-

pro Ex16_g

  ; =============================================
  ; PASO 1: PARÁMETROS DEL TELESCOPIO Y OBSERVACIONES
  ; =============================================
  
  ; Parámetros del telescopio VTT (Vacuum Tower Telescope)
  diameter = 0.7  ; Diámetro en metros
  
  ; Longitud de onda para observaciones en continuo rojo
  ; Típicamente alrededor de 650 nm para el rojo
  wavelength = 650e-9  ; metros (650 nm)
  
  ; Escala de píxel del CCD (dada en el problema)
  pixel_scale = 0.1  ; arcsec/pixel
  
  print, '=== PARÁMETROS DEL SISTEMA ==='
  print, 'Telescopio: VTT (Vacuum Tower Telescope)'
  print, 'Diámetro del telescopio:', diameter, 'm'
  print, 'Longitud de onda asumida:', wavelength * 1e9, 'nm (rojo)'
  print, 'Escala de píxel del CCD:', pixel_scale, 'arcsec/pixel'
  print, ''
  
  ; =============================================
  ; PASO 2: CALCULAR RESOLUCIÓN DE DIFRACCIÓN
  ; =============================================
  
  ; Criterio de Rayleigh: θ = 1.22 * λ / D (en radianes)
  diff_limit_rad = 1.22 * wavelength / diameter
  
  ; Convertir radianes a arcsegundos (1 radián = 206265 arcsec)
  diff_limit_arcsec = diff_limit_rad * 206265
  
  ; También calcular resolución de Dawes (aproximación alternativa)
  dawes_limit_arcsec = 116.0 / diameter  ; Para diámetro en mm, resultado en arcsec
  dawes_limit_arcsec = 116.0 / (diameter * 1000)  ; Convertir m a mm
  
  print, '=== RESOLUCIÓN DE DIFRACCIÓN ==='
  print, 'Límite de Rayleigh (radianes):', diff_limit_rad, 'rad'
  print, 'Límite de Rayleigh (arcsegundos):', diff_limit_arcsec, 'arcsec'
  print, 'Límite de Dawes (aproximado):', dawes_limit_arcsec, 'arcsec'
  print, ''
  
  ; =============================================
  ; PASO 3: RELACIÓN CON LA ESCALA DE PÍXEL
  ; =============================================
  
  ; Calcular relación de muestreo (pixel scale / resolución)
  sampling_ratio = pixel_scale / diff_limit_arcsec
  
  ; Número de píxeles por elemento resuelto
  pixels_per_resel = sampling_ratio^2
  
  print, '=== RELACIÓN ESCALA-PÍXEL/RESOLUCIÓN ==='
  print, 'Resolución de difracción:', diff_limit_arcsec, 'arcsec'
  print, 'Escala de píxel:', pixel_scale, 'arcsec/pixel'
  print, 'Relación (pixel/resolución):', sampling_ratio
  print, 'Píxeles por elemento resuelto:', pixels_per_resel
  print, ''
  
  ; =============================================
  ; PASO 4: INTERPRETACIÓN DEL MUESTREO
  ; =============================================
  
  print, '=== INTERPRETACIÓN DEL MUESTREO ==='
  
  if sampling_ratio lt 0.5 then begin
    print, 'CRÍTICO: SUB-muestreo severo (ratio < 0.5)'
    print, 'La escala de píxel es muy GROSERA'
    print, 'No se puede resolver el límite de difracción del telescopio'
    print, 'Se pierde información espacial'
  endif
  
  if sampling_ratio ge 0.5 and sampling_ratio lt 1.0 then begin
    print, 'SUB-muestreo moderado (0.5 ≤ ratio < 1.0)'
    print, 'La escala de píxel es ligeramente gruesa'
    print, 'Resolución limitada por el píxel, no por la óptica'
  endif
  
  if sampling_ratio ge 1.0 and sampling_ratio le 2.0 then begin
    print, 'MUESTREO ADECUADO (1.0 ≤ ratio ≤ 2.0)'
    print, 'La escala de píxel coincide bien con la resolución óptica'
    print, 'Se muestrea adecuadamente el límite de difracción'
    print, 'Este es el rango ideal para observaciones críticas'
  endif
  
  if sampling_ratio gt 2.0 then begin
    print, 'SOBRE-muestreo (ratio > 2.0)'
    print, 'La escala de píxel es muy FINA'
    print, 'Buena para observaciones, pero puede haber ruido adicional'
    print, 'Ventaja: permite algún procesamiento posterior (deconvolution)'
  endif
  
  print, ''
  
  ; =============================================
  ; PASO 5: IMPLICACIONES PARA LAS OBSERVACIONES
  ; =============================================
  
  print, '=== IMPLICACIONES PARA LAS OBSERVACIONES SOLARES ==='
  print, 'Con esta configuración:'
  print, '- Se pueden resolver estructuras de ~', diff_limit_arcsec, 'arcsec'
  print, '- Esto corresponde a ~', diff_limit_arcsec * 736, 'km en el Sol'
  print, '- Adecuado para estudiar granulación (~1000-2000 km)'
  print, '- Posible resolución de estructuras finas en manchas solares'
  print, '- La escala de píxel permite un buen muestreo de las características solares'

end
