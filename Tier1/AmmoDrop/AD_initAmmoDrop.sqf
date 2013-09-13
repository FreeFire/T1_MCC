/*
This script will allow pilots in the driver seat of a specific chopper to spawn an ammo crate, to simulate an ammo drop.

Run this file on all machines.

This script requires the following script to exist: Tier1\MiscScripts\aircraftResupplyZone.sqf
The above script can give a vehicle an ammo box when it resupplies, then the ammo box can later be deployed in the field.
*/



// Vehicles that can carry an ammo crate.
AD_compatibleVehicles = ["B_Heli_Transport_01_F", "I_Heli_Transport_02_F"];



if (isnil "AD_ammocrates") then {
	
	AD_ammocrates = [];
	
} else {
	
	[] spawn {
		if (!(isnil "AD_hndlr_fac")) then {
			waitUntil {scriptDone AD_hndlr_fac};
		};
		AD_hndlr_fac = [] execVM "Tier1\AmmoDrop\AD_fillAmmoCrate.sqf";
	}; 
	
};



"AD_ammocrates" addPublicVariableEventHandler {
	
	[] spawn {
		if (!(isnil "AD_hndlr_fac")) then {
			waitUntil {scriptDone AD_hndlr_fac};
		};
		AD_hndlr_fac = [] execVM "Tier1\AmmoDrop\AD_fillAmmoCrate.sqf";
	};
	
};



AD_running = false;

player addeventhandler ["Respawn", {
	player addaction ["Unload Ammo Box", "Tier1\AmmoDrop\AD_unloadAmmoCrate.sqf", "", 1, false, true,"", "((typeof (vehicle player) in AD_compatibleVehicles) and (speed (vehicle player) > -2) and (speed (vehicle player) < 2) and (getpos (vehicle player) select 2 < 2) and (driver (vehicle player) == player) and (!AD_running))"];
}];

player addaction ["Unload Ammo Box", "Tier1\AmmoDrop\AD_unloadAmmoCrate.sqf", "", 1, false, true,"", "((typeof (vehicle player) in AD_compatibleVehicles) and (speed (vehicle player) > -2) and (speed (vehicle player) < 2) and (getpos (vehicle player) select 2 < 2) and (driver (vehicle player) == player) and (!AD_running))"];



if (isserver) then {
	
	AD_createCrate = [];
	
	"AD_createCrate" addPublicVariableEventHandler {
		_this spawn {
			_this execVM "Tier1\AmmoDrop\AD_createAmmoCrate.sqf";
		};
	};
	
};


