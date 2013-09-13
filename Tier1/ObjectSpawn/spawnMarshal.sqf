


_veh = "B_APC_Wheeled_01_cannon_F" createVehicle (getPos spawnV1);
_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 0.5];
_veh setDir (getDir spawnV1);
playSound "confirm1";