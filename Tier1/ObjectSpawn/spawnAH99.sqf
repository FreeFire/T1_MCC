


_pos = [(getPos spawnA2), 0, 30, 13, 0, 1000, 0, [], [(getPos spawnA2),(getPos spawnA2)]] call BIS_fnc_findSafePos;
_veh = "B_Heli_Attack_01_F" createVehicle _pos;
_veh setDir (getDir spawnA2);
playSound "confirm1";