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
  
  
  restore,'colesavefile.sav'
  coleB=colecontrollwc

  ;for TWC
  p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,dimensions=[1600,1200])
  
  ;for LWC
  ;p3=plot(massmeansorted,coletotsorted,color='green',thick=2,linestyle=2,dimensions=[1600,1200])

  

  

  coleBx=dindgen(n_elements(coleB),start=binintstart,increment=binsizestart)

  p5=scatterplot(coleBx,coleB,sym_size=.7,sym_color='black',/overplot)
  
  p6=scatterplot(coleBx,colevarlwc,sym_size=.7,sym_color='blue',/overplot)
  
  p7=scatterplot(coleBx,colevarbothlwc,sym_size=.7,sym_color='red',/overplot)
  ;p5=scatterplot(coleBx,colevartwc,sym_size=.7,sym_color='green',/overplot)
  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2)

  p5.xrange=[0,50]
  p5.yrange=[0,1.4]

  ;p5.


  p5.font_size=22

  stop


end