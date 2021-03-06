//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_posX","_posY","_posNew","_posCurrent"];
disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_posX = _params select 1;
_posY = _params select 2; 

if (MCC_ConsoleUAVMouseButtonDown) then {
	_posNew = [((MCC_uavPos select 0) - _posX)*(MCC_fakeUAVFOV*500), ((MCC_uavPos select 1) - _posY)*(MCC_fakeUAVFOV*500),0];
	setMousePosition [0.5,0.44];
	_posCurrent = getpos MCC_fakeUAVCenter;
	MCC_fakeUAVCenter setpos (MCC_fakeUAVCenter modeltoWorld [(_posNew select 0)*-1,(_posNew select 1),0]);
	};