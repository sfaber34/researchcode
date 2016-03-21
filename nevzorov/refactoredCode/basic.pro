pro basic


stuff=20

;flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
;flight='0307'
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
presdevcon=[]


if stuff eq 13 then begin
  level=['400','700']
  flightb=['0727','0307']
  level=['400']
  flightb=['0727']
colors=['red','green','blue','black']
cgcleanup
for i=0,n_elements(flightb)-1 do begin
  g= nevBase(flightb[i],'indicated','400')
  p1=plot(g.timeFlight,g.rawsignal,dimensions=[1400,1000])
  p2=plot(g.timeFlight,g.smoothsignal,dimensions=[1400,1000])
  p3=plot([min(g.timeFlight),max(g.timeFlight)],[g.thresh,g.thresh],'r',/overplot,name='Threshold',thick=3)
  ;p1=plot(g.timeFlight,g.lwc100,/overplot,'r')
  p1.ytitle="Liquid Power Difference (Volt)"
  p1.xtitle="Flight Time (sec)"
  p1.FONT_SIZE=24
  p1.yrange=[0,2]
  p1.xrange=[min(g.timeFlight),max(g.timeFlight)]
  p1.save,'rawsignal.ps'
  
  p2.ytitle="Liquid Power Difference (Volt)"
  p2.xtitle="Flight Time (sec)"
  p2.FONT_SIZE=24
  p2.yrange=[-.02,.3]
  p2.xrange=[min(g.timeFlight),max(g.timeFlight)]
  l1=legend(position=[400,100],target=[p3],/device,shadow=0)
  stop
  p2.save,'smoothsignal.ps'
  
  
  
;  p2=plot(g.timeFlight,g.lwc,dimensions=[1400,1000],title=flightb[i])
;  p1=scatterplot(g.timeFlight[g.clearair],g.lwc[g.clearair],sym_color='red',/overplot)
  
  endfor
 ; thresh2=.005
  
  ;raw=((g.vlwccol)-(g.vlwcref))
  
;  u=sort(raw)
;  u=reverse(u)
;  u1=u[0]
;  u2=u[50]
;  
;  x1=min([u1,u2])
;  x2=max([u1,u2])
;  thresh2=.0045*mean(raw[x1:x2])
;  
;  
;  
;  
;  print,thresh2/mean(raw[x1:x2])
;
;
;  int=10
;correction=dindgen(n_elements(g.pmb),increment=0)
;smooth=dindgen(n_elements(g.pmb),increment=0)
;
; for a=0,n_elements(g.pmb)-(int+1) do begin
;  correction[a:a+int]=min(raw[a:a+int])
;  a=a+int
;endfor
;
;
;for b=0,n_elements(g.pmb)-(int+1) do begin
;  smooth[b:b+int]=raw[b:b+int]-correction[b:b+int]
;  b=b+int
;endfor
;
;  diff=ts_diff(smooth,1)
;    
;    
; clear=where(abs(diff) le thresh2 and shift(abs(diff),1) le thresh2 and shift(abs(diff),-1) le thresh2)
;    
;
;
;p2=plot(g.timeFlight,g.lwc,dimensions=[1400,1000],title=flightb[i])
;p1=scatterplot(g.timeFlight[clear],g.lwc[clear],sym_color='red',/overplot)
;  p1.yrange=[-.06,.06]
;  print, double(n_elements(clear))/double(n_elements(g.lwc))
;
;  endfor


    
;    h=histogram((abs(g.lwc-g.lwc100)/abs(g.lwc100)),binsize=2,max=100)
;    p1=barplot((dindgen(n_elements(h))),h,ylog=1)
;    stop
;    x=smooth(g.timeFlight,.1*n_elements(g.timeFlight))
;    y=smooth(abs(g.lwc-g.lwc100)/abs(g.lwc100),.1*n_elements(g.timeFlight))
;    p1=plot(x,y,dimensions=[1400,1000],'black',/overplot)
    ;p2=plot(g.timeFLight,g.lwc100,dimensions=[1400,1000],'red',/overplot)




endif



