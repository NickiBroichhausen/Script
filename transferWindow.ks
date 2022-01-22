
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

print " ".

if targetStructure:obt:eccentricity > 0.1 {
    print "target eccentricity to high !!!!!!!!!!!!!".
}.
if targetStructure:obt:inclination > 1 {
    print "target inclanation to high !!!!!!!!!!!!!".
}.
if startStructure:obt:eccentricity > 0.1 {
    print "startStructure eccentricity to high !!!!!!!!!!!!!".
}.
if startStructure:obt:inclination > 1 {
    print "startStructure inclanation to high !!!!!!!!!!!!!".
}.

print " ".
print "Transfer starting".
print "5".
wait 1.
print "4".
wait 1.
print "3".
wait 1.
print "2".
wait 1.
print "1".
wait 1.
clearScreen.

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


lock diff to angle - TRANSFERANGLE.
until diff < 1 and diff > -1{
    print angle  at (35, 1).
    print " - " + TRANSFERANGLE at (35, 2).
    print diff at (35, 3).
    set kuniverse:timewarp:rate to abs(round(diff)).
}.
set kuniverse:timewarp:rate to 0.
print "TRANSFER WINDOW REACHED".