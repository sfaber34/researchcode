function nevbase, flightDay, airspeedType, level

  ;-----------------------------------------SET FILE PATH----------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if !version.OS_FAMILY eq 'Windows' then begin
  if flightDay eq '0709' then nclPath='Z:\research\nevzorov\data\070913\20130709.c1.nc'
  if flightDay eq '0710' then nclPath='Z:\research\nevzorov\data\20130710.c1.nc'
  if flightDay eq '0725' then nclPath='Z:\research\nevzorov\data\072513\20130725.c1.nc' ;tons of level ca
  if flightDay eq '0727' then nclPath='Z:\research\nevzorov\data\072713\20130727.c1.nc'
  if flightDay eq '0728' then nclPath='Z:\research\nevzorov\data\072813\20130728.c1.nc'
  if flightDay eq '0729' then nclPath='Z:\research\nevzorov\data\072913\20130729.c1.nc'
  if flightDay eq '0807' then nclPath='Z:\research\nevzorov\data\080713\20130807.c1.nc'
  if flightDay eq '0814' then nclPath='Z:\research\nevzorov\data\081413\20130814.c1.nc'
  if flightDay eq '0815' then nclPath='Z:\research\nevzorov\data\081513\20130815.c1.nc'
  if flightDay eq '0803' then nclPath='Z:\research\nevzorov\data\080313\20130803.c1.nc'
endif else begin
  if flightDay eq '0709' then nclPath='../data/070913/20130709.c1.nc'
  if flightDay eq '0710' then nclPath='../data/20130710.c1.nc'
  if flightDay eq '0725' then nclPath='../data/072513/20130725.c1.nc' ;tons of level ca
  if flightDay eq '0727' then nclPath='../data/072713/20130727.c1.nc'
  if flightDay eq '0728' then nclPath='../data/072813/20130728.c1.nc'
  if flightDay eq '0729' then nclPath='../data/072913/20130729.c1.nc'
  if flightDay eq '0807' then nclPath='../data/080713/20130807.c1.nc'
  if flightDay eq '0814' then nclPath='../data/081413/20130814.c1.nc'
  if flightDay eq '0815' then nclPath='../data/081513/20130815.c1.nc'
  if flightDay eq '0803' then nclPath='../data/080313/20130803.c1.nc'
  if flightDay eq '0304' then nclPath='../data/030416/20160304.c1.nc'
  if flightDay eq '0307' then nclPath='../data/030716/20160307.c1.nc'
endelse

if strmatch(nclpath,'*2013*') eq 1 then cope=1
if strmatch(nclpath,'*2015*') eq 1 then cope=0
if strmatch(nclpath,'*2016*') eq 1 then cope=2


;-----------------------------------------LOAD VARIABLES----------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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

;true airspeed [m/s]
tas=loadvar('tas', filename=nclPath)

;indicated airspeed [knot]
aias=loadvar('aias', filename=nclPath)

;time formatted
timeForm=loadvar('TIME', filename=nclPath)

;time seconds since 2015-01-01 00:00:00 +0000
time=loadvar('time', filename=nclPath)

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

;CDP hydrometeor concentration
cdpconc_NRB=loadvar('cdpconc_NRB', filename=nclPath)

;liquid water content from CDP [g/m^3]
cdplwc_NRB=loadvar('cdplwc_NRB', filename=nclPath)

;CDP accepted particles
cdpacc=loadvar('cdpacc_NRB', filename=nclPath)

;CDP droplet mean diamter [um]
cdpdbar_NRB=loadvar('cdpdbar_NRB', filename=nclPath)

;Pitch [degrees]
avpitch=loadvar('avpitch', filename=nclPath)

;roll [degrees]
avroll=loadvar('avroll', filename=nclPath)

;Vertical Speed [m/s]
if cope eq 1 then hivs=loadvar('hivs', filename=nclPath)
if cope ne 1 then hivs=0

;Sideslip Angle [deg]
betaB=loadvar('beta', filename=nclPath)

;Yaw [deg]
avyawr=loadvar('avyawr', filename=nclPath)

;Attack Angle [rad]
alpha=loadvar('alpha', filename=nclPath)


lwcnev1 = 0
lwcnev2 = 0
if cope eq 1 then begin

  ;liquid water content from Nevzorov probe [g/m^3]
  lwcNev1=loadvar('nevlwc1', filename=nclPath)

  ;liquid water content from Nevzorov probe [g/m^3]
  lwcNev2=loadvar('nevlwc2', filename=nclPath)

endif





;-----------------------------------------SET START/STOP TIMES----------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


if flightDay eq '0807' then begin
  flightString='08-07-13'
  aStart=where(timeForm eq 124100)
  aEnd=where(timeForm eq 155400)
