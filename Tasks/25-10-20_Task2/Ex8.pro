PRO exercise8_compare
    seed = 12345L  ; semilla para reproducibilidad

    ; --- Primera prueba con n = 300000 ---
    n = 300000
    a = RANDOMU(seed, n) * 10 - 5
    b = RANDOMU(seed, n) * 10 - 5

    t0 = SYSTIME(/SECONDS)
    FOR i = 0, n-1 DO BEGIN
        IF b[i] LT 0 THEN a[i] = a[i] + b[i]
    ENDFOR
    t1 = SYSTIME(/SECONDS)
    PRINT, 'Tiempo FOR+IF: ', t1 - t0, ' segundos'

    ; WHERE
    a = RANDOMU(seed, n) * 10 - 5
    b = RANDOMU(seed, n) * 10 - 5
    t0 = SYSTIME(/SECONDS)
    idx = WHERE(b LT 0, count)
    IF count GT 0 THEN a[idx] = a[idx] + b[idx]
    t1 = SYSTIME(/SECONDS)
    PRINT, 'Tiempo WHERE: ', t1 - t0, ' segundos'

    ; Operador <
    a = RANDOMU(seed, n) * 10 - 5
    b = RANDOMU(seed, n) * 10 - 5
    t0 = SYSTIME(/SECONDS)
    a = a + (b < 0)
    t1 = SYSTIME(/SECONDS)
    PRINT, 'Tiempo con operador < : ', t1 - t0, ' segundos'

    ; --- Comparación para distintos tamaños ---
    sizes = [1e4, 1e5, 3e5, 1e6]

    FOR j = 0, N_ELEMENTS(sizes)-1 DO BEGIN
        n = LONG(sizes[j])
        a = RANDOMU(seed, n) * 10 - 5
        b = RANDOMU(seed, n) * 10 - 5
        PRINT, '--- n = ', n, ' ---'

        ; FOR + IF
        t0 = SYSTIME(/SECONDS)
        FOR i = 0, n-1 DO BEGIN
            IF b[i] LT 0 THEN a[i] = a[i] + b[i]
        ENDFOR
        PRINT, 'FOR+IF: ', SYSTIME(/SECONDS) - t0

        ; WHERE
        a = RANDOMU(seed, n) * 10 - 5
        b = RANDOMU(seed, n) * 10 - 5
        t0 = SYSTIME(/SECONDS)
        idx = WHERE(b LT 0, count)
        IF count GT 0 THEN a[idx] = a[idx] + b[idx]
        PRINT, 'WHERE:  ', SYSTIME(/SECONDS) - t0

        ; Operador <
        a = RANDOMU(seed, n) * 10 - 5
        b = RANDOMU(seed, n) * 10 - 5
        t0 = SYSTIME(/SECONDS)
        a = a + (b < 0)
        PRINT, 'MIN (<): ', SYSTIME(/SECONDS) - t0
    ENDFOR
END

