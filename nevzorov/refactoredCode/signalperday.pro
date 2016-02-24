pro signalperday

common g, g

days=[0710,0725,0727,0728,0729,0803,0807,0814,0815]
for i=0, n_elements(days)-1 do begin
    nevbase, days[i],'indicated',400

  print, '-------------------------------------------'
  print, days[i]
  print, n_elements(g.signal),'/',n_elements(g.pmb),' ',(n_elements(g.signal)/n_elements(g.pmb))
  print,''
  print,''
endfor

return
end