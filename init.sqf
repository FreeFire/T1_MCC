


//	Check mission parameter settings and execute parameter code.
for [ { _i = 0 }, { _i < count(paramsArray) }, { _i = _i + 1 } ] do
{
	_paramName =(configName ((missionConfigFile >> "Params") select _i));
	_paramValue = (paramsArray select _i);
	_paramCode = ( getText (missionConfigFile >> "Params" >> _paramName >> "code"));
		
	diag_log format ["INIT Params: [%1] - [%2]", _paramName, _paramCode];
	
	if !( _paramCode == "" ) then 
	{
		_code = format[_paramCode, _paramValue];
		call compile _code;
	};
};



//	Initialize time of day, chosen in the mission parameters.
if (isserver) then {
	setDate [2035, 7, 6, T1_startingTimeHour, 0];
};



// Run the briefing file.
execVM "Briefing.sqf";



// MCC stuff.
private ["_string","_null","_nul","_dummyGroup","_dummy","_name","_keyDown"];
MCC_initDone = false;
MCC_path = ""; 



//	Initialize some misc stuff.
_side = createCenter east;
_side = createCenter west;



//	The below list contains all unit types that are allowed to pilot aircraft vehicles.
//	This list is used by some Tier1 scripts.
playablePilotTypes = ["B_Helipilot_F", "O_helipilot_F", "I_helicrew_F", "I_helipilot_F", "T1_Pilot_Standard_F", "T1_Pilot_Black_F", "T1_Pilot_Blackcamo_F", "T1_Pilot_Camo_F", "T1_Pilot_Night_F"];




//	Initialize BTC Revive.
call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";


////	Disabled, because the MCC does something similar.
/*
//	Initialize UPSMON.
if ((!isServer) && (player != player)) then
{
  waitUntil {player == player};
};
//	Init UPSMON script (must be run on all clients)
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";	
//	Process statements stored using setVehicleInit
//processInitCommands;
//	Finish world initialization before mission is launched. 
finishMissionInit;
*/
////


//	The following code is executed after the briefing screen.
sleep 0.5;



//	Server-side scripts.
if (isserver) then {
	
	//	Begin script that keeps the base clear of destroyed wrecks.
	[] execVM "Tier1\MiscScripts\clearVehicleWrecks.sqf";
	
	//	Tweak AI accuracy and skill.
	[] execVM "Tier1\MiscScripts\set_skills.sqf";
	
};



//	Client-side scripts.
if (!isdedicated) then {
	
	//	Add map markers to all player groups.
	[] execVM "Tier1\UnitMarkers\setgroupmarkers.sqf";
	
	//	Disable AI radio chatter.
	player setVariable ["BIS_noCoreConversations", true];
	
	//	Firing in base protection.
	[] execVM "Tier1\MiscScripts\noFireZone.sqf";
	
	//	Aircraft resupply zones.
	[] execVM "Tier1\MiscScripts\aircraftResupplyZone.sqf";
	
	//	Enable ghost mode and teleport for server admin.
	[player] call compile preprocessFileLineNumbers "Tier1\AdminActions\main.sqf";
	
	//	Night mission white screen fix.
	//	Enable the below line if you are running a night mission with players who have no night vision goggles.
	//[] execVM "Tier1\WhiteScreenFix\init_WhiteScreenFix.sqf";
	
	//	Initialize eject script.
	[] execVM "Tier1\EjectScript\EP_init_eject.sqf";
	
	//	TAW view distance stuff.
	[] execVM "taw_vd\init.sqf";
	
};



//	Scripts for all machines.



//	Initialize ammo drop script.
[] execVM "Tier1\Ammodrop\AD_initAmmoDrop.sqf";

// Vehicle crew HUD
hud_teamlist = compile preprocessFileLineNumbers ("Tier1\VehicleHud\hud_teamlist.sqf");
[] spawn hud_teamlist;



