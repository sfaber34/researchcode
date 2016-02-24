;For 121715 case
;airspeed A
;asAStart=0
;asAEnd=1
;
;;airspeed B
;asBStart=where(timeForm eq 182530)
;asBEnd=where(timeForm eq 182630)
;
;;airspeed C
;asCStart=where(timeForm eq 182830)
;asCEnd=where(timeForm eq 182930)
;
;;airspeed D
;asDStart=where(timeForm eq 183340)
;asDEnd=where(timeForm eq 183540)
;
;;airspeed E
;asEStart=0
;asEEnd=1

;--------GITHUB TEST-----------


;---------For altitude compare case 090713---------
;-----SMALL SAMPLE-----
;Altitude A
;altAStart=where(timeForm eq 105045)
;altAEnd=where(timeForm eq 105126)
;
;;Altitude B
;altBStart=where(timeForm eq 113511)
;altBEnd=where(timeForm eq 113645)
;
;;Altitude C
;altCStart=where(timeForm eq 115605)
;altCEnd=where(timeForm eq 115807)



;;-----LARGE SAMPLE-----
;;Altitude A
;altAStart=where(timeForm eq 112522)
;altAEnd=where(timeForm eq 112659)
;
;;Altitude B
;altBStart=where(timeForm eq 112922)
;altBEnd=where(timeForm eq 113259)
;
;;Altitude C
;altCStart=where(timeForm eq 113437)
;altCEnd=where(timeForm eq 113559)
;
;;Altitude D
;altDStart=where(timeForm eq 113650)
;altDEnd=where(timeForm eq 113859)
;;--------
;;Altitude E
;altEStart=where(timeForm eq 114526)
;altEEnd=where(timeForm eq 114859)
;
;;Altitude F
;altFStart=where(timeForm eq 115200)
;altFEnd=where(timeForm eq 115959)
;
;;Altitude G
;altGStart=where(timeForm eq 120100)
;altGEnd=where(timeForm eq 120559)

;;regression lines 121715
;regLineLiqTrue=unitVector*(-.00258517)+1.97261
;regLineLiqInd=unitVector*(-.00145538)+1.95638
;
;regLineTotalTrue=unitVector*(-.00483436)+1.27220
;regLineTotalInd=unitVector*(-.00272310)+1.24209
;
;regLineLiqTrueMean=unitVector*(-.00258595)+1.97268
;regLineLiqIndMean=unitVector*(-.00145571)+1.95643
;
;regLineTotalTrueMean=unitVector*(-.00483458)+1.27222
;regLineTotalIndMean=unitVector*(-.00272312)+1.24209
;
;regLineAltitude=unitVector*(-.000183979)+1.29452

;regression lines 070913
;regLineLiqTrue=unitVector*0
;regLineLiqInd=unitVector*(-0.00221532)+1.33777 ;FOR 070913 FL 3000
regLineLiqInd=unitVector*(-0.00275541)+1.36608 ;FOR 070913 FL 130
;
;regLineTotalTrue=unitVector*0
;regLineTotalInd=unitVector*(-.000814697)+.624324 ;FOR 070913 FL 3000
;;regLineTotalInd=unitVector*(-.000911216)+.676645 ;FOR 070913 FL 130
;
;regLineLiqTrueMean=unitVector*0
;regLineLiqIndMean=unitVector*0
;
;regLineTotalTrueMean=unitVector*0
;regLineTotalIndMean=unitVector*0



