;CALCS AND PLOTS MEAN ERROR/STDEV FOR EACH K LIQ CALC

pro kliqpresimprove

  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
flight='0725'

  ;flight=['0710','0725','0727','0728','0729']
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
  lwcnev10con=[]
  avpitchcon=[]
  avrollcon=[]
  betabcon=[]
  avyawcon=[]
  betaBcon=[]
  lwcnoPresCorcon=[]
  sigcon=[]
  column=dindgen(10,n_elements(flight))
  
  if runcalc eq 1 then begin
  for k=0,n_elements(ktype)-1 do begin
    
    
    
    for i=0,n_elements(kLevel)-1 do begin
      
        lwccon=[]
        pmbcon=[]
        ascon=[]
        cdpdbar_NRBcon=[]
        cdpconc_NRBcon=[]
        lwcnoPresCorDiffcon=[]
        trfcon=[]
        clearaircon=[]
        hivscon=[]
        asdelcon=[]
        
        for j=0,n_elements(flight)-1 do begin
       g= nevBase(flight[j],ktype[k],kLevel[i])

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
          lwcnoPresCor=g.lwcnoPresCor
          flightString=g.flightString
          kLiq=g.kLiq
          cdpdbar_NRB=g.cdpdbar_NRB
          cdpconc_NRB=g.cdpconc_NRB
          trf=g.trf
          lwc100=g.lwc100
          avyaw=g.avyaw
          
          
          
          pmbcon=[pmbcon,pmb]
          lwccon=[lwccon,lwc]
          ascon=[ascon,as]
          cdpdbar_NRBcon=[cdpdbar_NRBcon,cdpdbar_NRB]
          cdpconc_NRBcon=[cdpconc_NRBcon,cdpconc_NRB]
          trfcon=[trfcon,trf]
          lwc100con=[lwc100con,lwc100]
          lwcnev1con=[lwcnev1con,lwcnev1]
          clearaircon=[clearaircon,clearair]
          avpitchcon=[avpitchcon,avpitch]
          avrollcon=[avrollcon,avroll]
          ;betabcon=[betabcon,betab]
          avyawcon=[avyawcon,avyaw]
          lwcnoPresCorcon=[lwcnoPresCorcon,lwcnoPresCor]
         cgcleanup
          sig=(g.vlwccol*g.ilwccol)-(g.vlwcref*g.ilwcref)
          ;sig[0:100]=0
          sig[n_elements(sig)-100:n_elements(sig)-1]=5
          x=a_correlate(sig,dindgen(n_elements(sig),start=0,increment=-1))
          sigcon=[sigcon,sig]
          
          smooth=ts_smooth(x,600)
          thresh=smooth+.002                
          
          p5=plot(g.time,x, dimensions=[800,1000])
          p6=plot(g.time,thresh,'r',/overplot)
          
          clearair2i=dindgen(n_elements(g.pmb),start=0,increment=0)
          for e=0,n_elements(sig)-1 do begin
            if x[e] lt thresh[i] then begin
              clearair2i[e] = 1
            endif
          endfor
          
          clearair2=where(clearair2I eq 1)
          stop
          
          
         
         fraction=(double(n_elements(clearair))/double(n_elements(pmb)))*100.
         print,fraction
          
          ;if j eq 0 then plot1=scatterplot(pmb,sig, sym_size=.2,sym_color='black')
          ;if j gt 0 then plot1=scatterplot(pmb,sig,sym_color='black',/overplot, sym_size=.2)
          smooth=ts_smooth(sig,460)
          
          thresh=(smooth+0.25)-(exp(smooth)*.03)
          
          
          sigdiff=abs(ts_diff(sig,1))
          