//	TPWCAS AI Suppression.
if !(isNil "tpwcas_enable") then 
{
	if ( tpwcas_enable == 1 ) then
	{
		tpwcas_mode = tpwcas_mode + 2;
		diag_log format ["%1 - starting TPWCAS_A3 with tpwcas_mode [%2]", time, (tpwcas_mode)];
		[tpwcas_mode] execVM "tpwcas\tpwcas_script_init.sqf";
	};

	// enable AI Supression statistics logging (once every 60 seconds)
	if ( (tpwcas_enable == 1) && ( tpwcas_mode == 2 || isServer ) ) then
	{
		waitUntil { !(isNil "bdetect_init_done") };
	
		[] spawn tpwcas_fnc_log_benchmark;
	};
};

// More MCC stuff. Should be moved to a different file at some point...

//----------------------General settings---------------------------------------
//Default side that detect undercover units 0 -East, 1 - West
//MCC_underCoverDetect				= 0; 
//Default AI skill
MCC_AI_Skill						= [0.3,[0.1,0.3]]; 

//-----------------------BTC Revive - --------------------------------------------
//disable this line if you don't want it in the mission version - will not work on the mod version by default
//if (MCC_path == "") then {call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf"};
/*
//----------------------IED settings---------------------------------------------
// IED types the first one is display name the second is the classname [displayName, ClassName]
MCC_ied_small = [["Plastic Crates","Land_CratesPlastic_F"],["Plastic Canister","Land_CanisterPlastic_F"],["Sack","Land_Sack_F"],["Road Cone","RoadCone"],["Tyre","Land_Tyre_F"]];
MCC_ied_medium = [["Wheel Cart","Land_WheelCart_F"],["Metal Barrel","Land_MetalBarrel_F"],["Plastic Barrel","Land_BarrelSand_F"],["Pipes","Land_Pipes_small_F"],["Wooden Crates","Land_CratesShabby_F"],["Wooden Box","Land_WoodenBox_F"],["Cinder Blocks","Land_Ytong_F"],["Sacks Heap","Land_Sacks_heap_F"]];
MCC_ied_wrecks = [["Car Wreck","Land_Wreck_Car3_F"],["BRDM Wreck","Land_Wreck_BRDM2_F"],["Offroad Wreck","Land_Wreck_Offroad_F"],["Truck Wreck","Land_Wreck_Truck_FWreck"]];
MCC_ied_mine = [["Mine Field AP - Visable","apv"], ["Mine Field AP - Hidden","ap"],["Mine Field AP Bounding - Visable","apbv"],["Mine Field AP Bounding- Hidden","apb"], ["Mine Field AT - Visable","atv"], ["Mine Field AT - Hidden","at"]];
MCC_ied_rc = [["SLAM","SLAMDirectionalMine"],["Trip Mine","APERSTripMine"]];
MCC_ied_hidden = [["Dirt Small","IEDLandSmall_Remote_Ammo"],["Dirt Big","IEDLandBig_Remote_Ammo"],["Urban Small","IEDUrbanSmall_Remote_Ammo"],["Urban Big","IEDUrbanSmall_Remote_Ammo"]];
//IED jammer vehicle, the first one is display name the second is the classname [displayName, ClassName]
MCC_IEDJammerVehicles = ["M2A3_EP1", "HMMWV_M1151_M2_CZ_DES_EP1", "HMMWV_M1151_M2_DES_EP1"];
*/

/*
//------------------------Convoy settings----------------------------------------
MCC_convoyHVT = [["None","0"],["B.Commander","B_Soldier_lite_F"],["B. Pilot","B_Helipilot_F"],["O. Commander","O_Soldier_lite_F"],["O. Pilot","O_helipilot_F"],["Citizen","C_man_polo_1_F"]];
MCC_convoyHVTcar = [["Hunter","B_Hunter_F"],["Quadbike","B_Quadbike_F"],["Ifrit","O_Ifrit_F"],["Offroad","c_offroad"]];
*/

