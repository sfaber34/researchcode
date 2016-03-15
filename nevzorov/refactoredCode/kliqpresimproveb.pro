;CALCS AND PLOTS MEAN ERROR/STDEV FOR EACH K LIQ CALC

pro kliqpresimproveB

  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
  kLevel=['400']
  ktype=['indicated']
  colors=['red','blue','black']
  yrange=[.05,-.05]
  xrange=[60,150]
  runcalc=0

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
  lwcNoPresCorcon=[]
  column=dindgen(10,n_elements(flight))

  if runcalc eq 1 or runcalc eq 2 then begin
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
        hivscon=[]
        asdelcon=[]
        errorcon=[]

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
          flightString=g.flightString
          kLiq=g.kLiq
          cdpdbar_NRB=g.cdpdbar_NRB
          cdpconc_NRB=g.cdpconc_NRB
          trf=g.trf
          lwc100=g.lwc100
          avyaw=g.avyaw
          lwcNoPresCor=g.lwcNoPresCor


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
          avyawcon=[avyawcon,avyaw]
          lwcNoPresCorcon=[lwcNoPresCorcon,lwcNoPresCor]
          
          error=lwcnev1-lwc

          if j eq 0 then plot1=scatterplot(pmb,error, sym_size=.2,sym_color='black')
          if j gt 0 then plot1=scatterplot(pmb,error,sym_color='black',/overplot, sym_size=.2)

          lwcmean=mean(abs(error))
          dev=stddev(error)

          lin=linfit(pmb,lwc)
          errorweighted=lin[1]
          print, errorweighted
          errorcon=[errorcon,errorweighted]
          if flight[j] eq '0710' then begin
            lwcmean0710=lwcmean
            lwcdev0710=dev
          endif

          if flight[j] eq '0725' then begin
            lwcmean0725=lwcmean
            lwcdev0725=dev
          endif

          if flight[j] eq '0727' then begin
            lwcmean0727=lwcmean
            lwcdev0727=dev
          endif

          if flight[j] eq '0728' then begin
            lwcmean0728=lwcmean
            lwcdev0728=dev
          endif

          if flight[j] eq '0729' then begin
            lwcmean0729=lwcmean
            lwcdev0729=dev
          endif

          if flight[j] eq '0803' then begin
            lwcmean0803=lwcmean
            lwcdev0803=dev
          endif

          if flight[j] eq '0807' then begin
            lwcmean0807=lwcmean
            lwcdev0807=dev
          endif

          if flight[j] eq '0814' then begin
            lwcmean0814=lwcmean
            lwcdev0814=dev
          endif

          if flight[j] eq '0815' then begin
            lwcmean0815=lwcmean
            lwcdev0815=dev
          endif


          ;if mean(lwcnev10) gt 0 then plot1=scatterplot(hivs[lwcnev10],lwc[lwcnev10],sym_color='red',/overplot, sym_size=.2)
        endfor
        
        errorall=mean(errorcon)*25.
        print, errorall
        var=pmbcon
        xleft=min(var)-min(var)*.1
        xright=max(var)+max(var)*.1
        ytop=max(var[clearaircon])+max(var[clearaircon])*.1
        ybottom=min(var[clearaircon])-min(var[clearaircon])*.1

        fit=linfit(var[clearaircon],lwccon[clearaircon])

        unitvec=dindgen(200000,start=-1000.,increment=.01)
        line=unitvec*(fit[1])+(fit[0])
        print,fit
        plotline=plot(unitvec,line,'r',/overplot)
        plotline.xrange=[xleft,xright]
        plotline.yrange=[-.04,.04]



        if j eq 0 then plot1=scatterplot(ascon,lwccon, sym_size=.2)

        

      endfor

    endfor

  endif

 

  if runcalc eq 1 then save,lwcmean0710,lwcmean0725,lwcmean0727,lwcmean0728,lwcmean0729,lwcmean0803,lwcmean0807,lwcmean0814,lwcmean0815,lwcdev0710,lwcdev0725,lwcdev0727,$
    lwcdev0728,lwcdev0729,lwcdev0803,lwcdev0807,lwcdev0814,lwcdev0815 ,filename='kAsLwcMeansBB'
  if runcalc eq 2 then begin
    
    lwcmean0710C=lwcmean0710
    lwcmean0725C=lwcmean0725
    lwcmean0727C=lwcmean0727
    lwcmean0728C=lwcmean0728
    lwcmean0729C=lwcmean0729
    lwcmean0803C=lwcmean0803
    lwcmean0807C=lwcmean0807
    lwcmean0814C=lwcmean0814
    lwcmean0815C=lwcmean0815
    lwcdev0710C=lwcdev0710
    lwcdev0725C=lwcdev0725
    lwcdev0727C=lwcdev0727
    lwcdev0728C=lwcdev0728
    lwcdev0729C=lwcdev0729
    lwcdev0803C=lwcdev0803
    lwcdev0807C=lwcdev0807
    lwcdev0814C=lwcdev0814
    lwcdev0815C=lwcdev0815
    
    save,lwcmean0710C,lwcmean0725C,lwcmean0727C,lwcmean0728C,lwcmean0729C,lwcmean0803C,lwcmean0807C,lwcmean0814C,lwcmean0815C,lwcdev0710C,lwcdev0725C,lwcdev0727C,$
    lwcdev0728C,lwcdev0729C,lwcdev0803C,lwcdev0807C,lwcdev0814C,lwcdev0815C,filename='kAsLwcMeansCB'
  endif    
  if runcalc eq 1 then stop
  if runcalc eq 2 then stop


  if runcalc eq 0 then restore, 'kAsLwcMeansBB',/verbose
  if runcalc eq 0 then restore, 'kAsLwcMeansCB',/verbose

  callevel=['07/10/13','07/25/13','07/27/13','07/28/13','07/29/13','08/03/13','08/07/13','08/14/13','08/15/13']
  holder=dindgen(n_elements(callevel),start=0,increment=1)
  kmeans=[lwcmean0710,lwcmean0725,lwcmean0727,lwcmean0728,lwcmean0729,lwcmean0803,lwcmean0807,lwcmean0814,lwcmean0815]
  devs=[lwcdev0710,lwcdev0725,lwcdev0727,lwcdev0728,lwcdev0729,lwcdev0803,lwcdev0807,lwcdev0814,lwcdev0815]

  plot1=scatterplot(holder,kmeans,dimensions=[1200,900], name='',sym_filled=0,sym_thick=3)
  ;plot1.xrange=[0,10]
  ;plot1.yrange=[40,150]
  plot1.xtickname=callevel
  plot1.sym_filled=1
  plot1.font_size=16
  plot1.title='All Flights Clear Air LWC Mean Error - No Pressure Correction'
  plot1.ytitle='Absolute Mean LWC Error g m!U-3!N'
  plot1.xtitle='Flight Day'
  plot1.yrange=[-0.005,0.015]

  ;leg1=legend(target=[plot1,plot2],shadow=0)

  plot2=errorplot(holder,kmeans, devs,/overplot,linestyle=6,errorbar_thick=2)

  plot2.xTICKVALUES=[0,1,2,3,4,5,6,7,8,9]
  plot2.xrange=[-1,9]
  plot2.xminor=0

  plot2.Save,'meanpreserrosBB.ps'
  
  
  
  
  
  callevel=['07/10/13','07/25/13','07/27/13','07/28/13','07/29/13','08/03/13','08/07/13','08/14/13','08/15/13']
  holder=dindgen(n_elements(callevel),start=0,increment=1)
  kmeans=[lwcmean0710C,lwcmean0725C,lwcmean0727C,lwcmean0728C,lwcmean0729C,lwcmean0803C,lwcmean0807C,lwcmean0814C,lwcmean0815C]
  devs=[lwcdev0710C,lwcdev0725C,lwcdev0727C,lwcdev0728C,lwcdev0729C,lwcdev0803C,lwcdev0807C,lwcdev0814C,lwcdev0815C]

  plot2=scatterplot(holder,kmeans,dimensions=[1200,900], name='',sym_color='black',sym_filled=1,sym_thick=3)
  ;plot2.xrange=[0,10]
  ;plot2.yrange=[40,150]
  plot2.xtickname=callevel
  plot2.sym_filled=0
  plot2.font_size=16
  plot2.title='All Flights Clear Air LWC Mean Error - With Pressure Correction'
  plot2.ytitle='Absolute Mean LWC Error g m!U-3!N'
  plot2.xtitle='Flight Day'
  plot2.yrange=[-0.005,0.015]

  ;leg1=legend(target=[plot1,plot2],shadow=0)

  plot3=errorplot(holder,kmeans, devs,linestyle=6,/overplot,errorbar_color='black',errorbar_thick=2)

  plot3.xTICKVALUES=[0,1,2,3,4,5,6,7,8,9]
  plot3.xrange=[-1,9]
  plot3.xminor=0

  plot3.Save,'meanpreserrosC.ps'



  ;  presHeadersa=['Flight Day','900 mb','','','600 mb','','','400mb','','']
  ;  presHeadersb=['Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error','Slope','Intercept','Abs Mean Error']
  ;
  ;  write_csv,'kAsIndComp.csv',column,header=presHeadersa
  ;  errorComp, column
  stop
  return

end