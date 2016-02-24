pro nevzorovWaterContent



  ;------OPTIONS------


  ;CASE (cope, december)
  flight='cope'

  ;PLOT (liqComp)
  genplot='pressureCorrection'
  
  airspeedType='indicated'
  
  level='400'
  
  flightDay='0728'



  ;-----RUN LOADVAR-----

  ;path to ncl file
  ;nclPath='/Volumes/sfaber1/research/nevzorov/121715/20151217.c1.nc'
  if flightDay eq '0709' then nclPath='/Volumes/sfaber1/research/nevzorov/070913/20130709.c1.nc'
  if flightDay eq '0710' then nclPath='/Volumes/sfaber1/research/nevzorov/20130710.c1.nc'
  if flightDay eq '0727' then nclPath='/Volumes/sfaber1/research/nevzorov/072713/20130727.c1.nc'
  if flightDay eq '0728' then nclPath='/Volumes/sfaber1/research/nevzorov/072813/20130728.c1.nc'
  if flightDay eq '0729' then nclPath='/Volumes/sfaber1/research/nevzorov/072913/20130729.c1.nc'
  if flightDay eq '0807' then nclPath='/Volumes/sfaber1/research/nevzorov/080713/20130807.c1.nc'
  if flightDay eq '0814' then nclPath='/Volumes/sfaber1/research/nevzorov/081413/20130814.c1.nc'
  ;nclPath='Z:\research\nevzorov\081413\20130814.c1.nc'
  
  
  

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

  ;reverse flow static temperature [C]
  trf=loadvar('trf', filename=nclPath)
  
  ;reverse flow static temperature [K]
  thetad=loadvar('thetad', filename=nclPath)
  
  ;reverse flow static temperature [K]
  thetae=loadvar('thetae', filename=nclPath)

  ;true airspeed [m/s]
  tas=loadvar('tas', filename=nclPath)

  ;indicated airspeed [knot]
  aias=loadvar('aias', filename=nclPath)

  ;altitude (radar) [m]
  ralt3=loadvar('ralt3', filename=nclPath)

  ;time formatted
  timeForm=loadvar('TIME', filename=nclPath)

  ;time seconds since 2015-01-01 00:00:00 +0000
  time=loadvar('time', filename=nclPath)

  ;h20 mixing ratio from licor
  mr=loadvar('mr', filename=nclPath)

  ;pressure from rosemount sensor [mb]
  pmb=loadvar('pmb', filename=nclPath)

  ;temperature from rosemount sensor [C]
  trose=loadvar('trose', filename=nclPath)

  ;pressure derived altitude [m]
  z=loadvar('z', filename=nclPath)
  
  ;liquid water content from Gerber probe [g/m^3]
  pvmlwc=loadvar('pvmlwc', filename=nclPath)
  
  ;liquid water content from lwc100 probe [g/m^3]
  lwc100=loadvar('lwc100', filename=nclPath)  
  
  ;liquid water content from CDP [g/m^3]
  cdpconc_NRB=loadvar('cdpconc_NRB', filename=nclPath)
  
  ;CDP accepted particles
  cdpacc=loadvar('cdpacc_NRB', filename=nclPath)
  
  ;CDP droplet mean diamter [um]
  cdpdbar_NRB=loadvar('cdpdbar_NRB', filename=nclPath)
  
  ;Pitch [degrees]
  avpitch=loadvar('avpitch', filename=nclPath)
  
  ;roll [degrees]
  avroll=loadvar('avroll', filename=nclPath)
  
  ;Vertical Speed [m/s]
  hivs=loadvar('hivs', filename=nclPath)
  
  ;Sideslip Angle [deg]
  betaB=loadvar('beta', filename=nclPath)
  
  ;Yaw [deg]
  avyawr=loadvar('avyawr', filename=nclPath)
  
  ;Attack Angle [rad]
  alpha=loadvar('alpha', filename=nclPath)

  if flight eq 'cope' then begin
    
    ;liquid water content from Nevzorov probe [g/m^3]
    lwcNev1=loadvar('nevlwc1', filename=nclPath)
    
    ;liquid water content from Nevzorov probe [g/m^3]
    lwcNev2=loadvar('nevlwc2', filename=nclPath)
    
    ;total water content from Nevzorov probe [g/m^3]
    twcNev=loadvar('nevtwc', filename=nclPath)
    
    lwcNevMean=(lwcNev1+lwcNev2)/2.
    
  endif
  
  
  
  
  time=time-min(time)
  
  
  ;-----DEFINE TIMES-----
  
  ;airspeed A
;  aStart=where(timeForm eq 130410)
;  aEnd=where(timeForm eq 130540)
;  aStart=where(timeForm eq 140500)
;  aEnd=where(timeForm eq 154700)
;  aStart=where(timeForm eq 141558)
;  aEnd=where(timeForm eq 142400)
;aStart=where(timeForm eq 152400)
;aEnd=where(timeForm eq 153800)




;----------080713----------

;;LWC COMPARE WITH CORRECTED COLLECTOR AREA
;aStart=where(timeForm eq 153500)
;aEnd=where(timeForm eq 153800)


if flightDay eq '0807' then begin
  ;ENTIRE FLIGHT
  aStart=where(timeForm eq 124100)
  aEnd=where(timeForm eq 155400)
endif


;;HIGH AMPLITUDE
;aStart=where(timeForm eq 151853)
;aEnd=where(timeForm eq 151937)

;;HIGH VARIATION
;aStart=where(timeForm eq 153058)
;aEnd=where(timeForm eq 154540)

;;ZERO HUMP
;aStart=where(timeForm eq 132100)
;aEnd=where(timeForm eq 140200)

;;BEGINNNIG GROUP
;aStart=where(timeForm eq 124307)
;aEnd=where(timeForm eq 124752)

;;400 METER ASCENT
;aStart=where(timeForm eq 130958)
;aEnd=where(timeForm eq 131840)




;----------081413----------


if flightDay eq '0814' then begin
;ENTIRE FLIGHT
  aStart=where(timeForm eq 115400)
  aEnd=where(timeForm eq 150200)
endif


;;LATE LEVEL FLIGHT
;aStart=where(timeForm eq 142206)
;aEnd=where(timeForm eq 144624)

;;LATE LEVEL FLIGHT ZOOMED
;aStart=where(timeForm eq 143506)
;aEnd=where(timeForm eq 144124)

;;LATE CLIMB
;aStart=where(timeForm eq 135153)
;aEnd=where(timeForm eq 135905)

;;GREATEST DIFF
;aStart=where(timeForm eq 134206)
;aEnd=where(timeForm eq 135224)

;;GREATEST DIFF ZOOMED
;aStart=where(timeForm eq 134230)
;aEnd=where(timeForm eq 134515)

;;BASELINE
;aStart=where(timeForm eq 123906)
;aEnd=where(timeForm eq 124524)

;;1200 METER DESCENT
;aStart=where(timeForm eq 132700)
;aEnd=where(timeForm eq 140000)

;;1200 METER DESCENT ZOOMED
;aStart=where(timeForm eq 132100)
;aEnd=where(timeForm eq 140800)

;;1200 METER DESCENT ZOOMED B
;aStart=where(timeForm eq 132718)
;aEnd=where(timeForm eq 133719)

;;MIDDLE
;aStart=where(timeForm eq 121906)
;aEnd=where(timeForm eq 125924)




;----------071013----------


if flightDay eq '0710' then begin
;ENTIRE FLIGHT
  aStart=where(timeForm eq 112600)
  aEnd=where(timeForm eq 141100)
endif




;----------072713----------


if flightDay eq '0727' then begin
;ENTIRE FLIGHT
  aStart=where(timeForm eq 115500)
  aEnd=where(timeForm eq 135600)
endif





;----------072813----------


