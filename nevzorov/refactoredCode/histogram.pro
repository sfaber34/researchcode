pro histogram

run=2

if run eq 1 then begin
  g= nevBase('0727','indicated','400')

  clear=where(lwcnev1 lt .02)
  rawdiff=ts_diff(g.rawsignal)

  p1=plot(g.timeFlight,g.rawsignal,sym_color=colors[i],symbol='+',dimensions=[1400,1000],title='raw')
  p2=scatterplot(g.timeFlight[clear],g.rawsignal[clear],sym_color=colors[i],symbol='+',sym_color='red',/overplot)
  p3=plot(g.timeFlight,rawdiff,sym_color=colors[i],symbol='+',dimensions=[1400,1000],title='diff')
  p4=scatterplot(g.timeFlight[clear],rawdiff[clear],sym_color=colors[i],symbol='+',sym_color='red',/overplot)
  stop

restore,'cons.sav',/verbose
restore,'consca.sav',/verbose

inc=.005


h=histogram(lwcConca,binsize=inc)
ticks=['.02','.04',' ',' ']

stop
plot1=barplot(dindgen(n_elements(h)),h,histogram=1)
plot1.xtickname=ticks
plot1.xtext_orientation=270
plot1.yrange=[1,1d5]
endif

if run eq 2 then begin
  restore, 'loopdata.sav'
  
  inc=2.
  
  dbar3m=cdpdbar^3.
  
  dbar=cdpdbar[where(cdpacc gt 0.)]
  dbar3=dbar3m[where(cdpacc gt 0.)]
  
  
  


  h=histogram(dbar,binsize=inc,REVERSE_INDICES=r)
;  tickstart=string(dindgen(n_elements(
;  ticks=[,' ',' ']

  plot1=barplot(dindgen(n_elements(h)),h,histogram=1,ylog=1)
  ;plot1.xrange=[1,3.9d13]
  ;plot1.xtickname=ticks
  plot1.xtext_orientation=270
  stop
endif


end