PRO Nevzorov_baseline

  ;procedure to compute 'k-factor' for the Nevzorov. Included in this procedure is a hardwire to the 
  ;data file, variable names, and start/end times for individual speed runs. A single flight typically
  ;has multiple levels for which the k-factor is computed independently, thus we also include # levels to include for the fiven flight
  
  
  ;Hardwire for a given flight
  ; first we ask the user to pick a file, then we check if the file is defined in the code. If it is we set the hardwired variables. If it is
  ; not then we inform the user that the file is not defined and we exit the program
;  inf = DIALOG_PICKFILE(/READ, FILTER='*.nc', GET_PATH=path, PATH='/Volumes/kingair_data/')
;    inf_nopath = STRMID(inf, STRLEN(path))

  inf = DIALOG_PICKFILE(/READ, FILTER='*.nc', GET_PATH=path, PATH='/Volumes/sfaber1/research/nevzorov/data/030416/')
    inf_nopath = STRMID(inf, STRLEN(path))


  CASE inf_nopath OF 
    '20160304.c1.nc' : BEGIN
           n_levels = 4
           n_spds = 5
           stt_time = [[171140, 171320, 171530, 171745, 172200], $
                       [172910, 173211, 173540, 174010, 174010], $
                       [175000, 175240, 175440, 175800, 180250], $
                       [181555, 181810, 182105, 183740, 183740]]
           stp_time = [[171230, 171425, 171700, 171900, 172304], $
                       [173050, 173420, 173655, 174055, 174011], $
                       [175138, 175407, 175605, 175940, 180500], $
                       [181720, 181950, 182227, 183920, 183741]]
           stt_time = TRANSPOSE(stt_time) & stp_time = TRANSPOSE(stp_time)
         END
  ELSE : BEGIN
           PRINT,'No such filename defined in procedure Nevzorov_baseline: '+inf_nopath
           RETURN
         END
  ENDCASE
  ; END OF HARDWIRED INFORMATION for individual flights
   
  ;get the data....
  hhmmss = LOADVAR('TIME', file=inf)
    hhmmss = LONG(hhmmss+0.3)  ;ensure hhmmss is an integer value
  vlwccol = LOADVAR('vlwccol', file=inf)
  vlwcref = LOADVAR('vlwcref', file=inf)
  ilwccol = LOADVAR('ilwccol', file=inf)
  ilwcref = LOADVAR('ilwcref', file=inf)
  vtwccol = LOADVAR('vtwccol', file=inf)
  vtwcref = LOADVAR('vtwcref', file=inf)
  itwccol = LOADVAR('itwccol', file=inf)
  itwcref = LOADVAR('itwcref', file=inf)
    ;k_fact = (vlwccol * ilwccol)/(vlwcref*ilwcref)
    k_fact = (vtwccol * itwccol)/(vtwcref*itwcref)
  aias = LOADVAR('aias', file=inf)
  ps = LOADVAR('ps_hads_a', file=inf)
  trf = LOADVAR('trf', file=inf)
  
  aias=aias*.514444

  ; the next two lines provide the start index and the stop index for each of the segments.
  ; They will be an array of n_levels by n_spds  
  stt = stt_time & FOR i=0,N_ELEMENTS(stt)-1 DO stt[i] = WHERE(hhmmss EQ stt_time[i])
  stp = stt_time & FOR i=0,N_ELEMENTS(stp)-1 DO stp[i] = WHERE(hhmmss EQ stp_time[i])
  
  ; then we find the length of each indivdual segment
  lens = stp - stt + 1
  ;Lets go through our measurements for each level -- 
  p1 = PLOT([0],[0],/nodata)
  p1.xrange=[120,200] & p1.yrange=[1.6,1.8]
  FOR i = 0, n_levels-1 DO BEGIN
    ;we go through a quick loop to build all the indices for this level
    FOR j = 0, n_spds-1 DO BEGIN
      IF (j EQ 0) THEN inds = stt[i,j]+LINDGEN(lens[i,j]) ELSE inds = [inds, stt[i,j]+LINDGEN(lens[i,j])]
    ENDFOR
    
    ;fit = LINFIT(aias[inds],k_fact[inds])
    fita=poly_fit(aias[inds],k_fact[inds],2)
    fitb=comfit(aias[inds],k_fact[inds],[fita[1],.3,fita[0]],/geometric,itmax=20000)

    unitv=dindgen(2000,start=0,increment=.1)
    
    line=(fitb[0])*unitv^(fitb[1])+fitb[2]

    p1 = PLOT(aias[inds], k_fact[inds], 'o', /CURRENT, OVERPLOT=1)
    ;p2 = PLOT([0,200],[fit[0],200*fit[1]+fit[0]], /CURRENT, OVERPLOT=1)
    p2 = PLOT(unitv,line, /CURRENT, OVERPLOT=1,dimensions=[1200,1000])
    print, fitb[0], fitb[1], fitb[2]
    p2.xrange=[60,104]
    ;p2.yrange=[1.6,1.8]
    p1.yrange=[0,.6]
    
    CASE i of 
       0 : BEGIN
             p1.color='red'
             p2.color='red'
           END
       1 : BEGIN
             p1.color='blue'
             p2.color='blue'
           END
       2 : BEGIN
             p1.color='green'
             p2.color='green'
           END
       3 : BEGIN
             p1.color='magenta'
             p2.color='magenta'
           END
    ENDCASE


  ENDFOR
STOP

;  ;the following calculate the 'wet' power given fit parameters fit[0] and fit[1]
;  Pw = (vlwccol*ilwccol) - (aias*fit[1] + fit[0])*(vlwcref*ilwcref)
;  ;the following calculates the LWC given the wet power, tas, sensing area, and L*
;  tas = LOADVAR('tas', file=inf)
;  nevlwc = pw/(tas*0.328d-4*2589)
;  lwc100 = LOADVAR('lwc100', file=inf)

END