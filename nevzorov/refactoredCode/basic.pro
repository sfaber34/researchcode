pro basic

g=nevBase('0807','indicated','400')
stop
stuff=8

flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
flight='0307'
kLevel=['400','500','600','700']
ktype=['indicated']
colors=['black','red','green','blue','magenta','yellow','purple','orange','grey']

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

if stuff eq 8 then begin
  
  for k=0,n_elements(ktype)-1 do begin

    for i=0,n_elements(kLevel)-1 do begin

      lwccon=[]
      pmbcon=[]
      ascon=[]
      cdpdbar_NRBcon=[]
      cdpconc_NRBcon=[]
      lwcnoPresCorDiffcon=[]
      trfcon=[]
      clearaircon=[]
      hivscon=[]
      asdelcon=[]
      
      for j=0,n_elements(flight)-1 do begin
        g= nevBase(flight[j],ktype[k],kLevel[i])
        plot1=plot(g.time[g.clearair],g.lwc[g.clearair],dimensions=[1400,1000],color=colors[i],/overplot)
        
      endfor
    endfor
  endfor
endif




if stuff eq 0 then begin
for i=0,n_elements(flight)-1 do begin
  
  g=nevBase(flight[i],'indicated','400')
  
  t=[where(g.timeForm eq 132300),where(g.timeForm eq 140000)]

  ;plot2=plot(g.timeForm,g.lwcnev1,'red',thick=2)
  ;plot1=plot(g.timeForm,g.lwc,/overplot,linestyle=2,thick=1)
  
  ;plot1.xrange=[1.21d5,1.221d5]
  
  ;plot2=plot(g.timeForm[g.clearair],g.vlwccol[g.clearair],'red',/overplot)

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

    
    plot1=plot(g.timeFlight,g.lwc,title=string(flight[i]))
    ;plot1.xrange=[8.7d3,9.2d3]
    plot2=scatterplot(g.timeFlight[g.clearair],g.lwc[g.clearair],symbol='+',sym_color='red',/overplot,title='pdifslope')
;    plot2=plot(g.timeFlight,idifslope,title='idifslope')
    ;plot3=scatterplot(g.as[g.signal],g.lwc[g.signal],title='rawpslope',/overplot)
    ;plot3=plot(g.timeFlight,g.lwc,title='rawpslope')
    ;plot3=scatterplot(g.timeFlight[g.clearair],g.lwc[g.clearair],/overplot,sym_color='red',title='rawpslope')
    print,(where(g.lwc[g.clearair] gt .03))
    print, max(g.lwc[g.clearair])


    ;plot3=scatterplot(g.timeFlight[g.posEnd],rawpslope[g.posEnd],sym_color='red',symbol='+',title='rawpslope',/overplot)
    ;plot3=scatterplot(g.timeFlight[g.negend],rawpslope[g.negend],sym_color='green',symbol='+',title='rawpslope',/overplot)

    ;plot3.xrange=[2.75d3,2.78d3]
    ;plot3.yrange=[-.09,.09]
;    plot4=plot(g.timeFlight,vslope,title='vslope')
;    plot5=plot(g.timeFlight,pdifslope,title='islope')
    
    
    ;plot1=scatterplot(g.lwcnev1,error,sym_color=colors[i],/overplot)

    ;plot1=scatterplot(((g.vlwccol*g.ilwccol)-(g.vlwcref*g.ilwcref)),g.lwc,sym_color=colors[i],/overplot)

;    plot1=plot(g.timeFlight,(g.vlwccol*g.ilwccol),sym_color=colors[i])
;    plot1=plot(g.timeFlight[g.clearair],(g.vlwccol[g.clearair]*g.ilwccol[g.clearair]),color='red',/overplot)
;    plot1.xrange=[6d3,6.2d3]
    ;plot2=plot(g.timeForm,g.lwcnev1,color='red',/overplot)
    ;plot1.xrange=[132500,140300]
    ;plot1.yrange=[-.1,.1]

;    plot1=scatterplot(g.lwcnev1,g.lwc,symbol='+',sym_size=.8,/overplot,dimensions=[1200,1200])
;     lin=linfit(g.lwcnev1,g.lwc,CHISQR=CHISQR)
;    plot1.xrange=[0,2.5]
;    plot1.yrange=[0,2.5]
;    plot1.title="Comparison of Korolev's LWC and Calculated LWC For All Flights"
;    plot1.xtitle="Korolev's LWC g m!U-3!N"
;    plot1.ytitle="Calculated LWC g m!U-3!N"

    
    
endfor
;  plot2=plot([0,2.5],[0,2.5],'red',thick=2,/overplot)
;  plot2.Save,'lwcminevskorolev.ps'
lin=linfit(lwcnev1con,lwccon,CHISQR=CHISQR)
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
cgcleanup
endif  
flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815','0307']

if stuff eq 5 then begin
  countcon=0
  for i=0,n_elements(flight)-1 do begin
    g=nevBase(flight[i],'indicated','400')
    ;p2=plot(g.time,g.lwc,dimensions=[1400,1000])
    p3=scatterplot(g.time[g.clearair],g.lwc[g.clearair],sym_color='red',symbol='.')
    t=(double(n_elements(g.clearair))/double(n_elements(g.time)))*100.
    t2=string(t)
    text1=text(100,100,t2,/device)
    countcon=[countcon+n_elements(g.clearair)]
    print,countcon
  endfor  
  
  stop
  g=nevBase('0815','indicated','400')
  
  p1=plot(g.time,s,dimensions=[1400,1000])
  
  
  ;p2=plot(g.time,g.lwc)
  ;p3=scatterplot(g.time[g.clearair],g.lwc[g.clearair],sym_color='red',symbol='.',/overplot)

  ratio2=(g.vlwccol*g.ilwccol)-g.kliq*(g.vlwcref*g.ilwcref)
  ;ratio2=(g.vlwccol)/g.vlwcref
  ratioshift=shift(ratio2,1)
  ratio=ratio2-ratioshift
  unitvec=dindgen(n_elements(g.pmb))
  pline=dindgen(n_elements(g.pmb))
  clear=dindgen(n_elements(g.pmb),increment=0)
  
    pline=dindgen(n_elements(g.pmb),start=.06,increment=0)
    pline2=dindgen(n_elements(g.pmb),start=-.06,increment=0)
    
    for i=0,n_elements(g.pmb)-6 do begin
    if ratio[i] lt pline[i] and ratio[i] gt pline2[i] and ratio[i+1] lt pline[i+1] and ratio[i+1] gt pline2[i+1] and ratio[i+2] lt pline[i+2] and ratio[i+2] gt pline2[i+2] and ratio[i+3] lt pline[i+3] and ratio[i+3] gt pline2[i+3] and ratio[i+4] lt pline[i+4] and ratio[i+4] gt pline2[i+4] and ratio[i+5] lt pline[i+5] and ratio[i+5] gt pline2[i+5] then clear[i]=1
    endfor
    
    clears=where(clear eq 1)
  
  p1=plot(unitvec,ratio2)
  p2=plot(unitvec,pline,'r',/overplot)
  p2=plot(unitvec,pline2,'g',/overplot)
  stop
  p3=plot(unitvec,g.lwc)
  p4=scatterplot(unitvec[clears],g.lwc[clears],sym_color='red',symbol='.',/overplot)
p2.yrange=[-.4,.4] 
;p2.xrange=[1500,2500] 

p3.yrange=[-.04,.04]
p3.xrange=[1500,2500]
  
  ;p2=scatterplot(g.timeFlight[g.clearair],g.vlwccol[g.clearair],/overplot,symbol='.',sym_color='red')
stop
endif  








end