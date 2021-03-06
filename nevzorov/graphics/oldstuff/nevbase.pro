pro nevbase, flightDay
common g, g


cope=1

airspeedType='indicated'

level='400'




if flightDay eq '0709' then nclPath='/Volumes/sfaber1/research/nevzorov/070913/20130709.c1.nc'
if flightDay eq '0710' then nclPath='/Volumes/sfaber1/research/nevzorov/20130710.c1.nc'
if flightDay eq '0725' then nclPath='/Volumes/sfaber1/research/nevzorov/072513/20130725.c1.nc' ;tons of level ca
if flightDay eq '0727' then nclPath='/Volumes/sfaber1/research/nevzorov/072713/20130727.c1.nc'
if flightDay eq '0728' then nclPath='/Volumes/sfaber1/research/nevzorov/072813/20130728.c1.nc'
if flightDay eq '0729' then nclPath='/Volumes/sfaber1/research/nevzorov/072913/20130729.c1.nc'
if flightDay eq '0807' then nclPath='/Volumes/sfaber1/research/nevzorov/080713/20130807.c1.nc'
if flightDay eq '0814' then nclPath='/Volumes/sfaber1/research/nevzorov/081413/20130814.c1.nc'
if flightDay eq '0815' then nclPath='/Volumes/sfaber1/research/nevzorov/081513/20130815.c1.nc'







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

if cope eq 1 then begin

  ;liquid water content from Nevzorov probe [g/m^3]
  lwcNev1=loadvar('nevlwc1', filename=nclPath)

  ;liquid water content from Nevzorov probe [g/m^3]
  lwcNev2=loadvar('nevlwc2', filename=nclPath)
  
  ;total water content from Nevzorov probe [g/m^3]
  nevtwc=loadvar('nevtwc', filename=nclPath)

endif




if flightDay eq '0807' then begin
  ;ENTIRE FLIGHT
  flightString='08-07-13'
  aStart=where(timeForm eq 124100)
  aEnd=where(timeForm eq 155400)
endif

if flightDay eq '0814' then begin
  ;ENTIRE FLIGHT
  flightString='08-14-13'
  aStart=where(timeForm eq 115400)
  aEnd=where(timeForm eq 150200)
endif

if flightDay eq '0710' then begin
  ;ENTIRE FLIGHT
  flightString='07-10-13'
  aStart=where(timeForm eq 112600)
  aEnd=where(timeForm eq 141100)
endif

if flightDay eq '0725' then begin
  ;ENTIRE FLIGHT
  flightString='07-25-13'
  aStart=where(timeForm eq 110300)
  aEnd=where(timeForm eq 130700)
endif

if flightDay eq '0727' then begin
  ;ENTIRE FLIGHT
  flightString='07-27-13'
  aStart=where(timeForm eq 115500)
  aEnd=where(timeForm eq 135600)
endif

if flightDay eq '0728' then begin
  ;ENTIRE FLIGHT
  flightString='07-28-13'
  aStart=where(timeForm eq 115800)
  aEnd=where(timeForm eq 150800)
endif

if flightDay eq '0729' then begin
  ;ENTIRE FLIGHT
  flightString='07-29-13'
  aStart=where(timeForm eq 115800)
  aEnd=where(timeForm eq 145900)
endif

if flightDay eq '0815' then begin
  ;ENTIRE FLIGHT
  flightString='08-15-13'
  aStart=where(timeForm eq 123000)
  aEnd=where(timeForm eq 145500)
endif








vlwcref=vlwcref[aStart:aEnd]
vlwccol=vlwccol[aStart:aEnd]
vtwcref=vtwcref[aStart:aEnd]
vtwccol=vtwccol[aStart:aEnd]
ilwcref=ilwcref[aStart:aEnd]
itwccol=itwccol[aStart:aEnd]
ilwccol=ilwccol[aStart:aEnd]
trf=trf[aStart:aEnd]
thetad=thetad[aStart:aEnd]
thetae=thetae[aStart:aEnd]
tas=tas[aStart:aEnd]
aias=aias[aStart:aEnd]
ralt3=ralt3[aStart:aEnd]
timeForm=timeForm[aStart:aEnd]
time=time[aStart:aEnd]
mr=mr[aStart:aEnd]
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
hivs=hivs[aStart:aEnd]
betaB=betaB[aStart:aEnd]
avyawr=avyawr[aStart:aEnd]
alpha=alpha[aStart:aEnd]
nevtwc=nevtwc[aStart:aEnd]

if cope eq 1 then begin

  lwcNev1=lwcNev1[aStart:aEnd]
  lwcNev2=lwcNev2[aStart:aEnd]

endif









;-----CONSTANTS-----

;surface area liquid sensor [m^2]
aLiq=3.28d-5

;surface area total sensor [m^2]
aTot=5d-5

;liquid collection efficiency
colELiq=1.

;total collection efficiency
colETot=1.

;liquid water latent heat of vaporization at 100C [J/G]
lLiq=2260.
;lLiq=2264.76


;L* [J/G]
;lLiq=2589.

;specific heat capacity of liquid water at 110 C [J/G K]
cLiq=4.223

if cope eq 1 then begin
  ;sensor temperature [C]
  sensorTemp=110.
endif

if cope eq 0 then begin
  ;sensor temperature [C]
  sensorTemp=90.
