

AD_running = true;

_veh = vehicle player;
_varcheck = (_veh getVariable "AD_hasammobox");

if (isnil "_varcheck") then {
	_veh setVariable ["AD_hasammobox", true, false];
};



_abort = false;
_pilotAlive = true;



if (_veh getVariable "AD_hasammobox") then {
	
	hintSilent "Wait while the ammo crate is being unloaded.";
	playsound "confirm1";
	
	for [{_y = 1}, {(_y <= 30 + floor(random 30))}, {_y = _y + 1}] do {
	
		if (((speed _veh < -2) or (speed _veh > 2) or ((position _veh) select 2 > 2)) or (!alive _veh)) exitwith {_abort = true};
		
		if (!alive player) then {_pilotAlive = false;};
		
		sleep 1;
	
	};
	
	if (!_abort) then {
		
		_veh setVariable ["AD_hasammobox", false, true];
	
		_cratepos = [(getpos _veh), 10 , 20 , 1 , 0 , 1 , 0, [], [getpos _veh, getpos _veh]] call BIS_fnc_findSafePos;
		
		AD_createCrate = _cratepos;
		
		if (!isserver) then {
			publicVariableServer "AD_createCrate";
		} else {
			[_cratepos] spawn {
				[0, _this select 0] execVM "Tier1\AmmoDrop\AD_createAmmoCrate.sqf";
			};
		};
		
		sleep 6;
		
		if (_pilotAlive) then {
			hintSilent "The ammo crate has been unloaded!";
			playsound "confirm1";
		};
	
	} else {
		
		if (_pilotAlive) then {
			sleep 2;
			hintSilent "You moved away before the ammo crate could be unloaded!";
			playsound "warning1";
		};
	};
	
} else {
	
	hintSilent format["No ammo crate inside this vehicle!\n\nYou can pick one up at the service point!"];
	playsound "warning1";
	
};



AD_running = false;


