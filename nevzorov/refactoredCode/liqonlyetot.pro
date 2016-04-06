pro liqonlyETot
 
    

    stuff=1
 
;---------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------

   restore,'loopdata.sav'


    binint=0

    binsize=15
    
    binint2=binint+binsize
    bincount=60/binsize

    dBarBI=dblarr(bincount,n_elements(pmb))
    dbarbinn=dindgen(bincount,start=0,increment=0)
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]

    binstart=[]
    binend=[]
    binindex=[]
    binistarti=[]
    biniendi=[]
    starti=0
    endi=0

    for i=0,bincount-1 do begin
      selectinds=where(cdpdbar ge binint and cdpdbar le binint2)
      
      
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
    
    
    
    
    
    
    
    
    
    
    
    
    if stuff eq 0 then begin


    cgcleanup

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)

      color=['black','blue','red','green','purple','orange','pink','yellow','sky','black','blue','red','green','purple']
      for i=0,n_elements(binistarti)-1 do begin
      
      bins=binindex[binistarti[i]:biniendi[i]]
     
     p1=scatterplot(lwc[bins],lwc[bins]-twc[bins],/overplot,sym_color=color[i],sym_size=.2,dimensions=[1600,1000])
        
     cole=ladfit([twos,lwc[bins]],[zeros,lwc[bins]-twc[bins]])
     p2=plot([.02,2.5],[cole[0],2.5*cole[1]+cole[0]],/overplot,color=color[i]) 
      
      
      print,1.-cole[1]
  
  
      endfor
    endif

    
    
    
    
    
    
    
    if stuff eq 1 then begin


      cgcleanup

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)

      color=['black','blue','red','green','purple','orange','pink','yellow','sky','black','blue','red','green','purple']
      for i=0,n_elements(binistarti)-1 do begin

        bins=binindex[binistarti[i]:biniendi[i]]

        p1=scatterplot(lwc[bins],twc[bins],sym_color=color[i],sym_size=.2,dimensions=[1000,1000])
        p1.xrange=[0,2.5]
        p1.yrange=[0,2.5]
        
        p1.TITLE=STRCOMPRESS(string(min(cdpdbar[bins]))+'-'+string(max(cdpdbar[bins])),/remove_all)
        cole=ladfit([zeros,lwc[bins]],[zeros,twc[bins]])
        p2=plot([0,2.5],[0,2.5],/overplot,color='black',thick=2,linestyle=2)
        p2=plot([0,2.5],[cole[0],2.5*cole[1]+cole[0]],/overplot,color=color[i],thick=2)


        print,cole[1]


      endfor
    endif


end