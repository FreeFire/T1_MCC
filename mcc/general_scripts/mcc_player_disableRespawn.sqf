
/*
	by Sickboy (sb_at_dev-heaven.net)
*/

if (isDedicated) exitWith {}; // not a player machine

private ["_safePos", "_startMarker", "_trainingMode", "_pos"];

while { !alive player } do {sleep 1};
sleep 3;

//_playerClass = typeOf player;
//_playerSideNr =  getNumber (configFile >> "CfgVehicles" >> _playerClass >> "side");

_playerSide = (side player);

switch ( _playerSide ) do
{ 
	case west:
	{ 
		while { (isnil ("MCC_START_WEST"))  } do {sleep 1};

		if (MCC_teleportAtStart) then
		{
			if (surfaceIsWater (MCC_START_WEST)) then 
			{
				_safePos = [(MCC_START_WEST),1,10,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_WEST),1,10,1,0,900,0] call BIS_fnc_findSafePos;
			};
			MCC_START_WEST = _safepos;
			player setPos MCC_START_WEST;
		};
		_startMarkerW = createMarkerLocal ["STARTLOCATIONW", (MCC_START_WEST)];
		_startMarkerW setMarkerShapeLocal "ICON";	
		_startMarkerW setMarkerTypeLocal  "mil_start";
		_startMarkerW setMarkerColorLocal "ColorGreen";

		//create the respawn locations
		_respawnMarkerW = createMarkerLocal ["RESPAWN_WEST", (MCC_START_WEST)];
		_respawnMarkerW setMarkerShapeLocal "ICON";	
		_respawnMarkerW setMarkerTypeLocal  "mil_objective";
		_respawnMarkerW setMarkerColorLocal "ColorRed";
	};

	case east:
	{ 
		while { (isnil ("MCC_START_EAST"))  } do {sleep 1};
		if (MCC_teleportAtStart) then
		{
			if (surfaceIsWater (MCC_START_EAST)) then 
			{
				_safePos = [(MCC_START_EAST),1,10,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_EAST),1,10,1,0,900,0] call BIS_fnc_findSafePos;
			};
			MCC_START_EAST = _safepos;
			player setPos MCC_START_EAST;
		};
		_startMarkerE = createMarkerLocal ["STARTLOCATIONE", ( MCC_START_EAST)];
		_startMarkerE setMarkerShapeLocal "ICON";	
		_startMarkerE setMarkerTypeLocal  "mil_start";
		_startMarkerE setMarkerColorLocal "ColorGreen";

		//create the respawn locations
		_respawnMarkerE = createMarkerLocal ["RESPAWN_EAST", ( MCC_START_EAST)];
		_respawnMarkerE setMarkerShapeLocal "ICON";	
		_respawnMarkerE setMarkerTypeLocal  "mil_objective";
		_respawnMarkerE setMarkerColorLocal "ColorRed";
	};

	case resistance:
	{ 
		while { (isnil ("MCC_START_GUAR")) } do {sleep 1};
		if (MCC_teleportAtStart) then
		{
			if (surfaceIsWater (MCC_START_GUAR)) then 
			{
				_safePos = [(MCC_START_GUAR),1,10,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_GUAR),1,10,1,0,900,0] call BIS_fnc_findSafePos;
			};
			MCC_START_GUAR = _safepos;
			player setPos MCC_START_GUAR;
		};
		_startMarkerG = createMarkerLocal ["STARTLOCATIONG", (MCC_START_GUAR)];
		_startMarkerG setMarkerShapeLocal "ICON";	
		_startMarkerG setMarkerTypeLocal  "mil_start";
		_startMarkerG setMarkerColorLocal "ColorGreen";

		//create the respawn locations
		_respawnMarkerG = createMarkerLocal ["RESPAWN_GREEN", (MCC_START_GUAR)];
		_respawnMarkerG setMarkerShapeLocal "ICON";	
		_respawnMarkerG setMarkerTypeLocal  "mil_objective";
		_respawnMarkerG setMarkerColorLocal "ColorRed";
	};
  
	case civilian:
	{ 
		while { (isnil ("MCC_START_CIV")) } do {sleep 1};
		if (MCC_teleportAtStart) then
		{
			if (surfaceIsWater (MCC_START_CIV)) then 
			{
				_safePos = [(MCC_START_CIV),1,10,1,2,900,0] call BIS_fnc_findSafePos;
			} else {
				_safePos = [(MCC_START_CIV),1,10,1,0,900,0] call BIS_fnc_findSafePos;
			};
			MCC_START_CIV = _safepos;
			player setPos MCC_START_CIV;
		};
		_startMarkerG = createMarkerLocal ["STARTLOCATIONG", (MCC_START_CIV)];
		_startMarkerG setMarkerShapeLocal "ICON";	
		_startMarkerG setMarkerTypeLocal  "mil_start";
		_startMarkerG setMarkerColorLocal "ColorGreen";

		//create the respawn locations
		_respawnMarkerG = createMarkerLocal ["RESPAWN_Civilans", (MCC_START_CIV)];
		_respawnMarkerG setMarkerShapeLocal "ICON";	
		_respawnMarkerG setMarkerTypeLocal  "mil_objective";
		_respawnMarkerG setMarkerColorLocal "ColorRed";
	};
};

