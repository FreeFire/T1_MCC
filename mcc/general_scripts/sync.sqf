private ["_type","_d","_RainLevel","_waves","_lightning","_cloudLevel","_weather","_footer","_x", "_html", "_loop","_wind","_fog","_fogArray","_target"];

if (!isServer) exitwith {};

_target = _this select 0;

//diag_log format ["Player %1 connected - triggering sync.sqf on system %1", _target];      
//[[format ["triggering sync.sqf on system %1", _target]], "MCC_fnc_log",_target,false] call BIS_fnc_MP;   

[[[date select 0, date select 1, date select 2, (date select 3)-1, date select 4]],"MCC_fnc_setTime",_target,false] spawn BIS_fnc_MP; 

_fog = [];

if ( mcc_fog_index > 0 ) then // fog has been set by MCC
{
	_fogArray = [];
	_fogArray = MCC_fog_array select mcc_fog_index;
	_fog = [_fogArray select 0, 0.08, _fogArray select 1];
}
else
{
	_fog = [fog, 0.08, 25];
};		

[[[overcast, windStr, waves, rain, lightnings,_fog]],"MCC_fnc_setWeather",_target,false] spawn BIS_fnc_MP;
[['MCC_sync', MCC_sync],"MCC_fnc_setVar",_target,false] spawn BIS_fnc_MP;
[['mcc_sync_status', 1],"MCC_fnc_setVar",_target,false] spawn BIS_fnc_MP;

