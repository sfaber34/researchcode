pro errorComppermeanpres
  common g, g

  days=[0710,0725,0727,0728,0729,0803,0807,0814,0815]
  levels=['900','600','400']
    pmb900=[]
    error900=[]
    pmb600=[]
    error600=[]
    pmb400=[]
    error400=[]
    for i=0, n_elements(days)-1 do begin
      for j=0, n_elements(levels)-1 do begin
        nevbase, days[i],'indicated',levels[j]
  
        if levels[j] eq '900' then begin
          pmb900=[pmb900,g.pmb]
          error900=[error900,g.lwcAsCorrDiff]
        endif
  
        if levels[j] eq '600' then begin
          pmb600=[pmb600,g.pmb]
          error600=[error600,g.lwcAsCorrDiff]
        endif
  
        if levels[j] eq '400' then begin
          pmb400=[pmb400,g.pmb]
          error400=[error400,g.lwcAsCorrDiff]
        endif
  
      endfor
      print,'Done with',days[i]
    endfor

  save, filename='errorComppermeanpres.sav', pmb900,error900,pmb600,error600,pmb400,error400
  ;restore, 'errorComppermeanpres.sav', /verbose

  day=['','0710','0725','0727','0728','0729','0803','0807','0814','0815','']
  holder=dindgen(n_elements(error900))

  ytickvals=[]


  xrange=[350,1000]
  plot1=scatterplot(pmb900,error900,dimensions=[1200,900], symbol='+', sym_size=.2, name='900 mb K')
  plot2=scatterplot(pmb600,error600,sym_color='blue',/overplot, name='600 mb K', symbol='+', sym_size=.2)
  plot3=scatterplot(pmb400,error400,sym_color='red',/overplot, name='400 mb K', symbol='+', sym_size=.2)
  plot1.xrange=xrange
  plot1.title='Mean Per Day'
  plot1.ytitle='Absolute Mean LWC Error [g/m^3]
  plot1.xtitle='Flight Day'

  leg1=legend(target=[plot1,plot2,plot3], shadow=0)
  
  
  
  lin900=linfit(pmb900,error900)
  lin600=linfit(pmb600,error600)
  lin400=linfit(pmb400,error400)
  
  lin900lineA=350*lin900[1]+lin900[0]
  lin900lineB=1000*lin900[1]+lin900[0]
  lin600lineA=350*lin600[1]+lin600[0]
  lin600lineB=1000*lin600[1]+lin600[0]
  lin400lineA=350*lin400[1]+lin400[0]
  lin400lineB=1000*lin400[1]+lin400[0]
  
  plot4=plot([350,1000],[lin900lineA,lin900lineB],name='900 mb K',dimensions=[1200,900],thick=2)
  plot5=plot([350,1000],[lin600lineA,lin600lineB],name='600 mb K',color='blue',/overplot,thick=2)
  plot6=plot([350,1000],[lin400lineA,lin400lineB],name='400 mb K',color='red',/overplot,thick=2)
  plot7=plot([350,1000],[0,0],color='black',/overplot,thick=1,line=2)
  
  plot7.title='Lin Fit LWC Error Averaged Across All Flights'
  plot7.xtitle='Pressure [mb]'
  plot7.ytitle='LWC Error [g/m^3]'
  
  leg2=legend(target=[plot4,plot5,plot6],shadow=0)
  plot4.xrange=xrange
  
  
  return

end