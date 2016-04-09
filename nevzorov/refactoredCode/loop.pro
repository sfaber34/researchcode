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
    cdpThirdM=[]
    cdpconc=[]
    ltdiff=[]
    tldiff=[]
    dbar3m=[]
    cdpacc=[]
    deff=[]
    othervar=[]
    cdpDEff=[]
    cdpVolMean=[]
    cdpMassMean=[]

    


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
      cdpDEff=[cdpDEff,g.cdpDEff]
      cdpVolMean=[cdpVolMean,g.cdpVolMean]
      cdpMassMean=[cdpMassMean,g.cdpMassMean]
      cdpconc=[cdpconc,g.cdpconc]
      cdpacc=[cdpacc,g.cdpacc]

      




      
      ;p1=plot(dindgen(n_elements(g.pmb)),g.cdpThirdM-g.cdpdbar,dimensions=[1100,1100],thick=4)
      ;p1.yrange=[-1,1]


    endfor
    
    
    
    
    
    

    liqOnly=where(trf gt -3. and lwc gt .02 and lwc lt 1.2 and cdpacc gt 5.)


    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,$
      signalTot,liqonly,cdpconc,ltdiff,tldiff,dbar3m,cdpacc,$
      dBarBI,cdpSecondM,cdpThirdM,cdpFourthM,cdpDEff,cdpVolMean,cdpMassMean,/verbose




end