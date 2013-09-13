_veh = "B_MBT_01_mlrs_F" createVehicle (getPos spawnV2);
_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 0.5];
_veh setDir (getDir spawnV2);
playSound "confirm1";