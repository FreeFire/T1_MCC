


_pos = [(getPos spawnA1), 0, 30, 13, 0, 1000, 0, [], [(getPos spawnA1),(getPos spawnA1)]] call BIS_fnc_findSafePos;
_veh = "B_Heli_Light_01_F" createVehicle _pos;
_veh setDir (getDir spawnA1);
playSound "confirm1";