;;ALTITUDE A
;liqKAltA=liqk[altAStart:altAEnd]
;altA=altRad[altAStart:altAEnd]
;altAirspeedA=airspeed[altAStart:altAEnd]
;altPresA=pmb[altAStart:altAEnd]
;
;;ALTITUDE B
;liqKAltB=liqk[altBStart:altBEnd]
;altB=altRad[altBStart:altBEnd]
;altAirspeedB=airspeed[altBStart:altBEnd]
;altPresB=pmb[altBStart:altBEnd]
;
;;ALTITUDE C
;liqKAltC=liqk[altCStart:altCEnd]
;altC=altRad[altCStart:altCEnd]
;altAirspeedC=airspeed[altCStart:altCEnd]
;altPresC=pmb[altCStart:altCEnd]
;
;;ALTITUDE D
;liqKAltD=liqk[altDStart:altDEnd]
;altD=altRad[altDStart:altDEnd]
;altAirspeedD=airspeed[altDStart:altDEnd]
;altPresD=pmb[altDStart:altDEnd]
;;----------
;;ALTITUDE E
;liqKAltE=liqk[altEStart:altEEnd]
;altE=altRad[altEStart:altEEnd]
;altAirspeedE=airspeed[altEStart:altEEnd]
;altPresE=pmb[altEStart:altEEnd]
;
;;ALTITUDE F
;liqKAltF=liqk[altFStart:altFEnd]
;altF=altRad[altFStart:altFEnd]
;altAirspeedF=airspeed[altFStart:altFEnd]
;altPresF=pmb[altFStart:altFEnd]
;
;;ALTITUDE G
;liqKAltG=liqk[altGStart:altGEnd]
;altG=altRad[altGStart:altGEnd]
;altAirspeedG=airspeed[altGStart:altGEnd]
;altPresG=pmb[altGStart:altGEnd]
;
;
;
;;ALTITUDE GROUP A
;liqKAltConA=[liqKAltA,liqKAltB,liqKAltC,liqKAltD]
;altConA=[altA,altB,altC,altD]
;altAirspeedConA=[altAirspeedA,altAirspeedB,altAirspeedC,altAirspeedD]
;altPresConA=[altPresA,altPresB,altPresC,altPresD]
;
;;ALTITUDE GROUP B
;liqKAltConB=[liqKAltE,liqKAltF,liqKAltG]
;altConB=[altE,altF,altG]
;altAirspeedConB=[altAirspeedE,altAirspeedF,altAirspeedG]
;altPresConB=[altPresE,altPresF,altPresG]
;
;
;
;
;liqKAltCon=[liqKAltConA,liqKAltConB]
;altCon=[altConA,altConB]
;altAirspeedCon=[altAirspeedConA,altAirspeedConB]
;altPresCon=[altPresConA,altPresConB]


;;ALTITUDE GROUP A
;liqKAltConA=[liqKAltA,liqKAltB,liqKAltC,liqKAltD]
;altConA=[altA,altB,altC,altD]
;altAirspeedConA=[altAirspeedA,altAirspeedB,altAirspeedC,altAirspeedD]
;altPresConA=[altPresA,altPresB,altPresC,altPresD]
;
;;ALTITUDE GROUP B
;liqKAltConB=[liqKAltE,liqKAltF,liqKAltG]
;altConB=[altE,altF,altG]
;altAirspeedConB=[altAirspeedE,altAirspeedF,altAirspeedG]
;altPresConB=[altPresE,altPresF,altPresG]


;SECOND TRY
;ALTITUDE B1
liqKAltB1=liqk[altB1Start:altB1End]
altB1=altRad[altB1Start:altB1End]
altAirspeedB1=airspeed[altB1Start:altB1End]
altPresB1=pmb[altB1Start:altB1End]

;ALTITUDE B2
liqKAltB2=liqk[altB2Start:altB2End]
altB2=altRad[altB2Start:altB2End]
altAirspeedB2=airspeed[altB2Start:altB2End]
altPresB2=pmb[altB2Start:altB2End]

;ALTITUDE C1
liqKAltC1=liqk[altC1Start:altC1End]
altC1=altRad[altC1Start:altC1End]
altAirspeedC1=airspeed[altC1Start:altC1End]
altPresC1=pmb[altC1Start:altC1End]

;ALTITUDE C2
liqKAltC2=liqk[altC2Start:altC2End]
altC2=altRad[altC2Start:altC2End]
altAirspeedC2=airspeed[altC2Start:altC2End]
altPresC2=pmb[altC2Start:altC2End]

;ALTITUDE C3
liqKAltC3=liqk[altC3Start:altC3End]
altC3=altRad[altC3Start:altC3End]
altAirspeedC3=airspeed[altC3Start:altC3End]
altPresC3=pmb[altC3Start:altC3End]

;ALTITUDE D1
liqKAltD1=liqk[altD1Start:altD1End]
altD1=altRad[altD1Start:altD1End]
altAirspeedD1=airspeed[altD1Start:altD1End]
altPresD1=pmb[altD1Start:altD1End]

