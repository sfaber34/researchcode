pro colETot

  stuff='directComp'


  restore,'concatsavesb2.sav' 
  x=where(trfcon gt -3. and lwccon gt .02 and cdpconccon gt 10)





  if stuff eq 'fitcurve3' then begin
    cgcleanup

       
    
    
    print,'n filtered=',n_elements(x)


    zeros=dindgen(10000,start=.2, increment=0)



    lwccon=lwccon[x]
    twccon=twccon[x]
    CDPDBARCON=CDPDBARCON[x]
    CDPLWCCON=CDPLWCCON[x]
    TRFCON=[x]
    PMBCON=PMBCON[x]
    
    

    p1=scatterplot(lwccon,twccon,sym_color='black',symbol='+',dimensions=[1600,1000])


    



    geofitb=poly_fit(lwccon,TWCcon,3,yfit=yfitb)

    


    lwcconsort=sort(lwccon)
    lwcconsorted=lwccon[lwcconsort]
    yfitb=yfitb[lwcconsort]

    p2=plot(lwcconsorted,yfitb,'r',/overplot)

    stop
  endif









  if stuff eq 'directComp' then begin


    zeros=dindgen(10000,start=0., increment=0.)

    lwccon=lwccon[x]
    twccon=twccon[x]
    CDPDBARCON=CDPDBARCON[x]
    CDPLWCCON=CDPLWCCON[x]
    TRFCON=[x]
    PMBCON=PMBCON[x]

    lwccon=[zeros,lwccon]
    twccon=[zeros,twccon]
    

    p1=scatterplot(lwccon,twccon,sym_color='black',symbol='+',dimensions=[1100,1100])

  

    p1.xrange=[0,2.6]
    p1.yrange=[0,2.6]
    
    p2=plot([0,2.6],[0,2.6],'g',thick=2,/overplot)


    geofitb=ladfit([zeros,lwccon],[zeros,TWCcon])

    print,(geofitb[1]-1.)*100.


    p3=plot([0,2.6],[0,2.6*geofitb[1]+geofitb[0]],'r',thick=2,/overplot)

    stop
  endif












  if stuff eq 'fitcurve2' then begin
    cgcleanup

    restore,'concatsavesb.sav'

    x=where(trfcon gt 5. and lwccon gt .02)


    ay=dindgen(10000,start=.2, increment=0)
    ax=dindgen(10000,start=0., increment=0)


    by=dindgen(700,start=.880, increment=0)
    bx=dindgen(700,start=9., increment=0)
    cy=dindgen(10000,start=.820, increment=0)
    cx=dindgen(10000,start=40, increment=0)



    lwccon=lwccon[x]
    twccon=twccon[x]
    COLETOTTESTCON=COLETOTTESTCON[x]
    CDPDBARCON=CDPDBARCON[x]
    CDPLWCCON=CDPLWCCON[x]
    TRFCON=[x]
    PMBCON=PMBCON[x]
    TWCNOECORCON=TWCNOECORCON[x]


    ;  lwccon=lwccon[x]
    ;  twccon=twccon[x]
    ;  TWCNOECORCON=[x]

    ;  colETotTestCon=[twotens,colETotTestCon[x],ones]
    ;  cdpdbarcon=[threes,cdpdbarcon[x],fourty]


    p1=scatterplot(lwccon,lwccon-TWCNOECORCON,sym_color='red',symbol='+',dimensions=[1600,1000])



    geofitb=poly_fit(lwccon,lwccon-TWCNOECORCON,4,yfit=yfitb)
    geoFit=comfit(lwccon,lwccon-TWCNOECORCON,[geofitb[0],.2,geofitb[2]],yfit=yfit,/geometric,itmax=4000,iter=its,yerror=yerror) ;400 true



    print,mean(abs(yerror))



    lwcconsort=sort(lwccon)
    lwcconsorted=lwccon[lwcconsort]
    yfit=yfit[lwcconsort]
    yfitb=yfitb[lwcconsort]

    plot1b=plot(lwcconsorted,yfit,'blue',/overplot)
    plot1b=plot(lwcconsorted,yfitb,'green',/overplot)

    stop
  endif



  if stuff eq 'testVarColETot2' then begin
    restore,'concatsaves.sav'
    x=where(trfcon gt 5. and cdpdbarcon gt 3 and colETotTestCon gt 0 and colETotTestCon le 1)
    y=where(trfcon lt -5.)

    xs=dindgen(1000,start=0,increment=0)
    ys=dindgen(1000,start=.1,increment=0)

    p1=scatterplot(cdpdbarcon[x],lwccon[x]/twcnoecorcon[x],sym_color='red',symbol='.',dimensions=[1400,1000])

    xfit=[xs]
    yfit=[ys]

    pol=poly_fit(cdpdbarcon[x],colETotTestCon[x],3,yfit=yfit)
    geo=comfit(cdpdbarcon[x],colETotTestCon[x],[pol[1],.1,pol[0]],yfit=yfitb,/geometric,itmax=10000)

    xfilter=cdpdbarcon[x]
    sortx=sort(xfilter)
    xfilter=xfilter[sortx]
    yfilter=yfit[sortx]
    yfilterb=yfitb[sortx]

    p2=plot(xfilter,yfilter,/overplot)
    p3=plot(xfilter,yfilterb,/overplot,'blue')
    ;  p3=plot([0,2.7],[0,2.7],'g',thick=2,/overplot)
    ;  p3.xrange=[0,2.7]
    ;  p3.yrange=[0,2.7]
    stop
  endif









  if stuff eq 'testVarColETot' then begin
    ;cgcleanup
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
    zeros=dindgen(1000,start=0.,increment=0.)

    flight=['0710','0725','0727','0728','0729','0803','0806','0807','0814','0815']
    ;flight='0806'

    color=['black','blue']


    for i=0, n_elements(flight)-1 do begin



      g= nevBase(flight[i],'indicated','400')

      x=where(g.trf gt 5. and g.lwc gt .02)


      ;p2=scatterplot(g.cdpdbar[x],g.lwc[x]-g.twcnoecor[x],sym_color='black',symbol='+',dimensions=[968,1000])
      p3=scatterplot(g.lwc[x],g.lwc[x]-g.twc[x],sym_color='green',symbol='+',dimensions=[1400,1000],/overplot)


      print,'--------------------------------------------------------'
      print,flight[i]
      print,n_elements(x)


      lwccon=[lwccon,g.lwc[x]]
      ascon=[ascon,g.as[x]]
      pmbcon=[pmbcon,g.pmb[x]]
      cdplwccon=[cdplwccon,g.cdplwc[x]]
      twccon=[twccon,g.twc[x]]
      ;twcnocolecorcon=[twcnocolecorcon,g.twcNoECor[x]]
      cdpdbarcon=[cdpdbarcon,g.cdpdbar[x]]
      colETotTestCon=[colETotTestCon,g.colETotTest[x]]
      trfcon=[trfcon,g.trf[x]]
      signalLiqcon=[signalLiqcon,g.signalLiq[x]]
      signalTotcon=[signalTotcon,g.signalTot[x]]
      clearairLiqCon=[clearairLiqCon,g.clearairLiq[x]]
      clearairTotCon=[clearairTotCon,g.clearairTot[x]]

    endfor
    stop

    p2=scatterplot(lwccon,twcnocolecorcon,dimensions=[1000,1000],sym_color='blue',symbol='+')
    p5=scatterplot(lwccon,twccon,/overplot,sym_color='orange',symbol='+')

    p2.yrange=[0,3]
    p2.xrange=[0,3]
    p5=plot([0,3],[0,3],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    ;save,filename='Only.sav',lwccon,twccon,colETotTestCon,cdpdbarcon,twcnocolecorcon,trfcon,ascon,pmbcon,cdplwccon




    lin=ladfit([zeros,lwccon],[zeros,twcnocolecorcon])
    p3=plot([0,2.],[0+lin[0],2.*lin[1]+lin[0]],color='purple',thick=2,/overplot)
    print,'diff=',lin[1]-1.

    lin=ladfit([zeros,lwccon],[zeros,twccon])
    p4=plot([0,2.],[0+lin[0],2.*lin[1]+lin[0]],color='red',thick=2,/overplot)
    print,'diff cor=',lin[1]-1.


    p5=plot([0,2],[0,2],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    p3.xrange=[0,2.]
    p3.yrange=[0,2.]


    stop
  endif














  if stuff eq 'fitcurve' then begin
    restore,'concatsaves.sav'

    x=where(colETotTestCon gt 0. and colETotTestCon lt .9)


    ay=dindgen(10000,start=.1, increment=0)
    ax=dindgen(10000,start=1., increment=0)

    ;  by=dindgen(100,start=.70, increment=0)
    ;  bx=dindgen(100,start=7., increment=0)
    by=dindgen(700,start=.880, increment=0)
    bx=dindgen(700,start=9., increment=0)
    cy=dindgen(10000,start=.820, increment=0)
    cx=dindgen(10000,start=40, increment=0)



    lwccon=lwccon[x]
    twccon=twccon[x]
    ;  colETotTestCon=[twotens,colETotTestCon[x],ones]
    ;  cdpdbarcon=[threes,cdpdbarcon[x],fourty]


    cdpdbarcon=[ax,cdpdbarcon[x],bx,cx]
    colETotTestCon=[ay,colETotTestCon[x],by,cy]

    p1=scatterplot(lwccon,twccon/twcnoecorcon,sym_color='red',symbol='+',dimensions=[968,1000])

    ;p1.xrange=[-.1,2.6]
    p1.yrange=[0,1.2]


    unitVector=dindgen(370, start=3., increment=.1)

    x=[3.,4.5,6.,7.5,9.,11.5,15.,21.5]
    y=[.2,.3,.4,.5,.6,.7,.8,.9]


    geofitb=poly_fit(cdpdbarcon,colETotTestCon,4)
    geoFit=comfit(cdpdbarcon,colETotTestCon,[geofitb[0],.2,geofitb[2]],yfit=yfit,/geometric,itmax=4000,iter=its,yerror=yerror) ;400 true

    regLine=(geoFit[0])*unitVector^geoFit[1]+geoFit[2]


    regLine2=dindgen(n_elements(unitVector))
    for i=0,n_elements(unitVector)-1 do begin
      if unitVector[i] le 25 then begin
        regLine2[i]=geofitb[0]+geofitb[1]*unitVector[i]+geofitb[2]*unitVector[i]^2.+geofitb[3]*unitVector[i]^3.+geofitb[4]*unitVector[i]^4.
      endif else begin
        regLine2[i]=0.72314992+unitVector[i]*0.0030687526
      endelse
    endfor

    p6=scatterplot(x,y,/overplot)

    print,mean(abs(yerror))

    plot1b=plot(unitVector,regLine,'blue',/overplot)
    plot1b=plot(unitVector,regLine2,'green',/overplot)

    stop
  endif








  if stuff eq 'liqOnlyPoints' then begin
    ;;cgcleanup
    lwccon=[]
    cdplwccon=[]
    twccon=[]
    lwcconx=[]
    cdplwcconx=[]
    twcconx=[]
    cdpdbarcon=[]
    trfcon=[]
    pmbcon=[]
    cdpconccon=[]

    flight=['0710','0725','0727','0728','0729','0803','0806','0807','0814','0815']
    ;flight='0806'

    color=['black','blue']


    for i=0, n_elements(flight)-1 do begin



      g= nevBase(flight[i],'indicated','400')

      x=where(g.pmb gt 0.)


      p2=scatterplot(g.lwc[x],g.twc[x],sym_color='red',symbol='+',/overplot,dimensions=[968,1000])


      print,'--------------------------------------------------------'
      print,flight[i]
      print,n_elements(x)
      p2.yrange=[0,3]
      p2.xrange=[0,3]

      lwccon=[lwccon,g.lwc]
      cdplwccon=[cdplwccon,g.cdplwc]
      twccon=[twccon,g.twc]
      cdpdbarcon=[cdpdbarcon,g.cdpdbar]
      trfcon=[trfcon,g.trf]
      pmbcon=[pmbcon,g.pmb]
      cdpconccon=[cdpconccon,g.cdpconc]

    endfor
    p5=plot([0,3],[0,3],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    save,filename='concatsavesb2.sav',lwccon,twccon,colETotTestCon,cdpdbarcon,cdplwccon,trfcon,pmbcon,twctestcon,cdpconccon
    stop
    p2=scatterplot(lwclinx,twclinx,dimensions=[1000,1000],sym_color='red',symbol='+',/overplot)


    lin=ladfit(lwclinx,twclinx)
    p3=plot([0,2.],[0+lin[0],2.*lin[1]+lin[0]],color='blue',thick=2,/overplot)
    p5=plot([0,2],[0,2],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    p1.xrange=[0,2.]
    p1.yrange=[0,2.]
    print,'diff=',lin[1]-1.

    stop
  endif

end