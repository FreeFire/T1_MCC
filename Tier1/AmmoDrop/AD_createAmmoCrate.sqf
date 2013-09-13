


_cratepos = _this select 1;

_crate = "B_supplyCrate_F" createVehicle _cratepos;

AD_ammocrates set [count AD_ammocrates, _crate];

publicVariable "AD_ammocrates";

[] spawn {
	if (!(isnil "AD_hndlr_fac")) then {
		waitUntil {scriptDone AD_hndlr_fac};
	};
	AD_hndlr_fac = [] execVM "Tier1\AmmoDrop\AD_fillAmmoCrate.sqf";
}; 