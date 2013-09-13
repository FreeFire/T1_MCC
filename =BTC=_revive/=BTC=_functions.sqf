/*
Created by =BTC= Giallustio
version 0.9 RC1
Visit us at: 
http://www.blacktemplars.altervista.org/
06/03/2012

Edited by BlackAlpha
*/



BTC_assign_actions =
{
	if ([player] call BTC_is_class_can_revive) then {player addAction [("<t color=""#ED2744"">") + ("Revive") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_first_aid], 8, true, true, "", "[] call BTC_check_action_first_aid"];};
	player addAction [("<t color=""#ED2744"">") + ("Drag") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_drag], 8, true, true, "", "[] call BTC_check_action_drag"];
	player addAction [("<t color=""#ED2744"">") + ("Pull out injured") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_pull_out], 8, true, true, "", "[] call BTC_pull_out_check"];
};



BTC_get_gear =
{
	private ["_array_mag","_id","_display_name","_count","_array_class","_array_bullet","_array_class_x","_array_bullet_x","_r_mag_d","_h_mag_d","_brack"];
	_gear = [];
	_weapons = weapons player;
	_prim_weap = primaryWeapon player;
	_prim_items = primaryWeaponItems player;
	_sec_weap = secondaryWeapon player;
	_sec_items = secondaryWeaponItems player;
	_items_assigned = assignedItems player;
	_handgun = handgunWeapon player;
	_handgun_items = handgunItems player;
	_goggles = goggles player;
	_headgear = headgear player;
	_uniform = uniform player;
	_uniform_items = uniformItems player;
	_vest = vest player;
	_vest_items = vestItems player;
	_back_pack = backpack player;
	_back_pack_items = backpackItems player;
	_back_pack_weap = getWeaponCargo (unitBackpack player);
	_weap_sel = currentWeapon player;
	_weap_mode = currentWeaponMode player;
	_at_mag = "";
	_r_mag = "";
	_h_mag = "";
		
	if (_sec_weap != "") then {
		_at_mag = (secondaryWeaponMagazine player) select 0;
		if (isnil "_at_mag") then {
			_at_mag = "";
		};
	};
	if (_handgun != "") then {
		_h_mag = (handgunMagazine player) select 0;
		if (isnil "_h_mag") then {
			_h_mag = "";
		};
	};
	if (_prim_weap != "") then {
		_r_mag = (primaryWeaponMagazine player) select 0;
		if (isnil "_r_mag") then {
			_r_mag = "";
		};
	};
	
	player selectWeapon _weap_sel;
	_fire_mode_array = getArray (configFile >> "cfgWeapons" >> _weap_sel >> "modes");
	_fire_mode = _fire_mode_array find _weap_mode;
	if (_fire_mode != -1) then {player action ["SWITCHWEAPON", player, player, _fire_mode];};
	
	_mags   = magazines player;
	_magd   = magazinesDetail player;
	
	if (_r_mag != "") then {_mags = _mags + [_r_mag];};
	if (_h_mag != "") then {_mags = _mags + [_h_mag];};
	
	BTC_compile_count = 0;
	_mags_g = [];
	_array_class  = [];
	_array_bullet = [];
	{
		_array_mag  = toArray _x;
		_brack = 0;
		{
			if (_x == 40) then {
				_brack = _brack + 1;
			};
		} foreach _array_mag;
		
		_cond_class = false;
		_cond_bullet = false;
		_array_class_x  = [];
		_array_bullet_x = [];
		
		for "_i" from 0 to (count _array_mag - 1) do
		{
			_n = _array_mag select _i;
			if (_n == 40) then {_brack = _brack - 1;};
			if (_brack == 0) then {_cond_class = true;};
			if !(_cond_class) then
			{
				_array_class_x = _array_class_x + [_n];
			}
			else
			{
				if (_n == 47) then {_cond_bullet = true;};
				if (_n != 40 && _n != 41 && _n != 47 && !_cond_bullet) then {_array_bullet_x = _array_bullet_x + [_n];};
			};
		};
		_array_class = _array_class + [toString _array_class_x];
		_array_bullet = _array_bullet + [toString _array_bullet_x];
	} foreach _magd;
	
	{
		_display_name = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
		_id = _array_class find _display_name;
		if (_id > -1) then {
			_count = _array_bullet select _id;
			_array_class set [_id,0];
			_array_class = _array_class - [0];
			_array_bullet set [_id,0];
			_array_bullet = _array_bullet - [0];
			call compile format ["BTC_compile_count = %1;", _count];
			_mags_g = _mags_g + [[_x,BTC_compile_count]];
		} else {
			_mags_g = _mags_g + [_x];
		};
	} foreach _mags;
	
	_gear =
	[
		_uniform,
		_vest,
		_goggles,
		_headgear,
		_back_pack,
		_back_pack_items,
		_back_pack_weap,
		_weapons,
		_prim_items,
		_sec_items,
		_handgun_items,
		_items_assigned,
		_uniform_items,
		_vest_items,
		_weap_sel,
		_mags_g,
		_at_mag,
		_sec_weap
	];
	
	_gear
};



