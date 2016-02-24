pro error0807investigation

  days=['0710','0725','0727','0728','0729','0807','0814','0815','0803']
  colors=['red','blue']

    ;flightDay, airspeedType, level
    nevBase, '0807','indicated','400'

    common g, g
    pmb=g.pmb
    lwc=g.lwc
    time=g.time
    timeForm=g.timeForm
    as=g.as
    clearAir=g.clearAir
    levelClearAir=g.levelClearAir
    avroll=g.avroll
    avpitch=g.avpitch
    pLiq=g.pLiq
    lwc=g.lwc
    lwcnev1=g.lwcnev1
    lwcAsCorrDiff=g.lwcAsCorrDiff
    lwcPresCorDiff=g.lwcPresCorDiff
    lwcPresCor=g.lwcPresCor
    linPresCor=g.linPresCor
    flightString=g.flightString
    kLiq=g.kLiq
    clearAirLargeErr=g.clearAirLargeErr
    clearAirLargeErrex=g.clearAirLargeErrex
    levelClearAirLargeErrex=g.levelClearAirLargeErrex
    hivs=g.hivs
    baselineClimbTimes=g.baselineClimbTimes
    baselineClimbTimesNon=g.baselineClimbTimesNon
    lowhivs=g.lowhivs


    baselineClimbI=dindgen(n_elements(pmb[clearAir]),start=0,increment=0)
    
    climbTimes=where((timeForm gt 132658) and (timeForm lt 135740))
    
    
    
    for i=0, n_elements(pmb[clearAir])-1 do begin
      if (((timeForm[i] gt 132030) and (timeForm[i] lt 140240))) then begin
        for j=0, n_elements(clearair)-1 do begin
          if (clearair[j] eq i) then begin
            baselineClimbI[i]=1
          endif
        endfor
      endif
    endfor
    
    baselineClimbTimes=where(baselineClimbI eq 1)
    
    
    lwcClimbPresCorDouble=lwcPresCor - (-4.1426728564968175e-05)*pmb - 0.035640472415037983
    lwcClimbPresCor=lwc - (-8.1768221950427242e-05)*pmb - 0.064373809113766792
    
    plot1=scatterplot(abs(avpitch[baselineClimbTimes]),lwcprescor[baselineClimbTimes],symbol='+',sym_size=.4,dimensions=[1200,900])
    plot1.xrange=[400,900]
    plot1.yrange=[-.04,.04]
    
  
    
    plot2=scatterplot(pmb[baselineClimbTimes],lwcClimbPresCorDouble[baselineClimbTimes],symbol='+',sym_size=.4,sym_color='red',/overplot)
    plot3=scatterplot(pmb[baselineClimbTimes],lwcnev1[baselineClimbTimes],symbol='+',sym_size=.4,sym_color='blue',/overplot)

    
    
    ;plot1=scatterplot(pmb[clearAir],lwc[clearAir],symbol='+',sym_size=.4,dimensions=[1200,900])
    ;plot2=scatterplot(pmb[baselineClimbTimes],lwc[baselineClimbTimes],symbol='+',sym_size=.4,sym_color='red',/overplot)
    ;plot2=scatterplot(pmb[clearAir],lwcnev1[clearAir],symbol='+',sym_size=.4,sym_color='blue',/overplot)
stop
  return

end