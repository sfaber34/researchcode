pro colescatterreal




  plots=2

  ;STARTING LEFT VALUE
  binint=2.

  ;WIDTH OF BINS
  binsize=.3

  ;LIQUID ONLY POINTS OR ALL
  liq=0






  bincount=60/binsize
  ticks=string(dindgen(bincount,start=binint,increment=binsize))
  ticks=strsplit(ticks,'.',/extract)

  ticks2=make_array(n_elements(ticks),/string)
  for u=0,n_elements(ticks)-1 do begin
    ticks2[u]=ticks[u,0]
  endfor

  ticks=[strcompress(ticks2),' ',' ']


  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------



  color=['black','deep sky blue','green','firebrick','purple','dark orange','sienna',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'deep sky blue','green','firebrick','purple','dark orange','sienna','midnight blue',$
    'dark olive green','firebrick','dark slate grey','dark khaki','black','deep sky blue',$
    'green','firebrick','purple','dark orange',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black']



  restore,'loopdata.sav'




  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------COLE SCATTER----------------------------------------------
  ;--------------------------------------------------------------------------------------------------------


;  coleControlLwc=[]
;  coleControlTwc=[]
;  colevarLwc=[]
;  colevarTwc=[]
;  colevarbothLwc=[]
;  colevarbothTwc=[]


  ;cgcleanup


  xs=dindgen(501,start=0,increment=.1)

  ;p1=scatterplot(korX,korY,sym_color=grey,sym_size=.1,symbol=0,dimensions=[1600,1200])



  massmeansort=sort(cdpmassmean)
  massmeansorted=cdpmassmean[massmeansort]
  coleliqsorted=coleliq[massmeansort]
  coletotsorted=coletot[massmeansort]
  coletotsorted2=coletot2[massmeansort]
  
  
  restore,'colesavefile.sav'
  coleB=colecontrollwc
  
  type='twc2'
  
  if type eq 'twc' then begin
    var1=colevarlwc
    var2=colevartwc
    ;var3=colevarbothlwc
  endif else if type eq 'twc2' then begin
    var1=colevarlwc
    var2=colevarLwc2
    ;var3=colevarbothtwc
  endif else if type eq 'lwc' then begin
    var1=colevarcontroltwc
    var2=colevartwc
    ;var3=colevarbothtwc
  endif
  
  


  

  

  coleBx=dindgen(n_elements(coleB),start=binintstart,increment=binsizestart)
  hErr=dindgen(n_elements(coleB),start=2.,increment=0)
  yErr=dindgen(n_elements(coleB),start=0,increment=0)
  
  e5=errorplot(coleBx,var1,hErr,yErr,errorbar_thick=2,linestyle=6,xaxis=0,errorbar_color='light grey',symbol=0,dimensions=[1200,1200])
  e6=errorplot(coleBx,var2,hErr,yErr,errorbar_thick=2,linestyle=6,xaxis=0,errorbar_color='light blue',symbol=0,/overplot)
  ;e7=errorplot(coleBx,var3,hErr,yErr,linestyle=6,xaxis=0,errorbar_color='light coral',symbol=0,/overplot)

  p5=scatterplot(coleBx,var1,sym_thick=2,sym_color='black',/overplot,name=type+' Eq. Coll. E')
  p6=scatterplot(coleBx,var2,sym_thick=2,sym_color='blue',/overplot,name=type+' Corrected Eq. Coll. E') 
  ;p7=scatterplot(coleBx,var3,sym_size=.7,sym_color='red',/overplot)
  
  l1=legend(target=[p5,p6],shadow=0,/device,font_size=22)
  
  
  ;p5=scatterplot(coleBx,colevartwc,sym_size=.7,sym_color='green',/overplot)
  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2, thick=2)
  p5.xtitle='VMD um'
  p5.ytitle='Equivalent/Corrected Equivalent Coll. E.'

  p5.xrange=[0,50]
  p5.yrange=[0,1.4]
  
  
  
  
  
  ;for LWC
  if type eq 'lwc' then p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=!margins,/device,/overplot)

  ;for TWC
  if type eq 'twc' then p3=plot(massmeansorted,coletotsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=!margins,/device,/overplot)

  ;for TWC2
  if type eq 'twc2' then p4=plot(massmeansorted,coletotsorted2,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=!margins,/device,/overplot)

  ;p5.


  p5.font_size=22


stop

end