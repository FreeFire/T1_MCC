// Written by Kochleffel
// Adapted by Code34
// Adapted by EightySix
// Adapted by WhiteRaven

// if (!local player) exitWith {};

private ["_crew","_text","_vehicle","_role","_name","_ctrl"];
disableSerialization;
uiNamespace setVariable ['crewdisplay', objnull];

while{true} do{
	if(isnull (uiNamespace getVariable "crewdisplay")) then { 2 cutrsc ["infomessage", "PLAIN"];};
	_text = "";
	if(vehicle player != player) then {
		if(!visibleMap) then {
			_crew = crew (vehicle player);
			_vehicle = vehicle player;
			_name= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "DisplayName");
			_text= format ["<t size='1.35' shadow='2' color='#77c753'>%1</t><br/>", _name];
			{
				if(!(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit")) then {
					_role = assignedVehicleRole _x;
					switch(_x)do {
						case commander _vehicle: { _text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='Tier1\VehicleHud\media\icon_commander.paa'></t><br/>", name _x]; };
						case gunner _vehicle: { _text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='Tier1\VehicleHud\media\icon_gunner.paa'></t><br/>", name _x]; };
						case driver _vehicle: { _text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='Tier1\VehicleHud\media\icon_driver.paa'></t><br/>", name _x]; };
						default	{
							if(format["%1", (_role select 0)] != "Turret") then {
								_text=_text+format ["<t size='1.35' shadow='1' color='#567656'>%1</t> <t size='1.5'><img image='Tier1\VehicleHud\media\icon_cargo.paa'></t><br/>", name _x];
							} else {
								_text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='Tier1\VehicleHud\media\icon_gunner.paa'></t><br/>", name _x];
							};
						};
					};
				};
			} forEach _crew;
		}else{
			_text = "";
		};
	};
	_ctrl = (uiNamespace getVariable 'crewdisplay') displayCtrl 102;
	_ctrl ctrlSetStructuredText parseText _text;
	sleep 1;
};
	_text = "";
	_ctrl = (uiNamespace getVariable 'crewdisplay') displayCtrl 102;
	_ctrl ctrlSetStructuredText parseText _text;
