;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;CALCULATES NEVZOROV LIQUID WATER CONTENT, TOTAL WATER CONTENT
;
;NOTE - K (DRY AIR HEAT LOSS COEF) MUST BE MANUALLY ENTERED BEFORE CALC
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



function nevbase, flightDay, airspeedType, level



RESOLVE_ROUTINE, 'convertTime',/is_function
RESOLVE_ROUTINE, 'loadvar',/is_function,/no_recompile


common t,t
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
  if flightDay eq '0307' then nclPath='Z:\research\nevzorov\data\030716\20160307.c1.nc'
  if flightDay eq '0304' then nclPath='Z:\research\nevzorov\data\030416\20160304.c1.nc'
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
  if flightDay eq '1217' then nclPath='../data/121715/20151217.c1.nc'
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

;liquid water content from Nevzorov probe [g/m^3]
if cope eq 1 then lwcNev1=loadvar('nevlwc1', filename=nclPath)
if cope ne 1 then lwcNev1=0

;liquid water content from Nevzorov probe [g/m^3]
if cope eq 1 then lwcNev2=loadvar('nevlwc2', filename=nclPath)
if cope ne 1 then lwcNev2=0

;Total water content from Nevzorov probe [g/m^3]
if cope eq 1 then twcNev=loadvar('nevtwc', filename=nclPath)
if cope ne 1 then twcNev=0

;Sideslip Angle [deg]
betaB=loadvar('beta', filename=nclPath)

;Yaw [deg]
avyawr=loadvar('avyawr', filename=nclPath)

;Attack Angle [rad]
alpha=loadvar('alpha', filename=nclPath)

;Flight Time [sec]
timeFlight=dindgen(n_elements(pmb),start=0,increment=1)

;Hour
hour=loadvar('HOUR', filename=nclPath)

;Hour
min=loadvar('MINUTE', filename=nclPath)

;Hour
sec=loadvar('SECOND', filename=nclPath)


;Convert time for axis

hourst=string(hour)
hourstsp=strsplit(hourst,'.',/extract)
minst=string(min)
minstsp=strsplit(minst,'.',/extract)
secst=string(sec)
secstsp=strsplit(secst,'.',/extract)

hourstspb=SINDGEN(n_elements(hourst))
minstspb=SINDGEN(n_elements(hourst))
secstspb=SINDGEN(n_elements(hourst))

for i=0,n_elements(hourst)-1 do begin
  hourstspb[i]=hourstsp[i,0]
  minstspb[i]=minstsp[i,0]
  secstspb[i]=secstsp[i,0]
endfor
hourstspb=strtrim(hourstspb,1)
minstspb=strtrim(minstspb,1)
secstspb=strtrim(secstspb,1)

timePretty=hourstspb+':'+minstspb+':'+secstspb

t={hour:hour,min:min,sec:sec,timeForm:timeForm}





;-----------------------------------------SET START/STOP TIMES----------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


if flightDay eq '0807' then begin
  flightString='08-07-13'
  aStart=convertTime(12,41,00)
  aEnd=convertTime(15,54,00)
  
;  aStart=convertTime(13,25,58)
;  aEnd=convertTime(14,01,40)
endif

if flightDay eq '0814' then begin
  flightString='08-14-13'
  aStart=convertTime(11,54,00)
  aEnd=convertTime(15,02,00)
endif

if flightDay eq '0710' then begin
  flightString='07-10-13'
  ;aStart=convertTime(11,31,00)
  aStart=convertTime(11,50,00)
  aEnd=convertTime(14,20,00)
endif

if flightDay eq '0725' then begin
  flightString='07-25-13'
  aStart=convertTime(10,22,00)
  aEnd=convertTime(13,48,00)
endif

if flightDay eq '0727' then begin
  flightString='07-27-13'
  aStart=convertTime(11,49,17)
  aEnd=convertTime(13,50,00)
endif

if flightDay eq '0728' then begin
  flightString='07-28-13'
  aStart=convertTime(11,47,00)
  aEnd=convertTime(15,05,00)
endif

if flightDay eq '0729' then begin
  flightString='07-29-13'
  aStart=convertTime(11,49,10)
  aEnd=convertTime(14,57,00)
endif

if flightDay eq '0815' then begin
  flightString='08-15-13'
  aStart=convertTime(12,25,00)
  aEnd=convertTime(14,57,00)
endif

if flightDay eq '0803' then begin
  flightString='08-03-13'
  aStart=convertTime(11,34,45)
  aEnd=convertTime(15,07,00)
endif

