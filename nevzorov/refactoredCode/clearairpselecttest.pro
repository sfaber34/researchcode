;TESTS FOR SELECTING CLEAR AIR POINTS BY COLLECTOR SENSOR P

pro clearairpselecttest

  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
  flight=['copecal900','copecal600','copecal400','larcal900','larcal600','larcal400']
  kLevel=['400','600','900']
  ktype=['indicated']
  colors=['red','blue','black']
  yrange=[.05,-.05]
  xrange=[60,150]
  runcalc=1

  mean400=[]
  stdev400=[]
  mean600=[]
  stdev600=[]
  mean900=[]
  stdev900=[]
  meanlwcdiff400=[]
  slopePerCorComp=[]
  interceptPerCorComp=[]
  column=dindgen(10,n_elements(flight))

  if runcalc eq 1 then begin

        lwccon=[]
        pmbcon=[]
        clearaircon=[]
        timecon=[]
        vlwccolcon=[]
        ilwccolcon=[]
        lwcnev1con=[]
        vlwccolcondelsmooth=[]
        clearairb=[]
        timecon=[]
        clearairlwcnevcon=[]

        for j=0,n_elements(flight)-1 do begin
          g=nevBasektest(flight[j],'indicated','400')

;          print,''
;          print,'-------------------------------------------'
;          print, flight[j]

          clearAir=g.clearAir
          pmb=g.pmb
          lwc=g.lwc
          time=g.time
          timeForm=g.timeForm
          as=g.as
          aiasMs=g.aiasMs
          tas=g.tas
          levelClearAir=g.levelClearAir
          avroll=g.avroll
          avpitch=g.avpitch
          pLiq=g.pLiq
          ;lwcnev1=g.lwcnev1[clearair]
          ;lwcAsCorrDiff=g.lwcAsCorrDiff
          ;lwcPresCorDiff=g.lwcPresCorDiff
          lwcPresCor=g.lwcPresCor
          linPresCor=g.linPresCor
          flightString=g.flightString
          kLiq=g.kLiq
          clearAirLargeErr=g.clearAirLargeErr
          clearAirLargeErrex=g.clearAirLargeErrex
          levelClearAirLargeErrex=g.levelClearAirLargeErrex
          vlwccol=g.vlwccol
          ilwccol=g.ilwccol
          kliqcalc=g.kliqcalc
          

          

          pmbcon=[pmbcon,pmb]
          lwccon=[lwccon,lwc]
          clearaircon=[clearaircon,clearair]
          timecon=[timecon,time]
          vlwccolcon=[vlwccolcon,vlwccol]
          ilwccolcon=[ilwccolcon,ilwccol]
          ;lwcnev1con=[lwcnev1con,lwcnev1]
          timecon=[timecon,time]
          ;clearairlwcnevcon=[clearairlwcnevcon,lwcnev1[clearair]]


          ;if j eq 0 then plot1=scatterplot(pmb,lwcnev1,dimensions=[1600,1200])
          ;if j ne 0 then plot1=scatterplot(pmb,lwcnev1,dimensions=[1600,1200],/overplot)
          ;plot1.title='vlwccol'
          ;plot1.yrange=[-.03,.03]
          ;plot1.xrange=[1.7756d7,1.7757d7]
          ;plot2=scatterplot(pmb[clearair],lwcnev1,dimensions=[1600,1200],sym_color='red',symbol='+',/overplot)
          ;plot2.title='vlwccolcondel'
          
          print,''
          print,'----------------------------------------'
          print,flight[j]
          print,'TRUE AS-',mean(tas)
          print,'IND AS-',mean(aiasms)
        endfor


  endif
  stop
  
;  vlwccolconshift=shift(vlwccolcon,1)
;  vlwccolcondel=vlwccolcon-vlwccolconshift
;  
;  vlwccolcondelshift=shift(vlwccolcondel,1)
;  vlwccolcondelshift2=shift(vlwccolcondel,2)
;  vlwccolcondelshift3=shift(vlwccolcondel,3)
;  vlwccolcondelshift4=shift(vlwccolcondel,4)
  
  


  x=dindgen(n_elements(pmbcon))
  xclearair=dindgen(n_elements(clearaircon))
            
  ;clearairb=where(abs(vlwccolcondel) lt .01 and abs(vlwccolcondelshift) lt .01 and abs(vlwccolcondelshift2) lt .01 and abs(vlwccolcondelshift3) lt .01)
  


  ;if runcalc eq 1 then save,lwcmean400ind,lwcmean600ind,lwcmean900ind,lwcmean400true,lwcmean600true,lwcmean900true,lwcdev400ind,lwcdev600ind,lwcdev900ind,lwcdev400true,lwcdev600true,lwcdev900true ,filename='kAsLwcMeansB'
  ;if runcalc eq 1 then stop


  if runcalc eq 0 then restore, 'kAsLwcMeansB'

  callevel=['','900 mb Ind','600 mb Ind','400 mb Ind','900 mb True','600 mb True','400 mb True','']
  holder=dindgen(n_elements(callevel))
  kmeans=[' ',lwcmean400ind,lwcmean600ind,lwcmean900ind,lwcmean400true,lwcmean600true,lwcmean900true,' ']
  devs=[' ',lwcdev400ind,lwcdev600ind,lwcdev900ind,lwcdev400true,lwcdev600true,lwcdev900true,' ']

  plot1=scatterplot(holder,kmeans,dimensions=[1200,900], name='% Slope Correction')
  ;plot1.xrange=[0,10]
  ;plot1.yrange=[40,150]
  plot1.xtickname=flights
  plot1.title='Percent Correction After Pres Correction Averaged All Flights'
  plot1.ytitle='Percent Correction'
  plot1.xtitle='Flight Day'

  ;leg1=legend(target=[plot1,plot2],shadow=0)

  plot2=errorplot(holder,kmeans, devs,/overplot)






  ;  presHeadersa=['Flight Day','900 mb','','','600 mb','','','400mb','','']
  ;  presHeadersb=['Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error']
  ;
  ;  write_csv,'kAsIndComp.csv',column,header=presHeadersa
  ;  errorComp, column
  stop
  return

end