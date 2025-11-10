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


PRO planck_plot_log
    ;------------------------------------------------------------
    ; Visualización de la función de Planck para tres temperaturas
    ; con escala logarítmica y colores
    ;------------------------------------------------------------

    ; --- 1. Definir vector de longitud de onda ---
    lambda_nm = FINDGEN(797) * 10.0 + 40.0   ; 40–8000 nm
    lambda_m = lambda_nm * 1e-9               ; convertir a metros

    ; --- 2. Definir temperaturas ---
    T = [4000.0, 5780.0, 8000.0]

    ; --- 3. Calcular las curvas ---
    B4000 = planck_function(lambda_m, T[0])
    B5780 = planck_function(lambda_m, T[1])
    B8000 = planck_function(lambda_m, T[2])

    ; --- 4. Crear la figura principal ---
    !P.FONT = 1
    !P.CHARSIZE = 1.2
    !X.MARGIN = [6, 2]
    !Y.MARGIN = [4, 2]
    !P.THICK = 2

    PLOT, lambda_nm, B4000, TITLE='Planck Function B!l(T)', $
          XTITLE='Wavelength λ (nm)', $
          YTITLE='Spectral Radiance B!l(T) [W·m!u-3!n·sr!u-1!n]', $
          /XSTYLE, /YSTYLE, $
          XRANGE=[40,8000], YRANGE=[1e10, 1e14], $
          /YLOG, COLOR='orange'

    OPlot, lambda_nm, B5780, COLOR='goldenrod', THICK=2
    OPlot, lambda_nm, B8000, COLOR='steelblue', THICK=2

    LEGEND, ['4000 K (cool K-star)', '5780 K (Sun, G2V)', '8000 K (A-star)'], $
           /DATA, FONT=1, CHARSIZE=1.1, LOCATION=[0.6, 0.85]

    ; --- 5. Calcular máximos y λ correspondiente ---
    Bmax_4000 = MAX(B4000, idx1)
    Bmax_5780 = MAX(B5780, idx2)
    Bmax_8000 = MAX(B8000, idx3)

    PRINT, 'λmax (4000 K) = ', lambda_nm[idx1], ' nm'
    PRINT, 'λmax (5780 K) = ', lambda_nm[idx2], ' nm'
    PRINT, 'λmax (8000 K) = ', lambda_nm[idx3], ' nm'

    ; --- 6. Dibujar líneas verticales en los picos ---
    OPlot, [lambda_nm[idx1], lambda_nm[idx1]], [1e10, Bmax_4000], LINESTYLE=2, COLOR='orange'
    OPlot, [lambda_nm[idx2], lambda_nm[idx2]], [1e10, Bmax_5780], LINESTYLE=2, COLOR='goldenrod'
    OPlot, [lambda_nm[idx3], lambda_nm[idx3]], [1e10, Bmax_8000], LINESTYLE=2, COLOR='steelblue'

    ; --- 7. Integración sencilla (opcional, para imprimir resultados) ---
    delta_lambda = 10e-9   ; 10 nm en metros
    PB_4000 = TOTAL(B4000) * delta_lambda
    PB_8000 = TOTAL(B8000) * delta_lambda
    PRINT, 'Integrated Power Ratio (8000K / 4000K) = ', PB_8000 / PB_4000

END

