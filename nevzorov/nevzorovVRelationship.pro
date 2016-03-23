pro nevzorovVRelationship

;airspeed type (true, indicated)
airspeedType='indicated'

;select flight level (900,600,400)
flightLevel='900'

;select plots
genplots='airspeedCon'

;select sensor (liquid, total)
sensor='liquid'

findRange='true'

;select regression (linear, geometric)
regression='geometric'

;path to ncl file
;nclPath='/Volumes/sfaber1/research/nevzorov/121715/20151217.c1.nc'
nclPath='/Volumes/sfaber1/research/nevzorov/data/070913/20130709.c1.nc'



;-----run loadvar-----


  ;liquid reference voltage [V]
  vlwcref=loadvar('vlwcref', filename=nclPath)
  
  ;liquid collector voltage [V]
  vlwccol=loadvar('vlwccol', filename=nclPath)
  
  ;total reference voltage [V]
  vtwcref=loadvar('vtwcref', filename=nclPath)
  
  ;total collector voltage [V]
  vtwccol=loadvar('vtwccol', filename=nclPath)
  
  ;liquid reference current [A]
  ilwcref=loadvar('ilwcref', filename=nclPath)
  
  ;liquid collector current [A]
  ilwccol=loadvar('ilwccol', filename=nclPath)
  
  ;total reference current [A]
  itwcref=loadvar('itwcref', filename=nclPath)
  
  ;total collector current [A]
  itwccol=loadvar('itwccol', filename=nclPath)
  
  
  
  
  ;-------------------FOR TOTK----------------------
  ;liquid reference voltage [V]
  vlwcref=loadvar('vtwcref', filename=nclPath)

  ;liquid collector voltage [V]
  vlwccol=loadvar('vtwccol', filename=nclPath)

  ;liquid reference current [A]
  ilwcref=loadvar('itwcref', filename=nclPath)

  ;liquid collector current [A]
  ilwccol=loadvar('itwccol', filename=nclPath)
  ;-------------------FOR TOTK----------------------
  
  
  
  
  
  
  ;reverse flow static temperature [C]
  trf=loadvar('trf', filename=nclPath)
  
  ;true airspeed [m/s]
  tas=loadvar('tas', filename=nclPath)
  
  ;indicated airspeed [K]
  aias=loadvar('aias', filename=nclPath)
  
  ;altitude (radar) [m]
  altRad=loadvar('ralt3', filename=nclPath)
  
  ;time formatted
  timeForm=loadvar('TIME', filename=nclPath)
  
  ;time seconds since 2015-01-01 00:00:00 +0000
  time=loadvar('time', filename=nclPath)
  
  ;h20 mixing ratio from licor
  mix=loadvar('mr', filename=nclPath)
  
  ;pressure from rosemount sensor [mb]
  pmb=loadvar('pmb', filename=nclPath)
  
  ;temperature from rosemount sensor [C]
  tempRose=loadvar('trose', filename=nclPath)
  
  ;pressure derived altitude [m]
  altP=loadvar('z', filename=nclPath)

  aiasMs=aias*.514444
  

  
  if airspeedType eq 'true' then begin
    as=tas
  endif
  
  if airspeedType eq 'indicated' then begin
    as=aiasMs
  endif

;unit vector for regression line
unitVector=dindgen(n_elements(time), start=0, increment=1)

airspeeds=dindgen(101, start=110, increment=1)
airspeeds=airspeeds*.514444

pres900=dindgen(n_elements(airspeeds), start=906.686, increment=0.)
pres600=dindgen(n_elements(airspeeds), start=618.583, increment=0.)
pres400=dindgen(n_elements(airspeeds), start=409.319, increment=0.)


;----------calculations------------

