pro checkbaselineval
days=['0710','0725','0727','0728','0729','0807','0814','0815','0803']



for i=0,n_elements(days)-1 do begin
  
nevBase, days[i],'indicated','400'

common g, g
pmb=g.pmb
lwc=g.lwc
time=g.time
timeForm=g.timeForm
as=g.as
clearAir=g.clearAir
levelClearAir=g.levelClearAir
avroll=g.avroll
avpitch=g.avpitch
pLiq=g.pLiq
lwc=g.lwc
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
linPresCorSteepClimb=g.linPresCorSteepClimb
baselineClimbTimesNon=g.baselineClimbTimesNon
baselineClimbTimesNonLevel=g.baselineClimbTimesNonLevel
hivs=g.hivs
lowhivs=g.lowhivs
highhivs=g.highhivs
lowhivslevel=g.lowhivslevel
endfor




end