_firstLoop = 0;
_respawn = true;

//diag_log format ["--- main: %1 ---", MCC_enable_respawn];

scopename "mainRespawn";
while { true } do
{
	// loop while repawn is off and do nothing but wait
	scopeName "loopRespawn";
	while { true } do
	{
		scopeName "loopRespawnSub";
		if ( MCC_enable_respawn ) then 
		{	
			sleep 4;
diag_log format ["--- respawn enabled - breakTo main: %1 ---", MCC_enable_respawn];
		}
		else 
		{
			hint "Respawn Disabled";
			//respawn has been disabled
diag_log "--- respawn disabled - trigger breakOut ---";
			breakOut "loopRespawnSub";
		};
	};
	
	//diag_log "--- respawn disabled - start while loop ---";
	while { alive player } do 
	{
diag_log format ["--- %1 ---", MCC_enable_respawn];
		scopeName "loopNoRespawn";
		if (!MCC_enable_respawn ) then
		{
			if ( _firstLoop == 1 ) then 
			{
////				sleep 4;
				sleep 1;
			}
			else
			{
				//set respawn location at edge of the map
				//"RESPAWN_GREEN" setMarkerPosLocal [-9999, -9999, 0.5];
				//"RESPAWN_EAST" setMarkerPosLocal [-9999, -9999, 0.5];
				//"RESPAWN_WEST" setMarkerPosLocal [-9999, -9999, 0.5];
				"RESPAWN_WEST" setMarkerPosLocal [3780,7924];
				"RESPAWN_EAST" setMarkerPosLocal [3780,7924];
				"RESPAWN_GUERRILA" setMarkerPosLocal [3780,7924];
				"RESPAWN_Civilans" setMarkerPosLocal [3780,7924];
				_firstLoop = 1;
			};
		}
		else
		{
diag_log "--- respawn enabled again - trigger breakTo ---";
			hint "Respawn Enabled";
			//respawn enabled again - reset original respawn locations
			"RESPAWN_GUERRILA" setMarkerPosLocal MCC_START_GUAR;
			"RESPAWN_EAST" setMarkerPosLocal MCC_START_EAST;
			"RESPAWN_WEST" setMarkerPosLocal MCC_START_WEST;
			"RESPAWN_Civilans" setMarkerPosLocal MCC_START_CIV;
			_firstLoop = 0;
			breakTo "loopRespawn";
		};
	};

	if ( !(alive player) ) exitWith { diag_log "--- player died ---"; };
	// player died - exit loop and wait for respawn
};

//diag_log "--- outside respawn loop ---";

sleep 0.5;

if !(isNil "BTC_respawn_cond") then {
	waitUntil { (alive player) && (player isKindOf "CAManBase") && BTC_respawn_cond};
	sleep BTC_respawn_time;
} else {
	waitUntil { (alive player) && (player isKindOf "CAManBase")};
};

diag_log format ["%1 - C - setPos: [%2]", diag_tickTime, getPos player];	

waitUntil { !( ((getPosASL player) select 0) == 0 ) }; 

player setCaptive true;
[player] join MCC_deadGroup;

//removeAllWeapons player;

//sleep 1;
//if (mcc_missionmaker == (name player)) then {titlecut ["You Died...","BLACK OUT", 2];[cameraOn,cameraOn,cameraOn] execVM "f\common\f_spect\specta.sqf";};
//if (mcc_missionmaker == (name player)) then {titlecut ["You Died...","BLACK OUT", 2];[player] execVM "spect\specta.sqf";};
//[player] execVM "spect\specta.sqf";
player addAction ["Camera Mode", "A3\functions_f\Debug\fn_camera.sqf"];
//player addAction ["Spectator Mode", "camera.sqs"];
nul = [player] execVM "A3\functions_f\Debug\fn_camera.sqf";
