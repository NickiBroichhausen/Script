
local safeAltitude is ship:body:atm:height.
if safeAltitude < 8000 {
	set safeAltitude to 8000.
}.
local targetAltitude is ship:body:atm:height + 5000.
if targetAltitude < safeAltitude + 2000 {
	set targetAltitude to safeAltitude + 2000.
}.
local dir is 90.
lock mySteer to heading(90, dir).
Lock steering to mySteer.
set thrust to 0.
Lock throttle to thrust.
set oldThrust to -1.


function printInfo{
   local textOffset is 25.
   
   print "direction:" at (textOffset, 0).
   print round(dir, 0) + "   " at (textOffset + 15, 0).
   print "apoapsis:" at (textOffset, 1).
   print round(ship:orbit:Apoapsis, 0) + "   "  at (textOffset + 15, 1).
   print "eta apoapsis:" at (textOffset, 2).
   print round(eta:apoapsis, 0) + "   "  at (15 + textOffset, 2).
   print "periapsis: " at (textOffset, 3).
   print round(ship:orbit:periapsis, 0) + "   " at (15 + textOffset, 3).
}

function safeStage {
	PRINT " ".
	PRINT "STAGING".
	STAGE.
	wait 0.5.
	set oldThrust to ship:maxthrust.
}.

declare function ShipTWR
{
    set mth to SHIP:MAXTHRUST.
    set radius to SHIP:ALTITUDE+SHIP:BODY:RADIUS.
    set w to SHIP:MASS * SHIP:BODY:MU / radius / radius.
    return mth/w.
}

function liftOff {
	set thrust TO 1.0.
	
	PRINT "Countdown:".
	FROM {local countdown is 5.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
		PRINT "..." + countdown.
		WAIT 1.
	}

	until ship:maxthrust > 0 {
		safeStage().
	}.
	
	set thrust TO 1.9 / ShipTWR()..
	clearscreen.

	PRINT " ".
	PRINT "LIFTOFF".
}

function gravityTurn {
	wait 1.
	set warp to 1.
	until ship:orbit:Apoapsis > targetAltitude {
	   set dir to (90 - (ship:orbit:Apoapsis/targetAltitude) * 90).
	
	}.
	set warp to 0.
	set thrust TO 0.0.

	PRINT " ".
	PRINT "INSERTION BURN COMPLETE".
}

function circularize {
	wait 1.
	set warp to 3.
	PRINT " ".
	PRINT "PREPARING CIRCULARIZATION...".

	until eta:apoapsis < 20 / ShipTWR().{
	}.
	set warp to 0.
	wait 1.
	set thrust TO 1.0.
	wait 0.5.
	set mapView to true.
	set warp to 2.
	until (ship:orbit:apoapsis > 1000 + targetAltitude OR ship:orbit:eccentricity < 0.001) AND ship:orbit:periapsis > safeAltitude{
	   if ship:verticalspeed < 0 {
		  set dir to (-ship:verticalspeed * 3).
	   }
	   else{
		  set dir to (-ship:verticalspeed * 0.1).
	   }
	}.
	set thrust TO 0.0.
	set warp to 0.
	set mapView to false.
	PRINT " ".
	PRINT "CIRCULARIZATION BURN COMPLETE".
}

function startSequence{

	CLEARSCREEN.
 
	liftOff().

	gravityTurn().

	circularize().

	wait 3.

	SET antennaList to SHIP:MODULESNAMED("ModuleDeployableAntenna").
	FOR eachAntenna IN antennaList { 
		if eachAntenna:hasevent("extend antenna"){
			eachAntenna:DOEVENT("extend antenna"). 
		}
	}
	Panels On.
	RADIATORS ON.

	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	clearscreen.
	print "LAUNCH COMPLETE".
}



when ship:altitude > 50000 then {
	PRINT " ".
	print "FAIRING DEPLOY".
	for part in ship:parts {
	   if part:hasmodule("moduleproceduralfairing") {
		  local fairing is part:getmodule("moduleproceduralfairing").
		  if fairing:hasevent("deploy") {
			  fairing:doevent("deploy").
		  }
	   }
	}
}.

	
when ship:maxthrust < oldThrust OR oldThrust = 0 then {   
	safeStage().
	preserve.
}.

on  round(time:seconds,1){
	printInfo().
	preserve.
}.

startSequence().