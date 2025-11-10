PRO compare_speed_methods
    ;----------------------------
    ; Comparación de eficiencia de tres métodos
    ; para sumar los elementos negativos de b a a
    ;----------------------------

    COMPILE_OPT idl2
    RANDOM_SEED, seed

    sizes = [1e4, 5e4, 1e5, 3e5, 5e5, 1e6]   ; distintos tamaños
    n_sizes = N_ELEMENTS(sizes)

    t_for   = FLTARR(n_sizes)
    t_where = FLTARR(n_sizes)
    t_min   = FLTARR(n_sizes)

    FOR j = 0, n_sizes-1 DO BEGIN
        n = LONG(sizes[j])
        PRINT, '=== n = ', n, ' ==='

        ;--------------------------------------
        ; i) FOR + IF
        ;--------------------------------------
        a = RANDOMU(seed, n) * 10 - 5
        b = RANDOMU(seed, n) * 10 - 5

        t0 = systime(/seconds)
        FOR i = 0, n-1 DO BEGIN
            IF b[i] LT 0 THEN a[i] = a[i] + b[i]
        ENDFOR
        t_for[j] = systime(/seconds) - t0

        ;--------------------------------------
        ; ii) WHERE
        ;--------------------------------------
        a = RANDOMU(seed, n) * 10 - 5
        b = RANDOMU(seed, n) * 10 - 5

        t0 = systime(/seconds)
        idx = WHERE(b LT 0, count)
        IF count GT 0 THEN a[idx] = a[idx] + b[idx]
        t_where[j] = systime(/seconds) - t0

        ;--------------------------------------
        ; iii) Operador mínimo <
        ;--------------------------------------
        a = RANDOMU(seed, n) * 10 - 5
        b = RANDOMU(seed, n) * 10 - 5

        t0 = systime(/seconds)
        a = a + (b < 0)
        t_min[j] = systime(/seconds) - t0
    ENDFOR

    ;--------------------------------------
    ; Graficar resultados
    ;--------------------------------------
    PLOT, sizes, t_for, PSYM=4, COLOR='red', TITLE='Comparison of Methods', $
          XTITLE='Vector size (n)', YTITLE='Time [s]', $
          CHARSIZE=1.3, /XLOG, /YLOG
    OPlot, sizes, t_where, PSYM=6, COLOR='blue'
    OPlot, sizes, t_min, PSYM=2, COLOR='green'
    LEGEND, ['FOR+IF', 'WHERE', 'MIN (<)'], /TOP, /RIGHT

    ; Guardar gráfico
    DEVICE, DECOMPOSED=0
    SET_PLOT, 'PNG'
    PLOT, sizes, t_for, PSYM=4, COLOR='red', TITLE='Comparison of Methods', $
          XTITLE='Vector size (n)', YTITLE='Time [s]', $
          CHARSIZE=1.3, /XLOG, /YLOG
    OPlot, sizes, t_where, PSYM=6, COLOR='blue'
    OPlot, sizes, t_min, PSYM=2, COLOR='green'
    LEGEND, ['FOR+IF', 'WHERE', 'MIN (<)'], /TOP, /RIGHT
    DEVICE, /CLOSE
    SET_PLOT, 'X'

    PRINT, 'Gráfico guardado como comparison_methods.png'
END

