pro calcTwcLwcColE




  plots=2

  ;STARTING LEFT VALUE
  binint=2.
  binintstart=binint

  ;WIDTH OF BINS
  binsize=.5
  binsizestart=binsize

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

  liqOnly=where(trf gt -3. and lwc lt 1.1 and cdpconc ge 5)


  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpDEff=cdpDEff[liqonly]
    cdpVolMean=cdpVolMean[liqonly]
    cdpMassMean=cdpMassMean[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwcfixede=lwcfixede[liqonly]
    twcfixede=twcfixede[liqonly]
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
  coleControlLwc=[]
  coleControlTwc=[]
  colevarLwc=[]
  colevarTwc=[]
  colevarbothLwc=[]
  colevarbothTwc=[]

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
  ;------------------------------------------LWC VS LWC,TWC DIFF-------------------------------------------
  ;--------------------------------------------------------------------------------------------------------





  zeros=dindgen(100000,start=0,increment=0)
  twos=dindgen(100000,start=0,increment=0)

  count=0.
  for i=0,n_elements(binistarti)-1 do begin

    bins=binindex[binistarti[i]:biniendi[i]]
    binscon=[binscon,bins]
    countscon=[countscon,n_elements(bins)]

    ;p1=scatterplot(twcfixede[bins],lwcFixede[bins],/overplot,sym_color=color[i],sym_size=.5,dimensions=[1200,1200])
    cole1=ladfit([zeros,lwcfixede[bins]],[zeros,twcfixede[bins]])
    cole2=ladfit([zeros,twcfixede[bins]],[zeros,lwcFixede[bins]])
    cole3=ladfit([zeros,lwc[bins]],[zeros,twcfixede[bins]])
    cole4=ladfit([zeros,twc[bins]],[zeros,lwcfixede[bins]])
    cole5=ladfit([zeros,lwc[bins]],[zeros,twc[bins]])
    cole6=ladfit([zeros,twc[bins]],[zeros,lwc[bins]])
    ;p1.xrange=[0,1.2]
    ;p1.yrange=[0,1.2]


    cole0=[cole0,cole1[0]]
    coleControlTwc=[coleControlTwc,cole1[1]]
    coleControlLwc=[coleControlLwc,cole2[1]]
    colevarTwc=[colevarTwc,cole3[1]]
    colevarLwc=[colevarLwc,cole4[1]]
    colevarbothTwc=[colevarbothTwc,cole5[1]]
    colevarbothLwc=[colevarbothLwc,cole6[1]]


    print,(binistarti[i]/(11982.976*2.))*100.
  endfor

  for i=0,n_elements(cole0)-1 do begin
;          p2=plot([.02,1.2],[cole0[i],1.2*cole1[i]+cole0[i]],/overplot,color=color[i],thick=2)
;          perDiff=strcompress(ticks2[i]+'-'+ticks2[i+1]+'='+string(1.-cole1[i],format='(f8.4)'))
;          t1=text(i*.11,.94,perDiff,font_size=16,color=color[i])
;          print,coleControlTwc
  endfor

  ;cole1=1.-cole1

  save,filename='colesavefile.sav',coleControlLwc,coleControlTwc,colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,binintstart,/verbose
  
  



end
