pro histogram

restore,'cons.sav',/verbose
restore,'consca.sav',/verbose

inc=.005


h=histogram(lwcConca,binsize=inc)
ticks=['.02','.04',' ',' ']

stop
plot1=barplot(dindgen(n_elements(h)),h,histogram=1)
plot1.xtickname=ticks
plot1.xtext_orientation=270

end