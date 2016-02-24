pro nevzorov

;set to 1 to run loadvar
loadVars=1

;path to ncl file
nclPath='/Volumes/sfaber1/research/nevzorov/20151124.c1.nc'

;start time
iStart=

;end time
iEnd=


;-----constants-----

;surface area liquid sensor [m^2]
aLiq=.003

;surface area total sensor [m^2]
aTot=.005

;liquid collection efficiency
colELiq=1.

;total collection efficiency
colETot=1.

;sensor temperature [C]
sensT=90.

;liquid water latent heat of evaporation at 100C [J/Kg]
l=2.25d6

;liquid water specific heat [J/Kg K]
cLiq=4218.



;-----run loadvar-----

if loadVars eq 1 then begin
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
  airspeed=loadvar('tas', filename=nclPath)
  
  ;time
  time=loadvar('TIME', filename=nclPath)
  
endif





;-----calculations-----

;liquid coefficient
;kLiq=(vlwccol*ilwccol)/(vlwcref*ilwcref)
kLiq=(vlwccol*ilwccol)/(vlwcref*ilwcref)
kLiqMean=mean(kLiq[1000:3000])
kLiq=1


;liquid expanded heat [J K/Kg]
;exHLiq=cLiq*(sensT-trf)+l*sensT
exHLiq=2589

;liquid heat loss [W]
hLossLiq=(vlwccol*ilwccol)-kLiq*(vlwcref*ilwcref)

;liquid water content [Kg/m^2]
wLiq=hLossLiq/(colELiq*airspeed*aLiq*exHLiq)


plot1=plot(time,wLiq)




return

end