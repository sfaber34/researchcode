pro kliqastypecomp

  kLevel=['indicated','true']
  colors=['red','blue']
  yrange=[.05,-.05]
  xrange=[400,800]

  for i=0,n_elements(kLevel)-1 do begin
    nevBase, 0807,kLevel[i],'400'

    common g, g
    pmb=g.pmb
    lwc=g.lwc
    time=g.time
    timeForm=g.timeForm
    as=g.as
    aiasMs=g.aiasMs
    tas=g.tas
    clearAir=g.clearAir
    levelClearAir=g.levelClearAir
    avroll=g.avroll
    avpitch=g.avpitch
    pLiq=g.pLiq
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
stop

    plot1=scatterplot(pmb[clearair],lwc[clearair],/overplot)
    plot1.sym_color=colors[i]
    plot1.sym_size=.4
    
    lin=linfit(pmb[clearair],lwc[clearair])
    linleft=(lin[1])*xrange[0]+lin[0]
    linright=(lin[1])*xrange[1]+lin[0]
    
    plot1a=plot(xrange,[linleft,linright],/overplot)
    plot1a.color=colors[i]



  endfor

  return

end