//------------------------MCC Console--------------------------------------------
//AC-130 amo count by array [20mm,40mm,105mm]
//MCC_ConsoleACAmmo = [500,80,20]; 
//string that must return true inorder to open the MCC Console - str "MCC_Console" + "in (assignedItems player)"; 
//if (MCC_isMode) then {
//	MCC_consoleString = str "MCC_Console" + "in (assignedItems _this) && (vehicle _target == vehicle _this)"; 
//		} else {
//			MCC_consoleString = str "ItemGPS" + "in (assignedItems _this) && (vehicle _target == vehicle _this)"; 
//			};
//------------------------Artillery---------------------------------------------------
MCC_artilleryTypeArray = [["DPICM","GrenadeHand",0],["HE 120mm","Sh_120_HE",1], ["Cluster 120mm","Cluster_120mm_AMOS",1], ["Cluster AP","Mo_cluster_AP",1],["Mines 120mm","Mine_120mm_AMOS_range",1],
						["HE Laser-guided","Sh_120mm_AMOS_LG",3],["HE 82mm","Sh_82mm_AMOS",1], ["Incendiary 82mm","Fire_82mm_AMOS",1],
						["Smoke White 120mm","Smoke_120mm_AMOS_White",1],["Smoke White 82mm","Smoke_82mm_AMOS_White",1],["Smoke Green 40mm","G_40mm_SmokeGreen",1], ["Smoke Red 40mm","G_40mm_SmokeRed",1],
						["Flare White","F_40mm_White",2], ["Flare Green","F_40mm_Green",2], ["Flare Red","F_40mm_Red",2]];
MCC_artillerySpreadArray = [["On-target",0], ["Precise",50], ["Tight",100], ["Wide",200]]; //Name and spread in meters
MCC_artilleryNumberArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];

//-------------------------Close Air Support----------------------------------------------
//Vehicle name and class
MCC_CASPlanes = [["AH-9","B_AH9_F"],["Ka-60","O_Ka60_F"]]; 

/*
//-------------------------MCC Convoy presets---------------------------------------------
//The Type of units, drivers and escort in the HVT car
MCCConvoyWestEscort = "B_Soldier_F"; MCCConvoyWestDriver = "B_Soldier_SL_F";
MCCConvoyEastEscort = "O_Soldier_F"; MCCConvoyEastDriver = "O_Soldier_SL_F";
MCCConvoyGueEscort = "GUE_Soldier_1"; MCCConvoyGueDriver = "GUE_Soldier_CO";
MCCConvoyCivEscort = "C_man_1_1_F"; MCCConvoyCivDriver = "C_man_1_1_F";
*/

