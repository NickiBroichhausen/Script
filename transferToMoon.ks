parameter targetStructure.
lock origin to - ship:body:position.


function getAngle{
    set erg to vectorAngle(origin + ship:position, origin + targetStructure:position).
    wait 0.01.
    if erg - vectorAngle(origin + ship:position, origin + targetStructure:position) > 0 {
        set erg to -erg.
    }
    return erg.
}.


lock angle to getAngle().
print angle.


function getPeriod{
    parameter semiMajor.
    set erg to 2 * CONSTANT:PI * sqrt((semiMajor * semiMajor * semiMajor) / ship:body:mu).
    print 2 * CONSTANT:PI.
    print  semiMajor * semiMajor * semiMajor.
    print (semiMajor * semiMajor * semiMajor) / ship:body:mu.
    print erg.
    return erg.
}.


set tTarget to targetStructure:obt:period.
set tTransfer to getPeriod((75000 + 12000000)/2).
set tTransfer to 183600.


SET TRANSFERANGLE TO MOD(180 - ((tTransfer/2) / tTarget) * 360, 180).

lock steering to prograde.
until angle - TRANSFERANGLE < 1 and angle - TRANSFERANGLE > -1{
    print (ship:periapsis + targetStructure:apoapsis)/2 + " semi major".
    print tTarget + " target period".
    print tTransfer + " transfer period".
    print angle + " - " + TRANSFERANGLE.
}.
lock throttle to 1.

    print "fire".
until targetStructure:apoapsis - ship:orbit:apoapsis < 100000{
print ship:orbit:periapsis.
}.
lock throttle to 0.