;--find start/end time indexes--



  
  ;-----For 900mb 070913 case-----
  ;airspeed A
  aStartA=where(timeForm eq 120200)
  aEndA=where(timeForm eq 120435)
  
  ;airspeed B
  bStartA=where(timeForm eq 115833)
  bEndA=where(timeForm eq 120030)
  
  ;airspeed C
  cStartA=where(timeForm eq 115540)
  cEndA=where(timeForm eq 115800)
  
  ;airspeed D
  dStartA=where(timeForm eq 115228)
  dEndA=where(timeForm eq 115507)
  
  ;airspeed E
  eStartA=where(timeForm eq 114652)
  eEndA=where(timeForm eq 114920)







  ;-----For 600mb 070913 case------
  ;airspeed A
  aStartB=where(timeForm eq 113655)
  aEndB=where(timeForm eq 113859)
  
  ;airspeed B
  bStartB=where(timeForm eq 113438)
  bEndB=where(timeForm eq 113559)
  
  ;airspeed C
  cStartB=where(timeForm eq 113116)
  cEndB=where(timeForm eq 113259)
  
  ;airspeed D
  dStartB=where(timeForm eq 112837)
  dEndB=where(timeForm eq 113059)
  
  ;airspeed E
  eStartB=where(timeForm eq 112528)
  eEndB=where(timeForm eq 112659)






  ;-----For 400mb 070913 case 1047-1118------
  ;airspeed A
  aStartC=where(timeForm eq 105000)
  aEndC=where(timeForm eq 105120)
  
  ;airspeed B
  bStartC=where(timeForm eq 104740)
  bEndC=where(timeForm eq 104915)

  ;airspeed C
  cStartC=where(timeForm eq 105258)
  cEndC=where(timeForm eq 105455)

  ;airspeed D
  dStartC=where(timeForm eq 105530)
  dEndC=where(timeForm eq 105640)

  ;airspeed E
  eStartC=where(timeForm eq 110230)
  eEndC=where(timeForm eq 110400)





if flightLevel eq '900' then begin
  aStart=aStartA
  aEnd=aEndA
  bStart=bStartA
  bEnd=bEndA
  cStart=cStartA
  cEnd=cEndA
  dStart=dStartA
  dEnd=dEndA
  eStart=eStartA
  eEnd=eEndA
endif  

if flightLevel eq '600' then begin
  aStart=aStartB
  aEnd=aEndB
  bStart=bStartB
  bEnd=bEndB
  cStart=cStartB
  cEnd=cEndB
  dStart=dStartB
  dEnd=dEndB
  eStart=eStartB
  eEnd=eEndB
endif

if flightLevel eq '400' then begin
  aStart=aStartC
  aEnd=aEndC
  bStart=bStartC
  bEnd=bEndC
  cStart=cStartC
  cEnd=cEndC
  dStart=dStartC
  dEnd=dEndC
  eStart=eStartC
  eEnd=eEndC
endif
  

;redefine variables for twc

vlwccol=vtwccol
ilwccol=itwccol
vlwcref=vtwcref
vlwcref=vtwcref

;power calculations
liqColPower=vlwccol*ilwccol
liqRefPower=vlwcref*ilwcref
liqK=liqColPower/liqRefPower

totalColPower=vtwccol*itwccol
totalRefPower=vtwcref*itwcref
totalK=totalColPower/totalRefPower



;--define data ranges--

;airspeed A
liqKA=liqk[aStart:aEnd]
liqKAMean=mean(liqKA)
totalKA=totalk[aStart:aEnd]
totalKAMean=mean(totalKA)
asA=as[aStart:aEnd]
timeFormA=timeForm[aStart:aEnd]
asAMean=mean(asA)
pA=pmb[aStart:aEnd]
pAMean=mean(pA)


;airspeed B
liqKB=liqk[bStart:bEnd]
liqKBMean=mean(liqKB)
totalKB=totalk[bStart:bEnd]
totalKBMean=mean(totalKB)
asB=as[bStart:bEnd]
timeFormB=timeForm[bStart:bEnd]
asBMean=mean(asB)
pB=pmb[bStart:bEnd]
pBMean=mean(pB)

;airspeed C
liqKC=liqk[cStart:cEnd]
liqKCMean=mean(liqKC)
totalKC=totalk[cStart:cEnd]
totalKCMean=mean(totalKC)
asC=as[cStart:cEnd]
timeFormC=timeForm[cStart:cEnd]
asCMean=mean(asC)
pC=pmb[cStart:cEnd]
pCMean=mean(pC)

;airspeed D
liqKD=liqk[dStart:dEnd]
liqKDMean=mean(liqKD)
totalKD=totalk[dStart:dEnd]
totalKDMean=mean(totalKD)
asD=as[dStart:dEnd]
timeFormD=timeForm[dStart:dEnd]
asDMean=mean(asD)
pD=pmb[dStart:dEnd]
pDMean=mean(pD)

;airspeed E
liqKE=liqk[eStart:eEnd]
liqKEMean=mean(liqKE)
totalKE=totalk[eStart:eEnd]
totalKEMean=mean(totalKE)
asE=as[eStart:eEnd]
timeFormE=timeForm[eStart:eEnd]
asEMean=mean(asE)
pE=pmb[eStart:eEnd]
pEMean=mean(pE)