;ALTITUDE D2
liqKAltD2=liqk[altD2Start:altD2End]
altD2=altRad[altD2Start:altD2End]
altAirspeedD2=airspeed[altD2Start:altD2End]
altPresD2=pmb[altD2Start:altD2End]

;ALTITUDE D3
liqKAltD3=liqk[altD3Start:altD3End]
altD3=altRad[altD3Start:altD3End]
altAirspeedD3=airspeed[altD3Start:altD3End]
altPresD3=pmb[altD3Start:altD3End]



liqKAltCon=[liqKAltB1,liqKAltB2,liqKAltC1,liqKAltC2,liqKAltC3,liqKAltD1,liqKAltD2,liqKAltD3]
altCon=[altB1,altB2,altC1,altC2,altC3,altD1,altD2,altD3]
altAirspeedCon=[altAirspeedB1,altAirspeedB2,altAirspeedC1,altAirspeedC2,altAirspeedC3,altAirspeedD1,altAirspeedD2,altAirspeedD3]
altPresCon=[altPresB1,altPresB2,altPresC1,altPresC2,altPresC3,altPresD1,altPresD2,altPresD3]

;liqKAltConCorr=liqKAltCon*


;
;altCon=altCon[288:1522]
;liqKAltCon=liqKAltCon[288:1522]
;altAirspeedCon=altAirspeedCon[288:1522]
;altPresCon=altPresCon[288:1522]



;CLength=n_elements(altC)-1
;for i=0,cLength do begin
;  if (altAirspeedC[i] lt altAirspeedLow) or (altAirspeedC[i] gt altAirspeedHigh) then begin
;    altC[i]=''
;    liqKAltC[i]=''
;    altAirspeedC[i]=''
;  endif
;endfor
;
;altCSort=sort(altC)
;altC=altC[altCSort]
;liqKAltC=liqKAltC[altCSort]
;altAirspeedC=altAirspeedC[altCSort]
;altPresC=altPresC[altCSort]
;
;altC=altC[91:122]
;liqKAltC=liqKAltC[91:122]
;altAirspeedC=altAirspeedC[91:122]
;altPresC=altPresC[91:122]
;
;
;
;
;;ALTITUDE CON
;liqKAltCon=[liqKAltA,liqKAltB,liqKAltC]
;altGroupCon=[altA,altB,altC]
;altAirspeedCon=[altAirspeedA,altAirspeedB,altAirspeedC]
;altPresCon=[altPresA,altPresB,altPresC]




if genplots eq 'airspeedConMean' then begin
  liqKAsLowSort=liqKAsLow[sort(liqKAsLow)]
  liqKAsMedSort=liqKAsMed[sort(liqKAsMed)]
  liqKAsHighSort=liqKAsHigh[sort(liqKAsHigh)]

  liqKAsLowMin=liqKAsLowSort[0]
  liqKAsLowQ1=(liqKAsLowSort[14]+liqKAsLowSort[15])/2
  liqKAsLowMedian=(liqKAsLowSort[29]+liqKAsLowSort[30])/2
  liqKAsLowMean=mean(liqKAsLow)
  liqKAsLowQ3=(liqKAsLowSort[44]+liqKAsLowSort[45])/2
  liqKAsLowMax=liqKAsLowSort[60]


  liqKAsMedMin=liqKAsMedSort[0]
  liqKAsMedQ1=(liqKAsMedSort[14]+liqKAsMedSort[15])/2
  liqKAsMedMedian=(liqKAsMedSort[29]+liqKAsMedSort[30])/2
  liqKAsMedMean=mean(liqKAsMed)
  liqKAsMedQ3=(liqKAsMedSort[44]+liqKAsMedSort[45])/2
  liqKAsMedMax=liqKAsMedSort[60]


  liqKAsHighMin=liqKAsHighSort[0]
  liqKAsHighQ1=(liqKAsHighSort[14]+liqKAsHighSort[15])/2
  liqKAsHighMedian=(liqKAsHighSort[29]+liqKAsHighSort[30])/2
  liqKAsHighMean=mean(liqKAsHigh)
  liqKAsHighQ3=(liqKAsHighSort[44]+liqKAsHighSort[45])/2
  liqKAsHighMax=liqKAsHighSort[60]

  liqKAsBox=[[liqKAsLowMin,liqKAsMedMin,liqKAsHighMin], $
    [liqKAsLowQ1,liqKAsMedQ1,liqKAsHighQ1], $
    [liqKAsLowMedian,liqKAsMedMedian,liqKAsHighMedian], $
    [liqKAsLowQ3,liqKAsMedQ3,liqKAsHighQ3], $
    [liqKAsLowMax,liqKAsMedMax,liqKAsHighMax]]

  liqKAsMeanCon=[liqKAsLowMean,liqKAsMedMean,liqKAsHighMean]
  airspeedMeanCon=[airspeedLowMean,airspeedMedMean,airspeedHighMean]

  plot7=boxplot(liqKAsBox,dimensions=[1200,900])
  plot7.title='Liquid K vs Airspeed'
  plot7.xtitle='Mean Airspeed [m/s]'
  plot7.ytitle='Liquid K'
  plot7.xtickvalues=[0,1,2]
  plot7.xtickname=[string(airspeedLowMean),string(airspeedMedMean),string(airspeedHighMean)]

  line7=linfit(airspeedMeanCon, liqKAsMeanCon)
  text7=text(1,1,string(line7),/device)
