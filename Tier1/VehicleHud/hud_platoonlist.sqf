// Written by Kochleffel
// Adapted by Code34
// Adapted by EightySix
// Adapted by WhiteRaven

// if (!local player) exitWith {};

private ["_text","_role","_name","_ctrl","_westgroups","_showthis"];
disableSerialization;
uiNamespace setVariable ['platoondisplay', objnull];
/* showthis = 1;
_platHudAction = player addaction ["Show/Hide Platoon List", "if(showthis==1)then{showthis=0;}else{showthis=1;};", [], 9, false];
player addEventHandler ["respawn", "player addaction ['Show/Hide Platoon List', 'if(showthis==1)then{showthis=0;}else{showthis=1;};', [], 9, false];"]; */

while { true } do {
	if(isnull (uiNamespace getVariable "platoondisplay")) then { 1 cutrsc ["infomessage2", "PLAIN", 0];};
	_text = "";
	_westgroups = [];
	{ if (count units _x > 0 and side _x == west) then { _westgroups = _westgroups + [_x] } } forEach allGroups;

	// if (showthis == 1) then
	// {
			{
				_name = groupid _x;
				if (_name == "Platoon Lead") then { _text = _text + format ["<t size='1.4' shadow='2' color='#ff8800'>%1</t><br/>", _name]; };
				if ((_name == "Alpha Lead") || (_name == "Alpha 1") || (_name == "Alpha 2") || (_name == "Alpha 3")) then { _text = _text + format ["<t size='1.4' shadow='2' color='#ff2222'>%1</t><br/>", _name]; };
				if ((_name == "Bravo Lead") || (_name == "Bravo 1") || (_name == "Bravo 2") || (_name == "Bravo 3")) then { _text = _text + format ["<t size='1.4' shadow='2' color='#2255ff'>%1</t><br/>", _name]; };
				if ((_name == "Charlie Lead") || (_name == "Charlie 1") || (_name == "Charlie 2") || (_name == "Charlie 3")) then { _text = _text + format ["<t size='1.4' shadow='2' color='#cccc00'>%1</t><br/>", _name]; };
				if (_name == "Shadow 1") then { _text = _text + format ["<t size='1.4' shadow='2' color='#666666'>%1</t><br/>", _name]; };
				if (_name == "Reaper 1") then { _text = _text + format ["<t size='1.4' shadow='2' color='#00ff00'>%1</t><br/>", _name]; };
				
				if(!(format["%1", groupid _x] == "")) then 
				{
					{
						if (name _x == name player) then
						{
							_text = _text + format [" = <t size='1.2' shadow='2' color='#ffffff'>%1</t> = <br/>", name _x];
						} else
						{
							_text = _text + format ["<t size='1.1' shadow='2' color='#aae793'>%1</t><br/>", name _x];
						};
					} foreach units _x;
				};
			} forEach _westgroups;
	// };
	
	_ctrl = (uiNamespace getVariable 'platoondisplay') displayCtrl 104;
	_ctrl ctrlSetStructuredText parseText _text;
	sleep 30;
/*	for "_i" from 0 to 30 do
	{
		if (showthis == 0) then
		{
			_text = "";
			_ctrl = (uiNamespace getVariable 'platoondisplay') displayCtrl 104;
			_ctrl ctrlSetStructuredText parseText _text;
		} else
		{
		
		};
	sleep 1;
	}; */
};
	_text = "";
	_ctrl = (uiNamespace getVariable 'platoondisplay') displayCtrl 104;
	_ctrl ctrlSetStructuredText parseText _text;
