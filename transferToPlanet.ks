parameter targetStructure.

function getPeriod{
parameter semiMajor.
return 2 * CONSTANT:PI * sqrt((semiMajor * semiMajor * semiMajor) / kerbol:mu).
}.

set tStart to SHIP:body:obt:period.
set tTarget to targetStructure:obt:period.
set tTransfer to getPeriod((ship:body:periapsis + targetStructure:apoapsis) / 2).

print tStart.
print tTarget.
print tTransfer.


//SET TRANSFERANGLE TO MOD(((tTransfer/2) / tTarget) * 360, 360).
//LOCK ANGLE TO ship:body - targetStructure:AN

//FUCK ES GIBT GAR KEINE ANGLE, MIST