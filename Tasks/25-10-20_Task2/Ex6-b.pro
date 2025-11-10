PRO schwarzschild_radius_proc, mass
    rs = 2.0 * !const.G * mass / (!const.c ^ 2)
    PRINT, 'Mass (kg): ', mass
    PRINT, 'Schwarzschild radius (m): ', rs

    
; masa del Sol (kg) sun_mass = 2.0e30      
; masa de la Tierra (kg) earth_mass = 5.97e24    

schwarzschild_radius_proc, 2.0e30      ; Sol
schwarzschild_radius_proc, 5.97e24     ; Tierra


END

