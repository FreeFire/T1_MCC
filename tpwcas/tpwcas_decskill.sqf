/*
DECREASE UNIT SKILLS
- called from main loop
- aiming shake, aiming accuracy and courage decreased by 2.5% per enemy bullet, or 5% if there are nearby casualties
- these skills won't fall below the value set in twpcas_minskill
*/

tpwcas_fnc_decskill =
{
	private [ "_x","_unit","_originalaccuracy","_originalshake","_originalcourage","_shots","_newaccuracy","_newshake","_newcourage","_nearunits","_cas","_dec"];
	
	_unit = _this select 0;
	
	//ANY FRIENDLY CASUALTIES WITHIN 50m OF UNIT
	_nearunits = nearestobjects [_unit,["Man"],50];
	_cas = 0;
	{
		//if ((side _x == side _unit) && (lifestate _x != "ALIVE")) then //ARMA3
		if ( (side _x == side _unit) && !(lifestate _x == "HEALTHY") ) then
		{
			_cas = _cas + 1;
		};
	} foreach _nearunits;
		
	if (_cas == 0) then 
	{
		_dec = 0.03; //
	}
		else
	{
		_dec = 0.05; //
	};
		
	_originalaccuracy = _unit getvariable "tpwcas_originalaccuracy";        
	_originalshake = _unit getvariable "tpwcas_originalshake";      
	_originalcourage = _unit getvariable "tpwcas_originalcourage";       
	_shots = _unit getvariable "tpwcas_enemybulletcount";     

	_newaccuracy = (_originalaccuracy - (( _originalaccuracy * _dec) * _shots )) max tpwcas_minskill; 
	_newshake = (_originalshake - ((_originalshake * _dec) * _shots )) max tpwcas_minskill;
	_newcourage = (_originalcourage - ((_originalcourage * _dec * (1 - _originalcourage)) * _shots )) max tpwcas_minskill;
	_unit setskill ["aimingaccuracy",_newaccuracy];         
	_unit setskill ["aimingshake",_newshake];        
	_unit setskill ["courage",_newcourage]; 
	
	if (_unit getVariable ["tpwcas_skillreset", 0] == 0) then
	{
		_unit setVariable ["tpwcas_skillreset", 1];
	};
	
	//diag_log format ["<<< Unit [%1] - Acc: [%2] - Shake: [%3] - Courage: [%4] - time: [%5]", _unit, _newaccuracy, _newshake, _newcourage, time];
					
};  
