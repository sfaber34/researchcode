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

      
;      lwc=[lwc,g.lwc]
;      as=[as,g.as]
;      pmb=[pmb,g.pmb]
;      cdplwc=[cdplwc,g.cdplwc]
;      twc=[twc,g.twc]
;      cdpdbar=[cdpdbar,g.cdpdbar]
;      trf=[trf,g.trf]
;      signalLiq=[signalLiq,g.signalLiq]
;      signalTot=[signalTot,g.signalTot]
;      clearairLiq=[clearairLiq,g.clearairLiq]
;      clearairTot=[clearairTot,g.clearairTot]
;      ;liqonly=[liqonly,g.liqonly]
;      cdpconc=[cdpconc,g.cdpconc]
;      cdpacc=[cdpacc,g.cdpacc]

      lwc=g.lwc
      pmb=g.pmb
      
      firstM=make_array(n_elements(pmb))
      diff=make_array(n_elements(pmb))

      ;diam=[1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.,11.,13.,15.,17.,19.,21.,23.,25.,27.,29.,31.,33.,35.,37.,39.,41.,43.,45.,47.]
      if n_elements(g.cdpdbins[*,0,0]) eq 28 then diam=[1.5,2.5,3.5,4.5,5.5,6.5,7.5,9.,11.,13.,15.,17.,19.,21.,23.,25.,27.,29.,31.,33.,35.,37.,39.,41.,43.,45.,47.,49.]
      if n_elements(g.cdpdbins[*,0,0]) eq 27 then diam=[1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,10.5,14.,17.,19.,21.,23.,25.,27.,29.,31.,33.,35.,37.,39.,41.,43.,45.,47.,49.]
      



      for m=0, n_elements(pmb)-1 do begin
        x=[]
        for j=0,n_elements(g.cdpdbins[*,0,0])-1 do begin
          x=[x,diam[j]*(g.cdpdbins[j,0,m])]
        endfor
          y=total(x)/total(g.cdpdbins[*,0,m])
          firstM[m]=y
          diff[m]=y-g.cdpdbar[m]
      endfor
      
      p1=plot(dindgen(n_elements(pmb)),diff,dimensions=[1100,1100],thick=4)
      p1.yrange=[-1,1]


    endfor
    
    
    
    
    
    

    liqOnly=where(trf gt -3. and lwc gt .02 and cdpconc gt 10.)


    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,$
      signalTot,liqonly,cdpconc,ltdiff,tldiff,dbar3m,cdpacc,dBarBI,/verbose

    stop



end