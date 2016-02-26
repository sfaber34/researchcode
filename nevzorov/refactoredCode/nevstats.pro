;CALCULATES MEAN ABSOLUTE ERROR QUARTILES FOR VARIOUS PARAMETERS

function nevstats, var

var=abs(var)

middlei=(n_elements(var)/2.)
maxi=(n_elements(var)-1)

sortvar=sort(var)
var=var[sortvar]

minvar=min(var)
maxvar=max(var)

medvar=median(var)

varhalfa=var[0:middlei]
varhalfb=var[middlei:maxi]

quart1=median(varhalfa)
quart2=median(varhalfb)
    
;s={minvar:minvar, quart1:quart1, medvar:medvar, quart2:quart2, maxvar:maxvar}    


return,mean(var)

end