/*
This script allows everyone to manually eject from an aircraft.

Run this file on the clients.
*/


player addeventhandler ["Respawn", {
	player addaction [("<t color=""#ED2744"">") + ("EJECT") + "</t>", "Tier1\EjectScript\EP_eject.sqf", "", 1, false, true,"", "((vehicle player) iskindof ""Air"")"];
}];

player addaction [("<t color=""#ED2744"">") + ("EJECT") + "</t>", "Tier1\EjectScript\EP_eject.sqf", "", 1, false, true,"", "((vehicle player) iskindof ""Air"")"];