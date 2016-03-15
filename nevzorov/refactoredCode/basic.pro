pro basic

stuff=0

flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
flight=['0729']

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

colors=['black','red','green','blue','magenta','yellow','purple','orange','grey']

if stuff eq 0 then begin
for i=0,n_elements(flight)-1 do begin
  
  g=nevBase(flight[i],'indicated','400')

  plot2=plot(g.timeForm,g.lwcnev1,'red',thick=2)
  plot1=plot(g.timeForm,g.lwc,/overplot,linestyle=2,thick=1)
  
  plot1.xrange=[1.21d5,1.221d5]
  
  ;plot2=plot(g.timeForm[g.clearair],g.vlwccol[g.clearair],'red',/overplot)
  stop
    pmbcon=[pmbcon,g.pmb]
    lwccon=[lwccon,g.lwc]
    ascon=[ascon,g.as]
    cdpdbar_NRBcon=[cdpdbar_NRBcon,g.cdpdbar_NRB]
    cdpconc_NRBcon=[cdpconc_NRBcon,g.cdpconc_NRB]
    trfcon=[trfcon,g.trf]
    lwc100con=[lwc100con,g.lwc100]
    lwcnev1con=[lwcnev1con,g.lwcnev1]
    clearaircon=[clearaircon,g.clearair]
    avpitchcon=[avpitchcon,g.avpitch]
    avrollcon=[avrollcon,g.avroll]
    
    print,flight[i]
    
    error= g.lwc - g.lwcnev1
    errorcon=[errorcon,error]
    
    plot1=scatterplot(g.as,error,sym_color=colors[i],/overplot)
    
;    plot1=scatterplot(g.lwcnev1,g.lwc,symbol='+',sym_size=.8,/overplot,dimensions=[1200,1200])
;    plot1.xrange=[0,2.5]
;    plot1.yrange=[0,2.5]
;    plot1.title="Comparison of Korolev's LWC and Calculated LWC For All Flights"
;    plot1.xtitle="Korolev's LWC g m!U-3!N"
;    plot1.ytitle="Calculated LWC g m!U-3!N"
    
    
    
endfor
;  plot2=plot([0,2.5],[0,2.5],'red',thick=2,/overplot)
;  plot2.Save,'lwcminevskorolev.ps'
stop
save,pmbcon,lwcPresCorcon,lwcnev1con,ascon,lwc100con,cdpdbar_NRBcon,filename='consaves.sav'

endif

if stuff eq 1 then begin
  
  g=nevBase('0727','indicated','400')
stop
lin1=linfit(g.pmb[g.clearair],g.pLiq[g.clearair])
linleft=(lin1[1])*400.+(lin1[0])
linright=(lin1[1])*1000.+(lin1[0])

plot2=plot([400,1000],[linleft,linright],'r',thick=2,dimensions=[1000,800])
plot1=scatterplot(g.pmb[g.clearair],g.pLiq[g.clearair],symbol='+',sym_size=.4,/overplot)
plot1.xrange=[400,1000]
plot1.yrange=[-.3,.3]
plot1.font_size=16

plot1.title='Clear Air Power - With Pressure Baseline Correction (07/27/13 Flight)'
plot1.xtitle='Flight Level Pressure mb'
plot1.ytitle='Clear Air Power W'

plot1.Save,'0727Pliqwithprescor.ps'

endif






if stuff eq 2 then begin
restore,'consaves.sav',/verbose  
  
plot1=plot(timeForm,lwcPresCor, dimensions=[1000,800])

plot2=plot(timeForm,lwcnev1, 'green', dimensions=[1000,800],/overplot)

;plot2=plot(timeForm,cdplwc_NRB, 'red', dimensions=[1000,800],/overplot)  
  
;plot2.xrange=[1.302d5,1.304d5]


endif



if stuff eq 3 then begin
  

  restore,'consaves.sav',/verbose

  error=lwcPresCorCon - lwcnev1con

  plot1=scatterplot(ascon,error, dimensions=[1000,800],symbol='+',sym_size=.3)

  ;plot2=scatterplot(ascon,lwcnev1con, sym_color='green', dimensions=[1000,800],/overplot,symbol='+',sym_size=.3)

  ;plot2=plot(timeForm,cdplwc_NRB, 'red', dimensions=[1000,800],/overplot)

  ;plot2.xrange=[1.302d5,1.304d5]


endif

levels=['700','600','500','400']

if stuff eq 4 then begin

for i=0,n_elements(levels)-1 do begin

  g=nevBase('0307','indicated',levels[i])
  
  plot1=scatterplot(g.pmb[g.clearair],g.lwc[g.clearair])
  print, mean(abs(g.lwc))
endfor

endif  







end