BTC_set_gear =
{
	/*_gear =
	[
		_uniform,0
		_vest,1
		_goggles,2
		_headgear,3
		_back_pack,4
		_back_pack_items,5
		_back_pack_weap,6
		_weapons,7
		_prim_items,8
		_sec_items,9
		_handgun_items,10
		_items_assigned,11
		_uniform_items,12
		_vest_items,13
		_weap_sel,14
		_mags_g,15
		_at_mag,16
		_sec_weap,17
	];
	
	_missingGear =
	[
		_back_pack_items,0
		_prim_items,1
		_sec_items,2
		_handgun_items,3
	];*/
	
	private ["_uniform", "_vest", "_goggles", "_headgear", "_back_pack", "_back_pack_items", "_back_pack_weap", "_weapons", "_prim_items", "_sec_items", "_handgun_items", "_items_assigned", "_uniform_items", "_vest_items", "_weap_sel", "_mags_g", "_at_mag", "_sec_weap"];
	
	_unit = _this select 0;
	_gear = _this select 1;
	
	// Due to a bug in some of the scripting commands, you need to use a workaround to fetch the complete gear of dead units.
	_missingGear = BTC_GearMissingItems;
	
	_uniform = _gear select 0;
	_vest = _gear select 1;
	_goggles = _gear select 2;
	_headgear = _gear select 3;
	_back_pack = _gear select 4;
	
	if (!isnil {_gear select 5}) then {
		_back_pack_items = _gear select 5;
	} else {
		_back_pack_items = _missingGear select 0;
	};
	
	// This one isn't actually used.
	//_back_pack_weap = _gear select 6;
	
	_weapons = _gear select 7;
	
	if (!isnil {_gear select 8}) then {
		_prim_items = _gear select 8;
	} else {
		_prim_items = _missingGear select 1;
	};
	
	if (!isnil {_gear select 9}) then {
		_sec_items = _gear select 9;
	} else {
		_sec_items = _missingGear select 2;
	};
	
	if (!isnil {_gear select 10}) then {
		_handgun_items = _gear select 10;
	} else {
		_handgun_items = _missingGear select 3;
	};
	
	_items_assigned = _gear select 11;
	_uniform_items = _gear select 12;
	_vest_items = _gear select 13;
	_weap_sel = _gear select 14;
	_mags_g = _gear select 15;
	_at_mag = _gear select 16;
	_sec_weap = _gear select 17;
	
	// Strip all gear from the unit so that we can add new gear
	removeAllweapons _unit;
	removeuniform _unit;
	removevest _unit;
	removeheadgear _unit;
	removegoggles _unit;
	removeBackPack _unit;
	{_unit removeItem _x} foreach (items _unit);
	{_unit unassignItem _x;_unit removeItem _x} foreach (assignedItems _unit);
	
	// Begin adding new gear
	
	// Uniform
	if (_uniform != "") then {_unit addUniform _uniform;};
	
	// Vest
	if (_vest != "") then {_unit addVest _vest;};
	
	// Temp backpack, no idea why...
	_unit addBackpack "B_AssaultPack_blk";
	
	// Inventory items
	if (count _items_assigned > 0) then {{if (_x != "") then {_unit addItem _x;_unit assignItem _x;sleep 0.01;};} foreach _items_assigned;};
	
	// Remove temp backpack
	removeBackPack _unit;
	
	// Backpack
	if (_back_pack != "") then {_unit addBackPack _back_pack;clearAllItemsFromBackpack _unit;};
	
	// Uniform items
	{if !(isClass (configFile >> "cfgMagazines" >> _x)) then {_unit addItem _x;};sleep 0.1;} foreach _uniform_items;
	
	// Vest items
	{if !(isClass (configFile >> "cfgMagazines" >> _x)) then {_unit addItem _x;};sleep 0.1;} foreach _vest_items;	
	
	// Backpack items
	{
		if !(isClass (configFile >> "cfgMagazines" >> _x)) then {
			_unit addItem _x;
		};
		sleep 0.1;
	} foreach _back_pack_items;
	
	// Goggles
	if (_goggles != "") then {_unit addGoggles _goggles;};
	
	// Headgear
	if (_headgear != "") then {_unit addHeadgear _headgear;};
	
	// Add temporary backpack if unit has no backpack. A backpack is needed to correctly load AT weapon mags.
	_tempBackpackGiven = false;
	if (backpack _unit == "") then {
		_tempBackpackGiven = true;
		_unit addBackpack "B_AssaultPack_blk";
	};
	
	// Secondary (launcher) weapon mags
	if (_at_mag != "") then {_unit addMagazine _at_mag};
	
	// Secondary (launcher) weapon
	if (_sec_weap != "") then {_unit addweapon _sec_weap};
	
	// Remove the temporary backpack.
	if (_tempBackpackGiven) then {
		removeBackPack _unit;
	};
	
	// Primary and pistol weapon mags
	{_unit addMagazine _x;} foreach _mags_g;
	
	// Weapons (primary and pistol)
	{if (isClass (configFile >> "cfgWeapons" >> _x)) then {if (_x != _sec_weap) then {_unit addweapon _x;};};} foreach _weapons;
	
	// Remove attachments from primary weapon so that we can add new attachments.
	{_unit removePrimaryWeaponItem _x} foreach (primaryWeaponItems _unit);
	
	// Primary weapon attachments
	if (count _prim_items > 0) then {{_unit addPrimaryWeaponItem _x;} foreach _prim_items;};
	
	// Secondary (launcher) weapon attachments
	if (count _sec_items > 0) then {{_unit addSecondaryWeaponItem _x;} foreach _sec_items;};
	
	// Pistol weapon attachments
	if (count _handgun_items > 0) then {{_unit addHandgunItem _x;} foreach _handgun_items;};
	
	// Equip main weapon
	_unit selectweapon _weap_sel;
};



