FUNCTION schwarzschild_radius, mass
    ; Calcula el radio de Schwarzschild para una masa dada (en kg)
    rs = 2.0 * !const.G * mass / (!const.c ^ 2)
    RETURN, rs
    
END

