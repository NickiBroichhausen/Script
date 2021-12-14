wait until ship:unpacked.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
print "booting...".

wait 2.

local onPad to false.
Declare Local plist to ship:parts.
for part in plist{
	if part:hasmodule("LaunchClamp"){
		set onPad to true.
		break.
	}
}

if onPad {
   print"Launch sequenz initiated...".
   wait 1.
   copyPath("0:/launchBasic.ks", "").
   runpath("launchBasic.ks").
}

print "boot complete".