if stuff eq 20 then begin
;  cgcleanup
  lwccon=[]
  lwcnev1con=[]
  low=0.
  high=3.
  
  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
  for i=0, n_elements(flight)-1 do begin
  g= nevBase(flight[i],'indicated','400')
  
  p1=scatterplot(g.lwcnev1,g.lwc,dimensions=[1000,1000],/overplot,xrange=[low,high],yrange=[low,high])
  lwccon=[lwccon,g.lwc]
  lwcnev1con=[lwcnev1con,g.lwcnev1]
  endfor
  
  lin=linfit(lwcnev1con,lwccon)
  p2=plot([low,high],[low,high],thick=2,'red',/overplot)
  p2=plot([low,high],[low*lin[1]+lin[0],high*lin[1]+lin[0]],thick=2,'blue',linestyle=2,/overplot)
  p2.xtitle="CDP LWC (g m!U-3!N)"
  p2.ytitle="Calculated LWC (g m!U-3!N)"
  p2.font_size=24

  stop
endif







if stuff eq 12 then begin
  g= nevBase('0307','indicated','400')

  diff=g.lwc-g.lwc100

  p1=plot(g.timeFlight,diff,dimensions=[1400,1000])
  p1=plot(g.timeFlight,g.lwc100,/overplot,'r')
  p1.xtitle="Alexei's LWC g m!U-3!N"
  p1.ytitle="LWC Difference (Alexei's - Mine) g m!U-3!N"
  p1.FONT_SIZE=20
  p1.xrange=[-.02,2]
  p1.yrange=[-.2,.05]

  stop
endif



if stuff eq 11 then begin
  g= nevBase('0815','indicated','400')
  
  diff=g.lwcnev1-g.lwc
  
  p1=scatterplot(g.lwcnev1,diff,dimensions=[1400,1000])
  p1.xtitle="Alexei's LWC g m!U-3!N"
  p1.ytitle="LWC Difference (Alexei's - Mine) g m!U-3!N"
  p1.FONT_SIZE=20
  p1.xrange=[-.02,2]
  p1.yrange=[-.2,.05]
  
  stop
endif




if stuff eq 10 then begin
  for j=0,n_elements(klevel)-1 do begin
    lwccon=[]
    pmbcon=[]
    levelerrorcon=[]
    for i=0,n_elements(flight)-1 do begin
    g= nevBase(flight[i],ktype[0],kLevel[j])
    lwccon=[lwccon,abs(g.lwcnoprescor[g.clearair])]
    pmbcon=[pmbcon,g.pmb[g.clearair]]
    print,flight[i],' ',kLevel[j]
    
    
  endfor
  
  pmbconsort=sort(pmbcon)
  pmbconsorted=pmbcon[pmbconsort]
  lwcconsorted=lwccon[pmbconsort]

  pmbsmooth=smooth(pmbconsorted,50)
  lwcsmooth=smooth(lwcconsorted,50)
  
  if kLevel[j] eq '400' then begin
    pmbsmooth400=pmbsmooth
    lwcsmooth400=lwcsmooth
  endif
  if kLevel[j] eq '600' then begin
    pmbsmooth600=pmbsmooth
    lwcsmooth600=lwcsmooth
  endif
  if kLevel[j] eq '900' then begin
    pmbsmooth900=pmbsmooth
    lwcsmooth900=lwcsmooth
  endif
  ;plot1=plot(pmbsmooth,lwcsmooth,dimensions=[1400,1000])
endfor
  plot2=plot(pmbsmooth400,lwcsmooth400,'r',dimensions=[1400,1000])
  plot3=plot(pmbsmooth600,lwcsmooth600,'blue',/overplot)
  plot3=plot(pmbsmooth900,lwcsmooth900,/overplot)
  plot2.xrange=[1000,400]
  
  stop
endif






if stuff eq 9 then begin
  for i=0,n_elements(flight)-1 do begin
    g= nevBase(flight[i],ktype[0],kLevel[0])
      lwccon=[lwccon,abs(g.lwcnoprescor[g.clearair])]
      pmbcon=[pmbcon,abs(600-g.pmb[g.clearair])]
      print,flight[i]
  endfor
  
  
  plot1=scatterplot(pmbcon,lwccon,dimensions=[1400,1000])
  stop
endif






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