pro errorCompAirspeed
  common g, g

  days=[0710,0725,0727,0728,0729,0803,0807,0814,0815]
  levels=['900','600','400']
    as900=[]
    error900=[]
    as600=[]
    error600=[]
    as400=[]
    error400=[]
;    for i=0, n_elements(days)-1 do begin
;      for j=0, n_elements(levels)-1 do begin
;        nevbase, days[i],'indicated',levels[j]
;  
;        if levels[j] eq '900' then begin
;          as900=[as900,g.as]
;          error900=[error900,g.lwcAsCorrDiff]
;        endif
;  
;        if levels[j] eq '600' then begin
;          as600=[as600,g.as]
;          error600=[error600,g.lwcAsCorrDiff]
;        endif
;  
;        if levels[j] eq '400' then begin
;          as400=[as400,g.as]
;          error400=[error400,g.lwcAsCorrDiff]
;        endif
;  
;      endfor
;      print,'Done with',days[i]
;    endfor

  ;save, filename='errorCompPerMeanasVals.sav', as900,error900,as600,error600,as400,error400
  restore, 'errorCompPerMeanasVals.sav', /verbose

  day=['','0710','0725','0727','0728','0729','0803','0807','0814','0815','']
  holder=dindgen(n_elements(error900))

  ytickvals=[]


  xrange=[55,110]
  plot3=scatterplot(as900,error900,dimensions=[1200,900], symbol='+', sym_size=1, name='Clear Air')
  plot2=scatterplot(as600,error600,sym_color='blue',/overplot, name='600 mb K', symbol='+', sym_size=.2)
  plot1=scatterplot(as400,error400,sym_color='red',/overplot, name='Level Clear Air', symbol='+', sym_size=1)
  plot1.xrange=xrange
  plot1.title='Mean Per Day'
  plot1.ytitle='Absolute Mean LWC Error [g/m^3]
  plot1.xtitle='Flight Day'

  leg1=legend(target=[plot3,plot1], shadow=0)
  
  
  
  lin900=linfit(as900,error900)
  lin600=linfit(as600,error600)
  lin400=linfit(as400,error400)
  
  lin900lineA=55*lin900[1]+lin900[0]
  lin900lineB=110*lin900[1]+lin900[0]
  lin600lineA=55*lin600[1]+lin600[0]
  lin600lineB=110*lin600[1]+lin600[0]
  lin400lineA=55*lin400[1]+lin400[0]
  lin400lineB=110*lin400[1]+lin400[0]
  
  plot4=plot([55,110],[lin900lineA,lin900lineB],name='900 mb K',dimensions=[1200,900],thick=2)
  plot5=plot([55,110],[lin600lineA,lin600lineB],name='600 mb K',color='blue',/overplot,thick=2)
  plot6=plot([55,110],[lin400lineA,lin400lineB],name='400 mb K',color='red',/overplot,thick=2)
  plot7=plot([55,110],[0,0],color='black',/overplot,thick=1,line=2)
  
  plot7.title='Lin Fit LWC Error Averaged Across All Flights'
  plot7.xtitle='Indicated Airspeed [m/s]'
  plot7.ytitle='LWC Error [g/m^3]'
  
  leg2=legend(target=[plot4,plot5,plot6],shadow=0)
  plot4.xrange=xrange
  
  
  return

end