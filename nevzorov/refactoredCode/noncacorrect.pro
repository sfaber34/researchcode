pro noncacorrect

nevBase, '0729','indicated','400'

common g, g
pmb=g.pmb
lwc=g.lwc
time=g.time
timeForm=g.timeForm
as=g.as
clearAir=g.clearAir
levelClearAir=g.levelClearAir
signal=g.signal
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


;lin1=linfit(pLiq[signal],lwc[signal])
;
;lwcPresCor = lwcPresCor + ((lin1[0])*pLiq + lin1[1])
;lwcPresCorDiff = lwcPresCor - lwcnev1

plot1=scatterplot(pLiq[signal],lwcPresCorDiff[signal],symbol='+',sym_size=.45,dimensions=[1200,900],name='Clear Air Points')
;plot2=scatterplot(pmb[levelClearAir],lwc[levelClearAir],symbol='+',sym_size=.45,sym_color='red',/overplot, name='Level Clear Air Points')

lin1Left=360
lin1Right=1000



lin1=linfit(pLiq[signal],lwc[signal])
linYLeft=(lin1[1])*(lin1Left)+lin1[0]
linYRight=(lin1[1])*(lin1Right)+lin1[0]

;plot1lin=plot([lin1Left,lin1Right],[linYLeft,linYRight],/overplot, name='Level Clear Air Point linfit', thick=2)



linYLeftB=(linPresCor[1])*(lin1Left)+linPresCor[0]
linYRightB=(linPresCor[1])*(lin1Right)+linPresCor[0]

;plot2lin=plot([lin1Left,lin1Right],[linYLeftB,linYRightB],/overplot,'r', name='Level Clear Air Point linfit', thick=2)


;text1=string(lin1)
;text1a=text(300, 30, text1, color='red', /device)
;
;text2=string(linPresCor)
;text2a=text(100, 30, text2, /device)
;
;
;plot1.xrange=[lin1Left,lin1Right]
;plot1.yrange=[-.05,.05]
;
;plot1.title='Clear Air LWC ('+flightString+')'
;plot1.xtitle='Pressure [mb]'
;plot1.ytitle='LWC [g/m^3]'
;
;
;
;
;
;plot3=scatterplot(pmb[clearAir],lwc[clearAir],symbol='+',sym_size=.45,dimensions=[1200,900],name='No Correction')
;plot3b=scatterplot(pmb[clearAir],lwcPresCor[clearAir],symbol='+',sym_size=.45,sym_color='blue',/overplot,name='With Correction')
;leg3=legend(target=[plot3,plot3b])
;plot3.xrange=[lin1Left,lin1Right]
;plot3.yrange=[-.05,.05]
;
;
;lin3=linfit(pmb[clearAir],lwc[clearAir])
;linYLeftC=(lin3[1])*(lin1Left)+lin3[0]
;linYRightC=(lin3[1])*(lin1Right)+lin3[0]
;
;plot3lin=plot([lin1Left,lin1Right],[linYLeftC,linYRightC],/overplot, name='Level Clear Air Point linfit', thick=2)
;
;text3=string(lin3)
;text3a=text(100, 30, text3, /device)
;
;
;lin3b=linfit(pmb[clearAir],lwcPresCor[clearAir])
;linYLeftD=(lin3b[1])*(lin1Left)+lin3b[0]
;linYRightD=(lin3b[1])*(lin1Right)+lin3b[0]
;
;plot3lin=plot([lin1Left,lin1Right],[linYLeftD,linYRightD],/overplot,'b', name='Level Clear Air Point linfit', thick=2)
;
;text3b=string(lin3b)
;text3c=text(300, 30, text3b,color='blue', /device)
;
;plot3.title='Clear Air LWC With Pressure Correction ('+flightString+')'
;plot3.xtitle='Pressure [mb]'
;plot3.ytitle='LWC [g/m^3]'
;
;
;lin2Left=55
;lin2Right=105
;
;
;plot4=scatterplot(as[clearAir],lwc[clearAir],symbol='+',sym_size=.45,dimensions=[1200,900],name='No Correction')
;plot4b=scatterplot(as[clearAir],lwcPresCor[clearAir],symbol='+',sym_size=.45,sym_color='blue',/overplot,name='With Correction')
;leg3=legend(target=[plot4,plot4b])
;plot4.xrange=[lin2Left,lin2Right]
;plot4.yrange=[-.05,.05]
;
;
;lin4=linfit(as[clearAir],lwc[clearAir])
;linYLeftD=(lin4[1])*(lin2Left)+lin4[0]
;linYRightD=(lin4[1])*(lin2Right)+lin4[0]
;
;plot4lin=plot([lin2Left,lin2Right],[linYLeftD,linYRightD],/overplot, name='Level Clear Air Point linfit', thick=2)
;
;text4=string(lin4)
;text4a=text(100, 30, text4, /device)
;
;
;lin4b=linfit(as[clearAir],lwcPresCor[clearAir])
;linYLeftE=(lin4b[1])*(lin2Left)+lin4b[0]
;linYRightE=(lin4b[1])*(lin2Right)+lin4b[0]
;
;plot4lin=plot([lin2Left,lin2Right],[linYLeftE,linYRightE],/overplot,'b', name='Level Clear Air Point linfit', thick=2)
;
;text4b=string(lin4b)
;text4c=text(300, 30, text4b,color='blue', /device)
;
;plot4.title='Clear Air LWC With Pressure Correction ('+flightString+')'
;plot4.xtitle='Indicated Airspeed [m/s]'
;plot4.ytitle='LWC [g/m^3]'








return

end