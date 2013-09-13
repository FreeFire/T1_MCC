


_crates = AD_ammocrates;


{
	
	_varcheck = (_x getVariable "AD_filledbox");
	
	if (isnil "_varcheck") then {
		_x setVariable ["AD_filledbox", false, false];
	};
	
	if (!(_x getVariable "AD_filledbox")) then {
		
		clearMagazineCargo _x;
		clearweaponcargo _x;
		clearItemCargo _x;
		_x addmagazinecargo ["30Rnd_65x39_caseless_mag", 100];
		_x addMagazinecargo ["100Rnd_65x39_caseless_mag_Tracer",30];
		_x addMagazinecargo ["1Rnd_HE_Grenade_shell", 15];
		_x addMagazinecargo ["NLAW_F", 4];
		_x addMagazinecargo ["HandGrenade", 20];
		_x addMagazinecargo ["SmokeShell", 20];
		_x addWeaponcargo ["FirstAidKit", 15];
		
		_x setVariable ["AD_filledbox", true, false];
		
	};
	
} foreach _crates;


