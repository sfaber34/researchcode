pro coleff

d=[1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.]
eff=[.15,.5,.68,.79,.835,.88,.9,.92,.94,.99,1.]


plot1=scatterplot(d,eff)

pfit=poly_fit(d,eff,4)

line=pfit[0]+pfit[1]*d+pfit[2]*d^2.+pfit[3]*d^3.+pfit[4]*d^4.

plot2=plot(d,line,/overplot)

end