;combined sampled liqK values
liqKCon=[liqKA,liqKB,liqKC,liqKD,liqKE]
totalKCon=[totalKA,totalKB,totalKC,totalKD,totalKE]
asCon=[asA,asB,asC,asD,asE]
pCon=[pA,pB,pC,pD,pE]

liqKConMean=[liqKAMean,liqKBMean,liqKCMean,liqKDMean,liqKEMean]
totalKConMean=[totalKAMean,totalKBMean,totalKCMean,totalKDMean,totalKEMean]
asConMean=[asAMean,asBMean,asCMean,asDMean,asEMean]
pConMean=[pAMean,pBMean,pCMean,pDMean,pEmean]
pConMeanAll=mean(pConMean)



if findRange eq 'true' then begin
  
  
  ;--CACLULATE X RANGE--
  xAllA=[as[aStartA:aEndA],as[bStartA:bEndA],as[cStartA:cEndA],as[dStartA:dEndA],as[eStartA:eEndA]]    
  xAllB=[as[aStartB:aEndB],as[bStartB:bEndB],as[cStartB:cEndB],as[dStartB:dEndB],as[eStartB:eEndB]]
  xAllC=[as[aStartC:aEndC],as[bStartC:bEndC],as[cStartC:cEndC],as[dStartC:dEndC],as[eStartC:eEndC]]      
  
  xRangeA=max(xAllA)-min(xAllA)
  xRangeB=max(xAllB)-min(xAllB)
  xRangeC=max(xAllC)-min(xAllC)
  
   xMaxAll=max([xAllA,xAllB,xAllC])
   xMinAll=min([xAllA,xAllB,xAllC])
;  
;  xConRange=max(asCon)-min(asCon)
;  xMarg=(xRangeAll-xConRange)/2.
  
  xLeft=xMinAll-10.
  xRight=xMaxAll+10.
  
  
  
  ;--CACLULATE Y RANGE--
  liqColPowerA=[vlwccol[aStartA:aEndA]*ilwccol[aStartA:aEndA],vlwccol[bStartA:bEndA]*ilwccol[bStartA:bEndA],vlwccol[cStartA:cEndA]*ilwccol[cStartA:cEndA],vlwccol[dStartA:dEndA]*ilwccol[dStartA:dEndA],vlwccol[eStartA:eEndA]*ilwccol[eStartA:eEndA]]
  liqColPowerB=[vlwccol[aStartB:aEndB]*ilwccol[aStartB:aEndB],vlwccol[bStartB:bEndB]*ilwccol[bStartB:bEndB],vlwccol[cStartB:cEndB]*ilwccol[cStartB:cEndB],vlwccol[dStartB:dEndB]*ilwccol[dStartB:dEndB],vlwccol[eStartB:eEndB]*ilwccol[eStartB:eEndB]]
  liqColPowerC=[vlwccol[aStartC:aEndC]*ilwccol[aStartC:aEndC],vlwccol[bStartC:bEndC]*ilwccol[bStartC:bEndC],vlwccol[cStartC:cEndC]*ilwccol[cStartC:cEndC],vlwccol[dStartC:dEndC]*ilwccol[dStartC:dEndC],vlwccol[eStartC:eEndC]*ilwccol[eStartC:eEndC]]
  
  liqRefPowerA=[vlwcref[aStartA:aEndA]*ilwcref[aStartA:aEndA],vlwcref[bStartA:bEndA]*ilwcref[bStartA:bEndA],vlwcref[cStartA:cEndA]*ilwcref[cStartA:cEndA],vlwcref[dStartA:dEndA]*ilwcref[dStartA:dEndA],vlwcref[eStartA:eEndA]*ilwcref[eStartA:eEndA]]
  liqRefPowerB=[vlwcref[aStartB:aEndB]*ilwcref[aStartB:aEndB],vlwcref[bStartB:bEndB]*ilwcref[bStartB:bEndB],vlwcref[cStartB:cEndB]*ilwcref[cStartB:cEndB],vlwcref[dStartB:dEndB]*ilwcref[dStartB:dEndB],vlwcref[eStartB:eEndB]*ilwcref[eStartB:eEndB]]
  liqRefPowerC=[vlwcref[aStartC:aEndC]*ilwcref[aStartC:aEndC],vlwcref[bStartC:bEndC]*ilwcref[bStartC:bEndC],vlwcref[cStartC:cEndC]*ilwcref[cStartC:cEndC],vlwcref[dStartC:dEndC]*ilwcref[dStartC:dEndC],vlwcref[eStartC:eEndC]*ilwcref[eStartC:eEndC]]
 
  liqkAY=liqColPowerA/liqRefPowerA
  liqkBY=liqColPowerB/liqRefPowerB
  liqkCY=liqColPowerC/liqRefPowerC

  yRangeA=max(liqkAY)-min(liqkAY)
  yRangeB=max(liqkBY)-min(liqkBY)
  yRangeC=max(liqkCY)-min(liqkCY)

  yMaxAll=max([liqkAY,liqkBY,liqkCY])
  yMinAll=min([liqkAY,liqkBY,liqkCY])
