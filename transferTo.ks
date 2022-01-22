parameter targetStructure.
 
runpath("transferWindow.ks", targetStructure).
lock steering to prograde.

lock throttle to 1.

print "STARTING TRANSFER".

until targetStructure:apoapsis - ship:orbit:apoapsis < 100000 or (ship:orbit:hasnextpatch and ship:orbit:nextpatch:body = targetStructureParam){     //not working
    print ship:orbit:periapsis.
}.
lock throttle to 0.