if flightDay eq '0304' then begin
  flightString='03-04-16'
  aStart=convertTime(17,25,00)
  aEnd=convertTime(18,46,00)
endif

if flightDay eq '0307' then begin
  flightString='03-07-16'
  aStart=convertTime(22,11,00)
  aEnd=convertTime(00,04,00)
endif

if flightDay eq '1217' then begin
  flightString='12-17-15'
  aStart=convertTime(22,11,00)
  aEnd=convertTime(00,04,00)
endif




;-----------------------------------------APPLY START/STOP TIMES TO VARIABLES----------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


vlwcref=vlwcref[aStart:aEnd]
vlwccol=vlwccol[aStart:aEnd]
vtwcref=vtwcref[aStart:aEnd]
vtwccol=vtwccol[aStart:aEnd]
ilwcref=ilwcref[aStart:aEnd]
itwccol=itwccol[aStart:aEnd]
itwcref=itwcref[aStart:aEnd]
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
timeFlight=timeFlight[aStart:aEnd]

if cope eq 1 then begin
  lwcNev1=lwcNev1[aStart:aEnd]
  lwcNev2=lwcNev2[aStart:aEnd]
  twcNev=twcNev[aStart:aEnd]
  hivs=hivs[aStart:aEnd]
  vtwcref=vlwcref
  itwcref=ilwcref
endif






;------------------------------------------CONVERSIONS---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;CONVERT INDICATED AIRSPEED TO M/S
aiasMs=aias*.514444

if airspeedType eq 'true' then begin
  as=tas
endif

if airspeedType eq 'indicated' then begin
  as=aiasMs
endif



;-----------------------------------------Kliq---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





;----------------------------------------------------K LIQUID---------------------------------------------------------------

if cope eq 1 then begin
  if (airspeedType eq 'indicated') and (level eq '900') then kLiq=(2.47292)*aiasms^(-0.273777)+(0.399143) ;900 indicated
  if (airspeedType eq 'indicated') and (level eq '600') then kLiq=(3.73599)*aiasms^(-0.0628865)+(-1.67763) ;600 indicated
  if (airspeedType eq 'indicated') and (level eq '400') then kLiq=(36.0089)*aiasms^(-1.26173)+(1.03362) ;400 indicated
  
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








;----------------------------------------------------K TOTAL----------------------------------------------------

if cope eq 1 then begin
  if (airspeedType eq 'indicated') and (level eq '900') then kTot=(10.8603)*aiasms^(-0.675924)+(0.167331) ;900 indicated
  if (airspeedType eq 'indicated') and (level eq '600') then kTot=(3.39234)*aiasms^(-0.182697)+(-0.737908) ;600 indicated
  if (airspeedType eq 'indicated') and (level eq '400') then kTot=(224.264)*aiasms^(-1.73025)+(0.725502) ;400 indicated

  if (airspeedType eq 'true') and (level eq '900') then kTot=(35.0933)*tas^(-1.00354)+(0.318860) ;900 true
  if (airspeedType eq 'true') and (level eq '600') then kTot=(3.83487)*tas^(-0.238794)+(-0.496087) ;600 true
  if (airspeedType eq 'true') and (level eq '400') then kTot=(9874.83)*tas^(-2.45898)+(0.753854) ;400 true
endif



if cope eq 2 then begin
  if (airspeedType eq 'indicated') and (level eq '700') then kTot=(-0.0258749)*aiasms^(0.711242)+(1.37937)
  if (airspeedType eq 'indicated') and (level eq '600') then kTot=(-0.104706)*aiasms^(0.468563)+(1.64276)
  if (airspeedType eq 'indicated') and (level eq '500') then kTot=(-0.0249307)*aiasms^(0.698422)+(1.39464)
  if (airspeedType eq 'indicated') and (level eq '400') then kTot=(-0.0700741)*aiasms^(0.512351)+(1.56121) ;400 indicated
endif





;------------------------------------------FILTER CLEAR AIR---------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

correctionLiq=dindgen(n_elements(pmb),increment=0)
smoothSignalLiq=dindgen(n_elements(pmb),increment=0)

correctionTot=dindgen(n_elements(pmb),increment=0)
smoothSignalTot=dindgen(n_elements(pmb),increment=0)



;----------SIGNAL RATIO----------

;-----LIQUID-----
rawSignalLiq=(vlwccol)






;-----TOTAL-----
rawSignalTot=(vtwccol)



;----------BASELINE DETECTION STEP----------
int=10

for i=0,n_elements(pmb)-(int+1) do begin
  correctionLiq[i:i+int]=min(rawSignalLiq[i:i+int])
  i=i+int
