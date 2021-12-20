parameter targetStructure.
lock origin to - sun:position.

if targetStructure:obt:eccentricity > 0.1 {
    print "target eccentricity to high".
}.
if targetStructure:obt:inclination > 1 {
    print "target inclanation to high".
}.

function getAngle{
    set erg to vectorAngle(origin + ship:body:position, origin + targetStructure:position).
    wait 0.01.
    if erg - vectorAngle(origin + ship:body:position, origin + targetStructure:position) > 0 {
        set erg to -erg.
    }
    return erg.
}.


lock angle to getAngle().
function getPeriod{
    parameter semiMajor.
    return 2 * CONSTANT:PI * sqrt((semiMajor * semiMajor * semiMajor) / sun:mu).
}.

set tTarget to targetStructure:obt:period.
set tTransfer to getPeriod((ship:body:periapsis + targetStructure:apoapsis) / 2).

print tTarget.
print tTransfer.


// SET TRANSFERANGLE TO MOD(180 - ((tTransfer/2) / tTarget) * 360, 180).
SET TRANSFERANGLE TO (tTransfer/2) / tTarget * 360 - 180.

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