BTC_fnc_handledamage =
{
	_player = _this select 0;
	_enemy  = _this select 3;
	_damage = _this select 2;
	_part   = _this select 1;
	if (Alive _player) then
	{
		BTC_gear = [] call BTC_get_gear;
	};
	_damage
	//if (format ["%1", _player getVariable "BTC_need_revive"] == "1") then {} else {_damage};
};



BTC_fnc_PVEH =
{
	//0 - first aid - create // [0,east,pos]
	//1 - first aid - delete
	_array = _this select 1;
	_type  = _array select 0;
	switch (true) do
	{
		case (_type == 0) : 
		{
			_side = _array select 1;
			_unit = _array select 3;
			if (_side == BTC_side) then 
			{
				_pos = _array select 2;
				_marker = createmarkerLocal [format ["FA_%1", _pos], _pos];
				format ["FA_%1", _pos] setmarkertypelocal "mil_box";
				format ["FA_%1", _pos] setMarkerTextLocal format ["F.A. %1", name _unit];
				format ["FA_%1", _pos] setmarkerColorlocal "ColorGreen";
				format ["FA_%1", _pos] setMarkerSizeLocal [0.3, 0.3];
				[_pos,_unit] spawn
				{
					_pos  = _this select 0;
					_unit = _this select 1;
					while {(!(isNull _unit) && (format ["%1", _unit getVariable "BTC_need_revive"] == "1"))} do
					{
						format ["FA_%1", _pos] setMarkerPosLocal getpos _unit;
						sleep 1;
					};
					deleteMarker format ["FA_%1", _pos];
				};
			};
		};
		case (_type == 1) : {(_array select 1) setDir 180;(_array select 1) playMoveNow "AinjPpneMstpSnonWrflDb_grab";};
		case (_type == 2) : 
		{
			private ["_injured"];
			_injured = (_array select 1);
			[_injured] spawn
			{
				_injured = _this select 0;
				_injured allowDamage false;
				WaitUntil {sleep 1; (isNull _injured) || (format ["%1", _injured getVariable "BTC_need_revive"] == "0")};
				_injured allowDamage true;
			};
		};
		case (_type == 3) : 
		{
			private ["_injured","_veh"];
			_injured = (_array select 1);
			_veh     = (_array select 2);
			if (name _injured == name player) then {_injured moveInCargo _veh};
		};
		case (_type == 4) : 
		{
			private ["_array_injured"];
			_array_injured = (_array select 1);
			{
				if (name player == name _x) then {unAssignVehicle player;player action ["eject", vehicle player];};
			} foreach _array_injured;
		};
	};
};



