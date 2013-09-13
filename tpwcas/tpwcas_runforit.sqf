
// tpwcas_fnc_run_for_it: civilians will run in random directions due to shooting

//======================================================================================================================================================================================================

tpwcas_fnc_run_for_it =
{
	private ["_unit","_cover","_factorX","_factorY","_coverPosition","_coverDist","_coverTarget","_cPos","_vPos","_debug_flag","_dist","_shooter","_continue","_logOnce","_startTime","_checkTime","_stopped","_tooFar","_tooLong","_elapsedTime"];
	
	_unit 	=	_this select 0;
	
	_shooter = _unit getVariable "tpwcas_shooter";
	
	_unit setVariable ["tpwcas_cover", 1];	
	
	_cPos = (position _unit);
	
	_cover = random 3;
	if ( _cover > 1.5 ) then 
	{
		_factorY = 90;
	}
	else
	{
		_factorY = -90;
	};
	
	_vPos = [vectorDir _shooter, _factorY] call BIS_fnc_rotateVector2D;
	
	_factorX = random 225;
	
	//set move position to 125 to 350 m away from the shooting
	_coverPosition = [((_cPos select 0) + ((125 + _factorX) * (_vPos select 0))), ((_cPos select 1) + ((125 + _factorX) * (_vPos select 1)))];
	
	//Visual Debug
	if (tpwcas_debug > 0) then 
	{		
		//_debug_flag = "FlagCarrierWhite_EP1" createVehicle _coverPosition; //ARMA
		_debug_flag = "FlagChecked_F" createVehicle _coverPosition;
		_debug_flag setPos _coverPosition;
	};
		
	dostop _unit;
	sleep 0.1;
	_unit forceSpeed -1;
	_unit setSkill ["courage", 0.1];
	_unit moveTo _coverPosition;
	
	//_unit doMove _coverPosition;

	_coverDist = round ( _unit distance _coverPosition );

	_stopped = false;
	_continue = true;
	_logOnce = true;
	
	_startTime = time;
	_checkTime = (_startTime + (0.3 * _coverDist) + 10);
	
	while { _continue } do 
	{
		if ( _logOnce && (tpwcas_debug == 2) ) then 
		{
			diag_log format ["Civilian Unit [%1] fleeing to location [%2] - [%3] m", _unit, _coverPosition, _coverDist];
			_logOnce = false;
		};
		
		_dist = round ( _unit distance _coverPosition );
		
		if ( !( unitReady _unit ) && ( _dist > 3 ) && ( alive _unit )) then
		{
			//if unit takes too long to reach cover or moves too far out stop at current location
			_tooFar = ( _dist > ( _coverDist + 20 ));
			_tooLong = ( time > _checkTime );
			_elapsedTime = ( time - _startTime );
			
			if ( _tooFar || _tooLong ) exitWith
			{
				_coverPosition = getPosATL _unit;
				_unit forceSpeed -1;
				_unit doMove _coverPosition;

				_stopped = true;
				_continue = false;
				
				if (tpwcas_debug > 0) then 
				{
					if (tpwcas_debug == 2) then 
					{
						diag_log format ["Civilian Unit [%1] moving wrong way to cover [%2]: [%3] m - drop here - tooFar: [%4] - tooLong: [%5] - ([%6] seconds)", _unit, _cover, _dist, _tooFar, _tooLong, _elapsedTime];
					};
					//drop["\ca\data\cl_basic", "", "Billboard", 1, 20, _coverPosition, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[1, 0, 0, 0.5]], [0, 1], 0, 0, "", "", ""]; //Red Smoke
					_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[1, 0, 0, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Red Smoke
					[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
					
					sleep 1;
					deleteVehicle _debug_flag;
				};
			};
			sleep 1;
		}
		else
		{	
			if (tpwcas_debug > 0) then 
			{
				if (tpwcas_debug == 2) then 
				{
					diag_log format ["Civilian Unit [%1] reached cover [%2]: [%3] m - [%6] seconds", _unit, _cover, _dist, _tooFar, _tooLong, _elapsedTime];
				};
				//drop["\ca\data\cl_basic", "", "Billboard", 1, 20, _coverPosition, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[1, 0, 0, 0.5]], [0, 1], 0, 0, "", "", ""]; //Red Smoke
				_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[0, 0, 1, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Blue Smoke
				[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
				
				sleep 1;
				deleteVehicle _debug_flag;
			};
			_continue = false;
		};
	};
	
	_unit setunitpos "down"; 
	
	doStop _unit;
	sleep (random 25);
	
	_unit setunitpos "auto"; 
	
	//doMove:
	//Order the given unit(s) to move to the given position (without radio messages). 
	//After reaching his destination, the unit will immediately return to formation (if in a group),
	//or order his group to form around his new position (if a group leader). 
	_coverPosition = getPosATL _unit;
	_unit forceSpeed -1;
	_unit doMove _coverPosition;
	
	if (tpwcas_debug > 0) then 
	{
		if (tpwcas_debug == 2) then 
		{
			diag_log format ["Civilian Unit [%1] reached cover [%2]: [%3] m - [%6] seconds", _unit, _cover, _dist, _tooFar, _tooLong, _elapsedTime];
		};
		//drop["\ca\data\cl_basic", "", "Billboard", 1, 20, _coverPosition, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[1, 0, 0, 0.5]], [0, 1], 0, 0, "", "", ""]; //Red Smoke
		_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[0, 1, 0, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Green Smoke
		[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
	};
	
	//reset run to cover value
	_unit setvariable ["tpwcas_cover", 0];
};
