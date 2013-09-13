/* 
* Filename:
* ghostmode.sqf 
*
* Description:
* Spawns off init function to set admin player's visiblity 
* 
* Created by [KH]Jman
* Creation date: 06/03/2011
* Email: jman@kellys-heroes.eu
* Web: http://www.kellys-heroes.eu
* 
* */
// ====================================================================================
// MAIN

/* 
Params passed to this script:
object action was attached to
unit that activated action
index of action
*/

private ["_isAdmin","_player","_name","_index"];
_player = _this select 0;			 
_name = _this select 1;	
_index = _this select 2;


if (player != _player) exitWith { };

if (CFG_AdminCmds == 1) then { 
	_isAdmin = serverCommandAvailable "#kick" || !isMultiplayer;
	
	if (_isAdmin) then {
		
	player exec "camera.sqs";
	hint parsetext "WASD to move camera<br/>Numpad to look around<br/>Numpad 0 to exit";
		
	}else {
		hint "Command not available";
	};	
};
// ====================================================================================