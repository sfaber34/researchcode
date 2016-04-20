pro getColeE

img=read_png('/Volumes/sfaber1/Research/nevzorov/graphics/coleEChartTotE.png')

cgcleanup

;imageRGB = img[0:2, *,*]
;tv,imagergb,true=1


color=['blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red',$
  'blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red']


blackx=dindgen(n_elements(img[0,*,0]))
blacky=[]

for i=0,n_elements(img[0,*,0])-1 do begin
  b=where(img[0,i,*] lt 200)
  bm=round(mean(b))
  blacky=[blacky,bm]

endfor

blacky=blacky[where(blacky gt 0.)]
blackx=blackx[where(blacky gt 0.)]

blackx=(blackx*(5770./(n_elements(blackx)-1.)))*(300./5770.)

blacky=blacky/2872.

print,max(blackx)

stop
x1=blackx[0:150]
y1=blacky[0:150]

p1=scatterplot(x1,y1,dimensions=[1600,1200],symbol='.')

fit1=poly_fit(x1,y1,4,yfit)
p2=plot(x1,yfit,color=color[0],/overplot)



x2=blackx[150:320]
y2=blacky[150:320]

p3=scatterplot(x2,y2,dimensions=[1600,1200],symbol='.')

fit2=poly_fit(x2,y2,4,yfit2)
p4=plot(x2,yfit2,color=color[1],/overplot)




x3=blackx[320:1400]
y3=blacky[320:1400]

p4=scatterplot(x3,y3,dimensions=[1600,1200],symbol='.')

fit3=poly_fit(x3,y3,6,yfit3)
p5=plot(x3,yfit3,color=color[0],/overplot)





x4=blackx[1400:4639]
y4=blacky[1400:4639]

p5=scatterplot(x4,y4,dimensions=[1600,1200],symbol='.')

fit4=poly_fit(x4,y4,4,yfit4)
p6=plot(x4,yfit4,color=color[1],/overplot)





p20=scatterplot(blackx,blacky,dimensions=[1600,1200])
p2=plot(x1,yfit,color=color[0],/overplot)
p2=plot(x2,yfit2,color=color[1],/overplot)
p2=plot(x3,yfit3,color=color[0],/overplot)
p2=plot(x4,yfit4,color=color[1],/overplot)


stop


end