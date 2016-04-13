pro colescatter




  plots=2

  ;STARTING LEFT VALUE
  binint=2.

  ;WIDTH OF BINS
  binsize=2.

  ;LIQUID ONLY POINTS OR ALL
  liq=1






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

  liqOnly=where(trf gt -3. and lwc gt .02 and lwc lt .9)
  liqOnly2=where(trf gt -3. and lwc gt .02 and lwc lt .9)


  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    ;cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpDEff=cdpDEff[liqonly]
    cdpVolMean=cdpVolMean[liqonly]
    cdpMassMean=cdpMassMean[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
  endif




  ;-------------------------------SET VAR---------------------------------------
  var=cdpMassMean
  ;-------------------------------SET VAR---------------------------------------



  binint2=binint+binsize


  dBarBI=dblarr(bincount,n_elements(pmb))
  dbarbinn=dindgen(bincount,start=0,increment=0)


  binstart=[]
  binend=[]
  binindex=[]
  binistarti=[]
  biniendi=[]
  binscon=[]
  countscon=[]
  ncountscon=[0]
  cole0=[]
  cole1=[]


  starti=0
  endi=0

  for i=0,bincount-1 do begin
    selectinds=where(var ge binint and var le binint2)


    if selectinds[0] ne -1 then begin


      binindex=[binindex,selectinds]
      binistarti=[binistarti,starti]

      endi=starti+n_elements(selectinds)
      biniendi=[biniendi,endi-1]

    endif
    starti=endi



    binint=binint+binsize
    binint2=binint2+binsize
  endfor




  for i=0,n_elements(binistarti)-1 do begin

    bins=double(binindex[binistarti[i]:biniendi[i]])
    binscon=[binscon,bins]
    countscon=double([countscon,n_elements(bins)])
    ;ncountscon=double([ncountscon+n_elements(bins)])


  endfor




  ncountscon=dindgen(n_elements(binistarti),start=ncountscon, increment=0)




  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------COLE SCATTER----------------------------------------------
  ;--------------------------------------------------------------------------------------------------------


      cgcleanup


      korX=[1,3,5,6.5,10,15,20,25,30,35,40,45,50]
      korY=[.06,.1,.3,.4,.58,.76,.85,.905,.93,.95,.96,.97,.975]
     
;      korX=[0,5,10,15,20,25,50]
;      korY=[.2,.85,.97,.98,.99,.995,1]
      
      xs=dindgen(501,start=0,increment=.1)

      p1=scatterplot(korX,korY,sym_color=grey,sym_size=.1,symbol=0,dimensions=[1600,1200])



      fit=poly_fit(korX,korY,5,yfit=yfit) 
      ;fit=comfit(korX,korY,[.02,.3,fit2[0]],yfit=yfit,/geometric,itmax=400000,iter=its)    

      line=fit[0]+fit[1]*xs+fit[2]*xs^2.+fit[3]*xs^3.+fit[4]*xs^4.+fit[5]*xs^5.

      p2=plot(xs[0:300],line[0:300],/overplot,color='green',thick=2)
      p2=plot([30,50],[line[300],.975],/overplot,color='green',thick=2)

      p1.xrange=[0,50]
      
      restore,'coletest.sav'
      coleB=coleTest
      
      coleBx=dindgen(n_elements(coleB),start=5,increment=.2)
      
      p5=scatterplot(coleBx,coleB,sym_size=.5,sym_color='black',/overplot)
      
      p5.xrange=[0,50]
      p5.yrange=[0,1]
      
restore,'coletest3.sav'
      coleB=coleTest3
      
      coleBx=dindgen(n_elements(coleB),start=5,increment=.2)
      
      p5=scatterplot(coleBx,coleB,sym_size=.5,sym_color='red',/overplot)
      
      p5.xrange=[0,50]
      p5.yrange=[0,1]
      
      
      
      p1.font_size=22

      stop


end
