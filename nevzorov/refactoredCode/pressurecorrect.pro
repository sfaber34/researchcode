pro pressurecorrect

nevBase, '0803','indicated','400'

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


;lwc640660=where(((pmb lt 640) or (pmb gt 660)) and lwc lt .05 and ((pmb lt 669) or (pmb gt 675)) and ((pmb lt 680) or (pmb gt 691)) and (abs(avRoll) lt 5) and (avpitch lt (mean(avpitch) + 2) and avpitch gt (mean(avpitch) - 2)))
lwc640660=where(((timeform gt 142000) and (timeform lt 152400)) and lwc lt .05)
lwc640660ex=where(((timeform lt 142000) or (timeform gt 152400)) and lwc lt .05)
lwc640660non=where(((timeform lt 142000) or (timeform gt 152400)) and lwc lt .05 and (abs(avRoll) lt 5) and (avpitch lt (mean(avpitch) + 2) and avpitch gt (mean(avpitch) - 2)))

plot1=scatterplot(pmb[clearair],lwc[clearair],symbol='+',sym_size=.45,dimensions=[1200,900],name='Clear Air Points')
plot2=scatterplot(pmb[levelClearair],lwc[levelClearair],symbol='+',sym_size=.45,sym_color='red',/overplot, name='Level Clear Air Points')

lin1Left=300
lin1Right=1000



lin1=linfit(pmb[clearair],lwc[clearair])
linYLeft=(lin1[1])*(lin1Left)+lin1[0]
linYRight=(lin1[1])*(lin1Right)+lin1[0]


plot1lin=plot([lin1Left,lin1Right],[linYLeft,linYRight],/overplot, name='Level Clear Air Point linfit', thick=2)


linYLeftB=(linPresCor[1])*(lin1Left)+linPresCor[0]
linYRightB=(linPresCor[1])*(lin1Right)+linPresCor[0]

;lwcPresCor=lwcPresCor - (linPresCor[1])*pmb - (linPresCor[0])

plot2lin=plot([lin1Left,lin1Right],[linYLeftB,linYRightB],/overplot,'r', name='Level Clear Air Point linfit', thick=2)


text1=string(lin1)
text1a=text(300, 30, text1, color='red', /device)

text2=string(linPresCor)
text2a=text(100, 30, text2, /device)


plot1.xrange=[lin1Left,lin1Right]
plot1.yrange=[-.05,.05]

plot1.title='Clear Air LWC ('+flightString+')'
plot1.xtitle='Pressure [mb]'
plot1.ytitle='LWC [g/m^3]'




plot3=scatterplot(pmb[clearair],lwc[clearair],symbol='+',sym_size=.45,dimensions=[1200,900],name='No Correction')
plot3b=scatterplot(pmb[clearair],lwcPresCor[clearair],symbol='+',sym_size=.45,sym_color='blue',/overplot,name='With Correction')
leg3=legend(target=[plot3,plot3b])
plot3.xrange=[lin1Left,lin1Right]
plot3.yrange=[-.05,.05]


lin3=linfit(pmb[clearair],lwc[clearair])
linYLeftC=(lin3[1])*(lin1Left)+lin3[0]
linYRightC=(lin3[1])*(lin1Right)+lin3[0]

plot3lin=plot([lin1Left,lin1Right],[linYLeftC,linYRightC],/overplot, name='Level Clear Air Point linfit', thick=2)

text3=string(lin3)
text3a=text(100, 30, text3, /device)


lin3b=linfit(pmb[clearair],lwcPresCor[clearair])
linYLeftD=(lin3b[1])*(lin1Left)+lin3b[0]
linYRightD=(lin3b[1])*(lin1Right)+lin3b[0]

plot3lin=plot([lin1Left,lin1Right],[linYLeftD,linYRightD],/overplot,'b', name='Level Clear Air Point linfit', thick=2)

text3b=string(lin3b)
text3c=text(300, 30, text3b,color='blue', /device)

plot3.title='Clear Air LWC ('+flightString+')'
plot3.xtitle='Pressure [mb]'
plot3.ytitle='LWC [g/m^3]'


lin2Left=55
lin2Right=105


plot4=scatterplot(as[clearAir],lwc[clearAir],symbol='+',sym_size=.45,dimensions=[1200,900],name='No Correction')
plot4b=scatterplot(as[clearAir],lwcPresCor[clearAir],symbol='+',sym_size=.45,sym_color='blue',/overplot,name='With Correction')
leg3=legend(target=[plot4,plot4b])
plot4.xrange=[lin2Left,lin2Right]
plot4.yrange=[-.05,.05]


lin4=linfit(as[clearAir],lwc[clearAir])
linYLeftD=(lin4[1])*(lin2Left)+lin4[0]
linYRightD=(lin4[1])*(lin2Right)+lin4[0]

plot4lin=plot([lin2Left,lin2Right],[linYLeftD,linYRightD],/overplot, name='Level Clear Air Point linfit', thick=2)

text4=string(lin4)
text4a=text(100, 30, text4, /device)


lin4b=linfit(as[clearAir],lwcPresCor[clearAir])
linYLeftE=(lin4b[1])*(lin2Left)+lin4b[0]
linYRightE=(lin4b[1])*(lin2Right)+lin4b[0]

plot4lin=plot([lin2Left,lin2Right],[linYLeftE,linYRightE],/overplot,'b', name='Level Clear Air Point linfit', thick=2)

text4b=string(lin4b)
text4c=text(300, 30, text4b,color='blue', /device)

plot4.title='Clear Air LWC With Pressure Correction ('+flightString+')'
plot4.xtitle='Indicated Airspeed [m/s]'
plot4.ytitle='LWC [g/m^3]'








return

end