endfor


for i=0,n_elements(pmb)-(int+1) do begin
  smoothSignalLiq[i:i+int]=rawSignalLiq[i:i+int]-correctionLiq[i:i+int]
  i=i+int
endfor

intb=20

for i=0,n_elements(pmb)-(intb+1) do begin
  correctionTot[i:i+intb]=min(rawSignalTot[i:i+intb])
  i=i+int
endfor


for i=0,n_elements(pmb)-(intb+1) do begin
  smoothSignalTot[i:i+intb]=rawSignalTot[i:i+intb]-correctionTot[i:i+intb]
  i=i+int
endfor




diffLiq=smoothSignalLiq


uLiq2=sort(rawSignalLiq)
uLiq3=reverse(uLiq2)
uLiq=diffLiq[uLiq3]
u1Liq=uLiq[0]
u2Liq=uLiq[50]

x1Liq=min([u1Liq,u2Liq])
x2Liq=max([u1Liq,u2Liq])
if cope eq 0 or cope eq 2 then threshLiq=.007*mean(rawSignalLiq[0:50])
if cope eq 1 then threshLiq=.007*mean(rawSignalLiq[0:50])







diffTot=smoothSignalTot


uTot2=sort(diffTot)
uTot3=reverse(uTot2)
uTot=diffTot[uTot3]
u1Tot=uTot[0]
u2Tot=uTot[50]


x1Tot=min([u1Tot,u2Tot])
x2Tot=max([u1Tot,u2Tot])
if cope eq 0 or cope eq 2 then threshTot=.085*mean(uTot[0:50])
if cope eq 1 then threshTot=0.0025*mean(uTot[0:50])

 
    
clearairLiq=where(abs(diffLiq) le threshLiq and shift(abs(diffLiq),1) le threshLiq and shift(abs(diffLiq),-1) le threshLiq and shift(abs(diffLiq),2) le threshLiq and shift(abs(diffLiq),-2) le threshLiq)
clearairTot=where(abs(diffTot) le threshTot and abs(shift(diffTot,1)) le threshTot and abs(shift(diffTot,-1)) le threshTot and abs(shift(diffTot,2)) le threshTot and abs(shift(diffTot,-2)) le threshTot)


clearairLiq=clearairLiq[30:n_elements(clearairLiq)-30]
clearairTot=clearairTot[30:n_elements(clearairTot)-30]



clearairTotsort=sort(vtwccol[clearairTot])
clearairTotsortsorted=clearairTot[clearairTotsort]
clearairTotsortsorted=clearairTotsortsorted[n_elements(clearairTotsortsorted)*.01:n_elements(clearairTotsortsorted)*.99]







;------------------------------------------FILTER MISC.---------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




aSpan = n_elements(pmb) - 1

BetaI=dindgen(n_elements(pmb),start=0,increment=0)
baselineIB=dindgen(n_elements(pmb),start=0,increment=0)
baselineRollI=dindgen(n_elements(pmb),start=0,increment=0)
baselineYawI=dindgen(n_elements(pmb),start=0,increment=0)
baselinePitchI=dindgen(n_elements(pmb),start=0,increment=0)
baselineI=dindgen(n_elements(pmb),start=0,increment=0)



for i=0, aSpan do begin
  if (abs(avRoll[i]) lt 5) then begin
    baselineRollI[i]=1
  endif
  if (avpitch[i] lt (mean(avpitch) + 2) and avpitch[i] gt (mean(avpitch) - 2)) then begin ;0871013
    baselinePitchI[i]=1
  endif
  if (betaB[i] lt -.014 and betaB[i] gt -.026) then begin
    BetaI[i]=1
  endif
  if (abs(avyawr[i]) lt .003) then begin
    baselineYawI[i]=1
  endif
  if (baselineI[i] eq 1) and (baselineRollI[i] eq 1) and (baselinePitchI[i] eq 1) and (baselineYawI[i]=1) then begin
    baselineIB[i]=1
  endif
endfor



levelclearairLiq=where(baselineIB eq 1)






;-----------------------------------------CONSTANTS-------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;-----LIQUID-----

;surface area liquid sensor [m^2]
aLiq=3.17d-5


;liquid collection efficiency
colELiq=1.


;EXPENDED HEAT FOR LIQUID
lLiqStar=2589.


;LIQUID SENSOR ICE COLLECTION EFFICIENCY
betaLiq=0.11



;-----TOTAL-----

;surface area total sensor [m^2]
aTot=5.02d-5
;aTot=4.82d-5

