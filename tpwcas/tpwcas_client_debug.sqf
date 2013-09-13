/*
CLIENT DEBUG BALL HANDLER
Called by CBA Remote Event Handler
- Displays appropriate coloured debug ball depending on unit's suppression state
*/

tpwcas_fnc_client_debug = 
{
	private ["_unit", "_ball", "_color"];

	_unit = _this select 0;
	_ball = _this select 1;
	_color = _this select 2;

	_msg = format["'suppressDebug' event for unit [%1] - value [%2] - ball [%3]", _unit, _color, _ball];
	[ _msg, 9 ] call bdetect_fnc_debug;
	
	switch ( _color ) do
	{
		case 0: 
		{
			_ball setObjectTexture [0,"#(argb,8,8,3)color(0.99,0.99,0.99,0.7,ca)"];  // white
		};
		case 1: 
		{
			_ball setObjectTexture [0,"#(argb,8,8,3)color(0.0,0.0,0.0,0.9,ca)"];  // black
		};
		case 2:
		{
			_ball setObjectTexture [0,"#(argb,8,8,3)color(0.1,0.9,0.1,0.7,ca)"];  // green
		};
		case 3: 
		{
			_ball setObjectTexture [0,"#(argb,8,8,3)color(0.9,0.9,0.1,0.7,ca)"]; //yellow
		};
		case 4:
		{
			_ball setObjectTexture [0,"#(argb,8,8,3)color(0.9,0.1,0.1,0.7,ca)"]; //red  
		};
		case 5: //tpw los debug
		{
			_ball setObjectTexture [0,"#(argb,8,8,3)color(0.2,0.2,0.9,0.5,ca)"]; // blue
		};
	};
};
