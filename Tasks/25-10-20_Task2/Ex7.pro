FUNCTION planck_function, lambda, T
    ;------------------------------------------------------------
    ; Calcula el valor de la función de Planck Bλ(T)
    ; lambda : longitud de onda (m)
    ; T      : temperatura (K)
    ;------------------------------------------------------------
    h = !const.h
    c = !const.c
    k = !const.k

    ; Ecuación de Planck
    exponent = h * c / (lambda * k * T)
    B = (2.0 * h * c^2) / (lambda^5) / (EXP(exponent) - 1.0)
    RETURN, B   ; devuelve la irradiancia espectral (W·m⁻³·sr⁻¹)

PRO planck_test
    ; Vector de longitudes de onda: 40–8000 nm, paso 10 nm
    lambda_nm = FINDGEN(797) * 10.0 + 40.0
    lambda_m = lambda_nm * 1e-9   ; conversión a metros

    ; Temperaturas (en K)
    T = [4000.0, 5780.0, 8000.0]

    ; Calcular Bλ(T) para cada temperatura
    B4000 = planck_function(lambda_m, T[0])
    B5780 = planck_function(lambda_m, T[1])
    B8000 = planck_function(lambda_m, T[2])

    ; Graficar (escala logarítmica opcional)
    PLOT, lambda_nm, B4000, TITLE='Planck Curves', XTITLE='Wavelength (nm)', $
          YTITLE='Spectral Radiance Bλ (W·m⁻³·sr⁻¹)', /XSTYLE, /YSTYLE
    OPlot, lambda_nm, B5780, COLOR='red'
    OPlot, lambda_nm, B8000, COLOR='blue'

    LEGEND, ['4000 K', '5780 K', '8000 K'], /DATA

    ;--------------------------------------------------
    ; Integración numérica sencilla: Σ Bλ * Δλ
    ;--------------------------------------------------
    delta_lambda = 10e-9   ; 10 nm en metros
    PB_4000 = TOTAL(B4000) * delta_lambda
    PB_8000 = TOTAL(B8000) * delta_lambda

    PRINT, 'Integrated power (4000 K): ', PB_4000
    PRINT, 'Integrated power (8000 K): ', PB_8000
    PRINT, 'Ratio (8000K / 4000K): ', PB_8000 / PB_4000

    ;--------------------------------------------------
    ; Buscar el máximo de cada curva y su λ
    ;--------------------------------------------------
    Bmax_4000 = MAX(B4000, idx1)
    Bmax_5780 = MAX(B5780, idx2)
    Bmax_8000 = MAX(B8000, idx3)

    PRINT, 'Max B(4000K) = ', Bmax_4000, ' at λ = ', lambda_nm[idx1], ' nm'
    PRINT, 'Max B(5780K) = ', Bmax_5780, ' at λ = ', lambda_nm[idx2], ' nm'
    PRINT, 'Max B(8000K) = ', Bmax_8000, ' at λ = ', lambda_nm[idx3], ' nm'

END