//----------------------------Presets---------------------------------------------------------
	//	 ['AI Artillery - Cannon', '[_this,1,2000,100,12,5,"Sh_82mm_AMOS",20] execVM "'+MCC_path+'scripts\UPSMON\MON_artillery_add.sqf";']
	//	,['AI Artillery - Rockets', '[_this,6,5000,150,4,2,"Sh_82mm_AMOS",120] execVM "'+MCC_path+'scripts\UPSMON\MON_artillery_add.sqf";']
	//	,['Forward Observer Artillery', '[0,_this] execVM "'+MCC_path+'mcc\general_scripts\artillery\bon_art.sqf";']
		
		mccPresets = [ 
		['Ambient Artillery - Cannon', '[0,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['Ambient Artillery - Rockets', '[1,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['Ambient AA - Cannon/Rockets', '[2,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['Ambient AA - Search Light', '[3,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['Recruitable', '_this addAction [format ["Recruit %1", name _this], "'+MCC_path+'mcc\general_scripts\hostages\hostage.sqf",2,6,false,true];']
		,['Make Hostage', '_this execVM "'+MCC_path+'mcc\general_scripts\hostages\create_hostage.sqf";']
		,['Destroy Object', '_this setdamage 1;']
		,['Flip Object', '[_this ,0, 90] call bis_fnc_setpitchbank;']
		,['Join player', '[_this] join (group player);']
		,['Set Empty (Fuel)', '_this setfuel 0;']
		,['Set Empty (Ammo)', '_this setvehicleammo 0;']
		,['Set Locked', '_this setVehicleLock "LOCKED";']
		,['Set Renegade', '_this addrating -2001;']
		,['Create Local Marker', '_this execVM "'+MCC_path+'mcc\general_scripts\create_local_marker.sqf";']
	];


//**********************************************************************************************************************
//====================================================================================================================
//=		 				DO NOT EDIT BENEATH THIS LINE
//====================================================================================================================
//*********************************************************************************************************************
//-----------------------Bon artillery --------------------------------------------
//_nul = [] execVM MCC_path +"bon_artillery\bon_arti_init.sqf";

// HEADLESS CLIENT CHECK
if (isNil "MCC_isHC" ) then { 
	MCC_isHC = false; 
};
if (isNil "MCC_isLocalHC" ) then { 
	MCC_isLocalHC = false;
};
		
if ( !(isServer) && !(hasInterface) ) then 
{
	// is HC
	MCC_isHC = true;
	MCC_isLocalHC = true;
	MCC_ownerHC = owner player;
	publicVariable "MCC_isHC";
	publicVariable "MCC_ownerHC";
};

// define if tracking is enabled or disabled
MCC_trackMarker = false; 
// use mcc logic module to set to true to always allow to teleport to team, e.g. in case of training mission or respawn enabled mission
MCC_alwaysAllowTeleport = true;
// use mcc logic module to set to false to disable auto teleport to mcc start location 
MCC_teleportAtStart = false;

// use mcc logic module to set to false to disable Suunto and/or auto viewdistance adjust
//MCC_HALOviewDistance = true;
//MCC_HALOviewAltimeter = true;

//define stuff for popup menu
MCC_mouseButtonDown = false; //Mouse state
MCC_mouseButtonUp = true; 
MCC_sync= "";
MCC_unitInit = "";
MCC_unitName = "";
MCC_capture_state = false;
MCC_capture_var = "";
MCC_zones_numbers = [1,2,3,4,5,6,7,8,9,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40];
MCC_zones_x = [[10],[25],[50],[100],[200],[300],[400],[500],[600],[700],[800],[900],[1000],[1500],[2000],[2500],[3000],[4000],[5000],[6000],[7000],[8000],[9000],[10000]];
MCC_zone_drawing = false;
// NEW
MCC_ZoneType = [["regular",0],["respawn",1],["patrol",2],["reinforcement",3]];
MCC_ZoneType_nr1 = [["rectangle",0],["rectangle 45",1],["rectangle 30",2]]; //regular
MCC_ZoneType_nr2 = [["unlimited",0],["1",1],["2",2],["3",3],["4",4],["5",5],["6",6],["7",7],["8",8],["9",9],["10",10]]; // respawn
MCC_ZoneType_nr3 = [["2",0],["3",1],["4",2],["5",3],["6",4],["7",5],["8",6],["9",7],["10",8]]; // patrol
MCC_ZoneType_nr4 = [["specific - 1",0],["specific - 2",1],["specific - 3",2],["anyware",3]]; // reinforcement
MCC_Marker_type = "RECTANGLE";
MCC_Marker_dir = 0;
MCC_MarkerZoneColor = "ColorYellow";
MCC_MarkerZoneType = "join";
mcc_patrol_wps = [];
mcc_patrol_wps_array = [];
mcc_zone_colors = [];

MCC_ZoneLocation = [["Server", 0], ["Headless Client", 1]]; //NEW
MCC_hc = 0; // 0 = UPSMON target is server, 1 = UPSMON target is HeadlessClient
// end NEW
MCC_unit_array_ready=true; 
MCC_faction_choice=true; 
MCC_faction_index = 0; 
MCC_type_index = 1; 
MCC_branch_index = 0; 
MCC_class_index = 0; 
MCC_zone_index = 0; 
MCC_zoneX_index = 0; 
MCC_ZoneType_index = 0; //NEW
MCC_ZoneType_nr_index = 0; //NEW
//MCC_ZoneLocation_index = 0; // NEW
MCC_zoneY_index = 0; 
MCC_mcc_screen = 0;
MCC_tasks =[];
MCC_triggers = [];
MCC_drawTriggers = false; 
MCC_markerarray = [];
MCC_brushesarray = [];
//MCC_musicTracks_array = [];
MCC_soundTracks_array = [];
MCC_musicTracks_index = 0;
MCC_brush_drawing = false; 
//MCC_jukeboxMusic = true;
//MCC_musicActivateby_array = ["NONE","EAST","WEST","GUER","CIV","LOGIC","ANY","ALPHA","BRAVO","CHARLIE","DELTA","ECHO","FOXTROT","GOLF","HOTEL","INDIA","JULIET","STATIC","VEHICLE","GROUP","LEADER","MEMBER","WEST SEIZED","EAST  SEIZED","GUER  SEIZED"];
//MCC_musicCond_array = ["PRESENT","NOT PRESENT","WEST D","EAST D","GUER D","CIV D"];
MCC_angle_array = [0,45,90,135,180,225,270,315];
MCC_shapeMarker = ["RECTANGLE","ELLIPSE"];
MCC_colorsarray = [["Black","ColorBlack"],["White","ColorWhite"],["Red","ColorRed"],["Green","ColorGreen"],["Blue","ColorBlue"],["Yellow","ColorYellow"]];

MCC_spawn_empty =[["No",true],["Yes",false]];
MCC_spawn_behavior = [["Agressive", "MOVE"],["Defensive","NOFOLLOW"],["Passive", "NOMOVE"],["Fortify","FORTIFY"],["Ambush","AMBUSH"],["On-Road Offensive","ONROADO"],["On-Road Defensive","ONROADD"],["BIS Default","bis"],["BIS Defence","bisd"],["BIS Patrol","bisp"]];
MCC_spawn_awereness = [["Default", "default"],["Aware","Aware"],["Combat", "Combat"],["stealth","stealth"],["Careless","Careless"]];
MCC_spawn_track = [["Off", false],["On",true]];
MCC_empty_index = 0;
MCC_behavior_index = 0;
MCC_awereness_index = 0;
MCC_track_index = 0;

MCC_enable_west=true;
MCC_enable_east=true;
MCC_enable_gue=true;
MCC_enable_civ=true; 
MCC_enable_respawn = true; 
//MCC_enable_LHD = true;

MCC_months_array = [["January", 1],["February",2],["March", 3],["April",4],["May",5],["June", 6],["July",7],["August", 8],["September",9],["October",10],["November",11],["December",12]];
MCC_days_array =[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];
MCC_minutes_array =[00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59];
MCC_hours_array = [["01:00",1],["02:00",2],["03:00",3],["04:00",4],["05:00",5],["06:00",6],["07:00",7],["08:00",8],["09:00",9],["10:00",10],["11:00",11],["12:00",12],["13:00",13],["14:00",14],["15:00",15],["16:00",16],["17:00",17],["18:00",18],["19:00",19],["20:00",20],["21:00",21],["22:00",22],["23:00",23],["00:00",0]];
MCC_weather_array = [["Clear",[0, 0, 0, 0, 0]], ["Clouded",[0.5, 0.5, 0.5, 0.5, 0.5]],["Rainy",[0.8, 0.8, 0.8, 0.8, 0.8]],["Storm",[1, 1, 1,1,1]]];
//MCC_fog_array = [["None",0], [1,0.1], [2,0.2], [3,0.3], [4,0.4], [5,0.5], [6,0.6], [7,0.7], [8,0.8], [9,0.9], ["Full",1]];
//MCC_fog_array = [["None",0], [2,0.1], [3,0.15], [4,0.2], [5,0.3], [6,0.4], [7,0.5], [8,0.6], [9,0.8], ["Full",1]];
MCC_fog_array = [["None",[0,0]]
	,["1 - low",[0.05,20]], ["1 - medium",[0.05,40]],["1 - dense",[0.05,80]]
	,["2 - low",[0.1,20]], ["2 - medium",[0.1,40]],["2 - dense",[0.1,80]]
	,["3 - low",[0.15,25]], ["3 - medium",[0.15,45]],["3 - dense",[0.15,90]]
	,["4 - low",[0.25,25]], ["4 - medium",[0.25,45]],["4 - dense",[0.25,90]]
	,["5 - low",[0.4,25]], ["5 - medium",[0.4,45]],["5 - dense",[0.4,100]]
	,["6 - low",[0.6,25]], ["6 - medium",[0.6,50]],["6 - dense",[0.6,110]],
	["7 - low",[0.8,25]], ["6 - medium",[0.8,50]],["6 - dense",[0.8,125]],
	["Full - low",[1,25]], ["Full - medium",[1,60]],["Full - dense",[1,150]]];

MCC_ChangeWeather_array = [["Instant",0], ["5 mins",300], ["10 mins",600], ["15 mins",900], ["20 mins",1200], ["30 mins",1800], ["40 mins",2400], ["50 mins",3000], ["60 mins",3600]];
MCC_months_index=0;
MCC_day_index=0;
MCC_hours_index=0;
MCC_minutes_index=0;
MCC_weather_index=0;
MCC_fog_index=0;
MCC_ChangeWeather_index=0;
//MCCfog = [0,25]; //set basic fog param to sync to clients
MCC_grass_array = [["No grass",50],["Medium grass",25], ["High grass",12.5]];
MCC_view_array = [1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000];
MCC_grass_index = 2;

MCC_ied_proxArray = [3,5,10,15,20,25,30,35,45,50];
MCC_ied_targetArray = [west, east, resistance, civilian];
MCC_IEDDisarmTimeArray = [10, 20, 30, 40, 50, 60, 120, 180, 240, 300];
MCC_IEDCount = 0;
MCC_IEDLineCount = 0;
MCC_IEDisSpotter = 0;
MCC_ambushPlacing = false;
MCC_natureIsRuning = false;
MCC_drawGunIsRuning =  false; 
MCC_drawMinefield = false; 

MCC_deleteTypes = ["Man", "Car", "Tank", "Helicopter", "Plane", "ReammoBox", "All"];

MCC_trapvolume = [];
MCC_selectedUnits = [];

MCC_convoyCar1Index = 0;
MCC_convoyCar2Index = 0;
MCC_convoyCar3Index = 0;
MCC_convoyCar4Index = 0;
MCC_convoyCar5Index = 0;
MCC_convoyHVTIndex = 0;
MCC_convoyHVTCarIndex = 0;

MCC_mccFunctionDone = true; //define function is runing. 
MCC_lastSpawn = []; //For Undo.

/*
MCC_uavSiteArray = [["Console's UAV",0],["Console's predator UAV",1],["Console's AC-130",2]];
MCC_uavConsoleUp = false; 
MCC_uavConsoleUAVFirstTime = true; 
MCC_ConsoleUAVMouseButtonDown = false;
MCC_ConsoleUAVCameraMod = 0;
MCC_ConsoleUAVmissilesArmed = false; 
MCC_ConsoleUAVmissiles = 0; 
MCC_ConsoleUAVvision = "VIDEO"; 

MCC_ACConsoleUp = false;
MCC_ConsoleACvision = "VIDEO"; 
MCC_ConsoleACCameraMod = 0;
MCC_uavConsoleACFirstTime = true;
MCC_ConsoleACweaponSelected = 0;
MCC_ConsoleACMouseButtonDown  = false;
MCC_consoleACgunReady1 = true;
MCC_consoleACgunReady2 = true;
MCC_consoleACgunReady3 = true;
MCC_consoleACmousebuttonUp = true; 
*/

MCC_airDropArray = []; 
MCC_CASBombs = ["Gun-run short","Gun-run long","S&D","Rockets-run","AT run","AA run"];
MCC_GunRunBusy = [0,0,0,0,0,0,0];
MCC_CASrequestMarker = false;
MCC_CASConsoleArray	= []; 
MCC_CASConsoleFirstTime = true; 
MCC_ConsoleAirdropArray	= []; 

MCC_evacFlyInHight_array = [["50m",50],["100m",100],["150m",150],["200m",200],["300m",300],["400m",400],["500m",500]];
MCC_evacFlyInHight_index = 1;
MCC_evacVehicles = [];
MCC_evacVehicles_index = 0;

//MCC_townCount = 0; //Obsolete?
MCCFirstOpenUI= true;

MCC_UMunitsNames = [];
MCC_UMstatus = 0;
MCC_UMUnit = 0;
MCC_gearDialogClassIndex = 0;
MCC_UMParadropRequestMarker = false; 
MCC_UMPIPView = 0;
MCC_isBroadcasting = false;
MCC_UMisJoining = false;

MCC_align3D 		= false; //Align to surface in 3D editor? 
MCC_smooth3D		= false; //Smooth placing
MCC_align3DText 	= "Enabled";
MCC_smooth3DText	= "Disabled";
MCC_clientFPS 	= 0;
MCC_serverFPS 	= 0;
MCC_hcFPS		= 0;

mcc_loginmissionmaker	= false; 
mcc_active_zone 		= 1; 

MCC_groupFormation	= ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];	//Group formations
MCC_planeNameCount	= 0;

//Mission Settings Index
HW_arti_number_shells_per_hourIndex		= 0;
MCC_underCoverDetectIndex				= 0;
MCC_resistanceHostileIndex				= 0;
MCC_aiSkillIndex						= 5;
MCC_aceReviveIndex						= 0;
MCC_aceReviveTimeIndex					= 0;
MCC_spectatorIndex						= 0;
MCC_t2tIndex							= 1;

MCC_groupGenCurrenGroupArray = []; 
MCC_groupGenGroupArray = []; 
MCC_groupGenGroupStatus = 0; 		//0 - west, 1 - east, 2- guer, 3 - civilian
MCC_groupGenGroupcount = 0; 		//group spawned
MCC_groupGenGroupselectedIndex = 0;
MCC_groupGenTempWP = [];
MCC_groupGenTempWPLines = [];

//Bon artillery
//MCC_bonCannons = []; 
//====================================================================================MCC Engine Init============================================================================================================================
// Disable Respawn & Organise start on death location 
_null=[] execVM MCC_path + "mcc\general_scripts\mcc_player_disableRespawn.sqf";

// Initialize and load the pop up menu
_null=[] execVM MCC_path + "mcc\pop_menu\mcc_init_menu.sqf";

//Initialize UPSMON script
_null=[] execVM MCC_path + "scripts\Init_UPSMON.sqf";

mcc_spawntype   		= "";
mcc_classtype   		= "";
mcc_isnewzone   		= false;
mcc_spawnwithcrew 		= true;
mcc_spawnname     		= "";
mcc_spawnfaction  		= "";
mcc_spawndisplayname    = "";
mcc_zoneinform    		= "NOTHING";
mcc_zone_number			= 1; 		
mcc_zone_markername 	= "1"; 	
mcc_zone_markposition   = []; 	
mcc_markerposition      = [];	
mcc_zone_marker_X   	= 200;		
mcc_zone_marker_Y		= 200;		
mcc_spawnbehavior       = "MOVE";	
mcc_awareness			= "DEFAULT";
mcc_zone_pos  		= 	[];
mcc_zone_size 		= 	[];
mcc_zone_types		= 	[];
mcc_zone_locations	= 	[];
mcc_grouptype			= "";
mcc_track_units			= false;
mcc_safe				= "";
mcc_load				= "";
mcc_isloading			= false;
mcc_request				= 0;
mcc_resetmissionmaker	= false;
mcc_missionmaker		= "";
mcc_firstTime			= true; //First time runing?

// Objects
U_AMMO					= [];
U_ACE_AMMO				= [];
U_FORT 					= [];
U_DEAD_BODIES 			= [];
U_FURNITURE 			= [];
U_MARKET				= [];
U_MISC					= [];
U_SIGHNS				= [];
U_WARFARE				= [];
U_WRECKS				= [];
U_HOUSES				= [];
U_RUINS					= [];
U_GARBAGE				= [];
U_LAMPS					= [];
U_CONTAINER				= [];
U_SMALL_ITEMS			= [];
U_STRUCTERS				= [];
U_HELPERS				= [];
U_TRAINING				= [];
U_MINES					= [];

//Weapons
W_AR					= [];
W_BINOS					= [];
W_ITEMS					= [];
W_LAUNCHERS				= [];
W_MG					= [];
W_PISTOLS				= [];
W_RIFLES				= [];
W_SNIPER				= [];
W_RUCKS					= [];
U_MAGAZINES				= [];

_nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_obj.sqf";
//if (ACEIsEnabled) then {
//	_nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_weapons.sqf";
//} else {
	_nul=[] execVM MCC_path + "mcc\pop_menu\mcc_make_array_weaponsNoneAce.sqf";
//};

//Lets create our MCC subject in the diary
_index = player createDiarySubject ["MCCZones","MCC Zones"];

if ( isServer ) then 
{
	//Make sure about who is at war with who or it will be a very peacefull game 
	_SideHQ_East   = createCenter east;
	_SideHQ_Resist = createCenter resistance;
	_SideHQ_west   = createCenter west;

	// East hates west
	east setFriend [west, 0];

	// West hates east
	west setFriend [east, 0];

	//Civilians loves all
	civilian setfriend [east, 0.7];
	civilian setfriend [west, 0.7];
	_dummyGroup = creategroup civilian; 
	_dummy = _dummyGroup createunit ["Logic", [0, 90, 90],[],0.5,"NONE"];	//Logic Server
	_name = "server";
	call compile (_name + " = _dummy");
	publicVariable _name;
	
	//create group for dead players
	MCC_deadGroup = creategroup civilian; 
};


// Handler code for the server for MP purpose
_null=[] execVM MCC_path + "mcc\pv_handling\mcc_pv_handler.sqf";
_null=[] execVM MCC_path + "mcc\pv_handling\mcc_functions.sqf";
_null=[] execVM MCC_path + "mcc\pv_handling\mcc_extras_pv_handler.sqf";

diag_log format ["%1 - MCC Headless Client available: %2", time, MCC_isHC];
diag_log format ["%1 - MCC Local Headless Client: %2", time, MCC_isLocalHC];

//==========================Fire init=======================
finishMissionInit;

//=============================Sync with server when JIP======================
if  !( isDedicated ) then 
{
	waituntil {alive player};
	
	_mcc_owner = owner player;
	
	if ( hasInterface ) then //no HC
	{
		waituntil {!(IsNull (findDisplay 46))};

		sleep 1;
		
		//diag_log "--- running sync on server ---";
		mcc_sync_status = 0; 
		_result = [[player],"MCC_fnc_sync", false, false] call BIS_fnc_MP;
		//diag_log format ["Package '%1'", _result];
		
		_loop = 20; 
		for [{_x=1},{_x<=_loop},{_x=_x+1}]  do //Create progress bar
		{
			_footer = [_x,_loop] call BIS_AdvHints_createCountdownLine;
			//add header
			_html = "<t color='#818960' size='1.2' shadow='0' align='left' underline='true'>" + "Synchronizing with server" + "</t><br/><br/>";
			//add _text
			_html = _html + "<t color='#a9b08e' size='1' shadow='0' shadowColor='#312100' align='left'>" + "Wait a moment, Synchronizing with the server" + "</t>";
			//add _footer
			_html = _html + "<br/><br/><t color='#818960' size='0.85' shadow='0' align='right'>" + _footer + "</t>";
			hintsilent parseText(_html);
			sleep 0.1;
			if !(mcc_sync_status == 1) then {sleep 2}; 
		};
		sleep 1;
		_ok = [] spawn compile MCC_sync;
		Hint "Synchronizing Done";	
			
		//setviewdistance 4000; 
			
		// Teleport to team on Alt + T
		MCC_teleportToTeam = true;
		_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this select 1)==20 && (_this select 4)) then {player execVM '"+MCC_path+"mcc\general_scripts\mcc_SpawnToPosition.sqf';true}"];

		// Add to the action menu
		mcc_actionInedx = player addaction ["> Mission generator", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
			
		//Add MCC Console action menu
////	_null = player addaction ["<t color=""#FFCC00"">Open MCC Console</t>", MCC_path + "mcc\general_scripts\console\conoleOpenMenu.sqf",[0],-1,false,true,"teamSwitch",MCC_consoleString];
			
		//Save gear EH
		if(local player) then {player addEventHandler ["killed",{player execVM MCC_path + "mcc\general_scripts\save_gear.sqf";}];};
	}
	else
	{
		//is HC
		_result = [[player],"MCC_fnc_sync", false, false] call BIS_fnc_MP;
		//diag_log format ["Package '%1'", _result];
	};
	
	diag_log format ["mcc_sync_status = %1", mcc_sync_status]; 
	if (mcc_sync_status == 0) then 
	{
		//if == 1 then server synch failed for some reason
		hint "ERROR: failed synching with Server"; 
	};
};

MCC_initDone = true; 

//END OF MCC