if flightDay eq '0728' then begin
  ;ENTIRE FLIGHT
  aStart=where(timeForm eq 115800)
  aEnd=where(timeForm eq 150800)
endif






;----------072913----------


if flightDay eq '0729' then begin
  ;ENTIRE FLIGHT
  aStart=where(timeForm eq 115800)
  aEnd=where(timeForm eq 145900)
endif








titleTime=string(timeForm[aStart],timeForm[aEnd])



  ;-----CONSTANTS-----

  ;surface area liquid sensor [m^2]
  ;aLiq=4.78d-5 PROBABLY AN ERROR
  aLiq=3.28d-5

  ;surface area total sensor [m^2]
  aTot=5d-5

  ;liquid collection efficiency
  colELiq=1.

  ;total collection efficiency
  colETot=1.

  ;liquid water latent heat of vaporization at 100C [J/G]
  lLiq=2260.

  
  ;L* [J/G]
  ;lStar=2589.

  ;specific heat capacity of liquid water at 110 C [J/G K]
  ;cLiq=1.859
  cLiq=4.223
  
  if flight eq 'cope' then begin
    ;sensor temperature [C]
    sensorTemp=110.
  endif
  
  if flight eq 'december' then begin
    ;sensor temperature [C]
    sensorTemp=90.
  endif
  
  
  ;------CONVERSIONS-----
  
  ;CONVERT INDICATED AIRSPEED TO M/S
  aiasMs=aias*.514444
  
  ;CONVERT AIR TEMPERATURE TO KELVIN
  ;trf=trf+273.15
  
  
  
  
  ;-----CALCULATIONS-----  
 
  unitVector=dindgen(n_elements(time), start=0, increment=1)

  if airspeedType eq 'true' then begin
    as=tas
  endif

  if airspeedType eq 'indicated' then begin
    as=aiasMs
  endif
  
    
  if flight eq 'cope' then begin
    
    ;K LIQUID
    
if (airspeedType eq 'indicated') and (level eq '900') then kLiqAirspeed=(2.47292)*aiasMs^(-0.273777)+(0.399143) ;900 indicated
if (airspeedType eq 'indicated') and (level eq '600') then kLiqAirspeed=(3.73599)*aiasMs^(-0.0628865)+(-1.67763) ;600 indicated
if (airspeedType eq 'indicated') and (level eq '400') then kLiqAirspeed=(36.0089)*aiasMs^(-1.26173)+(1.03362) ;400 indicated
    
if (airspeedType eq 'true') and (level eq '900') then kLiqAirspeed=(8.56136)*tas^(-0.0292547)+(-6.37413) ;900 true
if (airspeedType eq 'true') and (level eq '600') then kLiqAirspeed=(3.91644)*tas^(-0.0685396)+(-1.70073) ;600 true
if (airspeedType eq 'true') and (level eq '400') then kLiqAirspeed=(1280.56)*tas^(-2.00624)+(1.08139) ;400 true
    
    ;TRUE AIRSPEED
    ;kLiqAirspeed=(-0.00235029)*tas+1.364895
    
    ;pmb=dindgen(701,start=300.,increment=1)
    
    ;PRESSURE DEPENDENCE
    ;kLiqPres=(-.000183979)*pmb+1.29452
    ;kLiqPres=(-.000483979)*pmb+1.60452
    ;kLiqPres=(-.000132173)*pmb+1.30020 ;second try
;    kLiqPres=(11.7037)*pmb^(-0.845077)+(1.10559)
;    kLiqPresCor=(11.7037)*pmb^(-0.845077)
;    kLiqPresLin=(-8.25223d-5)*pmb+(1.06693)
;    kLiqPresLinCor=(-8.25223d-5)*pmb
    ;kLiqPres=(-3.3131170e-07)*pmb+1.1762705
    ;kLiqPres=(-9.9568647020766289e-05)*pmb+0.073368215633053166
    
    ;kLiqPCorrect=(0.089513888229103458)*ilwccol-0.11384937325688001
    ;kLiqPres=(-0.0085146111)*pmb^(0.42503238)+0.141810842
    
    ;kLiqI=(0.017847091)*ilwccol^(2.3701003)-0.031947635
    
    ;kLiqPres=(-4.2204403e-5)*pmb+0.028384184
    
;    kLiqPres=(-0.081856377)*pmb^(0.17570545)+0.23416565
    ;kLiqPres=(-4.3304403132494147e-05)*pmb+0.028384183938775356
    ;kLiqPres=(-1.7759690e-05)*pmb+1.1888708
    ;kLiqPres=(-7.99769713e-05)*pmb+0.0541974281
    ;kLiqPres=(-4.4441645009364865e-05)*pmb-0.034576019778025775

    
    kLiq=kLiqAirspeed
    ;kLiq=kLiqPres
    ;kLiq=(((kLiqAirspeed)+(kLiqPres))/2.)
    ;kLiq=(((kLiqAirspeed*.755)+(kLiqPres*.245)))
    ;kLiq=(((kLiqAirspeed*.8106)+(kLiqPres*.1894))) ;second try
    ;kLiq=kLiqAirspeed*kLiqAirspeedWeight+kLiqPres*kLiqPresWeight


  endif  
  
  
  if flight eq 'december' then begin

    ;K LIQUID
    kLiq=(-0.00235029)*aiasMs+1.351925
    
  endif
  
  
  
  
  
    ;COLLECTION EFFICIENCY
