PRO Nevzorov_baseline

  ;procedure to compute 'k-factor' for the Nevzorov. Included in this procedure is a hardwire to the 
  ;data file, variable names, and start/end times for individual speed runs. A single flight typically
  ;has multiple levels for which the k-factor is computed independently, thus we also include # levels to include for the fiven flight
  
  
  ;Hardwire for a given flight
  ; first we ask the user to pick a file, then we check if the file is defined in the code. If it is we set the hardwired variables. If it is
  ; not then we inform the user that the file is not defined and we exit the program
  inf = DIALOG_PICKFILE(/READ, FILTER='*.nc', GET_PATH=path, PATH='/Volumes/kingair_data/')
    inf_nopath = STRMID(inf, STRLEN(path))


  CASE inf_nopath OF 
    '20160304.c1.nc' : BEGIN
           n_levels = 4
           n_spds = 5
           stt_time = [[171200, 171330, 171600, 171815, 172200], $
                       [173000, 173230, 173545, 174000, 174200], $
                       [175015, 175245, 175500, 175830, 180530], $
                       [181615, 181830, 182115, 183245, 184345]]
           stp_time = [[171307, 171435, 171710, 171920, 172304], $
                       [173100, 173420, 173650, 174100, 174318], $
                       [175130, 175400, 175600, 175940, 180750], $
                       [181720, 181930, 182215, 183440, 184445]]
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
    k_fact = (vlwccol * ilwccol)/(vlwcref*ilwcref)
  aias = LOADVAR('aias', file=inf)
  ps = LOADVAR('ps_hads_a', file=inf)
  trf = LOADVAR('trf', file=inf)

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
    
    fit = LINFIT(aias[inds],k_fact[inds])


    p1 = PLOT(aias[inds], k_fact[inds], 'o', /CURRENT, OVERPLOT=1)
    p2 = PLOT([0,200],[fit[0],200*fit[1]+fit[0]], /CURRENT, OVERPLOT=1)
    print, ps, fit[0], fit[1]
    
    
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