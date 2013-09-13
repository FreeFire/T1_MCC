private["_heli", "_route", "_endpos", "_height", "_landing ", "_pilot", "_i", "_j", "_pos", "_dist", "_distold", "_angh", "_dir",
		"_accel", "_speed", "_steps", "_inipos", "_offset","_nearSmokes","_wp","_distance"];

_route         = _this select 0;
_height        = _this select 1;
_landing       = _this select 2;
_heli          = _this select 3;

if (!local _heli) exitWith {hint "vehicle must be local";};
if (_height == 5000) then {								//We got a vehicle
		for [{_j = 0},{_j < count _route},{_j = _j + 1}] do
		{ 
		_pos = _route select _j;
		_wp = (group _heli) addWaypoint [_pos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "CARELESS";
		};
	if (_landing == 1) then {_wp setWaypointStatements ["true", " driver (vehicle this) action ['ENGINEOFF', (vehicle this)];"]};
	} else	{
	// First of all chopper gets its indicated flying height for the route
	_pilot = driver _heli;
	_heli setfuel 1; 
	_heli flyinHeight _height;
	_heli setVariable ["wp_complete", false];
	for [{_j = 0},{_j < count _route},{_j = _j + 1}] do
		{ 
		_pos = _route select _j;
		_wp = (group _heli) addWaypoint [_pos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "CARELESS";
		};
	_wp setWaypointStatements ["true", " (vehicle this) setVariable ['wp_complete', true];"];
	while {!(_heli getVariable "wp_complete")} do {sleep 1};
	switch (_landing) do		//Which insertion do we want
		{
		case 0:			//Free Landing engine on
			{
				_heli land "GET IN";
			};
		case 1:			//Free Landing engine off
			{
				_heli land "LAND";
			};
		case 2:			//Hover
			{
				_heli flyinHeight _height;
			};
		case 3:			//Helocasting
			{
				//while {(_heli distance _pos)>55} do {_pilot doMove _pos; sleep 5;};
				_heli flyinHeight 4;
				waituntil {((getposatl _heli) select 2) < 6};
				_heli globalChat "Golf 1 in position, clear for helocasting";
				_pilot action ["autoHover", _heli];	
			};
		case 4:			//Smoke signal
			{
				_heli globalChat "Waiting for smoke signal to land";
				_nearSmokes = []; 
				while {(count _nearSmokes < 1)} do {
					_nearSmokes = (getPos _heli) nearObjects ["SmokeShell", 300];
					sleep 1;
					if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
				};
				_endpos = getpos(_nearSmokes select 0);
				_distance = [_heli, _endpos] call BIS_fnc_distance2D;
				hint format ["%1",_distance];
				while {_distance>20} then {_pilot doMove _endpos; sleep 5;_distance = [_heli, _endpos] call BIS_fnc_distance2D;};
				_heli flyinHeight 2;
				_pilot action ["autoHover", _heli];
			};
	
		};
	};