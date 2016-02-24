pro meankvalscomp

levels=['400 mb','600 mb','900 mb']
color=['red','blue','black']
slope=['0.000697593','0.000482786','0.000670507']
intercept=['0.01942547','0.025647519','-0.003847054']

for i=0,n_elements(levels)-1 do begin
  lineLeft=intercept[i]
  lineRight=160.*slope[i]+intercept[i]
  
  plot1=plot([0,160],[lineleft,lineright],/overplot)
  plot1.color=color[i]
  plot1.name=string(levels[i])
endfor
  plot1.xrange=[60,160]
return

end