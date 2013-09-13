


//	This script makes it so players can't shoot inside a trigger called "trg_noFireZone".
//	Run this script on the clients.


waituntil{alive player};

fdelay = 0;

[] spawn {
	while {true} do {
		
		sleep 30;
		
		if (fdelay > 0 ) then {
			fdelay = fdelay - 1;
		};
		
	};
};



player addEventHandler ["Fired", {
	
	if (player in (list trg_noFireZone)) then {
		fdelay = fdelay + 1;
		
		if ((fdelay > 0) and (fdelay < 4)) then {
			hintC "Do not shoot at the base!";
			
		} else {
			if (fdelay >= 4) then {
				removeallweapons player;
			};
		};
	};
}];