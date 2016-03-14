pro basic
g=nevBase('0727','indicated','400')

stuff=2

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
;pmbdifftime=g.pmbdifftime
;pmbdiffTimeNon=g.pmbdiffTimeNon
;pmbdiff=g.pmbdiff
;pmbdiffTimeNonlevel=g.pmbdiffTimeNonlevel
;pmbdifflevel=g.pmbdifflevel
hivs=g.hivs
lowhivs=g.lowhivs
highhivs=g.highhivs
lowhivslevel=g.lowhivslevel
lwc100=g.lwc100
cdpdbar_NRB=g.cdpdbar_NRB
cdpconc_NRB=g.cdpconc_NRB
pvmlwc=g.pvmlwc
cdplwc_NRB=g.cdplwc_NRB




if stuff eq 1 then begin

lin1=linfit(pmb[clearair],lwcPresCor[clearair])
linleft=(lin1[1])*400.+(lin1[0])
linright=(lin1[1])*1000.+(lin1[0])

plot2=plot([400,1000],[linleft,linright],'r',thick=2,dimensions=[1000,800])
plot1=scatterplot(pmb[clearair],lwcPresCor[clearair],symbol='+',sym_size=.4,/overplot)
plot1.xrange=[400,1000]
plot1.yrange=[-.04,.04]
plot1.font_size=16

plot1.title='Clear Air LWC - With Baseline Correction (07/27/13 Flight)'
plot1.xtitle='Flight Level Pressure mb'
plot1.ytitle='LWC Error g m!U-3!N'

plot1.Save,'0727withprescor.ps'

endif






if stuff eq 2 then begin
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
  
  
  
  
  
  
  
plot1=plot(timeForm,lwcPresCor, dimensions=[1000,800])

plot2=plot(timeForm,lwcnev1, 'green', dimensions=[1000,800],/overplot)

;plot2=plot(timeForm,cdplwc_NRB, 'red', dimensions=[1000,800],/overplot)  
  
;plot2.xrange=[1.302d5,1.304d5]
endif




end