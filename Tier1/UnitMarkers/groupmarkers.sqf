
//	This script is run by setGroupMarkers.sqf.

// DECLARE PRIVATE VARIABLES

private ["_grp","_mkrType","_mkrText","_mkrColor","_mkrName","_mkr", "_grpName"];

// ====================================================================================

// WAIT FOR VARIABLE AND GROUP MEMBERS
// Before we continue with the script, we wait until the group variable has been initialized and there are alive units inside the group.

_grpName = _this select 0;
_runloop = true;

call compile format ["
	
	while {_runloop} do {
		sleep 3;
		if (!isNil ""%1"") then {
			if ({alive _x} count units %1 > 0) then {
				_runloop = false;
			};
		};
	};
	
	_grp = %1;
	
",_grpName];

// ====================================================================================

// SET KEY VARIABLES
// Using variables passed to the script instance, we will create some local variables:

_mkrType = _this select 1;
_mkrText = _this select 2;
_mkrColor = _this select 3;
_mkrName = format ["mkr_%1",_grp];

// ====================================================================================

// CREATE MARKER
// Depending on the value of _mkrType a different type of marker is created.

switch (_mkrType) do
{
	
	// Platoon HQ
	case 0:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_HQ";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Squad Leader
	case 1:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_HQ";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Fireteam
	case 2:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_INF";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Medium MG
	case 3:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_INF";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Medium AT
	case 4:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_EMPTY";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Heavy AT
	case 5:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_EMPTY";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Sniper Team
	case 6:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_RECON";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Heavy MG
	case 7:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_EMPTY";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	// Armor			
	case 8:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_ARMOR";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};


	// Air
	case 9:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_AIR";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
	case 10:
	{
		_mkr = createMarkerLocal [_mkrName,[(getPos leader _grp select 0),(getPos leader _grp select 1)]];
		_mkr setMarkerShapeLocal "ICON";
		_mkrName setMarkerTypeLocal "B_HQ";
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerSizeLocal [0.8, 0.8];
		_mkrName setMarkerTextLocal _mkrText;
	};
	
};

// ====================================================================================

// UPDATE MARKER POSITION
// As long as certain conditions are met, the marker position is updated periodically.
// This only happens locally - so as not to burden the server.

call compile format ["
	
	while {true} do {
		
		sleep 6;
		
		_showmarker = false;
		
		if (!isNil ""%1"") then {
			if ({alive _x} count units %1 > 0) then {
				if (alive leader %1) then {
					_showmarker = true;
				};
			};
		};
		
		if (_showmarker) then {
			_mkrName setMarkerPosLocal [(getPos leader %1 select 0),(getPos leader %1 select 1)];
			_mkr setMarkerAlphaLocal 1;
		} else {
			_mkr setMarkerAlphaLocal 0;
		};
	};
	
",_grpName];

// ====================================================================================
