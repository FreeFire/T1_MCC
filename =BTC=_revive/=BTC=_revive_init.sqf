/*
Created by =BTC= Giallustio
version 0.9 RC1
Visit us at: 
http://www.blacktemplars.altervista.org/
06/03/2012

Edited by BlackAlpha
*/

////////////////// EDITABLE \\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_revive_time_min = 5;
BTC_revive_time_max = 300;
BTC_who_can_revive  = ["B_medic_F", "O_medic_F", "I_medic_F", "T1_Squad_Medic_Standard_F", "T1_Squad_Medic_BlackCamo_F", "T1_SF_Medic_Standard_F", "T1_Diver_Medic_Standard_F"];
BTC_loop_check      = 0;
BTC_disable_respawn = 0;
BTC_respawn_gear    = 1;
BTC_black_screen    = 0;//Black screen + button while unconscious or action wheel and clear view
BTC_action_respawn  = 0;//if black screen is set to 0 you can choose if you want to use the action wheel or the button. Keep in mind that if you don't use the button, the injured player can use all the action, frag too....
BTC_respawn_time    = 30;
BTC_active_mobile   = 0;//Active mobile respawn (You have to put in map the vehicle and give it a name. Then you have to add one object per side to move to the mobile (BTC_base_flag_west,BTC_base_flag_east) - (1 = yes, 0 = no))
BTC_mobile_respawn  = 0;//Active the mobile respawn fnc (1 = yes, 0 = no)
BTC_mobile_respawn_time = 30;//Secs delay for mobile vehicle to respawn
BTC_need_first_aid = 0;//You need a first aid kit to revive (1 = yes, 0 = no)
BTC_pvp = 0; //(disable the revive option for the enemy)
BTC_injured_marker = 0;
BTC_objects_actions_west = [];
BTC_objects_actions_east = [];
BTC_objects_actions_guer = [];
BTC_objects_actions_civ  = [];
if (isServer) then
{
	BTC_vehs_mobile_west = [];//Editable - define mobile west
	BTC_vehs_mobile_east = [];//Editable - define mobile east
	BTC_vehs_mobile_guer = [];//Editable - define mobile independent
	BTC_vehs_mobile_civ  = [];//Editable - define mobile civilian
};
////////////////// Don't edit below \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

if (BTC_availableLives <= 0) then {
	BTC_active_lifes    = 0;
	BTC_lifes           = 1;
} else {
	BTC_active_lifes    = 1;
	BTC_lifes           = BTC_availableLives;
};


//FNC
call compile preprocessFile "=BTC=_revive\=BTC=_functions.sqf";

if (isServer) then
{
	//Mobile
	BTC_vehs_mobile_west_str = [];BTC_vehs_mobile_east_str = [];BTC_vehs_mobile_guer_str = [];
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_west != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_west) - 1) do {_veh = (BTC_vehs_mobile_west select _i);_var = str (_veh);BTC_vehs_mobile_west_str = BTC_vehs_mobile_west_str + [_var];_veh setVariable ["BTC_mobile_west",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_west"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_west;};
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_east != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_east) - 1) do {_veh = (BTC_vehs_mobile_east select _i);_var = str (_veh);BTC_vehs_mobile_east_str = BTC_vehs_mobile_east_str + [_var];_veh setVariable ["BTC_mobile_east",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_east"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_east;};
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_guer != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_guer) - 1) do {_veh = (BTC_vehs_mobile_guer select _i);_var = str (_veh);BTC_vehs_mobile_guer_str = BTC_vehs_mobile_guer_str + [_var];_veh setVariable ["BTC_mobile_guer",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_guer"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_guer;};
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_civ != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_civ) - 1) do {_veh = (BTC_vehs_mobile_civ select _i);_var = str (_veh);BTC_vehs_mobile_civ_str = BTC_vehs_mobile_civ_str + [_var];_veh setVariable ["BTC_mobile_civ",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_civ"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_civ;};
	if (BTC_active_mobile == 1) then {publicVariable "BTC_vehs_mobile_west_str";publicVariable "BTC_vehs_mobile_east_str";publicVariable "BTC_vehs_mobile_guer_str";publicVariable "BTC_vehs_mobile_civ_str";};
	//
	BTC_killed_pveh = [];publicVariable "BTC_killed_pveh";
	BTC_drag_pveh = [];publicVariable "BTC_drag_pveh";
	BTC_marker_pveh = [];publicVariable "BTC_marker_pveh";
	BTC_load_pveh = [];publicVariable "BTC_load_pveh";
	BTC_pullout_pveh = [];publicVariable "BTC_pullout_pveh";
};
if (isDedicated) exitWith {};

BTC_dragging = false;
BTC_respawn_cond = false;
BTC_cancelrevive = false;
BTC_GearMissingItems = [];

//Init
[] spawn
{
	waitUntil {!isNull player};
	waitUntil {player == player};
	"BTC_drag_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_marker_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_load_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_pullout_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_killed_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	player addRating 9999;
	BTC_side = playerSide;
	BTC_respawn_marker = format ["respawn_%1",side player];
	if (BTC_respawn_marker == "respawn_guer") then {BTC_respawn_marker = "respawn_guerrila";};
	if (BTC_respawn_marker == "respawn_civ") then {BTC_respawn_marker = "respawn_civilian";};
	player addEventHandler ["Killed", BTC_player_killed];
	player setVariable ["BTC_need_revive",0,true];
	player setVariable ["BTC_damage",0,true];
	player setVariable ["BTC_downed",0,false];
	if ([player] call BTC_is_class_can_revive) then {player addAction [("<t color=""#ED2744"">") + ("Revive") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_first_aid], 8, true, true, "", "[] call BTC_check_action_first_aid"];};
	player addAction [("<t color=""#ED2744"">") + ("Drag") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_drag], 8, true, true, "", "[] call BTC_check_action_drag"];
	player addAction [("<t color=""#ED2744"">") + ("Pull out injured") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_pull_out], 8, true, true, "", "[] call BTC_pull_out_check"];
	if (BTC_active_mobile == 1) then 
	{
		switch (true) do
		{
			case (side player == west) : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#ED2744"">") + ("Move to mobile " + _veh) + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[%1] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_west;} foreach BTC_vehs_mobile_west_str;};
			case (side player == east) : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#ED2744"">") + ("Move to mobile " + _veh) + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[%1] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_east;} foreach BTC_vehs_mobile_east_str;};
			case (side player == guer) : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#ED2744"">") + ("Move to mobile " + _veh) + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[%1] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_guer;} foreach BTC_vehs_mobile_guer_str;};
			case (side player == civ) : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#ED2744"">") + ("Move to mobile " + _veh) + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[%1] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_civ;} foreach BTC_vehs_mobile_civ_str;};
		};
	};
	BTC_gear = [] call BTC_get_gear;
	BTC_defaultgear = [] call BTC_get_gear;
	player addEventHandler ["killed", "BTC_gear = [] call BTC_get_gear;"];
	if (BTC_respawn_gear == 1) then {[] spawn BTC_getMissingGearItems;};
};