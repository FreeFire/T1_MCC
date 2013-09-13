


_unit = _this select 0;

UAVavailable=true;
UAVmode = false;
createMarker ["UAV", position _unit];
currentAO = "UAV";

_unit addAction [ "Select UAV Target", "Tier1\UAV\freeUAV.sqf", "", 0, false, true, "", "uav_available_in_mission == 1"];
_unit addAction [ "Activate UAV", "Tier1\UAV\uavView.sqf", [currentAO], 0, false, true, "", "uav_available_in_mission == 1"];

_unit addEventHandler ["respawn", "
	_unit = _this select 0;
	_unit addAction [ 'Select UAV Target', 'Tier1\UAV\freeUAV.sqf', '', 0, false, true, '', 'uav_available_in_mission == 1'];
	_unit addAction [ 'Activate UAV', 'Tier1\UAV\uavView.sqf', [currentAO], 0, false, true, '', 'uav_available_in_mission == 1'];
"];