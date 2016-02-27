pro checkbaselineval
days=['0710','0725','0727','0728','0729','0807','0814','0815','0803']
levels=['400','600','900']
levelsb=[400,600,900]
colors=['red','blue','black']
;stats=make_array(n_elements(levels),5)
err=make_array(n_elements(levels))
means=make_array(n_elements(levels))
for j=0,2 do begin
 concatval=[]
 pconcatval=[]
for i=0,n_elements(days)-1 do begin
  
nevBase, days[i],'true',levels[j]



common g, g
clearAir=g.clearAir
pmb=g.pmb[clearair]
lwc=g.lwc
time=g.time
timeForm=g.timeForm
as=g.as
levelClearAir=g.levelClearAir
avroll=g.avroll
avpitch=g.avpitch
pLiq=g.pLiq
lwc=g.lwc[clearair]
lwcnev1=g.lwcnev1
lwcAsCorrDiff=g.lwcAsCorrDiff[clearair]
lwcPresCorDiff=g.lwcPresCorDiff
lwcPresCor=g.lwcPresCor[clearair]
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


;set stat var
var=lwc



;if j eq 0 then plot1=scatterplot(pmb,var,sym_color=colors[j],dimensions=[1200,900])
;if j gt 0 then plot1=scatterplot(pmb,var,sym_color=colors[j],/overplot)

;plot1.yrange=[-.08,.08]

;stats[j,*]=[s.QUART1,s.QUART1,s.MEDVAR,s.QUART2,s.QUART2]

;stats[j,*]=[s.varmean-s.varstddev,s.varmean-s.varstddev,s.varmean,s.varmean+s.varstddev,s.varmean+s.varstddev]

print, days[i],' ',levels[j]
print, n_elements(clearair)
concatval=[concatval, var]


endfor



s= nevstats(var)

;stats[j,*]=[s.varmean-s.varstddev,s.varmean-s.varstddev,s.varmean,s.varmean+s.varstddev,s.varmean+s.varstddev]

err[j,*]=s.varstddev
means[j,*]=s.varmean

endfor




ticks=days
plot1=errorplot([0,1,2],means,err,linestyle='none',dimensions=[1200,900],ERRORBAR_COLOR='red')

plot1.xrange=[-1,3]


plot2=scatterplot([0,1,2],means,/overplot)


;plot1.xtickname=ticks
;plot1.xmajor=n_elements(ticks)+2
;plot1.xminor=0

stop

end