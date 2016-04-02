pro loop


    lwc=[]
    as=[]
    pmb=[]
    cdplwc=[]
    twc=[]
    lwcx=[]
    cdplwcx=[]
    twcx=[]
    colETotTest=[]
    cdpdbar=[]
    twcnocolecor=[]
    trf=[]
    signalLiq=[]
    signalTot=[]
    clearairLiq=[]
    clearairTot=[]
    liqonly=[]
    cdpconc=[]
    ltdiff=[]
    tldiff=[]
    dbar3m=[]
    cdpacc=[]


    flight=['0710','0725','0727','0728','0729','0803','0806','0807','0814','0815']



    for i=0, n_elements(flight)-1 do begin


      g= nevBase(flight[i],'indicated','400')

      print,flight[i]

      
      lwc=[lwc,g.lwc]
      as=[as,g.as]
      pmb=[pmb,g.pmb]
      cdplwc=[cdplwc,g.cdplwc]
      twc=[twc,g.twc]
      cdpdbar=[cdpdbar,g.cdpdbar]
      trf=[trf,g.trf]
      signalLiq=[signalLiq,g.signalLiq]
      signalTot=[signalTot,g.signalTot]
      clearairLiq=[clearairLiq,g.clearairLiq]
      clearairTot=[clearairTot,g.clearairTot]
      liqonly=[liqonly,g.liqonly]
      cdpconc=[cdpconc,g.cdpconc]
      ltdiff=[ltdiff,g.ltdiff]
      tldiff=[tldiff,g.tldiff]
      cdpacc=[cdpacc,g.cdpacc]
      
      p1=scatterplot(g.lwc[g.liqOnly],g.lwc[g.liqOnly]-g.twc[g.liqOnly],sym_color='blue',symbol='+',dimensions=[1100,1100],/overplot)
   
    endfor
    
;    dbar5=where(cdpdbar ge 0. and cdpdbar le 5.)
;    dbar10=where(cdpdbar ge 5. and cdpdbar le 10.)
;    dbar15=where(cdpdbar ge 10. and cdpdbar le 15.)
;    dbar20=where(cdpdbar ge 15. and cdpdbar le 20.)
;    dbar25=where(cdpdbar ge 20. and cdpdbar le 25.)
;    dbar30=where(cdpdbar ge 25. and cdpdbar le 30.)
;    dbar35=where(cdpdbar ge 30. and cdpdbar le 35.)
;    dbar40=where(cdpdbar ge 35. and cdpdbar le 40.)
;    dbar45=where(cdpdbar ge 40. and cdpdbar le 45.)
;    dbar50=where(cdpdbar ge 45. and cdpdbar le 50.)
;    
;    binint=1
;    
;    binsize=5
;    bincount=60/binsize
;    dbarbinn=dindgen(bincount,start=0,increment=0)
;    
;    
;    for i=0,bincount-1 do begin
;      if i eq 0 then step=4
;      if i gt 0 then step=5
;      
;      ind=where(cdpdbar ge binint and cdpdbar le binint+step)
;      if ind eq -1 then ind eq 0
;      dbarbinn[i]=n_elements(ind) 
;      
;      binint=binint+step
;    endfor
    
    

    liqOnly=where(trf gt -3. and lwc gt .02 and cdpconc gt 10.)

    
    
    stop

    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,$
      signalTot,liqonly,cdpconc,ltdiff,tldiff,dbar3m,cdpacc,/verbose

    stop



end