;total collection efficiency
colETot=1.

;-------PAR BY TRF---------
;-------SEE 3/23/16 IN LOG---------
;colETot=0.49964736687174566+trf*(-0.0030369760138078371)


;EXPENDED HEAT FOR LIQUID
lIceStar=lLiqStar



;-----HEAT LOSS LIQUID------
pLiq=vlwccol*ilwccol-kLiq*vlwcref*ilwcref
pLiqNoPresCor=pLiq


lwcNoPresCor=pLiq/(colELiq*tas*aLiq*lLiqStar)




;-----HEAT LOSS TOTAL------
pTot=vtwccol*itwccol-kTot*vtwcref*itwcref
pTotNoPresCor=pTot

twcNoPresCor=pTot/(colETot*tas*aTot*lIceStar)



;-----------------------------------------PRESSURE correctionLiq---------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


linPresCorLiq=linfit(pmb[clearairLiq],pLiqNoPresCor[clearairLiq])

;poly=poly_fit(pmb[clearairLiq],pLiqNoPresCor[clearairLiq],2)
pLiq=pLiqNoPresCor - ( linPresCorLiq[1]*pmb + linPresCorLiq[0] )





linPresCorTot=linfit(pmb[clearairTot],pTotNoPresCor[clearairTot])

;poly=poly_fit(pmb[clearairTot],pTot[clearairTot],2)
pTot=pTotNoPresCor - ( linPresCorTot[1]*pmb + linPresCorTot[0] )



;-----------------------------------------CALCULATIONS---------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


;WATER CONTENT LIQUID
lwc=pLiq/(colELiq*tas*aLiq*lLiqStar)





;WATER CONTENT TOTAL
twc=pTot/(colETot*tas*aTot*lIceStar)





g  = {as:as, pmb:pmb, time:time, timeForm:timeForm, avroll:avroll, avpitch:avpitch, $
  pLiq:pLiq, lwc:lwc, lwcnev1:lwcnev1, twcNev:twcNev, lwcNoPresCor:lwcNoPresCor, twc:twc,$
  clearairLiq:clearairLiq, levelclearairLiq:levelclearairLiq,timeFlight:timeFlight,$
  flightString:flightString, kLiq:kLiq,threshLiq:threshLiq, clearairTot:clearairTot,$
  aiasMs:aiasMs, tas:tas,vlwcref:vlwcref, ilwcref:ilwcref, twcNoPresCor:twcNoPresCor,$
  vlwccol:vlwccol, ilwccol:ilwccol, cdpconc:cdpconc_NRB, trf:trf, threshTot:threshTot,$
  lwc100:lwc100, cdpdbar:cdpdbar_NRB,lwcnev2:lwcnev2, timePretty:timePretty,$
  avyaw:avyawr,pvmlwc:pvmlwc,cdplwc:cdplwc_NRB,pLiqNoPresCor:pLiqNoPresCor,$
  rawSignalLiq:rawSignalLiq, smoothSignalLiq:smoothSignalLiq, cdpacc:cdpacc,colETot:colETot,$
  rawSignalTot:rawSignalTot, smoothSignalTot:smoothSignalTot, pTot:pTot,pTotNoPresCor:pTotNoPresCor,$
  vtwccol:vtwccol,itwccol:itwccol,vtwcref:vtwcref,itwcref:itwcref,aTot:aTot,lIceStar:lIceStar}

  
return,g

end




function convertTime,hh,mm,ss
  common t,t
  timeindex=where(t.hour eq hh and t.min eq mm and t.sec eq ss)
  return,timeindex
end



pro info
print,''
print,''
print,'-------------COPE-----------------'
print,'LEVELS COPE = 400, 600, 900'
print,'DAYS COPE = 0710, 0725, 0727, 0728, 0729, 0803, 0807, 0814, 0815, ||0709||'
print,''
print,''
print,'-----------LARAMIE----------------'
print,'LEVELS LARAMIE = 400, 500, 600, 700'
print,'DAYS LARAMIE = 0307, ||0304||'
print,''
print,'-------------COMMANDS-----------------'
print,'SUPERSCRIPT = !U *** !N'
end

pro setwd

  cd,current=h
  h=STRMATCH(h, '*/nevzorov/*')

  if !version.OS_FAMILY eq 'unix' then begin
    if h ne 1 then cd,'/Volumes/sfaber1/research/nevzorov/refactoredCode'
  endif else begin
    if h ne 1 then cd,'Z:\research\nevzorov/refactoredCode'
  endelse
end  
  