;          svlwccol=sort(sigdiff)
;          vlwccolsorted=sigdiff[svlwccol]
;          h=.017
;          
;
;          clearair2i=dindgen(n_elements(g.pmb),start=0,increment=0)
;          signal2i=dindgen(n_elements(g.pmb),start=0,increment=0)
;          
;          for e=0,n_elements(g.pmb)-2 do begin
;            if sig[e] lt thresh[e] and sigdiff[e] lt h and sigdiff[e+1] lt h then begin
;              clearair2i[e] = 1
;            endif
;            if sig[e] gt thresh[e] then begin
;              signal2i[e] = 1
;            endif
;          endfor
          
         
          
          clearair2=where(clearair2I eq 1)
          signal2=where(signal2i eq 1)
          
     
          
          p1=plot(g.time,sig, dimensions=[800,1000])
          p3=plot(time,smooth,'g',/overplot)
          
          p2=plot(time,thresh,'r',/overplot)
          
          p5=plot(g.time,sigdiff, dimensions=[800,1000])
          p6=plot([min(time),max(time)],[h,h],'r',/overplot)
          p12=scatterplot(g.time[clearair2],sigdiff[clearair2],sym_color='green',symbol='.',/overplot)
          p12=scatterplot(g.time[where(g.lwc[clearair2] gt .0499999)],sigdiff[where(g.lwc[clearair2] gt .0499999)],sym_color='pink',symbol='+',sym_size=4,/overplot)
          p12.xrange=[1.9573d7,1.9575d7]
          ;p6=plot([min(time),max(time)],[0.06,0.06],'r',/overplot)
          p6.yrange=[-.02,.1]
          
          
          p9=plot(g.time[clearair2],g.lwc[clearair2], dimensions=[800,1000])
          p10=plot(g.time[clearair2],g.lwc[clearair2],'b', dimensions=[800,1000])
          p10.yrange=[-.5,.5]
          print,double(n_elements(clearair2))/double(n_elements(g.pmb))*100.
          print,n_elements(where(g.lwc[clearair2] gt .05))
          ;p2=plot([min(g.time),max(g.time)],[0.7518,0.7518],'r',/overplot)          stop
      
                      
         
          
          ;if mean(lwcnev10) gt 0 then plot1=scatterplot(hivs[lwcnev10],lwc[lwcnev10],sym_color='red',/overplot, sym_size=.2)
        endfor
        ;save,pmbcon,lwccon,ascon,cdpdbar_NRBcon,cdpconc_NRBcon,trfcon,lwc100con,lwcnev1con,clearaircon,avrollcon,avpitchcon,avyawcon,lwcnoPresCorcon,filename='cons.sav'
        h=histogram(lwccon,binsize=.02)
        lwcconsort=sort(lwcCon)
        lwcConsorted=lwcCon[lwcconsort]
        sigconsorted=sigcon[lwcconsort]
        
        stop
        var=pmbcon
        xleft=min(var)-min(var)*.1
        xright=max(var)+max(var)*.1
        ytop=max(var)+max(var)*.1
        ybottom=min(var)-min(var)*.1
        
        ;fit=linfit(var,lwcNoPresCorcon)

        
        if j eq 0 then plot1=scatterplot(ascon,lwcNoPresCorcon, sym_size=.2)
   
;        plot1=scatterplot(lwc100con,lwcNoPresCorcon, sym_size=.2,dimensions=[1200,1200])
;        plot2=scatterplot(lwc100con,lwcnev1con, sym_size=.2,sym_color='red',/overplot)
;        plot2.xrange=[0,4]
;        plot2.yrange=[0,4]
;        plot3=plot([0,4],[0,4],'g',/overplot)
        
        lwcmean=mean(abs(lwcNoPresCorcon))
        dev=stddev(lwcNoPresCorcon)
        
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
    
   if runcalc eq 1 then save,lwcmean400ind,lwcmean600ind,lwcmean900ind,lwcmean400true,lwcmean600true,lwcmean900true,lwcdev400ind,lwcdev600ind,lwcdev900ind,lwcdev400true,lwcdev600true,lwcdev900true ,filename='kAsLwcMeansBB'
   if runcalc eq 1 then stop
   
    
   if runcalc eq 0 then restore, 'kAsLwcMeansBB'
  
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
   
   plot2=errorplot(holder,kmeans, devs,/overplot,linestyle=6,errorbar_thick=2)
   
   plot2.xTICKVALUES=[0,1,2,3,4,5,6]
   plot2.xrange=[-1,6]
   plot2.xminor=0

   plot2.Save,'meanerrosB.ps'



;  presHeadersa=['Flight Day','900 mb','','','600 mb','','','400mb','','']
;  presHeadersb=['Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error']
;
;  write_csv,'kAsIndComp.csv',column,header=presHeadersa
;  errorComp, column
stop
  return

end