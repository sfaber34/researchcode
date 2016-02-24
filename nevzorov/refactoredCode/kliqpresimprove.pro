pro kliqpresimprove

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
  slopePerCorComp=[]
  interceptPerCorComp=[]
  column=dindgen(10,n_elements(flight))

  for j=0,n_elements(flight)-1 do begin
    print,''
    print,'-------------------------------------------'
    print, flight[j]
      nevBase, flight[j],'indicated','400'

      common g, g
      clearAir=g.clearAir
      pmb=g.pmb[clearair]
      lwc=g.lwc[clearair]
      time=g.time
      timeForm=g.timeForm
      as=g.as
      aiasMs=g.aiasMs
      tas=g.tas      
      levelClearAir=g.levelClearAir
      avroll=g.avroll
      avpitch=g.avpitch
      pLiq=g.pLiq
      lwcnev1=g.lwcnev1
      lwcAsCorrDiff=g.lwcAsCorrDiff
      lwcPresCorDiff=g.lwcPresCorDiff
      lwcPresCor=g.lwcPresCor[clearair]
      linPresCor=g.linPresCor
      flightString=g.flightString
      kLiq=g.kLiq
      clearAirLargeErr=g.clearAirLargeErr
      clearAirLargeErrex=g.clearAirLargeErrex
      levelClearAirLargeErrex=g.levelClearAirLargeErrex

      lin=linfit(pmb,lwc)
      lin2=linfit(pmb,lwcprescor)
      linleft=(lin[1])*xrange[0]+lin[0]
      linright=(lin[1])*xrange[1]+lin[0]

      slopePerCor = (abs(lin[1]-lin2[1]))/(abs(lin[1]))*100.
      interceptPerCor = (abs(lin[0]-lin2[0]))/(abs(lin[0]))*100.
      
      lwcRawError=mean(abs(lwc))
      lwcProcessedError=mean(abs(lwcPresCor))
      lwcerrorpercent=abs(lwcRawError-lwcProcessedError)/abs(lwcRawError)
      
      print,'Raw'
      print, lin[1],'    ',lin[0]
      print,'Corrected'
      print, lin2[1],'    ',lin2[0]
      print, '% Diff'
      print, slopePerCor,'    ',interceptPerCor
      print,'---------------------------'
;      print, 'Raw Error'
;      print, lwcRawError
;      print, 'Processed Error'
;      print, lwcProcessedError
;      print, '% Diff Error'
;      print, lwcerrorpercent
      print, ' '
      print, ' '




    ;column[0,j]=[flight[j],slope900,intercept900,meanlwcdiff900,slope600,intercept600,meanlwcdiff600,slope400,intercept400,meanlwcdiff400]
    slopePerCorComp=[slopePerCorComp,slopePerCor]
    interceptPerCorComp=[interceptPerCorComp,interceptPerCor]

  endfor
  
   flights=['','07/10','07/25','07/27','07/28','07/29','08/03','08/07','08/14','08/15','']
   slopePerCorComp=[0,slopePerCorComp,0]
   interceptPerCorComp=[0,interceptPerCorComp,0]
   holder=dindgen(n_elements(flights))

   plot1=scatterplot(holder,slopePerCorComp,dimensions=[1200,900], name='% Slope Correction')
   plot2=scatterplot(holder,interceptPerCorComp,sym_color='red',/overplot, name='% Intercept Correction')
   plot1.xrange=[0,10]
   plot1.yrange=[40,150]
   plot1.xtickname=flights
   plot1.title='Percent Correction After Pres Correction Averaged All Flights'
   plot1.ytitle='Percent Correction'
   plot1.xtitle='Flight Day'
   
   leg1=legend(target=[plot1,plot2],shadow=0)
   
   




;  presHeadersa=['Flight Day','900 mb','','','600 mb','','','400mb','','']
;  presHeadersb=['Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error']
;
;  write_csv,'kAsIndComp.csv',column,header=presHeadersa
;  errorComp, column
stop
  return

end