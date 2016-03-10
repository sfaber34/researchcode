;CALCS AND PLOTS MEAN ERROR/STDEV FOR EACH K LIQ CALC

pro kliqpresimprove

  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
  kLevel=['400']
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
  lwc100con=[]
  interceptPerCorComp=[]
  lwcPresCorcon=[]
  lwcnev1con=[]
  column=dindgen(10,n_elements(flight))
  
  if runcalc eq 1 then begin
  for k=0,n_elements(ktype)-1 do begin
    
    
    
    for i=0,n_elements(kLevel)-1 do begin
      
        lwccon=[]
        pmbcon=[]
        ascon=[]
        cdpdbar_NRBcon=[]
        cdpconc_NRBcon=[]
        lwcPresCorDiffcon=[]
        trfcon=[]
        clearaircon=[]
        
        for j=0,n_elements(flight)-1 do begin
       g= nevBase(flight[j],ktype[k],kLevel[i])
  stop
          print,''
          print,'-------------------------------------------'
          print, flight[j]
          print, kLevel[i]
  
          ;common g, g
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
          cdpdbar_NRB=g.cdpdbar_NRB
          cdpconc_NRB=g.cdpconc_NRB
          trf=g.trf
          lwc100=g.lwc100
          
          
          pmbcon=[pmbcon,pmb]
          lwccon=[lwccon,lwc]
          ascon=[ascon,as]
          cdpdbar_NRBcon=[cdpdbar_NRBcon,cdpdbar_NRB]
          cdpconc_NRBcon=[cdpconc_NRBcon,cdpconc_NRB]
          lwcPresCorDiffcon=[lwcPresCorDiffcon,lwcPresCorDiff]
          trfcon=[trfcon,trf]
          lwc100con=[lwc100con,lwc100]
          lwcPresCorcon=[lwcPresCorcon,lwcPresCor]
          lwcnev1con=[lwcnev1con,lwcnev1]
          clearaircon=[clearaircon,clearair]
         
          
          if j eq 0 then plot1=scatterplot(pmb[clearair],lwcnev1[clearair], sym_size=.2)
          if j gt 0 then plot1=scatterplot(pmb[clearair],lwcnev1[clearair],/overplot, sym_size=.2)
        endfor
        
        if j eq 0 then plot1=scatterplot(ascon,lwccon, sym_size=.2)
   
        plot1=scatterplot(lwc100con,lwcPresCorcon, sym_size=.2,dimensions=[1200,1200])
        plot2=scatterplot(lwc100con,lwcnev1con, sym_size=.2,sym_color='red',/overplot)
        plot2.xrange=[0,4]
        plot2.yrange=[0,4]
        plot3=plot([0,4],[0,4],'g',/overplot)
        stop
        lwcmean=mean(abs(lwccon))
        dev=stddev(lwccon)
        
        if ktype[k] eq 'indicated' and kLevel[i] eq '400' then begin
          lwcmean400ind=lwcmean
          lwcdev400ind=dev
        endif
        
        if ktype[k] eq 'indicated' and kLevel[i] eq '600' then begin
          lwcmean600ind=lwcmean
          lwcdev600ind=dev
        endif
        
        if ktype[k] eq 'indicated' and kLevel[i] eq '900' then begin
          lwcmean900ind=lwcmean
          lwcdev900ind=dev
        endif
        
        if ktype[k] eq 'true' and kLevel[i] eq '400' then begin
          lwcmean400true=lwcmean
          lwcdev400true=dev
        endif

        if ktype[k] eq 'true' and kLevel[i] eq '600' then begin
          lwcmean600true=lwcmean
          lwcdev600true=dev
        endif

        if ktype[k] eq 'true' and kLevel[i] eq '900' then begin
          lwcmean900true=lwcmean
          lwcdev900true=dev
        endif
  
    endfor
    
    endfor
    
    endif
    
   if runcalc eq 1 then save,lwcmean400ind,lwcmean600ind,lwcmean900ind,lwcmean400true,lwcmean600true,lwcmean900true,lwcdev400ind,lwcdev600ind,lwcdev900ind,lwcdev400true,lwcdev600true,lwcdev900true ,filename='kAsLwcMeansB'
   if runcalc eq 1 then stop
   
    
   if runcalc eq 0 then restore, 'kAsLwcMeansB'
  
   callevel=['400 mb Ind','600 mb Ind','900 mb Ind','400 mb True','600 mb True','900 mb True']
   holder=dindgen(n_elements(callevel),start=0,increment=1)
   kmeans=[lwcmean400ind,lwcmean600ind,lwcmean900ind,lwcmean400true,lwcmean600true,lwcmean900true]
   devs=[lwcdev400ind,lwcdev600ind,lwcdev900ind,lwcdev400true,lwcdev600true,lwcdev900true]

   plot1=scatterplot(holder,kmeans,dimensions=[1200,900], name='% Slope Correction')
   ;plot1.xrange=[0,10]
   ;plot1.yrange=[40,150]
   plot1.xtickname=callevel
   plot1.sym_filled=1
   plot1.font_size=16
   plot1.title='All Flights Clear Air LWC Mean Error'
   plot1.ytitle='Absolute Mean Error g m!U-3!N'
   plot1.xtitle='k Regression Flight Level and Airspeed Type'
   
   ;leg1=legend(target=[plot1,plot2],shadow=0)
   
   plot2=errorplot(holder,kmeans, devs,/overplot,linestyle=6)
   
   plot2.xTICKVALUES=[0,1,2,3,4,5,6]
   plot2.xrange=[-1,6]
   plot2.xminor=0

   plot2.Save,'meanerros.ps'



;  presHeadersa=['Flight Day','900 mb','','','600 mb','','','400mb','','']
;  presHeadersb=['Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error']
;
;  write_csv,'kAsIndComp.csv',column,header=presHeadersa
;  errorComp, column
stop
  return

end