;
;  yConRange=max(liqKCon)-min(liqKCon)
;  yMarg=(yRangeAll-yConRange)/2.

  yLow=yMinAll-.02
  yHigh=yMaxAll+.02

        
        
  
endif




;-----------gen plots-----------



if genplots eq 'airspeedCon' then begin
    
    
    
  if sensor eq 'liquid' then begin

      plot1=scatterplot(asA,liqKA,symbol='o',sym_size='.6',name=string(asAMean),sym_fill_color='black',dimensions=[1200,900])
      plot2=scatterplot(asB,liqKB,symbol='o',sym_size='.6',name=string(asBMean),sym_color='blue',sym_fill_color='blue',/overplot)
      plot3=scatterplot(asC,liqKC,symbol='o',sym_size='.6',name=string(asCMean),sym_color='dark slate grey',sym_fill_color='dark slate grey',/overplot)
      plot4=scatterplot(asD,liqKD,symbol='o',sym_size='.6',name=string(asDMean),sym_color='green',sym_fill_color='green',/overplot)
      plot5=scatterplot(asE,liqKE,symbol='o',sym_size='.6',name=string(asEMean),sym_color='light sea green',sym_fill_color='light sea green',/overplot)
      legend1=legend(target=[plot1,plot2,plot3,plot4,plot5],shadow=0)
      
      atitle=string('Liquid K vs ',airspeedType,' Airspeed -',pConMeanAll)
      xtitle=string(airspeedType+' Airspeed [m/s]')
      plot1.title=atitle
      plot1.xtitle=xtitle
      
      if regression eq 'linear' then begin
        plot1Linfit=linfit(asCon,liqKCon,yfit=yfit)
        regLine=(plot1linfit[1])*unitVector+plot1LinFit[0]
        plot1b=plot(unitVector,regLine,'r',/overplot)
        
        text1=string(plot1Linfit)
        text1A=text(50,10,text1,/device)
        
        yFitErrorMean=mean(abs(liqKCon-yFit))
        text2=string('Mean Y Fit Error=',yFitErrorMean)
        text2a=text(250,10,text2,/device)
      endif
      
      
      if regression eq 'geometric' then begin
        ;geoFit=comfit(asCon,liqKCon,[1,-.00289,1.4095],yfit=yfit,/geometric)
        ;geoFit=comfit(asCon,liqKCon,[511.5,-1.29,1.48],yfit=yfit,/geometric) ;400 indicated
        geofitb=poly_fit(asCon,liqKCon,2)
        geoFit=comfit(asCon,liqKCon,[geofitb[0],.2,geofitb[2]],yfit=yfit,/geometric,itmax=4000,iter=its) ;400 true        
        ;geoFit=comfit(asCon,liqKCon,[2.5,-.19,-2.48],yfit=yfit,/geometric) ;600 indicated
        ;geoFit=comfit(asCon,liqKCon,[2.5,-.19,-2.48],yfit=yfit,/geometric) ;600 true
        ;geoFit=comfit(asCon,liqKCon,[1.5,-.99,-1.48],yfit=yfit,/geometric) ;900 indicated
        ;geoFit=comfit(asCon,liqKCon,[1.5,-.59,-8.48],yfit=yfit,/geometric) ;900 true
        regLine=(geoFit[0])*unitVector^geoFit[1]+geoFit[2]
        ;regLine=(geoFit[0])+unitVector*(geoFit[1])+(geoFit[2])*unitVector^2.
        plot1b=plot(unitVector,regLine,'r',/overplot)
        print, its
;        text1=string(geoFit)
;        text1A=text(50,10,text1,/device)
        
