#define MCC_SANDBOX2_IDD 2000
#define MCC_EVAC_TYPE 2020
#define MCC_EVAC_CLASS 2021
#define MCC_EVAC_SELECTED 2022
disableSerialization;
private ["_type","_evac"];
_type = _this select 0;
_evac = MCC_evacVehicles select (lbCurSel MCC_EVAC_SELECTED);

if !mcc_isloading then 
	{
	if (mcc_missionmaker == (name player)) then
	{	
    switch (_type) do
	{
   		case 0:
		{
		  hint "pilot deleted";
		}; 
		case 1:
		{
		hint "pilot respawned";
		};
		case 2:
		{ hint "Pilot & Chopper deleted";
		  };
		
	};
	
	if (MCC_capture_state) then
		{
		MCC_capture_var = MCC_capture_var + FORMAT ['
							[[%1,netid %2],"MCC_fnc_evacDelete",true,false] spawn BIS_fnc_MP;
							'
							,_type
							,_evac
							];
		} else
			{
			[[_type,netid _evac],"MCC_fnc_evacDelete",true,false] spawn BIS_fnc_MP;
			};
	}	
		else { player globalchat "Access Denied"};
	};	
//hint format ["%1, %2",_type, _evac];