endif

if flightDay eq '0814' then begin
  flightString='08-14-13'
  aStart=where(timeForm eq 115400)
  aEnd=where(timeForm eq 150200)
endif

if flightDay eq '0710' then begin
  flightString='07-10-13'
  aStart=where(timeForm eq 113100)
  aEnd=where(timeForm eq 141100)
endif

if flightDay eq '0725' then begin
  flightString='07-25-13'
  aStart=where(timeForm eq 102200)
  aEnd=where(timeForm eq 134800)
endif

if flightDay eq '0727' then begin
  flightString='07-27-13'
  aStart=where(timeForm eq 114917)
  aEnd=where(timeForm eq 135000)
endif

if flightDay eq '0728' then begin
  flightString='07-28-13'
  aStart=where(timeForm eq 114700)
  aEnd=where(timeForm eq 150500)
endif

if flightDay eq '0729' then begin
  flightString='07-29-13'
  aStart=where(timeForm eq 114910)
  aEnd=where(timeForm eq 145700)
endif

if flightDay eq '0815' then begin
  flightString='08-15-13'
  aStart=where(timeForm eq 122500)
  aEnd=where(timeForm eq 145700)
endif

if flightDay eq '0803' then begin
  flightString='08-03-13'
  aStart=where(timeForm eq 113445)
  aEnd=where(timeForm eq 150700)
endif

if flightDay eq '0304' then begin
  flightString='03-04-16'
  aStart=where(timeForm eq 170500)
  aEnd=where(timeForm eq 191600)
endif

if flightDay eq '0307' then begin
  flightString='03-07-16'
  aStart=where(timeForm eq 221100)
  aEnd=where(timeForm eq 000400)
endif





;-----------------------------------------APPLY START/STOP TIMES TO VARIABLES----------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


vlwcref=vlwcref[aStart:aEnd]
vlwccol=vlwccol[aStart:aEnd]
vtwcref=vtwcref[aStart:aEnd]
vtwccol=vtwccol[aStart:aEnd]
ilwcref=ilwcref[aStart:aEnd]
itwccol=itwccol[aStart:aEnd]
ilwccol=ilwccol[aStart:aEnd]
trf=trf[aStart:aEnd]
tas=tas[aStart:aEnd]
aias=aias[aStart:aEnd]
timeForm=timeForm[aStart:aEnd]
time=time[aStart:aEnd]
pmb=pmb[aStart:aEnd]
trose=trose[aStart:aEnd]
z=z[aStart:aEnd]
pvmlwc=pvmlwc[aStart:aEnd]
lwc100=lwc100[aStart:aEnd]
cdpconc_NRB=cdpconc_NRB[aStart:aEnd]
cdpacc=cdpacc[aStart:aEnd]
cdpdbar_NRB=cdpdbar_NRB[aStart:aEnd]
avpitch=avpitch[aStart:aEnd]
avroll=avroll[aStart:aEnd]
avyawr=avyawr[aStart:aEnd]
alpha=alpha[aStart:aEnd]
cdplwc_NRB=cdplwc_NRB[aStart:aEnd]

if cope eq 1 then begin
  lwcNev1=lwcNev1[aStart:aEnd]
  lwcNev2=lwcNev2[aStart:aEnd]
  hivs=hivs[aStart:aEnd]
endif






;-----------------------------------------CONSTANTS-------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;surface area liquid sensor [m^2]
aLiq=3.17d-5

;surface area total sensor [m^2]
aTot=5d-5

;liquid collection efficiency
colELiq=1.

;total collection efficiency
colETot=1.





;------------------------------------------CONVERSIONS---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;CONVERT INDICATED AIRSPEED TO M/S
aiasMs=aias*.514444





;-----------------------------------------Kliq---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if airspeedType eq 'true' then begin
  as=tas
endif

if airspeedType eq 'indicated' then begin
  as=aiasMs
endif



;K LIQUID

if cope eq 1 then begin
  if (airspeedType eq 'indicated') and (level eq '900') then kLiq=(2.47292)*aiasMs^(-0.273777)+(0.399143) ;900 indicated
  if (airspeedType eq 'indicated') and (level eq '600') then kLiq=(3.73599)*aiasMs^(-0.0628865)+(-1.67763) ;600 indicated
  if (airspeedType eq 'indicated') and (level eq '400') then kLiq=(36.0089)*aiasMs^(-1.26173)+(1.03362) ;400 indicated
  
  if (airspeedType eq 'true') and (level eq '900') then kLiq=(8.56136)*tas^(-0.0292547)+(-6.37413) ;900 true
  if (airspeedType eq 'true') and (level eq '600') then kLiq=(3.91644)*tas^(-0.0685396)+(-1.70073) ;600 true
  if (airspeedType eq 'true') and (level eq '400') then kLiq=(1280.56)*tas^(-2.00624)+(1.08139) ;400 true