;        yFitErrorMean=mean(abs(liqKCon-yFit))
;        text2=string('Mean Y Fit Error=',yFitErrorMean)
;        text2a=text(250,10,text2,/device)
        print,geoFit
      endif
      
      plot1.xrange=[xLeft,xRight]
      plot1.yrange=[yLow,yHigh]
      
    
    plot1.ytitle='Liquid K'
   
    endif
    

endif  







;if genplots eq 'airspeedCon' then begin
;
;
;
;  if sensor eq 'liquid' then begin
;
;    plot1=scatterplot(asA,liqKA,symbol='o',sym_size='.6',name=string(asAMean),sym_fill_color='black',dimensions=[1200,900])
;    plot2=scatterplot(asB,liqKB,symbol='o',sym_size='.6',name=string(asBMean),sym_color='blue',sym_fill_color='blue',/overplot)
;    plot3=scatterplot(asC,liqKC,symbol='o',sym_size='.6',name=string(asCMean),sym_color='dark slate grey',sym_fill_color='dark slate grey',/overplot)
;    plot4=scatterplot(asD,liqKD,symbol='o',sym_size='.6',name=string(asDMean),sym_color='green',sym_fill_color='green',/overplot)
;    plot5=scatterplot(asE,liqKE,symbol='o',sym_size='.6',name=string(asEMean),sym_color='light sea green',sym_fill_color='light sea green',/overplot)
;    legend1=legend(target=[plot1,plot2,plot3,plot4,plot5],shadow=0)
;
;    atitle=string('Liquid K vs ',airspeedType,' Airspeed -',pConMeanAll)
;    xtitle=string(airspeedType+' Airspeed [m/s]')
;    plot1.title=atitle
;    plot1.xtitle=xtitle
;
;    if regression eq 'linear' then begin
;      plot1Linfit=linfit(asCon,liqKCon,yfit=yfit)
;      regLine=(plot1linfit[1])*unitVector+plot1LinFit[0]
;      plot1b=plot(unitVector,regLine,'r',/overplot)
;
;      text1=string(plot1Linfit)
;      text1A=text(50,10,text1,/device)
;
;      yFitErrorMean=mean(abs(liqKCon-yFit))
;      text2=string('Mean Y Fit Error=',yFitErrorMean)
;      text2a=text(250,10,text2,/device)
;    endif
;
;
;    if regression eq 'geometric' then begin
;      ;geoFit=comfit(asCon,liqKCon,[1,-.00289,1.4095],yfit=yfit,/geometric)
;      ;geoFit=comfit(asCon,liqKCon,[511.5,-1.29,1.48],yfit=yfit,/geometric) ;400 indicated
;      geoFit=comfit(asCon,liqKCon,[150.5,-1.89,2.48],yfit=yfit,/geometric) ;400 true
;      ;geoFit=comfit(asCon,liqKCon,[2.5,-.19,-2.48],yfit=yfit,/geometric) ;600 indicated
;      ;geoFit=comfit(asCon,liqKCon,[2.5,-.19,-2.48],yfit=yfit,/geometric) ;600 true
;      ;geoFit=comfit(asCon,liqKCon,[1.5,-.99,-1.48],yfit=yfit,/geometric) ;900 indicated
;      ;geoFit=comfit(asCon,liqKCon,[1.5,-.59,-8.48],yfit=yfit,/geometric) ;900 true
;      regLine=(geoFit[0])*unitVector^geoFit[1]+geoFit[2]
;      plot1b=plot(unitVector,regLine,'r',/overplot)
;
;      text1=string(geoFit)
;      text1A=text(50,10,text1,/device)
;
;      yFitErrorMean=mean(abs(liqKCon-yFit))
;      text2=string('Mean Y Fit Error=',yFitErrorMean)
;      text2a=text(250,10,text2,/device)
;    endif
;
;    plot1.xrange=[xLeft,xRight]
;    plot1.yrange=[yLow,yHigh]
;
;
;    plot1.ytitle='Liquid K'
;
;  endif


;endif






if (genplots eq 'regCon') and (regression eq 'geometric') then begin

  
  if airspeedtype eq 'indicated' then begin
    reg400=(33.5115)*airspeeds^(-1.24087)+(1.03081)
    reg600=(3.73599)*airspeeds^(-0.0628865)+(-1.67763)
    reg900=(2.49407)*airspeeds^(-0.284605)+(0.427621)
  endif 
  
  if airspeedtype eq 'true' then begin
    reg400=(1280.56)*airspeeds^(-2.00624)+(1.08139)
    reg600=(3.91644)*airspeeds^(-0.0685396)+(-1.70073)
    reg900=(3.69374)*airspeeds^(-0.460247)+(0.664409)
  endif 
  
  
  plot1=plot(airspeeds,reg900,name='900mb',dimensions=[1200,900])
  plot2=plot(airspeeds,reg600,name='600mb',color='blue',/overplot)
  plot3=plot(airspeeds,reg400,name='400mb',color='red',/overplot)
  
  leg1=legend(target=[plot1,plot2,plot3])
  