endif




if genplots eq 'altitudeCon' then begin
  plot1=scatterplot(altPresCon,liqKAltCon)
  plot1.TITLE='Pressure vs. Liquid K'
  plot1.xtitle='Pressure [mb]'
  plot1.ytitle='Liquid K'
  plot1.xrange=[600,940]
  plot1.yrange=[1.08,1.23]

  plot1LinFit=string(linfit(altPresCon,liqKAltCon))
  text1=text(100,100,plot1LinFit,/device)
  ;text2=text(300,100,'Mean Airspeed = 90.327660 m/s',/device)

  plot2=plot(unitVector,regLineAltitude,'r',/overplot)
  stop
endif




if genplots eq 'presDepAirspeed' then begin
  filter=where((altAirspeedCon gt 90) and (altAirspeedCon lt 102))
  altAirspeedConFilter=altAirspeedCon[filter]
  altPresConFilter=altPresCon[filter]
  liqKAltConFilter=liqKAltCon[filter]

  liqKaltConCorr=((-0.0010415803)*altAirspeedCon+liqKaltCon)

  plot1=scatterplot(altPresConFilter,altAirspeedConFilter,symbol='+',sym_size=.4)
  plot1.xrange=[300,1000]
  plot1.TITLE='Pressure vs. Liquid K'
  plot1.xtitle='Pressure [mb]'
  plot1.ytitle='Liquid K'

  plot1LinFit=string(linfit(altPresConFilter,altAirspeedConFilter))
  text1=text(100,100,plot1LinFit,/device)
  ;text2=text(300,100,'Mean Airspeed = 90.327660 m/s',/device)

  plot2=plot(unitVector,regLineAltitude,'r',/overplot)
  stop
endif




if sensor eq 'total' then begin


  ;FIND RANGES

  ;AIRSPEED RANGES
  rangeAirspeed=max(airspeedIndCon)-min(airspeedIndCon)
  rangeAirspeedMargin=(rangeAirspeed*1.1-rangeAirspeed)/2

  ;K RANGES
  rangeK=max(totalKAsCon)-min(totalKAsCon)
  rangeKMargin=(rangeK*1.1-rangeK)/2


  if airspeedType eq 'indicated' then begin
    plot4=scatterplot(airspeedIndCon,totalKAsCon, dimensions=[1200,900])
    plot4.title='Total K vs Indicated Airspeed'
    plot4.xtitle='Indicated Airspeed [knot]'

    plot4Linfit=string(linfit(airspeedIndCon,totalKAsCon))
    text4=text(.8,10,plot4LinFit,/device)
    plot4R=string(R_CORRELATE(airspeedIndCon,totalKAsCon))
    text4b=text(180,10,plot4R,/device)

    plot4b=plot(unitVector,regLineTotalInd,'r',/overplot)

    plot4.xrange=[min(airspeedIndCon)-rangeAirspeedMargin,max(airspeedIndCon)+rangeAirspeedMargin]
    plot4.yrange=[min(totalKAsCon)-rangeKMargin,max(totalKAsCon)+rangeKMargin]
  endif

  plot4.ytitle='Total K'

