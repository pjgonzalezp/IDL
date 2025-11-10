;=========================================================
; Exercise 10 - Beats of two sine waves
;---------------------------------------------------------
; This program calculates two sine waves with slightly
; different frequencies, plots them, sums them, and
; calculates the beat period.
; Export plots as EPS and PNG.
;=========================================================

PRO exercise10_beats
    COMPILE_OPT idl2
    ;------------------------
    ; a) Time axis
    ;------------------------
    dt = 0.1
    t = 0.0 + dt * FINDGEN(2000+1)  ; 0,0.1,...,200
    PRINT, 'Vector t creado con ', N_ELEMENTS(t), ' elementos.'

    ; Frequencies
    omega1 = 2.0
    omega2 = 2.1

    ; Sine functions
    y1 = SIN(omega1 * t)
    y2 = SIN(omega2 * t)

    ;------------------------
    ; b) Plot first 500 points
    ;------------------------
    n_plot = 500
    ; -- Plot y1 vs t
    PLOT, t[0:n_plot-1], y1[0:n_plot-1], $
          TITLE='Sine Waves: ω1 vs ω2', XTITLE='Time t', YTITLE='y(t)', COLOR='blue'
    OPlot, t[0:n_plot-1], y2[0:n_plot-1], COLOR='red'
    LEGEND, ['y1 (ω1=2.0)', 'y2 (ω2=2.1)'], /TOP, /RIGHT

    ; Export EPS
    DEVICE, SET_PLOT='PS', FILENAME='sine_waves.eps', /LANDSCAPE, /COLOR
    PLOT, t[0:n_plot-1], y1[0:n_plot-1], TITLE='Sine Waves: ω1 vs ω2', $
          XTITLE='Time t', YTITLE='y(t)', COLOR='blue'
    OPlot, t[0:n_plot-1], y2[0:n_plot-1], COLOR='red'
    LEGEND, ['y1 (ω1=2.0)', 'y2 (ω2=2.1)'], /TOP, /RIGHT
    DEVICE, /CLOSE_FILE
    PRINT, 'EPS exportado como sine_waves.eps'

    ; Export PNG
    DEVICE, SET_PLOT='PNG', FILENAME='sine_waves.png'
    PLOT, t[0:n_plot-1], y1[0:n_plot-1], TITLE='Sine Waves: ω1 vs ω2', $
          XTITLE='Time t', YTITLE='y(t)', COLOR='blue'
    OPlot, t[0:n_plot-1], y2[0:n_plot-1], COLOR='red'
    LEGEND, ['y1 (ω1=2.0)', 'y2 (ω2=2.1)'], /TOP, /RIGHT
    DEVICE, /CLOSE_FILE
    PRINT, 'PNG exportado como sine_waves.png'

    ;------------------------
    ; c) Sum of y1 and y2
    ;------------------------
    y_sum = y1 + y2
    PLOT, t[0:n_plot-1], y_sum[0:n_plot-1], $
          TITLE='Sum of y1 + y2', XTITLE='Time t', YTITLE='y1+y2', COLOR='green'

    ; Export EPS
    DEVICE, SET_PLOT='PS', FILENAME='sine_sum.eps', /LANDSCAPE, /COLOR
    PLOT, t[0:n_plot-1], y_sum[0:n_plot-1], TITLE='Sum of y1 + y2', $
          XTITLE='Time t', YTITLE='y1+y2', COLOR='green'
    DEVICE, /CLOSE_FILE
    PRINT, 'EPS exportado como sine_sum.eps'

    ; Export PNG
    DEVICE, SET_PLOT='PNG', FILENAME='sine_sum.png'
    PLOT, t[0:n_plot-1], y_sum[0:n_plot-1], TITLE='Sum of y1 + y2', $
          XTITLE='Time t', YTITLE='y1+y2', COLOR='green'
    DEVICE, /CLOSE_FILE
    PRINT, 'PNG exportado como sine_sum.png'

    ;------------------------
    ; d) Beat period
    ;------------------------
    omega_beat = ABS(omega1 - omega2)
    period_beat = 2 * !PI / omega_beat
    PRINT, 'Beat frequency: ', omega_beat
    PRINT, 'Corresponding beat period: ', period_beat
    PRINT, 'Observe visually the amplitude modulation in y1+y2 plot.'

END

