


_veh = "B_APC_Tracked_01_rcws_F" createVehicle (getPos spawnV1);
_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 0.5];
_veh setDir (getDir spawnV1);
playSound "confirm1";