;    dEff=cdpdbar_NRB
;    colELiq=(dEff^2)/(dEff^2+7.5^2)
;    
;    colELiqLength=n_elements(colELiq)-1
;    for i=0,colELiqLength do begin
;      if (colELiq[i] eq 0.) then begin
;        colELiq[i]=1.
;      endif
;    endfor
    
    
    ;HEAT LOSS LIQUID
    pLiq=vlwccol*ilwccol-kLiq*vlwcref*ilwcref
    ;pLiq=(vlwccol^2./3.485)-kLiq*(vlwcref^2./3.485)
    
    
    ;EXPANDED HEAT FOR LIQUID
    lLiqStar=((sensorTemp-trf)*cLiq)+lLiq
    
    
    ;WATER CONTENT LIQUID
    
    if airspeedType eq 'indicated' then begin
       lwc=pLiq/(colELiq*as*aLiq*lLiqStar)
       ;lwc=((-0.052528561596591056)*lwc-0.0010041680497463220)+lwc
    endif
    
    if airspeedType eq 'true' then begin
      lwc=pLiq/(colELiq*tas*aLiq*lLiqStar)
    endif
    
    
    
    ;DELTA PRESSURE
    pmbShift=shift(pmb,1)
    pmbDelta=pmb-pmbShift

    pmbLength=n_elements(pmb)-1
    for i=0,pmbLength do begin
      if (pmbDelta[i] gt 10) or (pmbDelta[i] lt -10) then begin
        pmbDelta[i]=0.
      endif
    endfor
    
    ;DELTA AIRSPEED
    tasShift=shift(tas,1)
    tasDelta=tas-tasShift

    tasLength=n_elements(tas)-1
    for i=0,tasLength do begin
      if (tasDelta[i] gt 100) or (tasDelta[i] lt -100) then begin
        tasDelta[i]=0.
      endif
    endfor
   
    
    
    
    ;HEAT LOSS TOTAL
    pTot=vtwccol*itwccol-kLiq*vtwcref*itwcref
    
    ;WATER CONTENT TOTAL *SWITCH BACK TO LLIQSTAR
    waterConTot=pLiq/(colETot*aiasMs*aTot*lLiqStar)
    
    lwcDiff=(lwcNev1[aStart:aEnd]-lwc[aStart:aEnd])
    lwcDiffAbs=abs(lwc[aStart:aEnd]-lwcNev1[aStart:aEnd])    
    lwcDiffAbsMean=mean(lwcDiffAbs)
    diffRatio=abs(lwcDiffAbs/lwcNev1)
    
    lwcDiffNev=lwcNev1[aStart:aEnd]-pvmlwc[aStart:aEnd]
    lwcDiffAbsNev=abs(lwcNev1[aStart:aEnd]-pvmlwc[aStart:aEnd])
    lwcDiffAbsNevMean=mean(lwcDiffAbsNev)

    
    lwcDiffCalc=lwc[aStart:aEnd]-pvmlwc[aStart:aEnd]
    lwcDiffAbsCalc=abs(lwc[aStart:aEnd]-pvmlwc[aStart:aEnd])
    lwcDiffAbsCalcMean=mean(lwcDiffAbsCalc)

    
    for i=0, n_elements(diffRatio)-1 do begin
      if diffRatio[i] gt 1 then begin
        diffRatio[i]=0.
      endif
    endfor
    
    waterConTotDiff=abs(waterConTot[aStart:aEnd]-twcNev[aStart:aEnd])
    
    
    
    
    
    
    if genplot eq 'pressureCorrection' then begin
      
      lwc=lwc[aStart:aEnd]
      aiasMs=aiasMs[aStart:aEnd]
      pmb=pmb[aStart:aEnd]
      avroll=avroll[aStart:aEnd]
      avpitch=avpitch[aStart:aEnd]
      avyawr=avyawr[aStart:aEnd]
      alpha=alpha[aStart:aEnd]
      betaB=betaB[aStart:aEnd]
      time=time[aStart:aEnd]
      
      aStart = aStart[0]
      aEnd = aEnd[0]
      
      aSpan = abs(aEnd - aStart)

      baselineNevI=dindgen(n_elements(pmb),start=0,increment=0)
      baselineI=dindgen(n_elements(pmb),start=0,increment=0)
      baselineIB=dindgen(n_elements(pmb),start=0,increment=0)
      baselineIC=dindgen(n_elements(pmb),start=0,increment=0)
      baselineID=dindgen(n_elements(pmb),start=0,increment=0)
      baselineRollI=dindgen(n_elements(pmb),start=0,increment=0)
      baselineAlphaI=dindgen(n_elements(pmb),start=0,increment=0)
      baselineBetaI=dindgen(n_elements(pmb),start=0,increment=0)
      baselineYawI=dindgen(n_elements(pmb),start=0,increment=0)
      baselineLwcI=dindgen(n_elements(pmb),start=0,increment=0)
      baselinePitchI=dindgen(n_elements(pmb),start=0,increment=0)


      for i=0, aSpan do begin
        ;if (abs(avRoll[i]) lt 3) then begin
        if (abs(avRoll[i]) lt 5) then begin
          baselineRollI[i]=1
        endif
      endfor
      
      for i=0, aSpan do begin
        if (avpitch[i] lt (mean(avpitch) + 2) and avpitch[i] gt (mean(avpitch) - 2)) then begin ;0871013
          ;if (avpitch[i] lt 4.1 and avpitch[i] gt 2.1) then begin ;081413
          ;if (avpitch[i] lt 4.1 and avpitch[i] gt 2.1) then begin ;080713
          ;if (avpitch[i] lt 4.4 and avpitch[i] gt 2.4) then begin ;072713
          baselinePitchI[i]=1
        endif
      endfor

      for i=0, aSpan do begin
        ;if (alpha[i] lt .088 and alpha[i] gt .072) then begin
        if (alpha[i] lt .092 and alpha[i] gt .068) then begin
          baselineAlphaI[i]=1
        endif
      endfor

      for i=0, aSpan do begin
        ;if (where(beta lt -.025 and alpha gt -.016)) then begin
        if (betaB[i] lt -.014 and betaB[i] gt -.026) then begin
          baselineBetaI[i]=1
        endif
      endfor

      for i=0, aSpan do begin
        ;if (where(avyawr gt -.008 and avyawr lt 0)) then begin
        if (abs(avyawr[i]) lt .003) then begin
          baselineYawI[i]=1
        endif
      endfor

      for i=0, aSpan do begin
        ;if (where(avyawr gt -.008 and avyawr lt 0)) then begin
        if (lwc[i] lt .05) then begin
          baselineLwcI[i]=1
        endif
      endfor





      for i=0, aSpan do begin
        if (baselineLwcI[i] eq 1) then begin
          baselineI[i]=1
        endif
      endfor

      for i=0, aSpan do begin
        if (baselineI[i] eq 1) and (baselineRollI[i] eq 1) and (baselinePitchI[i] eq 1) then begin
          baselineIB[i]=1
        endif
      endfor

      for i=0, aSpan do begin
        if (baselineI[i] eq 1) and (baselineRollI[i] eq 1) and (baselinePitchI[i] eq 0) then begin
          baselineIC[i]=1
        endif
      endfor
      
      for i=0, aSpan do begin
        if (baselineI[i] eq 0) then begin
          baselineID[i]=1
        endif
      endfor





      filteredTimes=where(baselineI eq 1)
      filteredTimesB=where(baselineIB eq 1)
      filteredTimesC=where(baselineIC eq 1)
      filteredTimesD=where(baselineID eq 1)


      plot1=scatterplot(pmb[filteredTimes],lwc[filteredTimes],symbol='+',sym_size=.45,dimensions=[1200,900],name='Clear Air Points')
      plot2=scatterplot(pmb[filteredTimesB],lwc[filteredTimesB],symbol='+',sym_size=.45,sym_color='red',/overplot, name='Level Clear Air Points')

      lin1Left=360
      lin1Right=1000



      lin1=linfit(pmb[filteredTimesB],lwc[filteredTimesB])
      linYLeft=(lin1[1])*(lin1Left)+lin1[0]
      linYRight=(lin1[1])*(lin1Right)+lin1[0]

      plot1lin=plot([lin1Left,lin1Right],[linYLeft,linYRight],/overplot,'r', name='Level Clear Air Point linfit', thick=2)
      
      
      lin2=linfit(pmb[filteredTimes],lwc[filteredTimes])
      linYLeftB=(lin2[1])*(lin1Left)+lin2[0]
      linYRightB=(lin2[1])*(lin1Right)+lin2[0]

      plot2lin=plot([lin1Left,lin1Right],[linYLeftB,linYRightB],/overplot, name='Level Clear Air Point linfit', thick=2)


      text1=string(lin1)
      text1a=text(300, 30, text1, color='red', /device)
      
      text2=string(lin2)
      text2a=text(100, 30, text2, /device)


      plot1.xrange=[lin1Left,lin1Right]
      plot1.yrange=[-.05,.05]

      plot1.title='Clear Air LWC (072913)'
      plot1.xtitle='Pressure [mb]'
      plot1.ytitle='LWC [g/m^3]'





      lwcPresCor=lwc - (lin1[1])*pmb - lin1[0]
      ;lwcPresCor = lwc - (-6.2109506625328127e-05)*pmb - 0.041931856322807132 ;Calculated from 0710


      lwcPresCorDiff = lwcnev1[aStart:aEnd] - lwcPresCor
      pLiq=pLiq[aStart:aEnd]
