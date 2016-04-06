pro liqonlyETot
 
    restore,'loopdata.sav'

    
 

    binint=0

    binsize=5
    
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
        
        print,min(cdpdbar[selectinds])
        print,max(cdpdbar[selectinds])
        
        binindex=[binindex,selectinds]
        binistarti=[binistarti,starti]

        endi=starti+n_elements(selectinds)
        biniendi=[biniendi,endi-1]
        
      endif
      starti=endi
      ;dbarbinn[i]=n_elements(ind)

;      p=n_elements(dBarBI[i,*])-n_elements(selectinds)
;      ind=[selectinds,replicate(-100,p)]

      ;dBarBI[i,*]=ind
      

      
      binint=binint+binsize
      binint2=binint2+binsize
    endfor
print,''
print,''
print,''

    cgcleanup

    color=['black','blue','red','green','purple','orange','pink','yellow','sky']
    for i=0,n_elements(binistarti)-1 do begin
    
    binDs=cdpdbar[binindex[binistarti[i]:biniendi[i]]]
    
    print,min(binDs)
    print,max(binDs)
      
    cole=linfit(lwc[dbarbi[i,*]],lwc[dbarbi[i,*]]-twc[dbarbi[i,*]])


    endfor

    stop


end