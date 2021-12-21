
parameter targetStructure.
set startStructure to ship.

clearscreen.

set commonBody to startStructure:body.
set targetStructureParam to targetStructure.
until startStructure:body = targetStructure:body{
    set targetStructure to targetStructureParam.
    until  targetStructure:body = commonBody or targetStructure:body = sun{
        set targetStructure to targetStructure:body.
    }.
   
    if not (startStructure:body = targetStructure:body){
        set startStructure to startStructure:body.
        set commonBody to startStructure:body.
    }.
}.
// set targetStructure to targetStructureIter.
print "transfer from: " + startStructure + " to: " + targetStructure + " around: " + commonBody.

lock origin to - commonBody:position.

if targetStructure:obt:eccentricity > 0.1 {
    print "target eccentricity to high".
}.
if targetStructure:obt:inclination > 1 {
    print "target inclanation to high".
}.
if startStructure:obt:eccentricity > 0.1 {
    print "startStructure eccentricity to high".
}.
if startStructure:obt:inclination > 1 {
    print "startStructure inclanation to high".
}.

function getAngle{
    set erg to vectorAngle(origin + startStructure:position, origin + targetStructure:position).
    wait 0.01.
    if erg - vectorAngle(origin + startStructure:position, origin + targetStructure:position) > 0 {
        set erg to -erg.
    }
    return erg.
}.

function getPeriod{
    parameter semiMajor.
    return 2 * CONSTANT:PI * sqrt((semiMajor * semiMajor * semiMajor) / commonBody:mu).
}.


lock angle to getAngle().

set tTarget to targetStructure:obt:period.
set tTransfer to getPeriod((startStructure:obt:periapsis + targetStructure:obt:apoapsis) / 2).

print tTarget + " target period".
print tTransfer + " transfer period".


// SET TRANSFERANGLE TO MOD(180 - ((tTransfer/2) / tTarget) * 360, 180).
SET TRANSFERANGLE TO (tTransfer/2) / tTarget * 360 - 180.

lock steering to prograde.

set kuniverse:timewarp:rate to 1000.
until angle - TRANSFERANGLE < 1 and angle - TRANSFERANGLE > -1{
    print angle  at (40, 1).
    print " - " + TRANSFERANGLE at (40, 2).
}.
set kuniverse:timewarp:rate to 0.
// lock throttle to 1.

print "fire".

// until targetStructure:apoapsis - ship:orbit:apoapsis < 100000{
// print ship:orbit:periapsis.
// }.
// lock throttle to 0.