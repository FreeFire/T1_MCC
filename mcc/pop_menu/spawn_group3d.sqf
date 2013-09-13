#define MCC3D_IDD 8000
#define MCC_UNIT_TYPE 8001
#define MCC_UNIT_CLASS 8002
#define MCC_NAMEBOX 8003 
#define MCC_INITBOX 8004 
#define MCC_PRESETS 8005
#define MCC_SETTING_EMPTY 8006
#define MCC_ZONE_LOC 8007

private ["_type","_groupArray","_3d", "_dlg","_tempText","_presetText"];
disableSerialization;
_3d = _this select 0;

if (mcc_missionmaker == (name player)) then {
	if (_3d == 0) then //Case we are opening the 3D
		{
		hint "click on map"; 
		onMapSingleClick "_nul=["""",_pos] call MCC_3D_PLACER;closeDialog 0;onMapSingleClick """";";	
		MCC3DRuning = true;
		while {MCC3DRuning && (alive player)} do
			{
			MCC3DgotValue = false; 
			while {!MCC3DgotValue && MCC3DRuning} do {sleep 0.2};
			if (MCC3DRuning) then 
				{
				if (MCC_capture_state) then
					{
					 MCC_capture_var = MCC_capture_var + FORMAT ["
										[[%1, %2, '%3', '%4', '%5', %6, '%7', '%8', %9],'MCC_fnc_simpleSpawn',true,false] spawn BIS_fnc_MP;		
										"
										,MCC3DValue select 0
										,MCC3DValue select 1
										,mcc_spawnname
										,mcc_spawntype
										,mcc_spawnfaction
										,mcc_spawnwithcrew
										,MCC_unitInit
										,MCC_unitName
										,mcc_hc
										];
					}	else
						{
						 mcc_safe = mcc_safe + FORMAT ["
										[[%1, %2, '%3', '%4', '%5', %6, '%7', '%8', %9],'MCC_fnc_simpleSpawn',true,false] spawn BIS_fnc_MP;		
										MCC_mccFunctionDone = false; 
										waitUntil {MCC_mccFunctionDone};
										"
										,MCC3DValue select 0
										,MCC3DValue select 1
										,mcc_spawnname
										,mcc_spawntype
										,mcc_spawnfaction
										,mcc_spawnwithcrew
										,MCC_unitInit
										,MCC_unitName
										,mcc_hc
										];
						[[MCC3DValue select 0, MCC3DValue select 1, mcc_spawnname, mcc_spawntype, mcc_spawnfaction, mcc_spawnwithcrew,MCC_unitInit,MCC_unitName,mcc_hc],"MCC_fnc_simpleSpawn",true,false] spawn BIS_fnc_MP;		
						};
				};
			sleep 0.1;
			};
		mcc_isnewzone = false;	//reset stuff
		mcc_grouptype = "";
		mcc_spawntype = "";
		mcc_classtype = "";
		mcc_spawnname = "";
		mcc_spawnfaction = "";
		mcc_resetmissionmaker = false;
		MCC_unitInit = "";
		MCC_unitName = "";
		};
		
	if (_3d == 1) then //Case we are changing the object
		{		
		_type = lbCurSel MCC_UNIT_TYPE;
		switch (_type) do	
			{
			   case 0:	//Infantry
				{
					_groupArray = U_GEN_SOLDIER;
					mcc_spawntype="MAN";
				};
				
				case 1:	//Car
				{
					_groupArray = U_GEN_CAR;
					mcc_spawntype="VEHICLE";
				};
				
				case 2:	//Tank
				{
					_groupArray = U_GEN_TANK;
					mcc_spawntype="VEHICLE";
				};
				
				case 3:	//Motorcycle
				{
					_groupArray = U_GEN_MOTORCYCLE;
					mcc_spawntype="VEHICLE";
				};
				
				case 4:	//Helicopter
				{
					_groupArray = U_GEN_HELICOPTER;
					mcc_spawntype="VEHICLE";
				};
				
				case 5:	//Aircraft
				{
					_groupArray = U_GEN_AIRPLANE;
					mcc_spawntype="VEHICLE";
				};
				
				case 6:	//Ship
				{
					_groupArray = U_GEN_SHIP;
					mcc_spawntype="VEHICLE";
				};
						
				case 7:	//DOC
				{
					_groupArray = GEN_DOC1;
					mcc_spawntype="DOC";
				};
				
				case 8:	//AMMO
				{
					_groupArray = U_AMMO;
					mcc_spawntype="AMMO";
				};
				
				case 9:	//Fortifications
				{
					_groupArray = U_FORT;
					mcc_spawntype="AMMO";
				};
					
				case 10:	//Dead Bodies
				{
					_groupArray = U_DEAD_BODIES;
					mcc_spawntype="AMMO";
				};
				
				case 11:	//Furniture
				{
					_groupArray = U_FURNITURE;
					mcc_spawntype="AMMO";
				};
				
				case 12:	//Market
				{
					_groupArray = U_MARKET;
					mcc_spawntype="AMMO";
				};
				
				case 13:	//Misc
				{
					_groupArray = U_MISC;
					mcc_spawntype="AMMO";
				};
				
				case 14:	//Sighns
				{
					_groupArray = U_SIGHNS;
					mcc_spawntype="AMMO";
				};
				
				case 15:	//Warefare
				{
					_groupArray = U_WARFARE;
					mcc_spawntype="AMMO";
				};
				
				case 16:	//Wrecks
				{
					_groupArray = U_WRECKS;
					mcc_spawntype="AMMO";
				};
				
				case 17:	//Houses
				{
					_groupArray = U_HOUSES;
					mcc_spawntype="AMMO";
				};
				
				case 18:	//Ruins
				{
					_groupArray = U_RUINS;
					mcc_spawntype="AMMO";
				};
				
				case 19:	//Garbage
				{
					_groupArray = U_GARBAGE;
					mcc_spawntype="AMMO";
				};
				
				case 20:	//Lamps
				{
					_groupArray = U_LAMPS;
					mcc_spawntype="AMMO";
				};
				
				case 21:	//Containers
				{
					_groupArray = U_CONTAINER;
					mcc_spawntype="AMMO";
				};
				
				case 22:	//Small Items
				{
					_groupArray = U_SMALL_ITEMS;
					mcc_spawntype="AMMO";
				};
				
				case 23:	//structures
				{
					_groupArray = U_STRUCTERS;
					mcc_spawntype="AMMO";
				};
				
				case 24:	//helpers
				{
					_groupArray = U_HELPERS;
					mcc_spawntype="AMMO";
				};
				
				case 25:	//training
				{
					_groupArray = U_TRAINING;
					mcc_spawntype="AMMO";
				};
				
				case 26:	//Mines
				{
					_groupArray = U_MINES;
					mcc_spawntype="MINES";
				};
			};
		mcc_classtype = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 0;
		mcc_spawnname = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 1;
		mcc_spawnfaction = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 2;
		mcc_spawndisplayname = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 3;
		MCC_unitInit = ctrlText MCC_INITBOX;
		MCC_unitName = ctrlText MCC_NAMEBOX;
		
		mcc_spawnwithcrew = (MCC_spawn_empty select (lbCurSel MCC_SETTING_EMPTY)) select 1;	//let's add the behavior/awerness
		MCC_empty_index = (lbCurSel MCC_SETTING_EMPTY);
		mcc_hc = (MCC_ZoneLocation select (lbCurSel MCC_ZONE_LOC)) select 1;
		
		deletevehicle Object3D;
		if (mcc_spawntype == "MINES") then	{
				Object3D = createMine [mcc_spawnname,[0,0,500], [], 0];
				Object3D enableSimulation false;
				} else	{
					Object3D = mcc_spawnname createvehicle [0,0,500];	
					Object3D enableSimulation false;
					};
		};
		
	if (_3d == 2) then //Case we adding presets
		{	
		_tempText = ctrlText MCC_INITBOX;
		_presetText = (mccPresets select(lbCurSel MCC_PRESETS)) select 1; 
		ctrlSetText [MCC_INITBOX,format ["%1 %2",_tempText,_presetText]];
		};
} else {player globalchat "Access Denied"};	
	
	


 
		