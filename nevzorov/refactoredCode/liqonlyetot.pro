pro liqonlyETot
 



plots=2

;STARTING LEFT VALUE
binint=1.

;WIDTH OF BINS
binsize=6.

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



  color=['black','midnight blue','dark olive green','firebrick','purple','dark orange','sienna','deep sky blue','chartreuse','goldenrod','dark slate grey','dark khaki']



   restore,'loopdata.sav'
   
   



    if liq eq 1 then begin
      lwc=lwc[liqonly]
      twc=twc[liqonly]
      cdpdbar=cdpdbar[liqonly]
      cdpconc=cdpconc[liqonly]
      cdpThirdM=cdpThirdM[liqonly]
    endif
    
;    h1=histogram(cdpThirdM,binsize=3,min=1)
;    p1=barplot(dindgen(n_elements(h1)),h1, histogram=1,dimensions=[1600,1400])

    
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
      selectinds=where(cdpThirdM ge binint and cdpThirdM le binint2)
      
      
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

      bins=binindex[binistarti[i]:biniendi[i]]
      binscon=[binscon,bins]
      countscon=[countscon,n_elements(bins)]
      ncountscon=[ncountscon+n_elements(bins)]

      ;tickname=strsplit(string(min(cdpdbar[bins])),'.',/extract)
      ;ticks=dindgen(bincount,start=binint,increment=binsize)
      ;ticks=[ticks,tickname[0]]


    endfor
    
    
    
    
    ncountscon=dindgen(n_elements(binistarti),start=ncountscon, increment=0)
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------LWC VS LWC,TWC DIFF-------------------------------------------
    ;--------------------------------------------------------------------------------------------------------
    
    
    
    if plots eq 0 then begin


    cgcleanup

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)

      
      for i=0,n_elements(binistarti)-1 do begin
      
      bins=binindex[binistarti[i]:biniendi[i]]
      binscon=[binscon,bins]
      countscon=[countscon,n_elements(bins)]
     
     p1=scatterplot(lwc[bins],lwc[bins]-twc[bins],/overplot,sym_color=color[i],sym_size=.5,dimensions=[1600,1000])
     p1.xtitle='LWC g m!u-3!n'
     p1.ytitle='LWC - TWC g m!u-3!n' 
     p1.font_size=22  
     cole=ladfit([lwc[bins]],[lwc[bins]-twc[bins]])
      
      
     cole0=[cole0,cole[0]]
     cole1=[cole1,cole[1]]
     print,1.-cole[1]
     
     
     for i=0,n_elements(cole0)-1 do begin
       p2=plot([.02,2.5],[cole0[i],2.5*cole1[i]+cole0[i]],/overplot,color=color[i],thick=2)
     endfor
  
      endfor
    endif


    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------LWC/TWC 1:1 COMP----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------
    
    
    
    if plots eq 1 then begin


      cgcleanup

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)

      
      for i=0,n_elements(binistarti)-1 do begin

        bins=binindex[binistarti[i]:biniendi[i]]

        p1=scatterplot(lwc[bins],twc[bins],sym_color=color[i],sym_size=.2,dimensions=[1000,1000])
        p1.xrange=[0,2.5]
        p1.yrange=[0,2.5]
        
        p1.TITLE=STRCOMPRESS(string(min(cdpThirdM[bins]))+'-'+string(max(cdpThirdM[bins])),/remove_all)
        cole=ladfit([zeros,lwc[bins]],[zeros,twc[bins]])
        p2=plot([0,2.5],[0,2.5],/overplot,color='black',thick=2,linestyle=2)
        p2=plot([0,2.5],[cole[0],2.5*cole[1]+cole[0]],/overplot,color=color[i],thick=2)


        print,cole[1]


      endfor
    endif
    
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;---------------------------------------------------HISTOGRAM---------------------------------------------
    ;--------------------------------------------------------------------------------------------------------
    
    if plots eq 2 then begin

      
      
      cgcleanup


      
      
      p1=barplot(dindgen(n_elements(countscon)),countscon, histogram=1,dimensions=[1600,1400])
      
      p1.xrange=[0,n_elements(countscon)]
      p1.xmajor=n_elements(countscon)+1
      p1.xminor=0
      p1.xtickname=ticks
      p1.xtitle='Bin Edge um'
      p1.ytitle='Frequency'
      p1.font_size=22
      stop
    endif
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------LWC/TWC 1:1 COMP DIFFERENCE-----------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 3 then begin


      cgcleanup

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)



        p1=scatterplot(lwc,twc,sym_color='midnight blue',sym_size=.5,dimensions=[1000,1000])
        p1.xrange=[0,2.5]
        p1.yrange=[0,2.5]
        p1.xtitle='LWC g m!u-3!n'
        p1.ytitle='TWC g m!u-3!n'
        p1.TITLE='LWC vs. TWC Liquid Only Points' 
        p1.font_size=22
               


        cole=ladfit([zeros,lwc],[zeros,twc])
        p2=plot([0,2.5],[0,2.5],/overplot,color='orange red',thick=2,linestyle=2)
        p3=plot([0,2.5],[cole[0],2.5*cole[1]+cole[0]],/overplot,color='blue',thick=2)


        print,1.-cole[1]
        perDiff=strcompress('Percent Difference='+string((1.-cole[1])*100.)+'%')
        t1=text(.2,.2,perDiff,font_size=18)

stop
    endif






end