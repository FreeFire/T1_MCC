


_pos = [(getPos spawnA1), 0, 30, 13, 0, 1000, 0, [], [(getPos spawnA1),(getPos spawnA1)]] call BIS_fnc_findSafePos;
_veh = "I_Plane_Fighter_03_AA_F" createVehicle _pos;
_veh setDir (getDir spawnA1);
playSound "confirm1";