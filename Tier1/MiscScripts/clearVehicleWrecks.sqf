


//	This script removes destroyed, immobile, and out of fuel vehicles with no crew, in a 250 meter radius around the "m_clrvehwrks" marker.
//	Run this script on the server.



[] spawn {
	
	_vehs = [];
	
	while {true} do {
		
		_vehs = nearestObjects [(getmarkerpos "m_clrvehwrks"), ["LandVehicle","Air"], 250];
		
		if (count _vehs > 0) then {
			{
				if ((!alive _x) or (!canMove _x) or ((fuel _x <= 0) and ((count crew _x) < 1))) then {
					deletevehicle _x;
				};
			} foreach _vehs;
		};
		
		sleep 63;
	};
};