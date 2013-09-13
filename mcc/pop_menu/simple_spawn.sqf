private ["_pos", "_dir","_class","_type","_faction","_unitspawned","_dummy","_notEmpty","_init","_name","_dummyGroup","_loc"];
_pos 	 = _this select 0;
_dir 	 = _this select 1;
_class	 = _this select 2;
_type	 = _this select 3;
_faction = _this select 4;
_notEmpty	 = _this select 5;
_init	 = _this select 6;
_name	 = _this select 7;
_loc	 = _this select 8;

if ( ( (isServer) && ( (_loc == 0) || !(MCC_isHC) ) ) || ( (MCC_isLocalHC) && (_loc == 1) ) ) then 
{
	diag_log format ["%1 - spawning 3D Editor object [%2]", time, _class];
	
	switch (_type) do		//Which type do we want
			{
				case "MAN":	
				{
					if (_faction=="GUE") then {_unitspawned = createGroup resistance;};
					if (_faction=="WEST") then {_unitspawned = createGroup west;};							
					if (_faction=="EAST") then {_unitspawned = createGroup east;};
					if (_faction=="CIV") then {_unitspawned = createGroup civilian;};
					_dummy = _unitspawned createUnit [_class, _pos, [], 0, "NONE"];
					_dummy setpos _pos;
					_dummy setdir _dir;
					sleep 0.01;
					if (!MCC_align3D) then {_dummy setpos _pos};
					_unitspawned setformdir _dir; 
					[[netid _dummy, _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
					if (_name != "") then {
						[[netid _dummy, _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
						};
				};
				
				case "VEHICLE":	
				{
					if (_notEmpty) then
						{
							if (_faction=="GUE") then  {_dummy 		=	[_pos, _dir, _class, resistance] call BIS_fnc_spawnVehicle;};										
							if (_faction=="WEST") then { _dummy 	=	[_pos, _dir, _class, WEST] call BIS_fnc_spawnVehicle;};
							if (_faction=="EAST") then { _dummy 	=	[_pos, _dir, _class, EAST] call BIS_fnc_spawnVehicle;};										
							if (_faction=="CIV") then { _dummy	 	=	[_pos, _dir, _class, civilian] call BIS_fnc_spawnVehicle;};
							[[netid (_dummy select 0), _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
							if (_name != "") then {
								[[netid (_dummy select 0), _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
								};
						} else
						{
							_dummy = _class createvehicle _pos;
							_dummy setpos _pos;
							_dummy setdir _dir;
							sleep 0.01;
							if (!MCC_align3D) then {_dummy setpos _pos};
							[[netid _dummy, _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
							if (_name != "") then {
								[[netid _dummy, _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
								};
						};
				};
				
				case "AMMO":	
				{
					_dummy = _class createvehicle _pos;
					_dummy setpos _pos;
					_dummy setdir _dir;
					sleep 0.01;
					if (!MCC_align3D) then {_dummy setpos _pos};
					[[netid _dummy, _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
					if (_name != "") then {
						[[netid _dummy, _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
						};
				};
				
				case "MINES":	
				{
					_dummy = createMine [_class, _pos, [], 0];
					_dummy setpos _pos;
					_init = format ["%1;_this setdir %2;",_init,_dir];
					sleep 0.01;
					[[netid _dummy, _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
					if (_name != "") then {
						[[netid _dummy, _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
						}; 
				};
			};
	MCC_lastSpawn = MCC_lastSpawn + [_dummy]; 
};

MCC_mccFunctionDone = true;
publicvariable "MCC_mccFunctionDone";
