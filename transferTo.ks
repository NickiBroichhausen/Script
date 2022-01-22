parameter targetStructure.
 
clearScreen.

runpath("transferWindow.ks", targetStructure).
lock steering to prograde.

lock throttle to 1.

print "STARTING TRANSFER".

SET WARPMODE TO "PHYSICS".

set warp to 1.
until targetStructure:apoapsis - ship:orbit:apoapsis < 100000 or (ship:orbit:hasnextpatch and ship:orbit:nextpatch:body = targetStructureParam){     //not working
    print "periapsis" + ship:orbit:periapsis at (40, 1).
}.
set warp to 0.
lock throttle to 0.
SET WARPMODE TO "RAILS".