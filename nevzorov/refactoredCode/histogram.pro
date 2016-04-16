pro histogram


  ;LIQUID ONLY POINTS OR ALL
  liq=1




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

  liqOnly=where(trf gt -3. and lwc gt .01 and lwc lt .9)
 


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
    cdpdbar2=cdpdbar2[liqonly]
  endif


        
    ;STARTING LEFT VALUE
    binint=2.

    ;WIDTH OF BINS
    binsize=1

    ;LIQUID ONLY POINTS OR ALL
    liq=1

    ;SET VAR
    var=cdpmassmean

    cgcleanup

    if binsize eq 1 then begin
      bincount=60/(binsize*2.)
      ticks=string(dindgen(bincount,start=binint,increment=binsize*2))
    endif else begin
      bincount=60/(binsize*2.)
      ticks=string(dindgen(bincount,start=binint,increment=binsize*2))
    endelse
    
    
    ticks=strsplit(ticks,'.',/extract)

    ticks2=make_array(n_elements(ticks),/string)
    for u=0,n_elements(ticks)-1 do begin
      ticks2[u]=ticks[u,0]
    endfor

    ticks=[strcompress(ticks2),' ',' ']
        
        
        
    
       
        h1=histogram(var,min=binint,binsize=binsize)
        p1=barplot(dindgen(n_elements(h1)),h1, histogram=1,dimensions=[1400,1200],nbars=1,index=k,margin=!margins,/device)
        
        p1.xrange=[0,n_elements(h1)]
        p1.xmajor=n_elements(h1)/2.+1
        p1.xminor=0
        p1.xtickname=ticks
        p1.xtitle='Bin Edge um'
        p1.ytitle='Frequency'
        p1.title='CDP Diameter Dist (Liquid Only Points)'
        p1.font_size=22
        p1.xticklen=1


end