BTC_first_aid =
{
	private ["_injured","_array_item_injured","_array_item","_cond"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_injured = _men select 1;};
	if (format ["%1",_injured getVariable "BTC_need_revive"] != "1") exitWith {};
	_array_item = items player;
	_array_item_injured = items _injured;
	_cond = false;
	if (BTC_need_first_aid == 0) then {_cond = true;};
	if ((_array_item_injured find "FirstAidKit" == -1) && (BTC_need_first_aid == 1)) then {_cond = false;} else {_cond = true;};
	if (!_cond && BTC_need_first_aid == 1) then {if ((_array_item find "FirstAidKit" == -1)) then {_cond = false;} else {_cond = true;};};
	if (!_cond) exitWith {hint "Can't revive him";};
	
	player playMove "AinvPknlMstpSnonWrflDnon_medic0";
	_damage = _injured getVariable "BTC_damage";
	_actNr = player addAction [("<t color=""#ED2744"">") + ("Cancel Revive") + "</t>", "BTC_cancelrevive = true;"];
	BTC_cancelrevive = false;
	
	while {(!BTC_cancelrevive) and (_damage >= 10) and (alive player) and (alive _injured) and ((player getVariable "BTC_need_revive") != 1) and ((_injured getVariable "BTC_need_revive") == 1) and ((player distance _injured) < 4)} do {
		
		sleep 5;
		
		if ((!BTC_cancelrevive) and (alive player) and (alive _injured) and ((player getVariable "BTC_need_revive") != 1) and ((_injured getVariable "BTC_need_revive") == 1) and ((player distance _injured) < 4)) then {
			_damage = _damage - 5;
			
			if ((_damage >= 10) and (_damage <= 70)) then {
				hintsilent format["Patching him up...\nHe's still lightly wounded!"];
				
			} else {
				if ((_damage > 70) and (_damage <= 150)) then {
					hintsilent format["Patching him up...\nHe's still moderately wounded!"];
					
				} else {
					if (_damage > 150) then {
						hintsilent format["Patching him up...\nHe's still heavily wounded!"];
					};
				};

			};
		};
	};
	
	player switchMove "AidlPknlMstpSlowWrflDnon_AI";
	sleep 1;
	player playMove "";
	_injured setVariable ["BTC_damage",_damage,true];
	player removeaction _actNr;
	
	waitUntil {!Alive player || (animationState player != "AinvPknlMstpSlayWrflDnon_medic" && animationState player != "amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon" && animationState player != "amovpknlmstpsraswrfldnon_ainvpknlmstpslaywrfldnon" && animationState player != "ainvpknlmstpslaywrfldnon_amovpknlmstpsraswrfldnon")};
	
	if ((Alive _injured) and (_damage < 10)) then {
		if (BTC_need_first_aid == 1) then {if (_array_item_injured find "FirstAidKit" == -1) then {player removeItem "FirstAidKit";};};
		_injured playMoveNow "AinjPpneMstpSnonWrflDnon_rolltoback";
		_injured setVariable ["BTC_need_revive",0,true];
		hintsilent "He's patched up!";
	};
};



