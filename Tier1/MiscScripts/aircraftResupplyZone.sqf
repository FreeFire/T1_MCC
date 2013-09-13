
//	This script makes it so air and ground vehicles can resupply (repair, rearm, refuel) at two triggers called "trg_farp1" and "trg_farp2".
//	Run this script on the clients.

EGG_EVO_Repair = 
{
	_veh = (vehicle player);
	_type = typeOf vehicle player;


	if (not (_veh isKindOf "Man")) then {
		
		if ((_veh in list trg_farp1) or (_veh in list trg_farp2)) then {
			if (_veh != player and speed _veh > -2 and speed _veh < 2 and position _veh select 2 < 2.0 and (local _veh)) then {
				
				_aborted = false;
				_served = false;
				
				if(getDammage _veh > 0 or fuel _veh < 0.98) then {
				
					titleText ["SERVICING...", "PLAIN",0.3];
					playSound "confirm1";
					sleep 3;
					titleText ["PERFORMING REPAIR/REFUEL...", "PLAIN",0.3];
					_served = true;
					
					for [{_i = 0}, {_i < 1}, {_i = _i}] do {
					 
						sleep 0.200;
						
						if (getDammage _veh > 0) then {
							_veh setDammage ((getDammage _veh)-0.003);
						};
						
						if (Fuel _veh < 1) then {
							_veh setFuel ((Fuel _veh)+0.006);
						};
						
						if (getDammage _veh == 0 and Fuel _veh == 1) then {
							_i = 1;
							titleText ["REPAIR/REFUEL DONE", "PLAIN",0.3];
							hintSilent "REPAIR/REFUEL DONE";
						};
						
						if (_veh != vehicle player or speed _veh < -2 or speed _veh > 2 or position _veh select 2 > 2.0) then {
							_i = 1;
							_aborted = true;
						};
						
						_dam = (getDammage _veh)*100;
						_ful = (Fuel _veh)*100;
						hintSilent format["Damage: %1\nFuel: %2",Round _dam,Round _ful];
					};
				};
				
				if ((count (weapons _veh) > 0) and !_aborted) then {
				
					if (!_served) then {
						titleText ["SERVICING...", "PLAIN",0.3];
						playSound "confirm1";
					};
					sleep 3;
					titleText ["PERFORMING REARM...", "PLAIN",0.3];
					hintSilent "PERFORMING REARM...";
					_served = true;
					
					for [{_i=1}, {_i<=21}, {_i=_i + 1}] do {
					
						sleep 1;
						
						if (_veh != vehicle player or speed _veh < -2 or speed _veh > 2 or position _veh select 2 > 2.0) then {
							_i=22;
							_aborted = true;
						};
						
						if (_i == 21) then {
							titleText ["REARM DONE", "PLAIN",0.3];
							hintSilent "REARM DONE";
							_veh setVehicleAmmo 1;
						};
					};
					
				};
				
				if (((typeof _veh) in AD_compatibleVehicles) and !_aborted) then {
				
					if (!_served) then {
						titleText ["SERVICING...", "PLAIN",0.3];
						playSound "confirm1";
					};
					
					_varcheck = (_veh getVariable "AD_hasammobox");

					if (isnil "_varcheck") then {
						_veh setVariable ["AD_hasammobox", true, false];
					};
					
					_hasammobox = _veh getVariable "AD_hasammobox";
					
					if (!_hasammobox) then {
						sleep 3;
						titleText ["LOADING AMMO CRATE...", "PLAIN",0.3];
						hintSilent "LOADING AMMO CRATE...";
						
						for [{_i=1}, {_i<=15}, {_i=_i + 1}] do {
						
							sleep 1;
							
							if (_veh != vehicle player or speed _veh < -2 or speed _veh > 2 or position _veh select 2 > 2.0) then {
								_i=16;
								_aborted = true;
							};
							
							if (_i == 15) then {
								titleText ["AMMO CRATE LOADED", "PLAIN",0.3];
								hintSilent "AMMO CRATE LOADED";
								_served = true;
								_veh setVariable ["AD_hasammobox", true, true];
							};
							
						};
					};
				};
				
				if (!_aborted) then {
					if (_served) then {
						sleep 3;
						titleText ["SERVICE COMPLETE", "PLAIN",0.3];
						hintSilent "SERVICE COMPLETE";
						playSound "confirm1";
					} else {
						titleText ["NO SERVICE REQUIRED", "PLAIN",0.3];
						hintSilent "NO SERVICE REQUIRED";
						playSound "warning1";
					};
				} else {
					titleText ["SERVICE ABORTED", "PLAIN",0.3];
					hintSilent "SERVICE ABORTED";
					playSound "warning1";
				};
				
				waitUntil{!((_veh in list trg_farp1) or (_veh in list trg_farp2))};
			};
		};
	};
};

for [{_k=0}, {_k<1}, {_k=_k}] do
{
	[] call EGG_EVO_Repair;
	sleep 3;
};