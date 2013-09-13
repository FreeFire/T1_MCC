

//	This script is a fix for the white screen bug that happens when you alt tab out of the game during a night mission.
//	This script adds a new action to the player that will very briefly enable and then disable night vision mode, effectively fixing the bug.
//	You want to enable this script if you intend to run a night mission with players who have no night vision goggles.
//	Run this script on the clients.


player addeventhandler ["Respawn", {
	player addaction ["Fix Screen", "Tier1\WhiteScreenFix\WhiteScreenFix.sqf", "", 0, false, true]; 
}];

player addaction ["Fix Screen", "Tier1\WhiteScreenFix\WhiteScreenFix.sqf", "", 0, false, true];