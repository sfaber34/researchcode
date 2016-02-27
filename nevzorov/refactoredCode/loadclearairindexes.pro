function loadclearairindexes, flightday

restore, filename='clearairindexes.sav'

if flightday eq '0710' then clearair = clearair0710
if flightday eq '0725' then clearair = clearair0725
if flightday eq '0727' then clearair = clearair0727
if flightday eq '0728' then clearair = clearair0728
if flightday eq '0729' then clearair = clearair0729
if flightday eq '0807' then clearair = clearair0807
if flightday eq '0814' then clearair = clearair0814
if flightday eq '0815' then clearair = clearair0815
if flightday eq '0803' then clearair = clearair0803

return, clearair

end