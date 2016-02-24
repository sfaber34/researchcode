pro alldaysmeanascorrerror

  days=['0710','0725','0727','0728','0729','0807','0814','0815','0803']
  airspeeds=[]
  lwcs=[]
  slopes=[]
  intercepts=[]
  

  for i=0,n_elements(days)-1 do begin
    ;flightDay, airspeedType, level
    nevBase, days[i],'indicated','400'

    common g, g
    pmb=g.pmb
    lwc=g.lwc
    time=g.time
    timeForm=g.timeForm
    as=g.as
    tas=g.tas
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

    airspeeds=[airspeeds,tas[clearair]]
    lwcs=[lwcs,lwc[clearair]]
    
    lin=linfit(tas[clearair],lwc[clearair])
    slopes=[slopes,lin[1]]
    intercepts=[intercepts,lin[0]]

  endfor

  meanslope=mean(slopes)
  meanint=mean(intercepts)

  

  plot1=scatterplot(airspeeds,lwcs,symbol='+',sym_size=.4,dimensions=[1200,900])
stop
  
  return

end