;      
;      
;      for i=filteredTimesD[0],filteredTimesD[n_elements(filteredTimesD)- 1] do begin
;          lwcPresCor[i] = lwcPresCor[i] + (0.010541877414818981)*pLiq[i] - 0.0057836465754114484 
;      endfor  
;      
;      lwcPLiqCorDiff = lwcnev1[aStart:aEnd] - lwcPresCor

      plot3=scatterplot(pmb[filteredTimes],lwc[filteredTimes],symbol='+',sym_size=.45,dimensions=[1200,900],name='No Correction')
      plot3b=scatterplot(pmb[filteredTimes],lwcPresCor[filteredTimes],symbol='+',sym_size=.45,sym_color='blue',/overplot,name='With Correction')
      leg3=legend(target=[plot3,plot3b]) 
      plot3.xrange=[lin1Left,lin1Right]
      plot3.yrange=[-.05,.05]
      
      
      lin3=linfit(pmb[filteredTimes],lwc[filteredTimes])
      linYLeftC=(lin3[1])*(lin1Left)+lin3[0]
      linYRightC=(lin3[1])*(lin1Right)+lin3[0]

      plot3lin=plot([lin1Left,lin1Right],[linYLeftC,linYRightC],/overplot, name='Level Clear Air Point linfit', thick=2)
      
      text3=string(lin3)
      text3a=text(100, 30, text3, /device)
      
      
      lin3b=linfit(pmb[filteredTimes],lwcPresCor[filteredTimes])
      linYLeftD=(lin3b[1])*(lin1Left)+lin3b[0]
      linYRightD=(lin3b[1])*(lin1Right)+lin3b[0]

      plot3lin=plot([lin1Left,lin1Right],[linYLeftD,linYRightD],/overplot,'b', name='Level Clear Air Point linfit', thick=2)

      text3b=string(lin3b)
      text3c=text(300, 30, text3b,color='blue', /device)
      
      plot3.title='Clear Air LWC With Pressure Correction (072913)'
      plot3.xtitle='Pressure [mb]'
      plot3.ytitle='LWC [g/m^3]'

      
      lin2Left=55
      lin2Right=105


      plot4=scatterplot(aiasMs[filteredTimes],lwc[filteredTimes],symbol='+',sym_size=.45,dimensions=[1200,900],name='No Correction')
      plot4b=scatterplot(aiasMs[filteredTimes],lwcPresCor[filteredTimes],symbol='+',sym_size=.45,sym_color='blue',/overplot,name='With Correction')
      leg3=legend(target=[plot4,plot4b])
      plot4.xrange=[lin2Left,lin2Right]
      plot4.yrange=[-.05,.05]


      lin4=linfit(aiasMs[filteredTimes],lwc[filteredTimes])
      linYLeftD=(lin4[1])*(lin2Left)+lin4[0]
      linYRightD=(lin4[1])*(lin2Right)+lin4[0]

      plot4lin=plot([lin2Left,lin2Right],[linYLeftD,linYRightD],/overplot, name='Level Clear Air Point linfit', thick=2)

      text4=string(lin4)
      text4a=text(100, 30, text4, /device)


      lin4b=linfit(aiasMs[filteredTimes],lwcPresCor[filteredTimes])
      linYLeftE=(lin4b[1])*(lin2Left)+lin4b[0]
      linYRightE=(lin4b[1])*(lin2Right)+lin4b[0]

      plot4lin=plot([lin2Left,lin2Right],[linYLeftE,linYRightE],/overplot,'b', name='Level Clear Air Point linfit', thick=2)

      text4b=string(lin4b)
      text4c=text(300, 30, text4b,color='blue', /device)

      plot4.title='Clear Air LWC With Pressure Correction (072913)'
      plot4.xtitle='Indicated Airspeed [m/s]'
      plot4.ytitle='LWC [g/m^3]'



