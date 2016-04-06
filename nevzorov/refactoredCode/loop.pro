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
      cdpacc=[cdpacc,g.cdpacc]
      
      p1=scatterplot(g.lwc,g.lwc-g.twc,sym_color='red',symbol='+',dimensions=[1100,1100],/overplot)
      p1=scatterplot(g.lwc[g.liqOnly],g.lwc[g.liqOnly]-g.twc[g.liqOnly],sym_color='blue',symbol='+',dimensions=[1100,1100],/overplot)
   
    endfor
    
    
    
    
    
    

    liqOnly=where(trf gt -3. and lwc gt .02 and cdpconc gt 10.)


    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,$
      signalTot,liqonly,cdpconc,ltdiff,tldiff,dbar3m,cdpacc,dBarBI,/verbose

    stop



end