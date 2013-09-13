/*
GET COVER
- tpwcas_fnc_find_cover: AI will look for cover closeby
*/

//======================================================================================================================================================================================================

tpwcas_fnc_find_cover =
{
	private ["_unit","_status","_cover","_allcover","_objects","_shooter","_lineIntersect","_terrainIntersect","_inCover","_coverPosition","_cPos","_vPos"];

	_unit = _this select 0;
	_status = _this select 1;

	_cover = [];
	_allcover = [];
	_inCover = false;
	
	_unit setvariable ["tpwcas_cover", _status];	
	
	//potential cover objects list
	_objects = (nearestObjects [_unit, [], tpwcas_coverdist]); // - ((position _unit) nearRoads _dist);

	if ( count _objects > 0 ) then
	{
		// check if current location of unit already provides cover from shooter
		_shooter = _unit getVariable "tpwcas_shooter";
		_lineIntersect = lineIntersects [eyePos _shooter, getPosASL _unit, _shooter];

		if !(_lineIntersect) then
		{		
			// start foreach _objects
			{ 
				if ( !(_x isKindOf "Man") && !(_inCover) ) then
				{
					//_x is potential cover object
					_bbox = boundingBox _x;
					_dz = ((_bbox select 1) select 2) - ((_bbox select 0) select 2);
					
					_cPos = (position _x);
					_vPos = (vectorDir _shooter);
					
					//set coverposition to 1.3 m behind the found cover
					_coverPosition = [((_cPos select 0) + (1.3 * (_vPos select 0))), ((_cPos select 1) + (1.3 * (_vPos select 1))), (_cPos select 2)];
					
					//Any object which is high and wide enough is potential cover position, excluding water
					if ( (((getPosATL _x) select 2) < 0.2) && (_dz > 0.35) && (_dz < 12) && !(surfaceIsWater _coverPosition)) then
					{
						if ( ( _coverPosition distance _unit ) < 1 )  exitWith 
						{
							if (tpwcas_debug > 0) then 
							{	
								if (tpwcas_debug == 2) then 
								{
									diag_log format ["abort: [%1] close to cover [%2] now: distance [%3] m", _unit, _x, _coverPosition distance _unit];
								};
								_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[0, 1, 0, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Green Smoke
								[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
							};
							_inCover = true;
						};

						_cover set [count _cover, [_x, _coverPosition]];					
					};
				};
			} forEach _objects;
			// end foreach _objects
		}
		else
		{
			if (tpwcas_debug > 0) then 
				{
					if (tpwcas_debug == 2) then 
					{
						diag_log format ["abort: [%1] already in cover for shooter [%2]", _unit, _shooter];
					};
					_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[0, 1, 1, 0.5]], [0, 1], 0, 0, '', '', '']", getPosATL _unit]; //Cyan Smoke
					[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
				};
		};
	};
	
	//if cover found order unit to move into cover
	if ( ((count _cover) > 0) && !(_inCover) ) then
	{
		if (tpwcas_debug > 0) then 
		{
			_coverTarget = (_cover select 0) select 0;
			_coverPosition = (_cover select 0) select 1;
			if (tpwcas_debug == 2) then 
			{
				diag_log format ["[%1] cover: [%2] - distance [%3] - box: [%4] - pos: [%5]", _unit, _coverTarget, _coverPosition distance _unit, boundingBox _coverTarget, getPosATL _coverTarget]; 
			};
			_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[1, 1, 0, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Yellow Smoke
			[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
		};
		
		[_unit, _cover select 0, _shooter] spawn tpwcas_fnc_move_to_cover;
	};
};

//======================================================================================================================================================================================================

tpwcas_fnc_move_to_cover =
{
	private ["_unit","_cover","_coverArray","_coverPosition","_coverDist","_coverTarget","_cPos","_vPos","_debug_flag","_dist","_shooter","_continue","_logOnce","_startTime","_checkTime","_stopped","_tooFar","_tooLong","_elapsedTime"];
	
	_unit 			=	_this select 0;
	_coverArray 	=	_this select 1;
	_shooter 		=	_this select 2;
	
	_cover 			=	_coverArray select 0;
	_coverPosition 	= 	_coverArray select 1;


	dostop _unit;
	_unit forceSpeed -1;
	_unit doMove _coverPosition;

	_coverDist = round ( _unit distance _coverPosition );

	_stopped = false;
	_continue = true;
	_logOnce = true;
	
	_startTime = time;
	_checkTime =  (_startTime + (1.7 * _coverDist) + 7);
	
	while { _continue } do 
	{
		if ( _logOnce && (tpwcas_debug > 0) ) then 
		{
			//_debug_flag = "FlagCarrierWhite_EP1" createVehicle _coverPosition; //ARMA
			_debug_flag = "FlagChecked_F" createVehicle _coverPosition;
			_debug_flag setPos _coverPosition;

			if (tpwcas_debug == 2) then 
			{
				diag_log format ["Unit [%1] moving to cover [%2]: distance [%3] m", _unit, _cover, _coverDist];
			};
			_logOnce = false;
		};
		
		_dist = round ( _unit distance _coverPosition );
						
		if ( !( unitReady _unit ) && ( alive _unit ) && ( _dist > 1.25 ) ) then
		{
			//if unit takes too long to reach cover or moves too far out stop at current location
			_tooFar = ( _dist > ( _coverDist + 10 ));
			_tooLong = ( time >  _checkTime );
			_elapsedTime = time - _checkTime;
			
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
						diag_log format ["Unit [%1] moving wrong way to cover [%2]: [%3] m - drop here - tooFar: [%4] - tooLong: [%5] - ([%6] seconds)", _unit, _cover, _dist, _tooFar, _tooLong, _elapsedTime];
					};
					_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[1, 0, 0, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Red Smoke
					[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
					
					deleteVehicle _debug_flag;
				};
			};
			sleep 0.5;
		}
		else
		{	
			_continue = false;
		};
	}; 

	if ( !( _stopped) ) then 
	{
		if (tpwcas_debug > 0) then 
		{
			if (tpwcas_debug == 2) then
			{
				diag_log format["[%1] reached cover [%2]",_unit, _cover];
			};
			_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[0, 0, 1, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Blue Smoke
			[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
			
			deleteVehicle _debug_flag;
		};
				
		doStop _unit;
		_unit setunitpos "down"; 
		sleep (3 + random 5);
			
		//doMove:
		//Order the given unit(s) to move to the given position (without radio messages). 
		//After reaching his destination, the unit will immediately return to formation (if in a group); or order his group to form around his new position (if a group leader). 
		_coverPosition = getPosATL _unit;
		_unit forceSpeed -1;
		_unit doMove _coverPosition;

		if (tpwcas_debug > 0) then 
		{
			_smokeString = format ["drop['\ca\data\cl_basic', '', 'Billboard', 1, 20, %1, [0, 0, 0], 0, 1.274, 0.5, 0, [5],[[0, 1, 0, 0.5]], [0, 1], 0, 0, '', '', '']", _coverPosition]; //Green Smoke
			[-2, {call compile _this}, _smokeString] call CBA_fnc_globalExecute;
		};
	}
	else
	{
		if (tpwcas_debug == 2) then {
			diag_log format["[%1] DID NOT reach selected cover [%2]",_unit, _cover];
		};
	};
};