endif


;------CONVERSIONS-----

;CONVERT INDICATED AIRSPEED TO M/S
aiasMs=aias*.514444

;CONVERT AIR TEMPERATURE TO KELVIN
;trf=trf+273.15




;-----CALCULATIONS-----

if airspeedType eq 'true' then begin
  as=tas
endif

if airspeedType eq 'indicated' then begin
  as=aiasMs
endif





;K LIQUID

if (airspeedType eq 'indicated') and (level eq '900') then kLiqAirspeed=(2.47292)*aiasMs^(-0.273777)+(0.399143) ;900 indicated
if (airspeedType eq 'indicated') and (level eq '600') then kLiqAirspeed=(3.73599)*aiasMs^(-0.0628865)+(-1.67763) ;600 indicated
if (airspeedType eq 'indicated') and (level eq '400') then kLiqAirspeed=(36.0089)*aiasMs^(-1.26173)+(1.03362) ;400 indicated

if (airspeedType eq 'true') and (level eq '900') then kLiqAirspeed=(8.56136)*tas^(-0.0292547)+(-6.37413) ;900 true
if (airspeedType eq 'true') and (level eq '600') then kLiqAirspeed=(3.91644)*tas^(-0.0685396)+(-1.70073) ;600 true
if (airspeedType eq 'true') and (level eq '400') then kLiqAirspeed=(1280.56)*tas^(-2.00624)+(1.08139) ;400 true




kLiq=kLiqAirspeed




;HEAT LOSS LIQUID
pLiq=vlwccol*ilwccol-kLiq*vlwcref*ilwcref



;EXPANDED HEAT FOR LIQUID
lLiqStar=((sensorTemp-trf)*cLiq)+lLiq


;WATER CONTENT LIQUID
lwc=pLiq/(colELiq*as*aLiq*lLiqStar)
lwcAsCorrDiff = lwcNev1 - lwc 






;aStart = aStart[0]
;aEnd = aEnd[0]

aSpan = n_elements(pmb) - 1

baselineNevI=dindgen(n_elements(pmb),start=0,increment=0)
baselineI=dindgen(n_elements(pmb),start=0,increment=0)
baselineIB=dindgen(n_elements(pmb),start=0,increment=0)
baselineIC=dindgen(n_elements(pmb),start=0,increment=0)
baselineID=dindgen(n_elements(pmb),start=0,increment=0)
baselineIE=dindgen(n_elements(pmb),start=0,increment=0)
baselineIF=dindgen(n_elements(pmb),start=0,increment=0)
baselineRollI=dindgen(n_elements(pmb),start=0,increment=0)
baselineAlphaI=dindgen(n_elements(pmb),start=0,increment=0)
baselineBetaI=dindgen(n_elements(pmb),start=0,increment=0)
baselineYawI=dindgen(n_elements(pmb),start=0,increment=0)
baselineLwcI=dindgen(n_elements(pmb),start=0,increment=0)
baselinePitchI=dindgen(n_elements(pmb),start=0,increment=0)


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
  if (baselineI[i] eq 1) and (((pmb[i] gt 642) and (pmb[i] lt 662)) or ((pmb[i] gt 669.3) and (pmb[i] lt 675.2)) or ((pmb[i] gt 737.5) and (pmb[i] lt 740.5)) or ((pmb[i] gt 780.7) and (pmb[i] lt 783.5))) then begin
    baselineIC[i]=1
  endif
endfor

for i=0, aSpan do begin
  if (baselineI[i] eq 0) then begin
    baselineID[i]=1
  endif
endfor

for i=0, aSpan do begin
  if (baselineI[i] eq 1) and (baseLineIC[i] eq 0) then begin
    baselineIE[i]=1
  endif
endfor

for i=0, aSpan do begin
  if (baselineIE[i] eq 1) and (baseLineIB[i] eq 1) then begin
    baselineIF[i]=1
  endif
endfor





clearAir=where(baselineI eq 1)
levelClearAir=where(baselineIB eq 1)
clearAirLargeErr=where(baselineIC eq 1)
clearAirLargeErrex=where(baselineIE eq 1)
levelClearAirLargeErrex=where(baselineIF eq 1)
signal=where(baselineID eq 1)







linPresCor=linfit(pmb[levelClearAir],lwc[levelClearAir])
lwcPresCor=lwc - (linPresCor[1])*pmb - linPresCor[0]
lwcPresCorDiff = lwcnev1 - lwcPresCor







g  = {as:as, pmb:pmb, time:time, timeForm:timeForm, avroll:avroll, avpitch:avpitch, $
  pLiq:pLiq, lwc:lwc, lwcnev1:lwcnev1, lwcPresCor:lwcPresCor, lwcAsCorrDiff:lwcAsCorrDiff, $
  lwcPresCorDiff:lwcPresCorDiff, clearAir:clearAir, levelClearAir:levelClearAir, linPresCor:linPresCor, $
  flightString:flightString, signal:signal, kLiq:kLiq, clearAirLargeErr:clearAirLargeErr, $
  clearAirLargeErrex:clearAirLargeErrex, levelClearAirLargeErrex:levelClearAirLargeErrex, $
  ilwccol:ilwccol, vlwccol:vlwccol, hivs:hivs, trose:trose, nevtwc:nevtwc, trf:trf}

end