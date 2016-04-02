pro loop


    lwccon=[]
    ascon=[]
    pmbcon=[]
    cdplwccon=[]
    twccon=[]
    lwcconx=[]
    cdplwcconx=[]
    twcconx=[]
    colETotTestCon=[]
    cdpdbarcon=[]
    twcnocolecorcon=[]
    trfcon=[]
    signalLiqcon=[]
    signalTotcon=[]
    clearairLiqCon=[]
    clearairTotCon=[]
    liqonlycon=[]
 
    


    flight=['0710','0725','0727','0728','0729','0803','0806','0807','0814','0815','0821','0813','0722','0718']



    for i=0, n_elements(flight)-1 do begin


      g= nevBase(flight[i],'indicated','400')

      print,flight[i]

      liqOnly=where(g.trf gt -3. and g.lwc gt .02 and g.cdpconc gt 10.)
      
      lwccon=[lwccon,g.lwc]
      ascon=[ascon,g.as]
      pmbcon=[pmbcon,g.pmb]
      cdplwccon=[cdplwccon,g.cdplwc]
      twccon=[twccon,g.twc]
      cdpdbarcon=[cdpdbarcon,g.cdpdbar]
      trfcon=[trfcon,g.trf]
      signalLiqcon=[signalLiqcon,g.signalLiq]
      signalTotcon=[signalTotcon,g.signalTot]
      clearairLiqCon=[clearairLiqCon,g.clearairLiq]
      clearairTotCon=[clearairTotCon,g.clearairTot]
      liqonlycon=[liqonlycon,g.liqonly]
      
      p1=scatterplot(g.lwc[g.liqOnly],g.twc[g.liqOnly],sym_color='blue',symbol='+',dimensions=[1100,1100],/overplot)
   
    endfor
    stop

    save,filename='loopdata.sav',lwccon,twccon,cdpdbarcon,trfcon,ascon,pmbcon,cdplwccon,clearairLiqCon,clearairTotCon,signalLiqcon,signalTotcon,liqonlycon

    stop



end