endif




if (genplots eq 'presDep')  then begin

  if airspeedtype eq 'indicated' then begin
    reg400=(33.5115)*airspeeds^(-1.24087)+(1.03081)
    reg600=(3.73599)*airspeeds^(-0.0628865)+(-1.67763)
    reg900=(2.49407)*airspeeds^(-0.284605)+(0.427621)
  endif

  if airspeedtype eq 'true' then begin
    reg400=(1280.56)*airspeeds^(-2.00624)+(1.08139)
    reg600=(3.91644)*airspeeds^(-0.0685396)+(-1.70073)
    reg900=(3.69374)*airspeeds^(-0.460247)+(0.664409)
  endif

  
  liqKCon900=[liqK[aStartA:aEndA],liqK[bStartA:bEndA],liqK[cStartA:cEndA],liqK[dStartA:dEndA],liqK[eStartA:eEndA]]
  liqKCon600=[liqK[aStartB:aEndB],liqK[bStartB:bEndB],liqK[cStartB:cEndB],liqK[dStartB:dEndB],liqK[eStartB:eEndB]]
  liqKCon400=[liqK[aStartC:aEndC],liqK[bStartC:bEndC],liqK[cStartC:cEndC],liqK[dStartC:dEndC],liqK[eStartC:eEndC]]
  
  asCon900=[as[aStartA:aEndA],as[bStartA:bEndA],as[cStartA:cEndA],as[dStartA:dEndA],as[eStartA:eEndA]]
  asCon600=[as[aStartB:aEndB],as[bStartB:bEndB],as[cStartB:cEndB],as[dStartB:dEndB],as[eStartB:eEndB]]
  asCon400=[as[aStartC:aEndC],as[bStartC:bEndC],as[cStartC:cEndC],as[dStartC:dEndC],as[eStartC:eEndC]]
  
  presCon900=[pmb[aStartA:aEndA],pmb[bStartA:bEndA],pmb[cStartA:cEndA],pmb[dStartA:dEndA],pmb[eStartA:eEndA]]
  presCon600=[pmb[aStartB:aEndB],pmb[bStartB:bEndB],pmb[cStartB:cEndB],pmb[dStartB:dEndB],pmb[eStartB:eEndB]]
  presCon400=[pmb[aStartC:aEndC],pmb[bStartC:bEndC],pmb[cStartC:cEndC],pmb[dStartC:dEndC],pmb[eStartC:eEndC]]

  liqKCon900Cor=(1./(2.49407))*(asCon900)^(0.284605)
  liqKCon900CorD=(2.49407)*(asCon900)^(-0.284605)+(0.427621)
  liqKCon900CorB=liqKCon900-liqKCon900CorD
  liqKCon900CorC=liqKCon900CorB+liqKCon900CorD

  plot1=scatterplot(presCon900,liqKCon900,symbol='o',sym_size='.6',name=string(asAMean),sym_fill_color='black',dimensions=[1200,900])
  plot2=scatterplot(presCon600,liqKCon600,symbol='o',sym_size='.6',name=string(asBMean),sym_color='blue',sym_fill_color='blue',/overplot)
  plot3=scatterplot(presCon400,liqKCon400,symbol='o',sym_size='.6',name=string(asCMean),sym_color='dark slate grey',sym_fill_color='dark slate grey',/overplot)
  legend1=legend(target=[plot1,plot2,plot3,plot4,plot5],shadow=0)


  
;  plot1.xrange=[300,1000]
;  plot1.yrange=[1.05,1.3]

  ;leg1=legend(target=[plot1,plot2,plot3])
  ;unitVector=dindgen(921.-895.,start=895.,increment=1.)
  
  geoFit=linfit(pmb[aStart:aEnd],liqK[aStart:aEnd])
  regLine=(geoFit[1])*unitVector+(geoFit[0])
  ;geoFit=comfit(pmb,liqK,[1.5,-.29,1.28],yfit=yfit,/geometric) ;400 indicated
  ;regLine=(geoFit[0])*unitVector^(geoFit[1])+(geoFit[0])
  plot1b=plot(unitVector,regLine,'r',/overplot)

  text1=string(geoFit)
  text1A=text(50,10,text1,/device)