endif



if cope eq 2 then begin
  if (airspeedType eq 'indicated') and (level eq '700') then kLiq=(-0.0126704)*tas^(0.698457)+(2.01460)
  if (airspeedType eq 'indicated') and (level eq '600') then kLiq=(-0.00956550)*tas^(0.753178)+(2.00092)
  if (airspeedType eq 'indicated') and (level eq '500') then kLiq=(-0.135222)*tas^(0.375551)+(2.43805)
  if (airspeedType eq 'indicated') and (level eq '400') then kLiq=(-0.0810470)*tas^(0.436789)+(2.28769)
endif





;------------------------------------------FILTERS---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

vlwccolshift=shift(vlwccol,1)
vlwccoldel=vlwccol-vlwccolshift

vlwccoldelshift=shift(vlwccoldel,1)
vlwccoldelshift2=shift(vlwccoldel,2)
vlwccoldelshift3=shift(vlwccoldel,3)


aSpan = n_elements(pmb) - 1

baselineBetaI=dindgen(n_elements(pmb),start=0,increment=0)
baselineIB=dindgen(n_elements(pmb),start=0,increment=0)
baselineRollI=dindgen(n_elements(pmb),start=0,increment=0)
baselineYawI=dindgen(n_elements(pmb),start=0,increment=0)
baselinePitchI=dindgen(n_elements(pmb),start=0,increment=0)
baselineI=dindgen(n_elements(pmb),start=0,increment=0)



for i=0, aSpan do begin
  if (abs(vlwccoldel[i]) lt .01 and abs(vlwccoldelshift[i]) lt .01 and abs(vlwccoldelshift2[i]) lt .01 and abs(vlwccoldelshift3[i]) lt .01) then begin
    baselineI[i]=1
  endif
endfor


for i=0, aSpan do begin
  if (abs(avRoll[i]) lt 5) then begin
    baselineRollI[i]=1
  endif
endfor

for i=0, aSpan do begin
  if (avpitch[i] lt (mean(avpitch) + 2) and avpitch[i] gt (mean(avpitch) - 2)) then begin ;0871013
    baselinePitchI[i]=1
  endif
endfor

for i=0, aSpan do begin
  if (betaB[i] lt -.014 and betaB[i] gt -.026) then begin
    baselineBetaI[i]=1
  endif
endfor

for i=0, aSpan do begin
  if (abs(avyawr[i]) lt .003) then begin
    baselineYawI[i]=1
  endif
endfor


for i=0, aSpan do begin
  if (baselineI[i] eq 1) and (baselineRollI[i] eq 1) and (baselinePitchI[i] eq 1) and (baselineYawI[i]=1) then begin
    baselineIB[i]=1
  endif
endfor




clearAir=where(baselineI eq 1)
levelClearAir=where(baselineIB eq 1)



;EXPENDED HEAT FOR LIQUID
lLiqStar=2589.



;HEAT LOSS LIQUID
pLiq=vlwccol*ilwccol-kLiq*vlwcref*ilwcref
pLiqNoPresCor=pLiq


lwcNoPresCor=pLiq/(colELiq*tas*aLiq*lLiqStar)

;-----------------------------------------PRESSURE CORRECTION---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


linPresCor=linfit(pmb[clearair],pLiq[clearair])

poly=poly_fit(pmb[clearair],pLiq[clearair],2)
pLiq=pLiqNoPresCor - ( linPresCor[1]*pmb + linPresCor[0] )




;-----------------------------------------CALCULATIONS---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


;WATER CONTENT LIQUID
lwc=pLiq/(colELiq*tas*aLiq*lLiqStar)






g  = {as:as, pmb:pmb, time:time, timeForm:timeForm, avroll:avroll, avpitch:avpitch, $
  pLiq:pLiq, lwc:lwc, lwcnev1:lwcnev1, lwcNoPresCor:lwcNoPresCor, $
  clearAir:clearAir, levelClearAir:levelClearAir,$
  flightString:flightString, kLiq:kLiq, $
  aiasMs:aiasMs, tas:tas, $
  vlwccol:vlwccol, ilwccol:ilwccol, cdpconc_NRB:cdpconc_NRB, trf:trf, $
  lwc100:lwc100, cdpdbar_NRB:cdpdbar_NRB,lwcnev2:lwcnev2, $
  avyaw:avyawr,pvmlwc:pvmlwc,cdplwc_NRB:cdplwc_NRB,pLiqNoPresCor:pLiqNoPresCor}


return,g

end