stop


    endif
    
    
    
    
    
    
    
    if genplot eq 'liqCompPresScatterFilteredLevel' then begin

      baselineNevI=dindgen(n_elements(lwcnev1),start=0,increment=0)
      baselineCdpI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselinePmbI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineI=dindgen(n_elements(baselineCdpI),start=0,increment=0)
      baselineIB=dindgen(n_elements(baselineCdpI),start=0,increment=0)
      baselineIC=dindgen(n_elements(baselineCdpI),start=0,increment=0)
      baselineRollI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineAlphaI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineBetaI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineYawI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineLwcI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselinePitchI=dindgen(n_elements(cdpacc),start=0,increment=0)

      for i=0,n_elements(lwcnev1)-1 do begin
        if abs(lwcnev1[i]) lt .01 then begin
          baselineNevI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        if cdpacc[i] lt 4 then begin
          baselineCdpI[i]=1
        endif
      endfor

      ;      for i=0,n_elements(cdpacc)-1 do begin
      ;        if pmb[i] gt 668.9 and pmb[i] lt 980.9 then begin
      ;          baselinePmbI[i]=1
      ;        endif
      ;      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        ;if (abs(avRoll[i]) lt 3) then begin
        if (abs(avRoll[i]) lt 2) then begin
          baselineRollI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        ;if (alpha[i] lt .088 and alpha[i] gt .072) then begin
        if (alpha[i] lt .092 and alpha[i] gt .068) then begin
          baselineAlphaI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        if (avpitch[i] lt 3.9 and avpitch[i] gt 1.9) then begin ;0871013
        ;if (avpitch[i] lt 4.1 and avpitch[i] gt 2.1) then begin ;081413
        ;if (avpitch[i] lt 4.1 and avpitch[i] gt 2.1) then begin ;080713
        ;if (avpitch[i] lt 4.4 and avpitch[i] gt 2.4) then begin ;072713
          baselinePitchI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        ;if (where(beta lt -.025 and alpha gt -.016)) then begin
        if (betaB[i] lt -.014 and betaB[i] gt -.026) then begin
          baselineBetaI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        ;if (where(avyawr gt -.008 and avyawr lt 0)) then begin
        if (abs(avyawr[i]) lt .003) then begin
          baselineYawI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        ;if (where(avyawr gt -.008 and avyawr lt 0)) then begin
        if (lwc[i] gt .08) then begin
          baselineLwcI[i]=1
        endif
      endfor





      for i=0,n_elements(cdpacc)-1 do begin
        if (baselineNevI[i] eq 1) and (baselineCdpI[i] eq 1) then begin
          baselineI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        if (baselineI[i] eq 1) and (baselineRollI[i] eq 1) and (baselinePitchI[i] eq 1) and (baselineYawI[i] eq 1) then begin
          baselineIB[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        if (baselineI[i] eq 1) and (baselineRollI[i] eq 1) and (baselinePitchI[i] eq 0) then begin
          baselineIC[i]=1
        endif
      endfor





      filteredTimes=where(baselineI eq 1)
      filteredTimesB=where(baselineIB eq 1)
      filteredTimesC=where(baselineIC eq 1)


      plot1=scatterplot(pmb[filteredTimes],lwc[filteredTimes],symbol='+',sym_size=.45,dimensions=[1200,900],name='Clear Air Points')
      plot2=scatterplot(pmb[filteredTimesB],lwc[filteredTimesB],symbol='+',sym_size=.45,sym_color='red',/overplot, name='Level Clear Air Points')
      ;plot3=scatterplot(pmb[filteredTimesC],lwc[filteredTimesC],symbol='+',sym_size=.45,sym_color='blue',/overplot, name='Clear Air Points pitch > 1 deg mean')

      legend1=legend(target=[plot1,plot2], shadow=0)

      lin1Left=400
      lin1Right=1000


      lin2=linfit(pmb[filteredTimes],lwc[filteredTimes])
      linYLeft2=(lin2[1])*(lin1Left)+lin2[0]
      linYRight2=(lin2[1])*(lin1Right)+lin2[0]

      plot2lin=plot([lin1Left,lin1Right],[linYLeft2,linYRight2],/overplot, name='Clear Air Points linfit', thick=2)


      text2=string(lin2)
      text2a=text(100, 30, text2, /device)
      
      
      
      
      lin1=linfit(pmb[filteredTimesB],lwc[filteredTimesB])
      linYLeft=(lin1[1])*(lin1Left)+lin1[0]
      linYRight=(lin1[1])*(lin1Right)+lin1[0]

      plot1lin=plot([lin1Left,lin1Right],[linYLeft,linYRight],/overplot,'r', name='Level Clear Air Point linfit', thick=2)


      text1=string(lin1)
      text1a=text(300, 30, text1, color='red', /device)
      
      
      
      
      lin3=linfit(pmb[filteredTimesC],lwc[filteredTimesC])
      linYLeft=(lin3[1])*(lin1Left)+lin3[0]
      linYRight=(lin3[1])*(lin1Right)+lin3[0]

      ;plot3lin=plot([lin1Left,lin1Right],[linYLeft,linYRight],/overplot,'b', name='Level Clear Air Point linfit', thick=2)


      ;text1=string(lin3)
      ;text1a=text(500, 30, text1, color='blue', /device)


      ;legend2=legend(target=[plot2lin,plot1lin], shadow=0)
      plot1.xrange=[lin1Left,lin1Right]
      plot1.yrange=[-.04,.04]
      
      plot1.title='Clear Air LWC'
      plot1.xtitle='Pressure [mb]'
      plot1.ytitle='LWC [g/m^3]'
      
      
      
      text3=string(n_elements(filteredTimesB),'/',n_elements(filteredTimes))
      ;text3a=text(900, 30, text3, /device)
      
      
      stop
    endif
    
    
    
    
    
    if genplot eq 'liqComp' then begin
      plot1=plot(time[aStart:aEnd],lwc[aStart:aEnd],thick=1,name='Spencer',dimensions=[1200,900])
      plot2=plot(time[aStart:aEnd],lwcNev1[aStart:aEnd],'g',thick=1,/overplot,name='Alexei')
      plot2.title='Nevzorov LWC Calculation Comparison (080713 flight)'
      plot2.xtitle='Time'
      plot2.ytitle='Liquid Water Content [g/m^3]
      leg1=legend(target=[plot1,plot2])
      text1=lwcDiffAbsMean
      text1a=string(lwcDiffAbsMean)
      text1b=text(.1,.1,text1a)
      stop
    endif
    
    
    
    if genplot eq 'liqCompScatter' then begin
      plot1=plot(time[aStart:aEnd],lwcDiff,thick=1,name='Spencer',dimensions=[1200,900])
      plot1.title='Nevzorov LWC Calculation Comparison (080713 flight)'
      plot1.xtitle='Time'
      plot1.ytitle='Liquid Water Content [g/m^3]'
      text1=lwcDiffAbsMean
      text1a=string(lwcDiffAbsMean)
      text1b=text(.1,.1,text1a)
      stop
    endif
    
    
    
    if genplot eq 'liqCompGerber' then begin
      plot1=plot(time[aStart:aEnd],lwcDiffCalc,thick=1,name='Spencer',dimensions=[1200,900])
      plot2=plot(time[aStart:aEnd],lwcDiffNev,'g',thick=1,/overplot,name='Alexei')
      plot2.title='Gerber LWC Calculation Comparison'
      plot2.xtitle='Time'
      plot2.ytitle='Liquid Water Content [g/m^3]'
      leg1=legend(target=[plot1,plot2])
      text1=lwcDiffAbsMean
      text1a=string(lwcDiffAbsMean)
      text1b=text(.1,.1,text1a)
      stop
    endif
    
    
    
    if genplot eq 'liqComp11' then begin
      plot1=scatterplot(lwcNev1[aStart:aEnd],lwc[aStart:aEnd],dimensions=[1200,900],symbol='+',sym_size='.4')
      plot1.title='Alexei vs Spencer LWC Calculation - Indicated Airspeed K'
      plot1.ytitle='Liquid Water Content Difference [g/m^3]'
      plot1.xrange=[0,2.5]
      plot1.yrange=[0,2.5]

      text1=linfit(lwcNev1[aStart:aEnd],lwc[aStart:aEnd])
      text1a=string('linfit=',text1)
      text1b=text(10,10,text1a,/device)
      text2=R_CORRELATE(lwcNev1[aStart:aEnd],lwc[aStart:aEnd])
      text2a=string('Coorelation=',text2)
      text2b=text(600,10,text2a,/device)
      
      plot2=plot([0,2.5],[0,2.5],'r',/overplot)
      plot2.xtitle='LWC Alexei [g/m^3]'
      plot2.ytitle='LWC Spencer [g/m^3]'
      stop
    endif
    
    
    
    if genplot eq 'liqCompDiff' then begin
      plot1=plot(time[aStart:aEnd],lwcDiff,thick=1,name='Spencer',dimensions=[1200,900])
      ;plot1.title='LWC Difference'+titleTime[0]+'-'+titleTime[1]
      plot1.title='LWC Difference - 400mb Linear K'
      plot1.xtitle='Time [Sec]'
      plot1.ytitle='Liquid Water Content Difference [g/m^3]'
      plot1.xtickunits='numeric'
      text1=lwcDiffAbsMean
      text1a=string(lwcDiffAbsMean)
      text1b=text(.1,.1,text1a)
      ;plot1.yrange=[-.15,.05]
      stop
    endif
    
    
   
    
    if genplot eq 'liqCompIDiff' then begin
      unitVector=dindgen(100,start=0.,increment=.1)
      
      lwcDiffAbs=abs(lwcDiff)
      
      plot1=scatterplot(ilwccol[aStart:aEnd],lwcDiffAbs,name='Spencer',dimensions=[1200,900])
      ;plot1.title='LWC Difference'+titleTime[0]+'-'+titleTime[1]
      plot1.title='LWC Difference - 400mb Linear K'
      plot1.xtitle='Time [Sec]'
      plot1.ytitle='Liquid Water Content Difference [g/m^3]'
      plot1.xtickunits='numeric'
      text1=lwcDiffAbsMean
      text1a=string(lwcDiffAbsMean)
      text1b=text(.1,.1,text1a)
      fit=comfit(ilwccol[aStart:aEnd],lwcDiffAbs,[0.01187363957012138,2.3,-0.03828305643488737],/geometric)
      fitline=(fit[0])*unitVector^fit[1]+fit[2]
      plot2=plot(unitVector,fitline,'r',/overplot)
      plot1.yrange=[0,.145]
      plot1.xrange=[1,3]
      stop
    endif
    
    
    
    if genplot eq 'liqCompDiffAlt' then begin
      plot1=plot(time[aStart:aEnd],lwcDiff,thick=1,name='Spencer',dimensions=[1200,900],layout=[1,2,1],margin=[90,0,50,100],/device)
      plot1.title='LWC Difference'+titleTime[0]+'-'+titleTime[1]
      plot1.ytitle='Liquid Water Content Difference [g/m^3]'
      ;plot1.xrange=[1.94884d7,1.948905d7]
      ;plot1.yrange=[-.02,.02]

      text1=lwcDiffAbsMean
      text1a=string(lwcDiffAbsMean)
      text1b=text(.1,.1,text1a,/device)

      plot2=plot(time[aStart:aEnd],z[aStart:aEnd],thick=1,dimensions=[1200,900],layout=[1,2,2],margin=[90,100,50,84],/device,/current)
      plot2.xtitle='Time'
      plot2.ytitle='Altitude [m]'+titleTime[0]+'-'+titleTime[1]
      ;plot2.xrange=[1.94884d7,1.948905d7]
      stop
    endif
    
    
    
    if genplot eq 'liqCompDiffPres' then begin
      plot1=plot(time[aStart:aEnd],lwcDiff,thick=1,name='Spencer',dimensions=[1200,900],layout=[1,2,1],margin=[90,0,50,100],/device)
      plot1.title='LWC Difference'+titleTime[0]+'-'+titleTime[1]
      plot1.ytitle='Liquid Water Content Difference [g/m^3]'
      ;plot1.xrange=[1.94884d7,1.948905d7]
      plot1.yrange=[-.02,.02]

      text1=lwcDiffAbsMean
      text1a=string(lwcDiffAbsMean)
      text1b=text(.1,.1,text1a,/device)

      plot2=plot(time[aStart:aEnd],pmb[aStart:aEnd],thick=1,dimensions=[1200,900],layout=[1,2,2],margin=[90,100,50,84],/device,/current)
      plot2.xtitle='Time'
      plot2.ytitle='Pressure [mb]'
      plot1.yrange=[-.04,.04]
      ;plot2.xrange=[1.94884d7,1.948905d7]
      stop
    endif
    
    
    
    if genplot eq 'totalComp' then begin
      plot1=plot(time[aStart:aEnd],waterConTot[aStart:aEnd],thick=1,name='Spencer',dimensions=[1200,900])
      plot2=plot(time[aStart:aEnd],twcNev[aStart:aEnd],'g',thick=1,/overplot,name='Alexei')
      plot2.title='Nevzorov TWC Calculation Comparison (080713 flight)'+titleTime[0]+'-'+titleTime[1]
      plot2.xtitle='Time'
      plot2.ytitle='Total Water Content [g/m^3]'
      leg1=legend(target=[plot1,plot2])
      text1=text(50,50,'Mean Absolute Difference = g/m^3',/device)
      stop
    endif
    
    
    
    if genplot eq 'liqCompAirspeedScatter' then begin
      plot1=scatterplot(aiasMs[aStart:aEnd],lwcDiff,symbol='+',sym_size=.4,name='600 mb',sym_color='black',dimensions=[1200,900])
      plot2=scatterplot(aiasMs[aStart:aEnd],lwcDiff,symbol='+',sym_size=.4,name='600 mb',sym_color='black',dimensions=[1200,900])
      plot3=scatterplot(aiasMs[aStart:aEnd],lwcDiff,symbol='+',sym_size=.4,name='600 mb',sym_color='black',dimensions=[1200,900])
      ;plot1.title='Liquid Collector Current Vs. Absolute Difference (080713 flight)'+titleTime[0]+'-'+titleTime[1]
      plot1.title='LWC Difference vs. Indicated Airspeed'
      plot1.xtitle='Indicated Airspeed [m/s]'
      plot1.ytitle='LWC Difference'
      plot1.yrange=[-1.8,.5]
      stop
    endif
    
    
    
    if genplot eq 'liqCompAirspeedScatterAll' then begin
      kLiqAirspeedInd900=(2.47292)*aiasMs^(-0.273777)+(0.399143) ;900 indicated
      kLiqAirspeedInd600=(3.73599)*aiasMs^(-0.0628865)+(-1.67763) ;600 indicated
      kLiqAirspeedInd400=(36.0089)*aiasMs^(-1.26173)+(1.03362) ;400 indicated

      kLiqAirspeedTrue900=(8.56136)*tas^(-0.0292547)+(-6.37413) ;900 true
      kLiqAirspeedTrue600=(3.91644)*tas^(-0.0685396)+(-1.70073) ;600 true
      kLiqAirspeedTrue400=(1280.56)*tas^(-2.00624)+(1.08139) ;400 true
      
      ;HEAT LOSS LIQUID
      pLiqInd900=vlwccol*ilwccol-kLiqAirspeedInd900*vlwcref*ilwcref
      pLiqInd600=vlwccol*ilwccol-kLiqAirspeedInd600*vlwcref*ilwcref
      pLiqInd400=vlwccol*ilwccol-kLiqAirspeedInd400*vlwcref*ilwcref
      pLiqTrue900=vlwccol*ilwccol-kLiqAirspeedTrue900*vlwcref*ilwcref
      pLiqTrue600=vlwccol*ilwccol-kLiqAirspeedTrue600*vlwcref*ilwcref
      pLiqTrue400=vlwccol*ilwccol-kLiqAirspeedTrue400*vlwcref*ilwcref



      ;WATER CONTENT LIQUID
      lwcInd900=pLiqInd900/(colELiq*aiasMs*aLiq*lLiqStar)
      lwcInd600=pLiqInd600/(colELiq*aiasMs*aLiq*lLiqStar)
      lwcInd400=pLiqInd400/(colELiq*aiasMs*aLiq*lLiqStar)
      lwcTrue900=pLiqTrue900/(colELiq*tas*aLiq*lLiqStar)
      lwcTrue600=pLiqTrue600/(colELiq*tas*aLiq*lLiqStar)
      lwcTrue400=pLiqTrue400/(colELiq*tas*aLiq*lLiqStar)
      
      
      if airspeedType eq 'indicated' then begin
        lwcDiff900=(lwcNev1[aStart:aEnd]-lwcInd900[aStart:aEnd])
        lwcDiff600=(lwcNev1[aStart:aEnd]-lwcInd600[aStart:aEnd])
        lwcDiff400=(lwcNev1[aStart:aEnd]-lwcInd400[aStart:aEnd])
      endif
      
      
      if airspeedType eq 'true' then begin
        lwcDiff900=(lwcNev1[aStart:aEnd]-lwcTrue900[aStart:aEnd])
        lwcDiff600=(lwcNev1[aStart:aEnd]-lwcTrue600[aStart:aEnd])
        lwcDiff400=(lwcNev1[aStart:aEnd]-lwcTrue400[aStart:aEnd])
      endif
      
      
      plot1=scatterplot(as[aStart:aEnd],lwcDiff900,symbol='+',sym_size=.4,name='900 mb',sym_color='black',dimensions=[1200,900])
      plot2=scatterplot(as[aStart:aEnd],lwcDiff600,symbol='+',sym_size=.4,name='600 mb',sym_color='blue',/overplot)
      plot3=scatterplot(as[aStart:aEnd],lwcDiff400,symbol='+',sym_size=.4,name='400 mb',sym_color='red',/overplot)
      leg1=legend(target=[plot1,plot2,plot3])
      ;plot1.title='Liquid Collector Current Vs. Absolute Difference (080713 flight)'+titleTime[0]+'-'+titleTime[1]
      titleText=string('LWC Difference vs. ',airspeedType,' Airspeed')
      plot1.title=titleText
      plot1.xtitle='Indicated Airspeed [m/s]'
      plot1.ytitle='LWC Difference'
      plot1.yrange=[-.2,.2]
      
      text1=string(mean(abs(lwcDiff900)))
      text1a=text(50,50,text1,/device)
      
      text2=string(mean(abs(lwcDiff600)))
      text2a=text(300,50,text2,/device)
      
      text3=string(mean(abs(lwcDiff400)))
      text3a=text(500,50,text3,/device)
      
      stop
    endif
    
    
    
    if genplot eq 'liqCompPresScatter' then begin
      plot1=scatterplot(pmb[aStart:aEnd],lwcDiff,symbol='+',sym_size=.4,dimensions=[1200,900])
      ;plot1.title='LWC Difference vs Absolute Difference (080713 flight)'+titleTime[0]+'-'+titleTime[1]
      plot1.title='LWC Difference vs Pressure (081413) - 400mb Linear K'
      plot1.xtitle='Pressure [mb]'
      plot1.ytitle='LWC Difference [g/m^3]'
      plot1.yrange=[-.02,.02]
      stop
    endif
    
    
    
    
    if genplot eq 'liqCompPresScatterFilteredAirspeed' then begin

      baselineNevI=dindgen(n_elements(lwcnev1),start=0,increment=0)
      baselineCdpI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselinePmbI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineI=dindgen(n_elements(baselineCdpI),start=0,increment=0)
      baselineRollI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineAlphaI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineBetaI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineYawI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineLwcI=dindgen(n_elements(cdpacc),start=0,increment=0)

      for i=0,n_elements(lwcnev1)-1 do begin
        if abs(lwcnev1[i]) lt .01 then begin
          baselineNevI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        if cdpacc[i] lt 4 then begin
          baselineCdpI[i]=1
        endif
      endfor

;      for i=0,n_elements(cdpacc)-1 do begin
;        if pmb[i] gt 668.9 and pmb[i] lt 980.9 then begin
;          baselinePmbI[i]=1
;        endif
;      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        ;if (abs(avRoll[i]) lt 3) then begin
        if (abs(avRoll[i]) gt 3.5) then begin  
          baselineRollI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        ;if (alpha[i] lt .088 and alpha[i] gt .072) then begin
        if (alpha[i] lt .092 and alpha[i] gt .068) then begin  
          baselineAlphaI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        ;if (where(beta lt -.025 and alpha gt -.016)) then begin
        if (betaB[i] lt -.014 and betaB[i] gt -.026) then begin
          baselineBetaI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        ;if (where(avyawr gt -.008 and avyawr lt 0)) then begin
        if (abs(avyawr[i]) gt .003) then begin  
          baselineYawI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        ;if (where(avyawr gt -.008 and avyawr lt 0)) then begin
        if (lwc[i] gt .08) then begin
          baselineLwcI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        if (baselineNevI[i] eq 1) and (baselineCdpI[i] eq 1) then begin
          baselineI[i]=1
        endif
      endfor
      
      

      filteredTimes=where(baselineI eq 1)
     
      unitVector=dindgen(n_elements(filteredTimes), start=0, increment=1)
     
      pmbrange=pmb[filteredTimes]
      pmbSort=sort(pmbrange)
      pmbSorted=pmbrange[pmbSort]
      
      lwcDiff=(lwcNev1[filteredTimes]-lwc[filteredTimes])
      lwcDiffSorted=lwcDiff[pmbSort]
      
      lwc=(lwc[filteredTimes])
      lwcSorted=lwc[pmbSort]
      
      asRange=aiasMs[filteredTimes]
      asSorted=asRange[pmbSort]
      
      pitchRange=avpitch[filteredTimes]
      pitchSorted=pitchRange[pmbSort]
      
      alphaRange=alpha[filteredTimes]
      alphaSorted=alphaRange[pmbSort]
      
      betaBRange=betaB[filteredTimes]
      betaBSorted=betaBRange[pmbSort]
      
      vsRange=hivs[filteredTimes]
      vsSorted=vsRange[pmbSort]
      
      yawRange=avyawr[filteredTimes]
      yawSorted=yawRange[pmbSort]
      
      rollRange=avroll[filteredTimes]
      rollSorted=rollRange[pmbSort]
      
      timeRange=time[filteredTimes]
      timeSorted=timeRange[pmbSort]
      
      hivsRange=hivs[filteredTimes]
      hivsSorted=hivsRange[pmbSort]
     
      upBound=(6.4d-5)*pmbSorted-0.05
      lowBound=(6.4d-5)*pmbSorted-0.057

      upBoundB=(1.125d-3)*pmbSorted^(.6)-0.061
      lowBoundB=(1.125d-3)*pmbSorted^(.6)-0.064
      
      filteredPoints=where((pitchSorted lt upBound) and (lwcDiffSorted gt lowBound))
      filteredPointsB=where((pitchSorted lt upBoundB) and (lwcDiffSorted gt lowBoundB))
      fI=[filteredPoints,filteredPointsB]

      plot1=scatterplot(pitchSorted[filteredTimes],lwcSorted[filteredTimes],symbol='+',sym_size=.4,dimensions=[1200,900],name='Clear Air Points')
      plot2=scatterplot(pitchSorted[fi],lwcSorted[fi],symbol='+',sym_size=.4,sym_color='red',/overplot, name='Isolated Clear Air Points')
      
      legend1=legend(target=[plot1,plot2], shadow=0)
      
      lin1Left=-13
      lin1Right=13
      
      lin1=linfit(pitchSorted[fi],lwcSorted[fi])
      linYLeft=(lin1[1])*(lin1Left)+lin1[0]
      linYRight=(lin1[1])*(lin1Right)+lin1[0]
      
      plot1lin=plot([lin1Left,lin1Right],[linYLeft,linYRight],/overplot,'r', name='Isolated Clear Air Point Reg')
      
      
      lin2=linfit(pitchSorted[filteredTimes],lwcSorted[filteredTimes])
      linYLeft2=(lin2[1])*(lin1Left)+lin2[0]
      linYRight2=(lin2[1])*(lin1Right)+lin2[0]

      plot2lin=plot([lin1Left,lin1Right],[linYLeft2,linYRight2],/overplot, name='Clear Air Points Reg')
      
      legend2=legend(target=[plot2lin,plot1lin], shadow=0)
      plot1.xrange=[lin1Left,lin1Right]
      stop
    endif
    
    
    
    
    
    if genplot eq 'liqCompPresScatterFilteredAirspeedComp' then begin


      baselineNevI=dindgen(n_elements(lwcnev1),start=0,increment=0)
      baselineCdpI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselinePmbI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineI=dindgen(n_elements(baselineCdpI),start=0,increment=0)
      baselineRollI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineAlphaI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineBetaI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineYawI=dindgen(n_elements(cdpacc),start=0,increment=0)

      for i=0,n_elements(lwcnev1)-1 do begin
        if abs(lwcnev1[i]) lt .01 then begin
          baselineNevI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        if cdpacc[i] lt 4 then begin
          baselineCdpI[i]=1
        endif
      endfor

      ;      for i=0,n_elements(cdpacc)-1 do begin
      ;        if pmb[i] gt 668.9 and pmb[i] lt 980.9 then begin
      ;          baselinePmbI[i]=1
      ;        endif
      ;      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        if (abs(avRoll[i]) lt 3) then begin
          baselineRollI[i]=1
        endif
      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        if (alpha[i] lt .088 and alpha[i] gt .072) then begin
          baselineAlphaI[i]=1
        endif
      endfor

      ;      for i=0,n_elements(cdpacc)-1 do begin
      ;        if (where(beta lt -.025 and alpha gt -.016)) then begin
      ;          baselineBetaI[i]=1
      ;        endif
      ;      endfor

      ;      for i=0,n_elements(cdpacc)-1 do begin
      ;        if (where(avyawr gt -.008 and avyawr lt 0)) then begin
      ;          baselineYawI[i]=1
      ;        endif
      ;      endfor

      for i=0,n_elements(cdpacc)-1 do begin
        if (baselineNevI[i] eq 1) and (baselineCdpI[i] eq 1) then begin
          baselineI[i]=1
        endif
      endfor



      filteredTimes=where(baselineI eq 1)


      pmbrange=pmb[filteredTimes]
      pmbSort=sort(pmbrange)
      pmbSorted=pmbrange[pmbSort]

      lwcDiff=(lwcNev1[filteredTimes]-lwc[filteredTimes])
      lwcDiffSorted=lwcDiff[pmbSort]

      lwc=(lwc[filteredTimes])
      lwcSorted=lwc[pmbSort]

      asRange=aiasMs[filteredTimes]
      asSorted=asRange[pmbSort]

      pitchRange=avpitch[filteredTimes]
      pitchSorted=pitchRange[pmbSort]

      alphaRange=alpha[filteredTimes]
      alphaSorted=alphaRange[pmbSort]

      betaBRange=betaB[filteredTimes]
      betaBSorted=betaBRange[pmbSort]

      vsRange=hivs[filteredTimes]
      vsSorted=vsRange[pmbSort]

      yawRange=avyawr[filteredTimes]
      yawSorted=yawRange[pmbSort]

      rollRange=avroll[filteredTimes]
      rollSorted=rollRange[pmbSort]

      timeRange=time[filteredTimes]
      timeSorted=timeRange[pmbSort]

      plot1=scatterplot(timesorted,lwcSorted,symbol='+',sym_size=.4,dimensions=[1200,900],layout=[1,2,1],margin=[90,0,50,100],/device)

      ;plot1.title='LWC Difference vs Absolute Difference (080713 flight)'+titleTime[0]+'-'+titleTime[1]
      plot1.title='Clear Air LWC (080713) - 400mb Indicated Geometric K'
      ;plot1.xtitle='Time [sec]'
      plot1.ytitle='LWC [g/m^3]'
      ;plot1.yrange=[-.03,.02]
      ;plot1.xrange=[400,920]




      ;      upBound=(2.1d-3)*pmbSorted^(.6)-0.114
      ;      lowBound=(2.1d-3)*pmbSorted^(.6)-0.117

      upBound=(6.4d-5)*pmbSorted-0.05
      lowBound=(6.4d-5)*pmbSorted-0.057

      upBoundB=(1.125d-3)*pmbSorted^(.6)-0.061
      lowBoundB=(1.125d-3)*pmbSorted^(.6)-0.064



      ;      plot1a=plot(pmbSorted,upBound,'b',/overplot)
      ;      plot1b=plot(pmbSorted,lowBound,'b',/overplot)
      ;
      ;      plot1c=plot(pmbSorted,upBoundB,'r',/overplot)
      ;      plot1d=plot(pmbSorted,lowBoundB,'r',/overplot)


      filteredPoints=where((lwcDiffSorted lt upBound) and (lwcDiffSorted gt lowBound))
      filteredPointsB=where((lwcDiffSorted lt upBoundB) and (lwcDiffSorted gt lowBoundB))
      fI=[filteredPoints,filteredPointsB]

      ;linfitA=linfit(pmb[aiasMsFilter],lwcDiff[aiasMsFilter])
      ;regline=(linFitA[1])*unitVector+linfitA[0]

      ;      linfitA=comfit(pmb[aStart:aEnd],lwcDiff,[.0001,.24,-.07],yfit=yfit,/geometric)
      ;      regline=(linFitA[0])*pmb^(linFitA[1])+linFitA[2]

      ;plot1a=plot(unitVector,regline,'r',/overplot)


      plot4=scatterplot(timeSorted[fi],lwcSorted[fi],symbol='+',sym_size=.4,sym_color='red',/overplot,dimensions=[1200,900],layout=[1,2,1],margin=[90,0,50,100],/device)
      plot2=plot(time[filteredTimes],pmb[filteredTimes],dimensions=[1200,900],layout=[1,2,2],/current,margin=[90,100,50,84],/device)
      plot2.ytitle='Pressure [mb]'
      plot2.xtitle='Time [sec]'

      plot4=scatterplot(pmbSorted[filteredPoints],lwcDiffSorted[filteredPoints])
      plot4.xrange=[650,800]
      plot4.yrange=[-.013,0]
      ;      geofit=comfit(pmbSorted[fI],lwcDiffSorted[fI],[0.009974850,.6,-0.7931724913],/geometric)
      ;
      ;      geofitline=(geofit[0])*pmbSorted[fI]^(geofit[1])+(geofit[2])
      geofit=linfit(pmbSorted[fI],lwcDiffSorted[fI])
      geofit=[-0.0641974281,7.99769713e-05]

      geofitline=(geofit[1])*pmbSorted[fI]+(geofit[0])
      plotgeofitline=plot(pmbSorted[fI],geofitline,'r',/overplot)
      stop
    endif
    
    
     
    
    
    
    if genplot eq 'liqCompNevScatter' then begin
      plot1=scatterplot(lwcNev1[aStart:aEnd],abs(lwcDiff),symbol='+',sym_size=.4,dimensions=[1200,900])
      ;plot1.title='LWC Difference vs Absolute Difference (080713 flight)'+titleTime[0]+'-'+titleTime[1]
      plot1.title='Alexei LWC vs LWC Difference (081413) - 400mb Linear K'
      plot1.xtitle='Alexei LWC [g/m^3]'
      plot1.ytitle='LWC Difference [g/m^3]'
      plot1.xrange=[-.1,3]
      plot1.yrange=[-.16,.16]
      stop
    endif
    

    
    if genplot eq 'liqCompBaseline' then begin
      lwcDiff=(lwcNev1-lwc)
      
      baselineNevI=dindgen(n_elements(lwcnev1),start=0,increment=0)
      baselineCdpI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselinePmbI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineLwcDiffI=dindgen(n_elements(cdpacc),start=0,increment=0) ;Select clear air points with abs lwcDiff gt .01
      baselineRollI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineAlphaI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineBetaBI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineYawI=dindgen(n_elements(cdpacc),start=0,increment=0)
      baselineI=dindgen(n_elements(baselineCdpI),start=0,increment=0)
      
      for i=0,n_elements(lwcnev1)-1 do begin
        if abs(lwcnev1[i]) lt .01 then begin
          baselineNevI[i]=1
        endif  
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        if cdpacc[i] lt 10 then begin
          baselineCdpI[i]=1
        endif
      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        ;if (abs(avRoll[i]) lt 3) then begin
          if (abs(avRoll[i]) lt 5) then begin
          baselineRollI[i]=1
        endif
        
        ;if (alpha[i] lt .088 and alpha[i] gt .072) then begin
          if (alpha[i] lt .092 and alpha[i] gt .068) then begin
          baselineAlphaI[i]=1
        endif
        
        ;if (betaB[i] lt -.016 and betaB[i] gt -.025) then begin
          if (betaB[i] lt -.014 and betaB[i] gt -.026) then begin
          baselineBetaBI[i]=1
        endif
        
        ;if (avyawr[i] gt -.005 and avyawr[i] lt .001) then begin
          if (avyawr[i] gt -.005 and avyawr[i] lt .005) then begin
          baselineYawI[i]=1
        endif
      endfor
      
      for i=0,n_elements(lwcDiff)-1 do begin
        if lwcDiff[i] lt -.0078 then begin
          BaselineLwcDiffI[i]=1
        endif
      endfor
      
;      for i=0,n_elements(cdpacc)-1 do begin
;        if pmb[i] gt 668.9 and pmb[i] lt 980.9 then begin
;          baselinePmbI[i]=1
;        endif
;      endfor
      
      for i=0,n_elements(cdpacc)-1 do begin
        ;if (baselineNevI[i] eq 1) and (baselineCdpI[i] eq 1) and (baselineRollI[i] eq 1) and (baselineAlphaI[i] eq 1) and (baselineBetaBI[i] eq 1) and (baselineYawI[i] eq 1) then begin
         if (baselineNevI[i] eq 1) and (baselineCdpI[i] eq 1) and (baselineBetaBI[i] eq 1) and (baselineYawI[i] eq 1) and (baselineAlphaI[i] eq 1) then begin
          baselineI[i]=1
        endif
      endfor
      
      filteredTimes=where(baselineI eq 1)
      
      xTimes=where(baselineRollI eq 1)
      
      dep900Mb=abs(906.686 - pmb)
      dep600Mb=abs(628.583 - pmb)
      dep400Mb=abs(409.487 - pmb)
      
      plot1=scatterplot(alpha[filteredTimes],lwc[filteredTimes],symbol='+',sym_size=.4,dimensions=[1200,900])
      ;plot1=plot(time,lwcdiff[filteredTimes],symbol='+',sym_size=.4,dimensions=[1200,900])
      ;plot1.title='LWC Difference vs Absolute Difference (080713 flight)'+titleTime[0]+'-'+titleTime[1]
      plot1.title='LWC Difference vs Pressure (081413) - 400mb Linear K'
      plot1.xtitle='Pressure [mb]'
      plot1.ytitle='LWC [g/m^3]'
      ;plot1.yrange=[-.05,.03]
      ;plot1.xrange=[600,1000]
      stop
    endif


stop
return

end