stop
endif



if (genplots eq 'presDepB')  then begin

;  if airspeedtype eq 'indicated' then begin
;    reg400=(33.5115)*airspeeds^(-1.24087)+(1.03081)
;    reg600=(3.73599)*airspeeds^(-0.0628865)+(-1.67763)
;    reg900=(2.49407)*airspeeds^(-0.284605)+(0.427621)
;  endif
;
;  if airspeedtype eq 'true' then begin
;    reg400=(1280.56)*airspeeds^(-2.00624)+(1.08139)
;    reg600=(3.91644)*airspeeds^(-0.0685396)+(-1.70073)
;    reg900=(3.69374)*airspeeds^(-0.460247)+(0.664409)
;  endif


  liqKCon900=[liqK[aStartA:aEndA],liqK[bStartA:bEndA],liqK[cStartA:cEndA],liqK[dStartA:dEndA],liqK[eStartA:eEndA]]
  liqKCon600=[liqK[aStartB:aEndB],liqK[bStartB:bEndB],liqK[cStartB:cEndB],liqK[dStartB:dEndB],liqK[eStartB:eEndB]]
  liqKCon400=[liqK[aStartC:aEndC],liqK[bStartC:bEndC],liqK[cStartC:cEndC],liqK[dStartC:dEndC],liqK[eStartC:eEndC]]

  asCon900=[as[aStartA:aEndA],as[bStartA:bEndA],as[cStartA:cEndA],as[dStartA:dEndA],as[eStartA:eEndA]]
  asCon600=[as[aStartB:aEndB],as[bStartB:bEndB],as[cStartB:cEndB],as[dStartB:dEndB],as[eStartB:eEndB]]
  asCon400=[as[aStartC:aEndC],as[bStartC:bEndC],as[cStartC:cEndC],as[dStartC:dEndC],as[eStartC:eEndC]]

  presCon900=[pmb[aStartA:aEndA],pmb[bStartA:bEndA],pmb[cStartA:cEndA],pmb[dStartA:dEndA],pmb[eStartA:eEndA]]
  presCon600=[pmb[aStartB:aEndB],pmb[bStartB:bEndB],pmb[cStartB:cEndB],pmb[dStartB:dEndB],pmb[eStartB:eEndB]]
  presCon400=[pmb[aStartC:aEndC],pmb[bStartC:bEndC],pmb[cStartC:cEndC],pmb[dStartC:dEndC],pmb[eStartC:eEndC]]
  presConAll=[presCon900,presCon600,presCon400]
  
  
  
  liqKCon900lt61I=where(asCon900 lt 61.)
  liqKCon900lt61=liqKCon900[liqKCon900lt61I]
  asCon900lt61=asCon900[liqKCon900lt61I]
  presCon900lt61=presCon900[liqKCon900lt61I]
  
  liqKCon600lt61I=where(asCon600 lt 61.)
  liqKCon600lt61=liqKCon600[liqKCon600lt61I]
  asCon600lt61=asCon600[liqKCon600lt61I]
  presCon600lt61=presCon600[liqKCon600lt61I]



;  plot1=scatterplot(asCon900,liqKCon900,symbol='o',sym_size='.6',name='900 mb',sym_fill_color='black',dimensions=[1200,900])
;  plot2=scatterplot(asCon600,liqKCon600,symbol='o',sym_size='.6',name='600 mb',sym_color='blue',sym_fill_color='blue',/overplot)
;  plot3=scatterplot(asCon400,liqKCon400,symbol='o',sym_size='.6',name='400 mb',sym_color='red',sym_fill_color='dark slate grey',/overplot)
;  legend1=legend(target=[plot1,plot2,plot3],shadow=0)
stop
plot1=scatterplot(asCon900Lt61,liqKCon900Lt61,symbol='o',sym_size='.6',name='900 mb',sym_fill_color='black',dimensions=[1200,900])
plot2=scatterplot(asCon600Lt61,liqKCon600Lt61,symbol='o',sym_size='.6',name='600 mb',sym_color='blue',sym_fill_color='blue',/overplot)
  
  atitle=string('Liquid K vs ',airspeedType,' Airspeed')
  plot1.title=aTitle
  
  xtitle=string(airspeedType,' Airspeed [m/s]')
  plot1.xtitle=xtitle
  
  plot1.ytitle='Liquid K'



    plot1.xrange=[xLeft,xRight]
    plot1.yrange=[yLow,yHigh]
  
  if airspeedType eq 'true' then begin
    geoFit400=comfit(asCon400,liqKCon400,[150.5,-1.89,2.48],yfit=yfit,/geometric) ;400 true
    geoFit600=comfit(asCon600,liqKCon600,[2.5,-.19,-2.48],yfit=yfit,/geometric) ;600 true
    geoFit900=comfit(asCon900,liqKCon900,[1.5,-.59,-8.48],yfit=yfit,/geometric) ;900 true
  endif
  
  if airspeedType eq 'indicated' then begin
