pro checkbaselineval
days=['0710','0725','0727','0728','0729','0807','0814','0815','0803']
levels=['400','600','900']
levelsb=[400,600,900]
colors=['red','blue','black']
stats=make_array(n_elements(levels),5)
stats2=[]
for j=0,2 do begin
 concatval=[]
 pconcatval=[]
;for i=0,n_elements(days)-1 do begin
  
nevBase, '0725','indicated',levels[j]



common g, g
clearAir=g.clearAir
pmb=g.pmb
lwc=g.lwc
time=g.time
timeForm=g.timeForm
as=g.as
baselineprefilter=g.baselineprefilter
levelClearAir=g.levelClearAir
avroll=g.avroll
avpitch=g.avpitch
pLiq=g.pLiq
lwc=g.lwc
lwcnev1=g.lwcnev1
lwcAsCorrDiff=g.lwcAsCorrDiff
lwcPresCorDiff=g.lwcPresCorDiff
lwcPresCor=g.lwcPresCor[baselineprefilter]
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

;s= nevstats(lwcPresCor)
plot1=scatterplot(pmb[baselineprefilter],lwcPresCor,sym_color=colors[j],/overplot)

;print, levels[j],'-',days[i],' ',n_elements(concatval)

endfor

;s= nevstats(levelsb[j],concatval)
;stats[j,*]=[s.minvar,s.QUART1,s.MEDVAR,s.QUART2,s.maxvar]
;stats2=[stats2,s]

;endfor

ticks=days
plot1=boxplot(stats)
;plot1.xtickname=ticks
;plot1.xmajor=n_elements(ticks)+2
;plot1.xminor=0

stop

end