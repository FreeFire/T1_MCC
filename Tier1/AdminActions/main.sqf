/* 
* Filename:
* main.sqf 
*
* Description:
* Gives the currently logged in admin access to special actions: teleport (click on map), ghost (enemy will not fire on you), Spectator (ACE only)
* 
* Created by [KH]Jman
* Creation date: 15/12/2010
* Email: jman@kellys-heroes.eu
* Web: http://www.kellys-heroes.eu
* 
* modified for A3: 11/03/2013
* modified for MSO: 16/08/2012
* */


// MAIN



private ["_player"];
_player = _this select 0;

if (player != _player) exitWith { };

if(isNil "CFG_AdminCmds") then {CFG_AdminCmds = 1;};
if(isNil "CFG_AdminCmdTeleport") then {CFG_AdminCmdTeleport = 1;};
if(isNil "CFG_AdminCmdGhost") then {CFG_AdminCmdGhost = 1;};
//if(isNil "CFG_AdminCmdSpectator") then {CFG_AdminCmdSpectator = 1;};
if(isNil "CFG_AdminCmdFreeCamera") then {CFG_AdminCmdFreeCamera = 1;};
if (CFG_AdminCmds == 0) exitwith {diag_log format ["MSO%1 Adminactions turned off - Exiting.",time];};



FNC_GHOST_CODE =
{ 
	private ["_player"];
	_player = _this select 0;
	if (player != _player) exitWith { }; 
	if (FNC_GHOST_ACTION == -1)then {
		FNC_GHOST_ACTION = player addAction ["Ghost Mode", "Tier1\AdminActions\ghostmode.sqf", "", 0, false, true];
	};
};
// ====================================================================================
FNC_TELEPORT_CODE =
{
	private ["_player"];
	_player = _this select 0;
	if (player != _player) exitWith { };
	if (FNC_TELEPORT_ACTION == -1)then { 
		FNC_TELEPORT_ACTION = player addAction ["Teleport Mode", "Tier1\AdminActions\teleportmode.sqf", "", 0, false, true];
	};
};
/* ====================================================================================
FNC_SPECTATOR_CODE =
{ 
	private ["_player"];
	_player = _this select 0;
	if (player != _player) exitWith { };
	if (FNC_SPECTATOR_ACTION == -1)then {
		FNC_SPECTATOR_ACTION = player addAction ["Spectator Mode", "Tier1\AdminActions\spectatormode.sqf", "", 0, false, true];
	};
};
 ====================================================================================
*/
FNC_FREE_CAMERA_CODE =
{
	private ["_player"];
	_player = _this select 0;
	if (player != _player) exitWith { };
	if (FNC_FREE_CAMERA_ACTION == -1)then {
		FNC_FREE_CAMERA_ACTION = player addAction ["Free Camera", "Tier1\AdminActions\freeCamera.sqf", "", 0, false, true];
	};
};
// ====================================================================================
FNC_PLAYER_RESPAWN = {
	private ["_isAdmin","_player"];
	_player = _this select 0;
	if (player != _player) exitWith { }; 
	
	FNC_GHOST_ACTION = -1;
	FNC_TELEPORT_ACTION = -1;
	//FNC_SPECTATOR_ACTION = -1;
	FNC_FREE_CAMERA_ACTION = -1;
	FNC_Vehicle_Action = -1;
	
	if (CFG_AdminCmds == 1) then { 
		[_player] spawn {
			teleportMode = false;
			waitUntil { 
				_isAdmin = serverCommandAvailable "#kick" || !isMultiplayer || isServer;
				if (_isAdmin) then {
					if (CFG_AdminCmdGhost == 1) then { [player] call FNC_GHOST_CODE; };
					if (CFG_AdminCmdTeleport == 1) then { [player] call FNC_TELEPORT_CODE; };
					//if (CFG_AdminCmdSpectator == 1) then { [player] call FNC_SPECTATOR_CODE; };
					if (CFG_AdminCmdFreeCamera == 1) then { [player] call FNC_FREE_CAMERA_CODE; };
				};

				if (!_isAdmin) then {
					//if ((FNC_GHOST_ACTION != -1) || (FNC_TELEPORT_ACTION != -1) || (FNC_SPECTATOR_ACTION != -1) || (FNC_FREE_CAMERA_ACTION != -1)) then {
					if ((FNC_GHOST_ACTION != -1) || (FNC_TELEPORT_ACTION != -1) || (FNC_FREE_CAMERA_ACTION != -1)) then {
						if (CFG_AdminCmdGhost == 1) then { player removeAction FNC_GHOST_ACTION;};
						if (CFG_AdminCmdTeleport == 1) then { player removeAction FNC_TELEPORT_ACTION; };
						//if (CFG_AdminCmdSpectator == 1) then { player removeAction FNC_SPECTATOR_ACTION;};
						if (CFG_AdminCmdFreeCamera == 1) then { player removeAction FNC_FREE_CAMERA_ACTION; };
						_this call FNC_PLAYER_RESPAWN;
					};
				};
				sleep 3;
				gameOver;
			};
		};
	};
};	
// ====================================================================================

if (CFG_AdminCmds == 1) then {
	gameOver = false;
	player addeventhandler ["Respawn", { _this call FNC_PLAYER_RESPAWN; } ];
	_this call FNC_PLAYER_RESPAWN;
};
// ====================================================================================
