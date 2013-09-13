/*
MAIN LOOP
Every 1 sec:
- Assigns initial variables to each unit if they are not yet assigned
- Checks suppression state of unit and applies appropriate stance and skill changes
*/

tpwcas_fnc_main_loop = 
{
	private ["_unitCheck","_stanceregain","_skillregain","_unit","_x", "_anim", "_upos", "_umov", "_dthstr", "_posstr", "_acePosstr", "_movstr", "_chatString", "_shooter", "_lineIntersect","_coverregain","_cover","_stance","_GetNeckPos"];	
	
	if( bdetect_debug_enable ) then {
        _msg = format["%1 Started 'tpwcas_fnc_main_loop' - mode: [%2]", time, tpwcas_mode];
        [ _msg, 8 ] call bdetect_fnc_debug;
	};
	
	while {true} do    
	{
		{ //foreach start
			
			// Check if the unit has been set to be ignored by TPWCAS.
			// If the tpwcas_ignoreUnit variable set on the unit is true, then the unit will be skipped/ignored.
			_runMainLoop = false;
			_ignoreUnit = (_x getVariable "tpwcas_ignoreUnit");
			if (isnil "_ignoreUnit") then {
				_runMainLoop = true;
			} else {
				if (!_ignoreUnit) then {
					_runMainLoop = true;
				};
			};
			
			if (_runMainLoop) then {
				
				if ( tpwcas_mode == 3 ) then // multiplayer (dedicated) server no client setup
				{
					_unitCheck = !(isPlayer _x);
				}
				else // singleplayer or (hosted/dedicated) server with clients enabled or headless client
				{
					_unitCheck = (local _x);
				};
			
				//if ( (_unitCheck) && (vehicle _x == _x) && (lifestate _x == "ALIVE") && (side _x != civilian) ) then //ARMA3
				if ( (_unitCheck) && (vehicle _x == _x) && ((lifestate _x == "HEALTHY") || (lifestate _x == "INJURED")) && (side _x != civilian) ) then
				{
					_unit  = _x;

					_stanceregain = _unit getvariable ["tpwcas_stanceregain", -1];
					_skillregain = _unit getvariable ["tpwcas_skillregain", -1]; 
					
					if (tpwcas_canflee == 0) then {
						_unit allowfleeing 0;
					};
							  
					//SET INITIAL PARAMETERS FOR EACH UNIT   
					if (_stanceregain == -1 ) then
					{ 
						//SET ASR AI SKILLS IF ASR AI IS RUNNNING
						if (!isNil "asr_ai_sys_aiskill_fnc_SetUnitSkill") then 
						{
							[_unit] call asr_ai_sys_aiskill_fnc_SetUnitSkill;
						};	
						
						//TEXT BASED DEBUGGING ON SP	=> DEPRECATED				
						//if ( (tpwcas_textdebug > 0) && !(isMultiPlayer) ) then  
						//{
						//	[_unit,tpwcas_textdebug] spawn tpwcas_fnc_textdebug;
						//};
						
						_unit setvariable ["tpwcas_originalaccuracy", _unit skill "aimingaccuracy"];      
						_unit setvariable ["tpwcas_originalshake",  _unit skill "aimingshake"];     
						_unit setvariable ["tpwcas_originalcourage", _unit skill "courage"];      
						_unit setvariable ["tpwcas_general", _unit skill "general"];     
						_unit setvariable ["tpwcas_stanceregain", time];      
						_unit setvariable ["tpwcas_stance", "auto"];
					};    
					 
					//RESET UNIT SETTINGS IF UNSUPPRESSED   
					if ( time >= _stanceregain ) then        
					{ 
						if !( _unit getVariable "tpwcas_stance" == "äuto") then 
						{
							_unit setvariable ["tpwcas_supstate",0];  
							_unit setvariable ["tpwcas_bulletcount",0];     
							_unit setvariable ["tpwcas_enemybulletcount",0]; 
							_unit setvariable ["tpwcas_stanceregain", time + 10]; 

							//RESET UNIT STANCE
							_stance = _unit getvariable ["tpwcas_stance", -1];
							
							if (_stance in ["middle","down"]) then 
							{
								_unit setunitpos "auto"; 
								_unit setvariable ["tpwcas_stance", "auto"];
							};
							
							//if ( _cover > 0 ) then
							if ( (tpwcas_getcover == 1) && ((_unit getvariable ["tpwcas_cover", 0]) > 0 ) ) then 
							{
								_unit setvariable ["tpwcas_cover", 0];
								//avoid run for cover loop effect
								_unit setvariable ["tpwcas_coverregain", time + (( random 20) + 20)]; 
							};
						};
						
						//RESET UNIT SKILLS IF UNSUPPRESSED  
						if ( ( tpwcas_skillsup == 1 ) && (time >= _skillregain) && (_unit getVariable ["tpwcas_skillreset", 1] == 1)) then 
						{						 
							[_unit] call tpwcas_fnc_incskill;
						};
					};   

					if ( _unit getvariable ["tpwcas_process", 0] == 1 ) then 
					{
						if !(isPlayer _unit) then 
						{
							//UNIT CHANGES FOR DIFFERENT SUPPRESSION 
							switch ( _unit getvariable "tpwcas_supstate" ) do  
							{  
								case 1: //IF ANY BULLETS NEAR UNIT  
								{
									//Check whether unit stands, kneels or lies'
									_upos = "stand"; // standing
									_GetNeckPos = ( _unit selectionPosition "Neck" ) select 2;
									if ((_GetNeckPos < 1.39) && (_GetNeckPos >= 0.5)) then {_upos = "kneel";};  // kneel
									if (_GetNeckPos < 0.5) then {_upos = "prone";};	 // lying
									
									//CROUCH IF NOT PRONE 
									if ( _upos == "stand" ) then  
									{ 
										_unit setunitpos "middle"; 
										_unit setvariable ["tpwcas_stance", "middle"];		
									};
								};  
								  
								case 2: //IF ENEMY BULLETS NEAR UNIT  
								{ 
									//Check whether unit stands, kneels or lies'
									_upos = "stand"; // standing
									_GetNeckPos = ( _unit selectionPosition "Neck" ) select 2;
									if ((_GetNeckPos < 1.39) && (_GetNeckPos >= 0.5)) then {_upos = "kneel";};  // kneel
									if (_GetNeckPos < 0.5) then {_upos = "prone";};	 // lying

									//CROUCH IF NOT PRONE
									if ( _upos != "prone" ) then  
									{ 
										//_cover = _unit getvariable ["tpwcas_cover", 0];
										_coverregain = _unit getVariable ["tpwcas_coverregain", time];
										
										if ( ( time >= _coverregain) && ( tpwcas_getcover == 1 ) && ( (_unit getvariable ["tpwcas_cover", 0]) == 0 ) && ( diag_fps > tpwcas_getcover_minfps ) ) then 
										{
											[_unit, 2] spawn tpwcas_fnc_find_cover;
										};
										
										_unit setunitpos "middle"; 
										_unit setvariable ["tpwcas_stance", "middle"];
									};
									
									//SKILL MODIFICATION 
									if (tpwcas_skillsup == 1) then 
									{ 
										[_unit] call tpwcas_fnc_decskill;
									};

									_shooter = _unit getVariable "tpwcas_shooter";
									_unit doWatch _shooter;
								};  
								  
								case 3: //IF UNIT IS SUPPRESSED BY MULTIPLE ENEMY BULLETS   
								{ 
									//Check whether unit stands, kneels or lies'
									_upos = "stand"; // standing
									_GetNeckPos = ( _unit selectionPosition "Neck" ) select 2;
									if ((_GetNeckPos < 1.39) && (_GetNeckPos >= 0.5)) then {_upos = "kneel";};  // kneel
									if (_GetNeckPos < 0.5) then {_upos = "prone";};	 // lying		
									
									if ( _upos != "prone" ) then  
									{ 
										_coverregain = _unit getVariable ["tpwcas_coverregain", time];
										
										if ( ( time >= _coverregain) && ( tpwcas_getcover == 1 ) && ( (_unit getvariable ["tpwcas_cover", 0]) == 0 ) && ( diag_fps > tpwcas_getcover_minfps ) ) then 
										{
											[_unit, 2] spawn tpwcas_fnc_find_cover;
										};

										//GO PRONE 
										_unit setunitpos "down"; 
										_unit setvariable ["tpwcas_stance", "down"];					
										_unit forcespeed -1;
									};
									
									//SKILL MODIFICATION 
									if (tpwcas_skillsup == 1) then 
									{
										[_unit] call tpwcas_fnc_decskill;
									};
									
									_shooter = _unit getVariable "tpwcas_shooter";							
									_unit doWatch _shooter;
								}; 
							};
						}
						else
						{
							//PLAYER VISUAL CHANGES FOR DIFFERENT SUPPRESSION 
							switch ( _unit getvariable "tpwcas_supstate" ) do  
							{
								case 2: //IF ENEMY BULLETS NEAR PLAYER  
								{
									//PLAYER CAMERA SHAKE  
									if (tpwcas_playershake == 1) then    
									{    
										addCamShake [0.12, 2 + (random 2), 2]; 
									};							
								};
							
								case 3: //IF PLAYER IS SUPPRESSED BY MULTIPLE ENEMY BULLETS   
								{
									//PLAYER CAMERA SHAKE AND FX 
									if (tpwcas_playershake == 1) then  
									{ 
										addCamShake [0.20 , 3 + (random 3), 3];
									}; 
									
									//PLAYER VISUAL FX
									if (tpwcas_playervis == 1) then  
									{     
										[] spawn tpwcas_fnc_visuals;   
									}; 
								};
							};
							
							if( bdetect_debug_enable ) then {
								_msg = format["'tpwcas_fnc_main_loop' Player CamShake suppression - level [%1]", (_unit getvariable "tpwcas_supstate")];
								[ _msg, 8 ] call bdetect_fnc_debug;
							};
							
						};
						
						//processed so reset value
						_unit setVariable ["tpwcas_process", 0];
					};
				}
				else
				{
					//if civilian
					//if ((side _x == civilian) && (vehicle _x == _x) && (lifestate _x == "ALIVE") && !(isPlayer _x)) then //ARMA3
					if ((side _x == civilian) && (vehicle _x == _x) && ((lifestate _x == "HEALTHY") || (lifestate _x == "INJURED")) && !(isPlayer _x)) then				
					{
						_unit  = _x;  

						_stanceregain = _unit getvariable ["tpwcas_stanceregain", -1];
							  
						//SET INITIAL PARAMETERS FOR EACH UNIT   
						if (_stanceregain == -1 ) then        
						{ 
							_unit setvariable ["tpwcas_originalcourage", _unit skill "courage"];      
							_unit setvariable ["tpwcas_stanceregain", time];      
							_unit setvariable ["tpwcas_stance", "auto"];
						};    
						 
						//RESET UNIT SETTINGS IF UNSUPPRESSED   
						if ( time >= _stanceregain) then        
						{ 
							_unit setvariable ["tpwcas_supstate",0];  
							_unit setvariable ["tpwcas_bulletcount",0];
							_unit setvariable ["tpwcas_enemybulletcount",0]; 
							
							_unit setSkill ["courage",_unit getVariable ["tpwcas_originalcourage",0.5]];
							
							_unit setvariable ["tpwcas_stanceregain", time + 5]; 					
							
							_stance = _unit getvariable ["tpwcas_stance", -1];						
							if (_stance in ["middle","down"]) then 
							{
								_unit setunitpos "auto"; 
								_unit setvariable ["tpwcas_stance", "auto"];
							};
						};
						
						//_cover = _unit getvariable ["tpwcas_cover", 0];
						
						if ( ((_unit getvariable ["tpwcas_cover", 0]) == 0) && ((_unit getvariable "tpwcas_supstate") > 0 ) ) then 
						{
							//run for it: civilians will run in random directions due to shooting
							[_unit] spawn tpwcas_fnc_run_for_it;
						};
					};
				};
			};
		} foreach allUnits; 
			
		//sleep 1.2;
		sleep 1;
	};   
};  