BTC_drag =
{
	private ["_injured"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_injured = _men select 1;};
	if (format ["%1",_injured getVariable "BTC_need_revive"] != "1") exitWith {};
	BTC_dragging = true;
	_injured attachTo [player, [0, 1.1, 0.092]];
	player playMoveNow "AcinPknlMstpSrasWrflDnon";
	_id = player addAction [("<t color=""#ED2744"">") + ("Release") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_release], 9, true, true, "", "true"];
	_injured playMoveNow "AinjPpneMstpSnonWrflDb_grab";
	BTC_drag_pveh = [1,_injured];publicVariable "BTC_drag_pveh";
	WaitUntil {!Alive player || ((animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb"))};
	private ["_act","_veh_selected","_array","_array_veh","_name_veh","_text_action","_action_id"];
	_act = 0;_veh_selected = objNull;_array_veh = [];
	while {!isNull player && alive player && !isNull _injured && alive _injured && format ["%1", _injured getVariable "BTC_need_revive"] == "1" && BTC_dragging} do
	{
		_array = nearestObjects [player, ["Air","LandVehicle"], 5];
		_array_veh = [];
		{if (_x emptyPositions "cargo" != 0) then {_array_veh = _array_veh + [_x];};} foreach _array;
		if (count _array_veh == 0) then {_veh_selected = objNull;};
		if (count _array_veh > 0 && _veh_selected != _array_veh select 0) then 
		{
			_veh_selected    = _array_veh select 0;
			_name_veh        = getText (configFile >> "cfgVehicles" >> typeof _veh_selected >> "displayName");
			_text_action     = ("<t color=""#ED2744"">" + "Load wounded in " + (_name_veh) + "</t>");
			_action_id = player addAction [_text_action,"=BTC=_revive\=BTC=_addAction.sqf",[[_injured,_veh_selected],BTC_load_in], 7, true, true];
			_act  = 1;
		};
		if (count _array_veh == 0 && _act == 1) then {player removeAction _action_id;_act = 0;};
		sleep 0.1;
	};
	if (_act == 1) then {player removeAction _action_id;};
	player playMoveNow "AmovPknlMstpSrasWrflDnon";
	detach _injured;
	if (format ["%1",_injured getVariable "BTC_need_revive"] == "1") then {_injured playMoveNow "AinjPpneMstpSnonWrflDb_release";};
	player removeAction _id;
	BTC_dragging = false;
};



BTC_release =
{
	BTC_dragging = false;
};



BTC_load_in =
{
	_injured = _this select 0;
	_veh     = _this select 1;
	BTC_dragging = false;
	BTC_load_pveh = [3,_injured,_veh];publicVariable "BTC_load_pveh";
};



BTC_pull_out =
{
	_array = nearestObjects [player, ["Air","LandVehicle"], 5];
	_array_injured = [];
	if (count _array != 0) then
	{
		{
			if (format ["%1",_x getVariable "BTC_need_revive"] == "1") then {_array_injured = _array_injured + [_x];};
		} foreach crew (_array select 0);
	};
	BTC_pullout_pveh = [4,_array_injured];publicVariable "BTC_pullout_pveh";
};



BTC_pull_out_check =
{
	_cond = false;
	_array = nearestObjects [player, ["Air","LandVehicle"], 5];
	if (count _array != 0) then
	{
		{
			if (format ["%1",_x getVariable "BTC_need_revive"] == "1") then {_cond = true;};
		} foreach crew (_array select 0);
	};
	_cond
};



BTC_player_killed =
{
	private ["_type_backpack","_weapons","_magazines","_weapon_backpack","_ammo_backpack","_score","_score_array","_name","_body_marker"];
	titleText ["", "BLACK OUT"];
	_body = _this select 0;
	player setVariable ["BTC_need_revive",1,true];
	[_body] spawn
	{
		_body = _this select 0;
		_dir = getDir _body;
		_pos = getPosATL vehicle _body;
		if (BTC_lifes != 0 || BTC_active_lifes == 0) then
		{
			WaitUntil {Alive player};
			detach player;
			player setdamage 0.5;
			_body_marker = player;
			if (BTC_pvp == 0) then {player setcaptive true;};
			//player setvehicleInit "this allowDamage false;";ProcessInitCommands;
			BTC_killed_pveh = [2,_body_marker];
			publicVariable "BTC_killed_pveh";
			player allowDamage false;
			_downed = (player getVariable "BTC_downed") + 1;
			_damage = (_downed * 60) + (floor(random 60));
			player setVariable ["BTC_downed", _downed, false];
			player setVariable ["BTC_damage", _damage, true];
			sleep 0.5;
			player switchMove "AinjPpneMstpSnonWrflDnon";
			_actions = [] spawn BTC_assign_actions;
			if (BTC_respawn_gear == 1) then
			{
				_gear = [player,BTC_gear] spawn BTC_set_gear;
			};
			WaitUntil {animationstate player == "ainjppnemstpsnonwrfldnon"};
			sleep 2;
			player setDir _dir;
			player setVelocity [0,0,0];
			player setPosATL _pos;
			deletevehicle _body;
			_side = playerSide;
			_injured = player;
			if (BTC_injured_marker == 1) then {BTC_marker_pveh = [0,BTC_side,_pos,_body_marker];publicVariable "BTC_marker_pveh";};
			disableUserInput true;
			for [{_n = BTC_revive_time_min}, {_n != 0 && damage player > 0.2}, {_n = _n - 0.5}] do
			{
				if (BTC_active_lifes == 1) then {titleText [format ["Lifes remaining: %1",BTC_lifes], "BLACK FADED"];} else {titleText ["", "BLACK FADED"];};
				sleep 0.5;
			};
			if (BTC_black_screen == 0) then {titleText ["", "BLACK IN"];};
			disableUserInput false;
			_time = time;
			_timeout = 10;
			_chance = 100 - (_downed * 7);
			if (floor(random 100) < _chance) then {_timeout = _time + floor(random BTC_revive_time_max) + 30;} else {_timeout = 10;};
			
			private ["_id","_lifes"];
			if (BTC_disable_respawn == 1) then {player enableSimulation false;};
			if (BTC_black_screen == 0 && BTC_disable_respawn == 0) then {if (BTC_action_respawn == 0) then {_dlg = createDialog "BTC_respawn_button_dialog";} else {_id = player addAction [("<t color=""#ED2744"">") + ("Respawn") + "</t>","=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_player_respawn], 9, true, true, "", "true"];};};
			if (BTC_black_screen == 1 && BTC_disable_respawn == 0) then {_dlg = createDialog "BTC_respawn_button_dialog";};
			_stabilized = false;
			while {format ["%1", player getVariable "BTC_need_revive"] == "1" && time < _timeout} do
			{
				if (((damage player) < 0.5) and !_stabilized) then {
					_chance = 100 - (_downed * 10);
					if ((floor(random 100) < _chance) or (_downed <= 1)) then {
						_timeout = _timeout + (floor(random BTC_revive_time_max) * 3) + 240;
					} else {
						_timeout = _timeout + (floor(random BTC_revive_time_max) / 2) + 180;
					};
					_stabilized = true;
				};
				if (BTC_black_screen == 0) then {if (animationstate player != "ainjppnemstpsnonwrfldnon" && animationstate player != "AinjPpneMstpSnonWrflDb_grab" && vehicle player == player) then {player switchMove "AinjPpneMstpSnonWrflDnon";};};
				if (BTC_disable_respawn == 0) then {if (BTC_black_screen == 1 || (BTC_black_screen == 0 && BTC_action_respawn == 0)) then {if (!Dialog) then {_dlg = createDialog "BTC_respawn_button_dialog";};};};
				_healer = call BTC_check_healer;
				_lifes = "";
				if (BTC_active_lifes == 1) then {_lifes = format ["Lifes remaining: %1",BTC_lifes];};
				if (BTC_black_screen == 1) then {
					if (_stabilized) then {
						titleText [format["You are down!\nYou are stabilized!\nWait for a medic to revive you!"], "BLACK FADED"];
					} else {
						titleText [format["You are down!\nA teammate needs to stabilize you!\nWait for a medic to revive you!"], "BLACK FADED"];
					};
				} else {
					if (_stabilized) then {
						hintsilent format["You are down!\n\nYou are stabilized!\n\nWait for a medic to revive you!"];
					} else {
						hintsilent format["You are down!\n\nA teammate needs to stabilize you!\n\nWait for a medic to revive you!"];
					};
				};
				sleep 0.5;
			};
			closedialog 0;
			if (time > _timeout && format ["%1", player getVariable "BTC_need_revive"] == "1") then 
			{
				_respawn = [] spawn BTC_player_respawn;
			};
			if (format ["%1", player getVariable "BTC_need_revive"] == "0" && !BTC_respawn_cond) then 
			{
				if (BTC_black_screen == 1) then {titleText ["", "BLACK IN"];} else {hintSilent "";};
				if (BTC_need_first_aid == 1 && ((items player) find "FirstAidKit" != -1)) then {player removeItem "FirstAidKit";};
				player playMove "amovppnemstpsraswrfldnon";
				player playMove "";
			};
			if (BTC_black_screen == 0 && BTC_action_respawn == 1 && BTC_disable_respawn == 0) then {player removeAction _id;};
			if (BTC_pvp == 0) then {player setcaptive false;};
			if (BTC_disable_respawn == 1) then {player enableSimulation true;};
			//player setvehicleInit "this allowDamage true;";ProcessInitCommands;
			player allowDamage true;
			hintSilent "";
		};
	};
};



BTC_check_healer =
{
	_pos = getpos player;
	_men = [];_dist = 501;_healer = objNull;_healers = [];
	_msg = "No healer in 500 m";
	_men = nearestObjects [_pos, BTC_who_can_revive, 500];
	if (count _men > 0) then
	{
		{if (Alive _x && format ["%1",_x getVariable "BTC_need_revive"] != "1" && ([_x,player] call BTC_can_revive) && isPlayer _x && side _x == BTC_side) then {_healers = _healers + [_x];};} foreach _men;
		if (count _healers > 0) then
		{
			{
				if (_x distance _pos < _dist) then {_healer = _x;_dist = _x distance _pos;};
			} foreach _healers;
			if !(isNull _healer) then {_msg = format ["%1 could heal you! He is %2 m away!", name _healer,round(_healer distance _pos)];};
		};
	};
	_msg
};



BTC_player_respawn =
{
	BTC_respawn_cond = true;
	if (BTC_active_lifes == 1) then {BTC_lifes = BTC_lifes - 1;};
	if (BTC_active_lifes == 1 && BTC_lifes == 0) exitWith BTC_out_of_lifes;
	deTach player;
	player setVariable ["BTC_need_revive",0,true];
	if (BTC_black_screen == 0) then {titleText ["", "BLACK OUT"];};
	sleep 0.2;
	if (BTC_black_screen == 0) then {titleText ["", "BLACK FADED"];};
	if (vehicle player != player) then {unAssignVehicle player;player action ["eject", vehicle player];};
	player setPos getMarkerPos BTC_respawn_marker;
	sleep 1;
	player setDamage 0;
	player switchMove "amovpercmstpslowwrfldnon";
	player switchMove "";
	
	if (BTC_respawn_time > 0) then
	{
		player enableSimulation false;
		player setpos [0,0,6000];
		player setVelocity [0,0,0];
		sleep 1;
		private ["_n"];
		for [{_n = BTC_respawn_time}, {_n != 0}, {_n = _n - 1}] do
		{
			private ["_msg"];
			player enableSimulation false;
			player setpos [0,0,6000];
			player setVelocity [0,0,0];
			titleText [format ["Respawn in %1",_n], "BLACK FADED"];
			sleep 1;
		};
		player enableSimulation true;
		deTach player;
		player setVelocity [0,0,0];
		player switchMove "amovpercmstpslowwrfldnon";
		player setPos getMarkerPos BTC_respawn_marker;
		//deleteVehicle _obj;
	};
	
	if (BTC_respawn_gear == 1) then {
		titleText ["", "BLACK FADED"];
		_gear = [player, BTC_defaultgear] spawn BTC_set_gear;
		sleep 4;
		titleText ["", "BLACK IN"];
		sleep 2;
		titleText ["", "PLAIN"];
	} else {
		if (BTC_black_screen == 0 || BTC_respawn_time > 0) then 
		{
			titleText ["", "BLACK IN"];
			sleep 2;
			titleText ["", "PLAIN"];
		};
	};
	player setVariable ["BTC_need_revive",0,true];
	player setVariable ["BTC_downed", 0, false];
	BTC_respawn_cond = false;
	if (BTC_black_screen == 1 && BTC_respawn_time == 0) then {titleText ["", "BLACK IN"];sleep 2;titleText ["", "PLAIN"];};
};



BTC_check_action_first_aid =
{
	private ["_injured","_array_item_injured"];
	_cond = false;
	_array_item = items player;
	_men = nearestObjects [vehicle player, ["Man"], 2];
	if (count _men > 1 && format ["%1", player getVariable "BTC_need_revive"] == "0") then
	{
		if (format ["%1", (_men select 1) getVariable "BTC_need_revive"] == "1" && !BTC_dragging) then {_cond = true;};
		_injured = _men select 1;
	};
	if (_cond && BTC_pvp == 1) then 
	{
		if (side (_men select 1) == BTC_side) then {_cond = true;} else {_cond = false;};
	};
	if (_cond && BTC_need_first_aid == 1) then
	{
		
		if (_array_item find "FirstAidKit" == -1) then {_cond = false;};
		_array_item_injured = items _injured;
		if (!_cond && _array_item_injured find "FirstAidKit" != -1) then {_cond = true;};
	};
	_cond
};



BTC_check_action_drag =
{
	_cond = false;
	_men = nearestObjects [vehicle player, ["Man"], 2];
	if (count _men > 1) then
	{
		if (format ["%1", (_men select 1) getVariable "BTC_need_revive"] == "1" && !BTC_dragging) then {_cond = true;};
	};
	_cond
};



BTC_is_class_can_revive =
{
	_unit    = _this select 0;
	_cond = false;
	{if (_unit isKindOf _x) then {_cond = true};} foreach BTC_who_can_revive;
	_cond
};



BTC_can_revive =
{
	_unit    = _this select 0;
	_injured = _this select 1;
	_array_item_unit    = items _unit;
	_array_item_injured = items _injured;
	_cond = false;
	{if (_unit isKindOf _x) then {_cond = true};} foreach BTC_who_can_revive;
	if (_cond && BTC_need_first_aid == 1) then
	{
		if (_array_item_unit find "FirstAidKit" == -1) then {_cond = false;};
		if (!_cond && _array_item_injured find "FirstAidKit" != -1) then {_cond = true;};
	};
	_cond
};



//Mobile
BTC_move_to_mobile =
{
	_var = _this select 0;
	_side = "";
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";};
		case (BTC_side == east) : {_side = "BTC_mobile_east";};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";};
	};
	_mobile = objNull;
	{
		if ((typeName (_x getvariable _side)) == "STRING") then
		{
			if ((_x getvariable _side) == _var) then {_mobile = _x;};
		};
	} foreach vehicles;
	if (isNull _mobile) exitWith {};
	if (speed _mobile > 2) exitWith {hint "Mobile respawn is moving! Can't move there!";};
	_pos = getPos _mobile;
	titleText ["Get Ready", "BLACK OUT"];
	sleep 3;
	titleText ["Get Ready", "BLACK FADED"];
	sleep 2;
	titleText ["", "BLACK IN"];
	player setPos [(_pos select 0) + ((random 50) - (random 50)), (_pos select 1) + ((random 50) - (random 50)), 0];
};



BTC_mobile_marker =
{
	_var = _this select 0;
	_side = "";
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";};
		case (BTC_side == east) : {_side = "BTC_mobile_east";};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";};
	};
	while {true} do
	{
		_obj = objNull;
		while {isNull _obj} do 
		{
			{
				if (format ["%1",_x getVariable _side] == _var && Alive _x) then {_obj = _x;};
			} foreach vehicles;
			sleep 1;
		};
		deleteMarkerLocal format ["%1", _var];
		_marker = createmarkerLocal [format ["%1", _var], getPos _obj];
		format ["%1", _var] setmarkertypelocal "mil_dot";
		format ["%1", _var] setMarkerTextLocal format ["%1", _var];
		format ["%1", _var] setmarkerColorlocal "ColorGreen";
		format ["%1", _var] setMarkerSizeLocal [0.5, 0.5];
		hint format ["%1 is available!", _var];
		while {Alive _obj} do
		{
			format ["%1", _var] setMarkerPosLocal (getPos _obj);
			if (speed _obj == 0) then {format ["%1", _var] setMarkerTextLocal format ["%1 deployed", _var];format ["%1", _var] setmarkerColorlocal "ColorGreen";} else {format ["%1", _var] setMarkerTextLocal format ["%1 is moving", _var];format ["%1", _var] setmarkerColorlocal "ColorBlack";};
			sleep 1;
		};
		hint format ["%1 has been destroyed!", _var];
		format ["%1", _var] setMarkerTextLocal format ["%1 destroyed!", _var];
		format ["%1", _var] setmarkerColorlocal "ColorRed";
		if (BTC_mobile_respawn == 0) exitWith {};
	};
};



BTC_mobile_check =
{
	_var = str (_this select 0);
	_side = "";
	switch (true) do
	{
		case (BTC_side == west) : {_side = "BTC_mobile_west";};
		case (BTC_side == east) : {_side = "BTC_mobile_east";};
		case (BTC_side == guer) : {_side = "BTC_mobile_guer";};
		case (BTC_side == civ) : {_side = "BTC_mobile_civ";};
	};
	_cond = false;
	{
		if ((typeName (_x getvariable _side)) == "STRING") then
		{
			if ((_x getvariable _side) == _var) then {_cond = true;};
		};
	} foreach vehicles;
	_cond
};



BTC_vehicle_mobile_respawn =
{
	_veh  = _this select 0;
	_var  = _this select 1;
	_set  = _this select 2;
	_type = typeOf _veh;
	_pos  = getPos _veh;
	_dir  = getDir _veh;
	waitUntil {sleep 1; !Alive _veh};
	_veh setVariable [_set,0,true];
	sleep BTC_mobile_respawn_time;
	_veh  = _type createVehicle _pos;
	_veh setDir _dir;
	_veh setVelocity [0, 0, -1];
	_veh setVariable [_set,_var,true];
	_resp = [_veh,_var,_set] spawn BTC_vehicle_mobile_respawn;
	_veh setpos _pos;
};



BTC_out_of_lifes =
{
	removeAllWeapons player;
	player enableSimulation false;
	titleText ["You have no more lifes", "BLACK FADED"];//BLACK FADED
	sleep 1;
	while {true} do
	{
		player enableSimulation false;
		player setpos [0,0,6000];
		player setVelocity [0,0,0];
		titleText ["You have no more lifes", "BLACK FADED"];
		sleep 1;
	};
};



BTC_getMissingGearItems =
{
	while {true} do
	{
		sleep 1;
		
		if (alive player && format ["%1",player getVariable "BTC_need_revive"] != "1") then {
			_back_pack_items = backpackItems player;
			_prim_items = primaryWeaponItems player;
			_sec_items = secondaryWeaponItems player;
			_handgun_items = handgunItems player;
			
			BTC_GearMissingItems = [
				_back_pack_items,
				_prim_items,
				_sec_items,
				_handgun_items
			];
		};
	};
};