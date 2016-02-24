pro kliqasindkcomp

  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
  kLevel=['400','600','900']
  colors=['red','blue','black']
  yrange=[.05,-.05]
  xrange=[60,150]
  
  slope400=[]
  intercept400=[]
  slope600=[]
  intercept600=[]
  slope900=[]
  intercept900=[]
  meanlwcdiff400=[]
  meanlwcdiff600=[]
  meanlwcdiff900=[]
  column=dindgen(10,n_elements(flight))
  allpoints=dindgen(1)
  clearairpoints=dindgen(1)

  for j=0,n_elements(flight)-1 do begin
  print,''
  print,'-------------------------------------------'
  print, flight[j]
  for i=0,n_elements(kLevel)-1 do begin
    nevBase, flight[j],'true',kLevel[i]
    
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


    ;plot1=scatterplot(as[clearair],lwc[clearair],/overplot)
    ;plot1.sym_color=colors[i]
    ;plot1.sym_size=.4

    lin=linfit(as,lwcAsCorrDiff)
    linleft=(lin[1])*xrange[0]+lin[0]
    linright=(lin[1])*xrange[1]+lin[0]

    ;plot1a=plot(xrange,[linleft,linright],/overplot)
    ;plot1a.color=colors[i]

    print, kLevel[i]
    print, lin[1],'    ',lin[0]
    
    if kLevel[i] eq 400 then begin
      slope400=[slope400,lin[1]]
      intercept400=[intercept400,lin[0]]
      meanlwcdiff400=[meanlwcdiff400,mean(abs(lwcAsCorrDiff))]

;       slope400=lin[1]
;       intercept400=lin[0]
;       meanlwcdiff400=mean(abs(lwcAsCorrDiff))
    endif
    
    if kLevel[i] eq 600 then begin
      slope600=[slope600,lin[1]]
      intercept600=[intercept600,lin[0]]
      meanlwcdiff600=[meanlwcdiff600,mean(abs(lwcAsCorrDiff))]

;       slope600=lin[1]
;       intercept600=lin[0]
;       meanlwcdiff600=mean(abs(lwcAsCorrDiff))
    endif
    
    if kLevel[i] eq 900 then begin
      slope900=[slope900,lin[1]]
      intercept900=[intercept900,lin[0]]
      meanlwcdiff900=[meanlwcdiff900,mean(abs(lwcAsCorrDiff))]

;       slope900=lin[1]
;       intercept900=lin[0]
;       meanlwcdiff900=mean(abs(lwcAsCorrDiff))
    endif
   
    allpoints=allpoints+n_elements(pmb)
    clearairpoints=clearairpoints+n_elements(clearair)
    
    print,'all points=', allpoints
    print,'clear air points=', clearairpoints

  endfor
    ;column[0,j]=[flight[j],slope900,intercept900,meanlwcdiff900,slope600,intercept600,meanlwcdiff600,slope400,intercept400,meanlwcdiff400]
    
    
  endfor
  
  
  print, '----------------------------------------'
  print, '900 mb'
  print, 'slope=',mean(slope900)
  print, 'intercept=',mean(intercept900)
  print, 'meanerr=',mean(meanlwcdiff900)
  print,''
  print,''
  print, '----------------------------------------'
  print, '600 mb'
  print, 'slope=',mean(slope600)
  print, 'intercept=',mean(intercept600)
  print, 'meanerr=',mean(meanlwcdiff600)
  print,''
  print,''
  print, '----------------------------------------'
  print, '400 mb'
  print, 'slope=',mean(slope400)
  print, 'intercept=',mean(intercept400)
  print, 'meanerr=',mean(meanlwcdiff400)
  print,''
  print,''
  

  presHeadersa=['Flight Day','900 mb','','','600 mb','','','400mb','','']
  presHeadersb=['Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error']
  
  write_csv,'kAsIndComp.csv',column,header=presHeadersa
  errorComp, column

  return

end