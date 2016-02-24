pro noncacorrect

nevBase, '0729'

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
signal=g.signal
ilwccol=g.ilwccol
vlwccol=g.vlwccol
hivs=g.hivs
trose=g.trose
nevtwc=g.nevtwc
trf=g.trf


;plot1=scatterplot(time,pmb,symbol='+',sym_size=.45,dimensions=[1200,900],name='Clear Air Points')
;plot1a=plot(pLiq, thresh,'r',/overplot)
;plot2=scatterplot(pmb[levelClearAir],lwc[levelClearAir],symbol='+',sym_size=.45,sym_color='red',/overplot, name='Level Clear Air Points')

plot1=scatterplot(pLiq[signal],lwcPresCorDiff[signal],symbol='+',sym_size=.45,dimensions=[1200,900],name='Clear Air Points')

plot1.title='Signal Points ('+flightString+')'
plot1.xtitle='Liquid Collector Power [watt]'
plot1.ytitle='LWC Difference [g/m^3]'

plot1.xrange=[0,20]
plot1.yrange=[-.2,.05]

pLiq=pLiq[signal]
pLiqSignalS=sort(pLiq)
pLiq=pLiq[pLiqSignalS]

avroll=avroll[signal]
avroll=avroll[pLiqSignalS]

avpitch=avpitch[signal]
avpitch=avpitch[pLiqSignalS]

time=time[signal]
time=time[pLiqSignalS]

lwcPresCorDiff=lwcPresCorDiff[signal]
lwcPresCorDiff=lwcPresCorDiff[pLiqSignalS]

lwc=lwc[signal]
lwc=lwc[pLiqSignalS]

lwcNev1=lwcNev1[signal]
lwcNev1=lwcNev1[pLiqSignalS]

pmb=pmb[signal]
pmb=pmb[pLiqSignalS]

as=as[signal]
as=as[pLiqSignalS]

trose=trose[signal]
trose=trose[pLiqSignalS]

nevtwc=nevtwc[signal]
nevtwc=nevtwc[pLiqSignalS]

thresh=(-.06/15)*pLiq+(.0066)

signalA=0.
signalB=0.
for i=0,n_elements(pLiq)-1 do begin
  if lwcPresCorDiff[i] gt thresh[i] then signalA=[signalA,i] else signalB=[signalB,i]
endfor

unitVector=dindgen(1501, start=0., increment=0.01)

plot2=scatterplot(pLiq[signalA],lwcPresCorDiff[signalA],symbol='+',sym_size=.45,sym_color='red',/overplot)
plot3=scatterplot(pLiq[signalB],lwcPresCorDiff[signalB],symbol='+',sym_size=.45,sym_color='blue',/overplot)

lin1Left=0
lin1Right=15









return

end