;    geoFit400=comfit(asCon400,liqKCon400,[511.5,-1.29,1.48],yfit=yfit,/geometric) ;400 indicated
;    geoFit600=comfit(asCon600,liqKCon600,[2.5,-.19,-2.48],yfit=yfit,/geometric) ;600 indicated
;    geoFit900=comfit(asCon900,liqKCon900,[1.5,-.99,-1.48],yfit=yfit,/geometric) ;900 indicated
  endif

  
  regLine400=(geoFit400[0])*unitVector^(geoFit400[1])+(geoFit400[2])
  regLine600=(geoFit600[0])*unitVector^(geoFit600[1])+(geoFit600[2])
  regLine900=(geoFit900[0])*unitVector^(geoFit900[1])+(geoFit900[2])

  plot1b=plot(unitVector,regLine400,color='red',/overplot)
  plot1c=plot(unitVector,regLine600,color='blue',/overplot)
  plot1d=plot(unitVector,regLine900,color='black',/overplot)

  text1=string(geoFit900)
  text1A=text(50,10,text1,/device)
  text2=string(geoFit600)
  text2A=text(150,10,text2,/device)
  text3=string(geoFit400)
  text3A=text(250,10,text3,/device)
  stop
endif



if genPlots eq 'presConCor' then begin
  asCon900=[as[aStartA:aEndA],as[bStartA:bEndA],as[cStartA:cEndA],as[dStartA:dEndA],as[eStartA:eEndA]]
  asCon600=[as[aStartB:aEndB],as[bStartB:bEndB],as[cStartB:cEndB],as[dStartB:dEndB],as[eStartB:eEndB]]
  asCon400=[as[aStartC:aEndC],as[bStartC:bEndC],as[cStartC:cEndC],as[dStartC:dEndC],as[eStartC:eEndC]]

  presCon900=[pmb[aStartA:aEndA],pmb[bStartA:bEndA],pmb[cStartA:cEndA],pmb[dStartA:dEndA],pmb[eStartA:eEndA]]
  presCon600=[pmb[aStartB:aEndB],pmb[bStartB:bEndB],pmb[cStartB:cEndB],pmb[dStartB:dEndB],pmb[eStartB:eEndB]]
  presCon400=[pmb[aStartC:aEndC],pmb[bStartC:bEndC],pmb[cStartC:cEndC],pmb[dStartC:dEndC],pmb[eStartC:eEndC]]
  
  liqKCon900=[liqK[aStartA:aEndA],liqK[bStartA:bEndA],liqK[cStartA:cEndA],liqK[dStartA:dEndA],liqK[eStartA:eEndA]]
  liqKCon600=[liqK[aStartB:aEndB],liqK[bStartB:bEndB],liqK[cStartB:cEndB],liqK[dStartB:dEndB],liqK[eStartB:eEndB]]
  liqKCon400=[liqK[aStartC:aEndC],liqK[bStartC:bEndC],liqK[cStartC:cEndC],liqK[dStartC:dEndC],liqK[eStartC:eEndC]]
  
  asConAll=[asCon400,asCon600,asCon900]
  presConAll=[presCon400,presCon600,presCon900]
  liqKConAll=[liqKCon400,liqKCon600,liqKCon900]
  
;  liKConCor=(36.0089)*asConAll^(-1.26173)+(1.03362)
;  liqKConAll=liqKConAll-liKConCor
  
  unitVector=dindgen(600,start=400,increment=1)
  fit=comfit(presConall,liqKConAll,[-6.9e-2,.8,.4],/geometric)
  fitLine=fit[0]*unitVector^(fit[1])+fit[2]
  
  plot1=scatterplot(presConAll,liqKConAll)
  plot2=plot(unitVector,fitLine,/overplot,'r')
  stop
endif 
  





return

end