endif






if sensor eq 'total' then begin

  ;--totalK vs airspeed--


  ;FIND RANGES

  ;AIRSPEED RANGES
  rangeAirspeedB=max(airspeedIndB)-min(airspeedIndB)
  rangeAirspeedC=max(airspeedIndC)-min(airspeedIndC)
  rangeAirspeedD=max(airspeedIndD)-min(airspeedIndD)

  rangeAirspeedMax=rangeAirspeedB
  if (rangeAirspeedC gt rangeAirspeedB) and (rangeAirspeedC gt rangeAirspeedD) then begin
    rangeAirspeedMax=rangeAirspeedC
  endif
  if (rangeAirspeedD gt rangeAirspeedC) and (rangeAirspeedD gt rangeAirspeedB) then begin
    rangeAirspeedMax=rangeAirspeedD
  endif

  rangeAirspeedBMargin=(rangeAirspeedMax*1.1-rangeAirspeedB)/2
  rangeAirspeedCMargin=(rangeAirspeedMax*1.1-rangeAirspeedC)/2
  rangeAirspeedDMargin=(rangeAirspeedMax*1.1-rangeAirspeedD)/2


  ;K RANGES
  rangeKB=max(totalKAsB)-min(totalKAsB)
  rangeKC=max(totalKAsC)-min(totalKAsC)
  rangeKD=max(totalKAsD)-min(totalKAsD)

  rangeKMax=rangeKB
  if (rangeKC gt rangeKB) and (rangeKC gt rangeKD) then begin
    rangeKMax=rangeKC
  endif
  if (rangeKD gt rangeKC) and (rangeKD gt rangeKB) then begin
    rangeKMax=rangeKD
  endif

  rangeKBMargin=(rangeKMax*1.1-rangeKB)/2
  rangeKCMargin=(rangeKMax*1.1-rangeKC)/2
  rangeKDMargin=(rangeKMax*1.1-rangeKD)/2


  ;airspeed A


  if airspeedType eq 'indicated' then begin
    plot1=scatterplot(airspeedIndA,totalKAsA,dimensions=[1200,900])
    plot1.title='Total K vs Indicated Airspeed - A'
    plot1.xtitle='Indicated Airspeed [knot]'
    plot1.ytitle='Total K'
    plot1.xrange=[114,126]
    plot1.yrange=[.528,.540]
    plot1b=plot(unitVector,regLineTotalInd,'r',/overplot)
  endif

  presMeanAsA=mean(pmb[asAStart:asAEnd])
  tempMeanAsA=mean(tempRose[asAStart:asAEnd])
  altMeanAsA=mean(altP[asAStart:asAEnd])
  text1=text(840,740,'Pressure='+string(presMeanAsA)+' mb',/device)
  text1b=text(840,720,'Temperature='+string(tempMeanAsA)+' C',/device)
  text1c=text(840,700,'Altitude='+string(altMeanAsA)+' m',/device)




  ;airspeed B

  if airspeedType eq 'indicated' then begin
    plot2=scatterplot(airspeedIndB,totalKAsB,dimensions=[1200,900])
    plot2.title='Total K vs Indicated Airspeed - B'
    plot2.xtitle='Indicated Airspeed [knot]'
    plot2.ytitle='Total K'
    plot2b=plot(unitVector,regLineTotalInd,'r',/overplot)
    plot2.xrange=[min(airspeedIndB)-rangeAirspeedBMargin,max(airspeedIndB)+rangeAirspeedBMargin]
    plot2.yrange=[min(totalKAsB)-rangeKBMargin,max(totalKAsB)+rangeKBMargin]
  endif

  presMeanAsB=mean(pmb[asBStart:asBEnd])
  tempMeanAsB=mean(tempRose[asBStart:asBEnd])
  altMeanAsB=mean(altP[asBStart:asBEnd])
  text2=text(840,740,'Pressure='+string(presMeanAsB)+' mb',/device)
  text2b=text(840,720,'Temperature='+string(tempMeanAsB)+' C',/device)
  text2c=text(840,700,'Altitude='+string(altMeanAsB)+' m',/device)



  ;airspeed C


  if airspeedType eq 'indicated' then begin
    plot3=scatterplot(airspeedIndC,totalKAsC,dimensions=[1200,900])
    plot3.title='Total K vs Indicated Airspeed - C'
    plot3.xtitle='Indicated Airspeed [knot]'
    plot3.ytitle='Total K'
    plot3.xrange=[min(airspeedIndC)-rangeAirspeedCMargin,max(airspeedIndC)+rangeAirspeedCMargin]
    plot3.yrange=[min(totalKAsC)-rangeKCMargin,max(totalKAsC)+rangeKCMargin]
    plot3b=plot(unitVector,regLineTotalInd,'r',/overplot)
  endif

  presMeanAsC=mean(pmb[asCStart:asCEnd])
  tempMeanAsC=mean(tempRose[asCStart:asCEnd])
  altMeanAsC=mean(altP[asCStart:asCEnd])
  text3=text(840,740,'Pressure='+string(presMeanAsC)+' mb',/device)
  text3b=text(840,720,'Temperature='+string(tempMeanAsC)+' C',/device)
  text3c=text(840,700,'Altitude='+string(altMeanAsC)+' m',/device)



  ;airspeed D

  if airspeedType eq 'indicated' then begin
    plot4=scatterplot(airspeedIndD,totalKAsD,dimensions=[1200,900])
    plot4.title='Total K vs Indicated Airspeed - D'
    plot4.xtitle='Indicated Airspeed [knot]'
    plot4.ytitle='Total K'
    plot4.xrange=[min(airspeedIndD)-rangeAirspeedDMargin,max(airspeedIndD)+rangeAirspeedDMargin]
    plot4.yrange=[min(totalKAsD)-rangeKDMargin,max(totalKAsD)+rangeKDMargin]
    plot4b=plot(unitVector,regLineTotalInd,'r',/overplot)
  endif

  presMeanAsD=mean(pmb[asDStart:asDEnd])
  tempMeanAsD=mean(tempRose[asDStart:asDEnd])
  altMeanAsD=mean(altP[asDStart:asDEnd])
  text4=text(840,740,'Pressure='+string(presMeanAsD)+' mb',/device)
  text4b=text(840,720,'Temperature='+string(tempMeanAsD)+' C',/device)
  text4c=text(840,700,'Altitude='+string(altMeanAsD)+' m',/device)



  ;airspeed E


  if airspeedType eq 'indicated' then begin
    plot5=scatterplot(airspeedIndE,totalKAsE,dimensions=[1200,900])
    plot5.title='Total K vs Indicated Airspeed - E'
    plot5.xtitle='Indicated Airspeed [knot]'
    plot5.ytitle='Total K'
    plot5.xrange=[199,211]
    plot5.yrange=[.457,.469]
    plot5b=plot(unitVector,regLineTotalInd,'r',/overplot)
  endif

  presMeanAsE=mean(pmb[asEStart:asEEnd])
  tempMeanAsE=mean(tempRose[asEStart:asEEnd])
  altMeanAsE=mean(altP[asEStart:asEEnd])
  text5=text(840,740,'Pressure='+string(presMeanAsE)+' mb',/device)
  text5b=text(840,720,'Temperature='+string(tempMeanAsE)+' C',/device)
  text5c=text(840,700,'Altitude='+string(altMeanAsE)+' m',/device)



