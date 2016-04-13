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

      korX=[2,2.5,5,7.5,10,12.5,15,17.5,20,22.5,23.75]
      korY=[.06,.1,.34,.5,.64,.73,.8,.85,.88,.9,.91]
      korX=korX*1.04436
      



      p1=scatterplot(korX,korY,sym_color=grey,sym_size=.4,symbol=0,dimensions=[1600,1200])



      fit=poly_fit(korX,korY,6,yfit=yfit)     



      p2=plot(korX,yfit,/overplot,color='green',thick=2,linestyle=1)
      p3=plot(korX,yfit+.12,/overplot,color='green',thick=2,linestyle=2)
      p4=plot(korX,yfit-.12,/overplot,color='green',thick=2,linestyle=2)
      
      
      restore,'coleB.sav'
      
      coleBx=dindgen(n_elements(coleB),start=2,increment=2)
      
      p5=scatterplot(coleBx,coleB,sym_size=.5,sym_color='black',/overplot)
      
      
      
;      restore,'cole4.sav'
;
;      cole2x=dindgen(n_elements(cole4),start=1,increment=1)
;
;      p5=scatterplot(cole2x,cole4,sym_size=.5,sym_color='red',/overplot)
;      
;      
;      
;      
;      restore,'cole3.sav'
;
;      cole3x=dindgen(n_elements(cole3),start=1,increment=1)
;
;      p5=scatterplot(cole3x,cole3,sym_size=.5,sym_color='blue',/overplot)
;      p5.YRANGE=[0,1]
;      p5.xrange=[0,25]
      
      
      
      p1.font_size=22

      stop


end
