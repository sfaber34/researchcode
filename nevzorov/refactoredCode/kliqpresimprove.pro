;CALCS AND PLOTS MEAN ERROR/STDEV FOR EACH K LIQ CALC

pro kliqpresimprove
;cgcleanup
count=0
total=0
  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
 ;flight='0727'
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
  sigcon=[]
  column=dindgen(10,n_elements(flight))
  ;cgcleanup
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
        lwcnoPresCorcon=[]
        for j=0,n_elements(flight)-1 do begin
       g= nevBase(flight[j],ktype[k],kLevel[i])
       p1=scatterplot(g.pmb[g.clearair],g.lwc[g.clearair],/overplot,dimensions=[1400,1000])
  
       
  
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
          lwcnev1=g.lwcnev1[g.clearair]
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
          lwcnoPresCorcon=[lwcnoPresCorcon,lwcnoPresCor[g.clearair]]

          print,' '
          print,' '
          print,'-------------------------------------------'
          print,''
          print, flight[j]
          print, kLevel[i]
          
          
          count=count+n_elements(g.clearair)
          print,count
          total=total+n_elements(g.pmb)
          print,total

        endfor
        
      
        


        
        lwcmean=mean(abs(lwcnoPresCorcon))
        dev=stddev(lwcnoPresCorcon)
        
        
          ave=(double(n_elements(clear))/double(n_elements(g.lwc)))*100.
          print,'mean=',lwcmean
          print,'stddev=',dev
        
        ;p1=scatterplot(g.pmb[g.clearair],g.lwc[g.clearair])
        
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
    stop
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

   stop
   return

 end





























;for m=0,n_elements(x)-1 do begin
;
;  for n=0,n_elements(x)-1 do begin
;    k=s
;    ;p2=plot(g.time,k)
;
;    f=dindgen(n_elements(g.time),increment=0)
;    c=dindgen(n_elements(g.time),increment=0)
;    cleari=dindgen(n_elements(g.time),increment=0)
;    int=230
;
;    for i=0,n_elements(g.time)-(int+1) do begin
;      f[i:i+int]=min(s[i:i+int])
;      i=i+int
;    endfor
;
;
;    for i=0,n_elements(g.time)-(int+1) do begin
;      c[i:i+int]=s[i:i+int]-f[i:i+int]
;      i=i+int
;    endfor
;    c=smooth(c,20)
;
;    csort=sort(c)
;    csorted=c[csort]
;    csorted2=csorted[n_elements(csorted)*.52]
;
;    for i=0,n_elements(g.time)-1 do begin
;      if c[i] lt csorted2 then cleari[i]=1
;
;
;    endfor
;
;    cleari[0:200]=0
;    cleari[n_elements(cleari)-200:n_elements(cleari)-1]=0
;
;    clear=where(cleari eq 1)


    ;        p4=plot(g.time,f,'r',/overplot)
    ;        p4.yrange=[1.5,2.5]
    ;
    ;        p5=plot(g.time,c,'r')
    ;        p9=plot(g.time[clear],g.lwc[clear])
    
    ;plot2.Save,'meanerrosB.ps'



    ;  presHeadersa=['Flight Day','900 mb','','','600 mb','','','400mb','','']
    ;  presHeadersb=['Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error']
    ;
    ;  write_csv,'kAsIndComp.csv',column,header=presHeadersa
    ;  errorComp, column
    ;save,pmbcon,lwccon,ascon,cdpdbar_NRBcon,cdpconc_NRBcon,trfcon,lwc100con,lwcnev1con,clearaircon,avrollcon,avpitchcon,avyawcon,lwcnoPresCorcon,filename='cons.sav'
    ;s=(g.vlwccol*g.ilwccol)/(g.vlwcref*g.ilwcref)
    ;
    ;h=histogram(lwccon,binsize=.02)
    ;lwcconsort=sort(s)
    ;lwcConsorted=s[lwcconsort]
    ;
    ;;x=[2,5,10,20,25,30,40,80,100]
    ;x=[80,90]
    ;;x=[100,140,180,220,350,400,600]