endif

endif







if genplots eq 'airspeed' then begin

  if sensor eq 'liquid' then begin

    ;--liqK vs airspeed--


    ;FIND RANGES

    ;AIRSPEED RANGES
    rangeAirspeedB=max(airspeedIndB)-min(airspeedIndB)
    rangeAirspeedC=max(airspeedIndC)-min(airspeedIndC)
    rangeAirspeedD=max(airspeedIndD)-min(airspeedIndD)

    rangeAirspeedMax=rangeAirspeedB
    if (rangeAirspeedC gt rangeAirspeedB) and (rangeAirspeedC gt rangeAirspeedD) then begin
      rangeAirspeedMax=rangeAirspeedC
    endif
    if (rangeAirspeedD gt rangeAirspeedC) and (rangeAirspeedD gt rangeAirspeedB) then begin
      rangeAirspeedMax=rangeAirspeedD
    endif

    rangeAirspeedBMargin=(rangeAirspeedMax*1.1-rangeAirspeedB)/2
    rangeAirspeedCMargin=(rangeAirspeedMax*1.1-rangeAirspeedC)/2
    rangeAirspeedDMargin=(rangeAirspeedMax*1.1-rangeAirspeedD)/2


    ;K RANGES
    rangeKB=max(liqKAsB)-min(liqKAsB)
    rangeKC=max(liqKAsC)-min(liqKAsC)
    rangeKD=max(liqKAsD)-min(liqKAsD)

    rangeKMax=rangeKB
    if (rangeKC gt rangeKB) and (rangeKC gt rangeKD) then begin
      rangeKMax=rangeKC
    endif
    if (rangeKD gt rangeKC) and (rangeKD gt rangeKB) then begin
      rangeKMax=rangeKD
    endif

    rangeKBMargin=(rangeKMax*1.1-rangeKB)/2
    rangeKCMargin=(rangeKMax*1.1-rangeKC)/2
    rangeKDMargin=(rangeKMax*1.1-rangeKD)/2




    ;airspeed A

    ;    if airspeedType eq 'true' then begin
    ;      plot1=scatterplot(airspeedA,liqKAsA,dimensions=[1200,900])
    ;      plot1.title='Liq K vs True Airspeed - A'
    ;      plot1.xtitle='True Airspeed [m/s]'
    ;      plot1.ytitle='Liquid K'
    ;      plot1.xrange=[80.2,82.2]
    ;      plot1.yrange=[1.7605,1.7655]
    ;      plot1b=plot(unitVector,regLineLiqTrue,'r',/overplot)
    ;    endif

    if airspeedType eq 'indicated' then begin
      plot1=scatterplot(airspeedIndA,liqKAsA,dimensions=[1200,900])
      plot1.title='Liq K vs Indicated Airspeed - A'
      plot1.xtitle='Indicated Airspeed [knot]'
      plot1.ytitle='Liquid K'
      plot1.xrange=[115,127]
      plot1.yrange=[1.180,1.213]
      plot1b=plot(unitVector,regLineLiqInd,'r',/overplot)
    endif

    presMeanAsLow=mean(pmb[asAStart:asAEnd])
    tempMeanAsLow=mean(tempRose[asAStart:asAEnd])
    altMeanAsLow=mean(altP[asAStart:asAEnd])
    text1=text(840,740,'Pressure='+string(presMeanAsLow)+' mb',/device)
    text1b=text(840,720,'Temperature='+string(tempMeanAsLow)+' C',/device)
    text1c=text(840,700,'Altitude='+string(altMeanAsLow)+' m',/device)




    ;airspeed B

    ;    if airspeedType eq 'true' then begin
    ;      plot2=scatterplot(airspeedB,liqKAsB,dimensions=[1200,900])
    ;      plot2.title='Liq K vs True Airspeed - B'
    ;      plot2.xtitle='True Airspeed [m/s]'
    ;      plot2.ytitle='Liquid K'
    ;      plot2b=plot(unitVector,regLineLiqTrue,'r',/overplot)
    ;      plot2.xrange=[94,96]
    ;      plot2.yrange=[1.725,1.73]
    ;    endif

    if airspeedType eq 'indicated' then begin
      plot2=scatterplot(airspeedIndB,liqKAsB,dimensions=[1200,900])
      plot2.title='Liq K vs Indicated Airspeed - B'
      plot2.xtitle='Indicated Airspeed [knot]'
      plot2.ytitle='Liquid K'
      plot2b=plot(unitVector,regLineLiqInd,'r',/overplot)
      ;plot2.xrange=[140,152] ;FOR 070913 FL 3000
      ;plot2.yrange=[1.145,1.179] ;FOR 070913 FL 3000

      plot2.xrange=[min(airspeedIndB)-rangeAirspeedBMargin,max(airspeedIndB)+rangeAirspeedBMargin]
      plot2.yrange=[min(liqKAsB)-rangeKBMargin,max(liqKAsB)+rangeKBMargin]
    endif

    presMeanAsMed=mean(pmb[asBStart:asBEnd])
    tempMeanAsMed=mean(tempRose[asBStart:asBEnd])
    altMeanAsMed=mean(altP[asBStart:asBEnd])
    text2=text(840,740,'Pressure='+string(presMeanAsMed)+' mb',/device)
    text2b=text(840,720,'Temperature='+string(tempMeanAsMed)+' C',/device)
    text2c=text(840,700,'Altitude='+string(altMeanAsMed)+' m',/device)




    ;airspeed C

    if airspeedType eq 'indicated' then begin
      plot3=scatterplot(airspeedIndC,liqKAsC,dimensions=[1200,900])
      plot3.title='Liq K vs Indicated Airspeed - C'
      plot3.xtitle='Indicated Airspeed [knot]'
      plot3.ytitle='Liquid K'
      ;plot3.xrange=[151,163] ;FOR 070913 FL 3000
      ;plot3.yrange=[1.126,1.16] ;FOR 070913 FL 3000

      plot3.xrange=[min(airspeedIndC)-rangeAirspeedCMargin,max(airspeedIndC)+rangeAirspeedCMargin]
      plot3.yrange=[min(liqKAsC)-rangeKCMargin,max(liqKAsC)+rangeKCMargin]
      plot3b=plot(unitVector,regLineLiqInd,'r',/overplot)
    endif

    presMeanAsHigh=mean(pmb[asCStart:asCEnd])
    tempMeanAsHigh=mean(tempRose[asCStart:asCEnd])
    altMeanAsHigh=mean(altP[asCStart:asCEnd])
    text3=text(840,740,'Pressure='+string(presMeanAsHigh)+' mb',/device)
    text3b=text(840,720,'Temperature='+string(tempMeanAsHigh)+' C',/device)
    text3c=text(840,700,'Altitude='+string(altMeanAsHigh)+' m',/device)



    ;airspeed D


    if airspeedType eq 'indicated' then begin
      plot4=scatterplot(airspeedIndD,liqKAsD,dimensions=[1200,900])
      plot4.title='Liq K vs Indicated Airspeed - D'
      plot4.xtitle='Indicated Airspeed [knot]'
      plot4.ytitle='Liquid K'
      ;plot4.xrange=[171.15,183.15] ;FOR 070913 FL 3000
      ;plot4.yrange=[1.10,1.134] ;FOR 070913 FL 3000

      plot4.xrange=[min(airspeedIndD)-rangeAirspeedDMargin,max(airspeedIndD)+rangeAirspeedDMargin]
      plot4.yrange=[min(liqKAsD)-rangeKDMargin,max(liqKAsD)+rangeKDMargin]
      plot4b=plot(unitVector,regLineLiqInd,'r',/overplot)
    endif

    presMeanAsHigh=mean(pmb[asDStart:asDEnd])
    tempMeanAsHigh=mean(tempRose[asDStart:asDEnd])
    altMeanAsHigh=mean(altP[asDStart:asDEnd])
    text4=text(840,740,'Pressure='+string(presMeanAsHigh)+' mb',/device)
    text4b=text(840,720,'Temperature='+string(tempMeanAsHigh)+' C',/device)
    text4c=text(840,700,'Altitude='+string(altMeanAsHigh)+' m',/device)



    ;airspeed E


    if airspeedType eq 'indicated' then begin
      plot5=scatterplot(airspeedIndE,liqKAsE,dimensions=[1200,900])
      plot5.title='Liq K vs Indicated Airspeed - E'
      plot5.xtitle='Indicated Airspeed [knot]'
      plot5.ytitle='Liquid K'
      plot5.xrange=[199,211]
      plot5.yrange=[1.074,1.108]
      plot5b=plot(unitVector,regLineLiqInd,'r',/overplot)
    endif

    presMeanAsHigh=mean(pmb[asEStart:asEEnd])
    tempMeanAsHigh=mean(tempRose[asEStart:asEEnd])
    altMeanAsHigh=mean(altP[asEStart:asEEnd])
    text5=text(840,740,'Pressure='+string(presMeanAsHigh)+' mb',/device)
    text5b=text(840,720,'Temperature='+string(tempMeanAsHigh)+' C',/device)
    text5c=text(840,700,'Altitude='+string(altMeanAsHigh)+' m',/device)

  endif




