pro getColeE

;img=read_png('/Volumes/sfaber1/Research/nevzorov/coleEChart.png')
img=read_png('Z:\Research\nevzorov\coleEChart.png')
;imageRGB = img[0:2, *,*]
;tv,imagergb,true=1
vals=profile(img)

end