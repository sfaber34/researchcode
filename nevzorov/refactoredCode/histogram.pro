pro histogram

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

end