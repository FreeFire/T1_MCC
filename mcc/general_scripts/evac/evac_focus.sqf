#define MCC_MINIMAP 9000
#define MCC_SANDBOX2_IDD 2000
#define MCC_EVAC_SELECTED 2022
#define MCC_EVAC_INSERTION 2023
#define MCC_EVAC_FLIGHTHIGHT 2024

disableSerialization;
private ["_mccdialog","_type","_pos","_control","_markerType","_index","_comboBox","_insetionArray"];
_mccdialog = findDisplay MCC_SANDBOX2_IDD;	
_index = lbCurSel MCC_EVAC_SELECTED;
if (MCC_evacVehicles_index !=_index && (count MCC_evacVehicles > 0)) then {
	MCC_evacVehicles_index = _index;
	deletemarkerlocal "currentEvacSelected";
	_type = MCC_evacVehicles select (lbCurSel MCC_EVAC_SELECTED);
	_pos = [(getpos _type) select 0, (getpos _type) select 1];
	
	_insetionArray = ["Move (engine on)","Move (engine off)"];
	ctrlShow [MCC_EVAC_FLIGHTHIGHT,false];
	_markerType = "b_inf";
	if (_type iskindof "Car") then {_markerType = "b_mech_inf";};
	if (_type iskindof "Tank") then {_markerType = "b_armor";};
	if (_type iskindof "helicopter") then {									//Case we choose aircrft
		_markerType = "b_air";
		_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)"];
		ctrlShow [MCC_EVAC_FLIGHTHIGHT,true];
		};

	createMarkerLocal ["currentEvacSelected",_pos];	//Create group's marker
	"currentEvacSelected" setMarkerTypeLocal _markerType;
	"currentEvacSelected" setMarkerColorLocal "ColorBlue";
	
	_control = _mccdialog displayCtrl MCC_MINIMAP;
	_control ctrlMapAnimAdd [1, 0.3, _pos];
	ctrlMapAnimCommit _control;
	
	_comboBox = _mccdialog displayCtrl MCC_EVAC_INSERTION;					//Adjust insertion type by evac type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach _insetionArray;
	_comboBox lbSetCurSel 0;
	};