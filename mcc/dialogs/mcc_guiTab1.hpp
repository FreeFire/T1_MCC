////////////////////////////////////////////////////////
// BY Shay Gman 03.2013
////////////////////////////////////////////////////////

#define MCC_SANDBOX_IDD 1000
#define MCC_SANDBOX2_IDD 2000
#define MCC_SANDBOX3_IDD 3000
#define MCC_SANDBOX4_IDD 4000

#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054

#define FACTIONCOMBO 1001
#define SPAWNTYPE 1002
#define SPAWNBRANCH 1003
#define SPAWNCLASS 1004
#define SPAWNBEHAVIOR 1005
#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007
#define MCCWEATHER 1008
#define MCCFOG 1009
#define TSMONTH 1010
#define TSDAY 1011
#define TSHOUR 1012
#define TSMINUTE 1013
#define MCCSTOPCAPTURE 1014
#define MCCSTARTWEST 1015
#define MCCSTARTEAST 1016
#define MCCSTARTGUAR 1017
#define MCCSTARTCIV 1018
#define MCCDISABLERESPAWN 1019
#define MCCMISSIONMAKERNAME 1020
#define MCCCLIENTFPS 1021
#define MCCSERVERFPS 1022
#define MCCHCFPS 1027
#define MCCZONENUMBER 1023
#define SPAWNEMPTY 1024
#define SPAWNAWARNESS 1025
#define MCC_ZONE_LOC 1026
#define MCCCHANGEWEATHER 1027
#define MCCLOGO 1028

class MCC_Sandbox {
	  idd = MCC_SANDBOX_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_gui_init1.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_Title,
	  MCC_logo
	  };
	  

	  //---------------------------------------------
	  objects[] = 
	  { 
	  };
	  
	  controls[] = 
	  {
	  MCC_map,
	  MCC_Menu1,
	  MCC_Menu2,
	  MCC_Menu3,
	  MCC_Menu4,
	  MCC_Menu5,
	  MCC_factioTittle,
	  MCC_factionCombo,
	  MCC_ghostMode,
	  MCC_Teleport,
	  MCC_Spectator,
	  MCC_spawnType,
	  MCC_spawnBranch,
	  MCC_spawnClass,
	  MCC_spawnTypeTittle,
	  MCC_spawnBranchTittle,
	  MCC_spawnClassTittle,
	  MCC_spawnButton,
	  MCC_spawnEmptyTittle,
	  MCC_spawnAwareness,
	  MCC_spawnBehavior,
	  MCC_spawnBehaviorTittle,
	  MCC_viewDistanceTittle,
	  MCC_viewDistance,
	  MCC_grassDensityTittle,
	  MCC_FogTittle,
	  MCC_ChangeWeatherTittle,
	  MCC_grassDensity,
	  MCC_WeatherTittle,
	  MCC_Weather,
	  MCC_Fog,
	  MCC_ChangeWeather,
	  MCC_TSMonthTittle,
	  MCC_TSDayTittle,
	  MCC_TSHourTittle,
	  MCC_TSMinuteTittle,
	  MCC_TSMonth,
	  MCC_TSDay,
	  MCC_TSHour,
	  MCC_TSMinute,
	  MCC_TSSetButton,
	  MCC_stopCapture,
	  MCC_MissionSettings,
	  MCC_groupGenerator,
	  MCC_boxGenerator,
	  MCC_3DEditor,
	  MCC_StartWest,
	  MCC_StartEast,
	  MCC_StartGuar,
	  MCC_StartCiv,
	  MCC_StartDisableRespawn,
	  MCC_StartLocationsTittle,
	  MCC_CSSettings,
	  MCC_EnvironmentTittle,
	  MCC_MissionMakerTittle,
	  MCC_MissionMakerName,
	  MCC_clientFPSTittle,
	  MCC_ServerFPSTittle,
	  MCC_clientFPS,
	  MCC_ServerFPS,
	  MCC_HcFPSTittle,
	  MCC_HcFPS,
	  MCC_BenchmarkTittle,
	  MCC_zoneTittle,
	  MCC_zone,
	  MCC_zoneUpdate,
	  MCC_saveLoad,
	  MCC_login,
	  MCC_Close,
	  MCC_spawnEmpty,
	  MCC_spawnAwarenessTittle,
	  MCC_zoneLocTittle,
	  MCC_zoneLoc
	  
	   };

class MCC_logo: MCC_RscPicture	
{
	idc = -1;text = __EVAL(MCCPATH +"mcc\pop_menu\mcc1.paa");
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.1600 * safezoneH + safezoneY;
	w = 0.1500 * safezoneW;
	h = 0.2000 * safezoneH;
};
class MCC_Title: MCC_RscText	
{
	idc = -1;
	text = __EVAL ("MCC Sandbox V"+MCCVersion+" By shay_gman, Spirit & Ollem");
	x = 0.185546 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.161476 * safezoneW;
	h = 0.0340016 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.52)";
};
class MCC_map: MCC_RscMapControl 
{
	idc = -1; moving = true;
 	text = "";	
	x = 0.4230 * safezoneW + safezoneX;
	y = 0.4610 * safezoneH + safezoneY;
	w = 0.4000 * safezoneW;
	h = 0.4340 * safezoneH;
	onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseDown.sqf'");
	onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseUp.sqf'");
	onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseMoving.sqf'");
};
class MCC_Menu1: MCC_RscButtonMenu
{
	idc = MAIN;
	text = "Main";
	x = 0.355521 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_Menu2: MCC_RscButtonMenu	
{	
	idc = MENU2;
	text = "Menu 2";
	x = 0.449008 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
};
class MCC_Menu3: MCC_RscButtonMenu
{
	idc = MENU3;
	text = "Menu 3";
	x = 0.542494 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
};
class MCC_Menu4: MCC_RscButtonMenu
{
	idc = MENU4;
	text = "Menu 4";
	x = 0.63598 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\dialogs\mcc_PopupMenu2.sqf'");
};
class MCC_Menu5: MCC_RscButtonMenu
{
	idc = MENU5;
	text = "Menu 5";
	x = 0.729466 * safezoneW + safezoneX;
	y = 0.108982 * safezoneH + safezoneY;
	w = 0.0849875 * safezoneW;
	h = 0.0510023 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_Spectator: MCC_RscButton
{
	idc = -1;
	text = "Spectator";
	x = 0.5400 * safezoneW + safezoneX;
	y = 0.181 * safezoneH + safezoneY;
	w = 0.07500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Start spectator mode for the misésion maker - press numpad-0 to return to player"; 
	//onButtonClick = "	if (mcc_missionmaker == (name player)) then { closeDialog 0;nul = [] execVM 'camera.sqf'; } else { player globalchat 'Access Denied'; }; ";
	onButtonClick = "	if (mcc_missionmaker == (name player)) then { closeDialog 0;nul = [] exec 'camera.sqs'; } else { player globalchat 'Access Denied'; }; ";
	//onButtonClick = "	if (mcc_missionmaker == (name player)) then { closeDialog 0;nul = [] execVM 'spect\specta.sqf'; } else { player globalchat 'Access Denied'; }; ";
};
class MCC_ghostMode: MCC_RscButton 
{
	idc = -1;
	text = "Ghost Mode"; 
	x = 0.6400 * safezoneW + safezoneX;
	y = 0.181 * safezoneH + safezoneY;
	w = 0.0750 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Make the mission maker invisible to enemies"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then{if (captive player) then {player setcaptive false; [-2, {hint 'Mission maker is no longer cheating'}] call CBA_fnc_globalExecute;} else {player setcaptive true; [-2, {hint 'Mission maker is cheating'}] call CBA_fnc_globalExecute;}} else {player globalchat 'Access Denied'};";
};
class MCC_Teleport: MCC_RscButton 
{
	idc = -1;
	text = "Teleport"; 
	x = 0.7400 * safezoneW + safezoneX;
	y = 0.181 * safezoneH + safezoneY;
	w = 0.0750 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Teleport the mission maker and any vehicle he is in to a new location"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then {hint 'Click on the map';onMapSingleClick 'vehicle player setPos _pos;onMapSingleClick '''';true;'} else {player globalchat 'Access Denied'};";
};

class MCC_MissionMakerTittle: MCC_RscText 
{
	idc = -1; text = "Mission Maker:"; 
	x = 0.3420 * safezoneW + safezoneX;
	y = 0.1800 * safezoneH + safezoneY;
	w = 0.1400 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_MissionMakerName: MCC_RscText 
{
	idc = MCCMISSIONMAKERNAME;	
	x = 0.400 * safezoneW + safezoneX;
	y = 0.1800 * safezoneH + safezoneY;
	w = 0.1400 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};

class MCC_factionCombo: MCC_RscCombo 
{
	idc = FACTIONCOMBO;
	x = 0.3420 * safezoneW + safezoneX;
	y = 0.2460 * safezoneH + safezoneY;
	w = 0.1200 * safezoneW;
	h = 0.0300 * safezoneH;
	onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
};
class MCC_spawnType: MCC_RscCombo 
{
	idc = SPAWNTYPE;
	x = 0.4710 * safezoneW + safezoneX;
	y = 0.2460 * safezoneH + safezoneY;
	w = 0.0680 * safezoneW;
	h = 0.0300 * safezoneH;
	onLBSelChanged = __EVAL("[1] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
};
class MCC_spawnBranch: MCC_RscCombo 
{
	idc = SPAWNBRANCH;
	x = 0.5530 * safezoneW + safezoneX;
	y = 0.2460 * safezoneH + safezoneY;
	w = 0.0990 * safezoneW;
	h = 0.0300 * safezoneH;
	onLBSelChanged = __EVAL("[2] execVM '"+MCCPATH+"mcc\pop_menu\mcc_guiTab1Change.sqf'");
};
class MCC_spawnClass: MCC_RscCombo 
{
	idc = SPAWNCLASS;
	x = 0.6640 * safezoneW + safezoneX;
	y = 0.2460 * safezoneH + safezoneY;
	w = 0.1500 * safezoneW;
	h = 0.0300 * safezoneH;
};
class MCC_factioTittle: MCC_RscText	{
	idc = -1;text = "Faction:";
	x = 0.3420 * safezoneW + safezoneX;
	y = 0.2150 * safezoneH + safezoneY;
	w = 0.0650 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnTypeTittle: MCC_RscText 
{
	idc = -1;text = "Type:";
	x = 0.4700 * safezoneW + safezoneX;
	y = 0.2150 * safezoneH + safezoneY;
	w = 0.0650 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnBranchTittle: MCC_RscText 
{
	idc = -1;text = "Branch:";
	x = 0.5530 * safezoneW + safezoneX;
	y = 0.2150 * safezoneH + safezoneY;
	w = 0.0650 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnClassTittle: MCC_RscText 
{
	idc = -1;text = "Class:";
	x = 0.6640 * safezoneW + safezoneX;
	y = 0.2150 * safezoneH + safezoneY;
	w = 0.0650 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnButton: MCC_RscButton 
{
	idc = -1;	text = "Spawn";
	x = 0.4600 * safezoneW + safezoneX;
	y = 0.3300 * safezoneH + safezoneY;
	w = 0.0810 * safezoneW;
	h = 0.0510 * safezoneH;
	onButtonClick = __EVAL("[false] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group.sqf'");
};
class MCC_spawnEmptyTittle: MCC_RscText 
{
	idc = -1;	text = "Empty:";
	x = 0.5600 * safezoneW + safezoneX;
	y = 0.4000 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnEmpty: MCC_RscCombo 
{
	idc = SPAWNEMPTY;
	x = 0.6200 * safezoneW + safezoneX;
	y = 0.4000 * safezoneH + safezoneY;
	w = 0.0975 * safezoneW;
	h = 0.0300 * safezoneH;
};
class MCC_spawnAwarenessTittle: MCC_RscText 
{
	idc = -1; text = "Awareness:"; 
	x = 0.5600 * safezoneW + safezoneX;
	y = 0.3500 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnAwareness: MCC_RscCombo 
{
	idc = SPAWNAWARNESS;	
	x = 0.6200 * safezoneW + safezoneX;
	y = 0.3500 * safezoneH + safezoneY;
	w = 0.0975 * safezoneW;
	h = 0.0300 * safezoneH;
};
class MCC_spawnBehaviorTittle: MCC_RscText 
{
	idc = -1; text = "Behavior:";
	x = 0.5600 * safezoneW + safezoneX;
	y = 0.3000 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_spawnBehavior: MCC_RscCombo 
{
	idc = SPAWNBEHAVIOR;
	x = 0.6200 * safezoneW + safezoneX;
	y = 0.3000 * safezoneH + safezoneY;
	w = 0.0975 * safezoneW;
	h = 0.0300 * safezoneH;
};
class MCC_viewDistanceTittle: MCC_RscText 
{
	idc = -1; text = "View:"; 
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.4580 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_grassDensityTittle: MCC_RscText 
{
	idc = -1; text = "Grass:"; 
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.4900 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};

class MCC_viewDistance: MCC_RscCombo 
{
	idc = MCCVIEWDISTANCE; 
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.4580 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged =  __EVAL("[2] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};
class MCC_grassDensity: MCC_RscCombo 
{
	idc = MCCGRASSDENSITY;
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.4900 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged =  __EVAL("[1] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};
class MCC_ChangeWeatherTittle: MCC_RscText 
{
	idc = -1;	text = "Change:";
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.5580 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_FogTittle: MCC_RscText 
{
	idc = -1;	text = "Fog:";
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.5900 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_WeatherTittle: MCC_RscText 
{
	idc = -1;	text = "Weather:"; 
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.6230 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSMonthTittle: MCC_RscText 
{	
	idc = -1;	text = "Month:";
	x = 0.185 * safezoneW + safezoneX;
	y = 0.6660 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSDayTittle: MCC_RscText 
{
	idc = -1; text = "Day:";
	x = 0.18500 * safezoneW + safezoneX;
	y = 0.6990 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSHourTittle: MCC_RscText 
{
	idc = -1; text = "Hour:";
	x = 0.18500 * safezoneW + safezoneX;
	y = 0.7320 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSMinuteTittle: MCC_RscText 
{
	idc = -1; text = "Minute:";
	x = 0.18500 * safezoneW + safezoneX;
	y = 0.7650 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_ChangeWeather: MCC_RscCombo 
{
	idc = MCCCHANGEWEATHER;
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.5620 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_Fog: MCC_RscCombo 
{
	idc = MCCFOG;
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.5950 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_Weather: MCC_RscCombo 
{
	idc = MCCWEATHER;
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.6280 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
};
class MCC_TSMonth: MCC_RscCombo 
{
	idc = TSMONTH;	
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.6660 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSDay: MCC_RscCombo 
{
	idc = TSDAY;	
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.6990 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSHour: MCC_RscCombo 
{
	idc = TSHOUR;
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.7320 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSMinute: MCC_RscCombo 
{
	idc = TSMINUTE;
	x = 0.2400 * safezoneW + safezoneX;
	y = 0.7650 * safezoneH + safezoneY;
	w = 0.06500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_TSSetButton: MCC_RscButton 
{
	idc = -1;	text = "Set"; 
	x = 0.18500 * safezoneW + safezoneX;
	y = 0.7990 * safezoneH + safezoneY;
	w = 0.1200 * safezoneW;
	h = 0.0300 * safezoneH;
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
};
class MCC_stopCapture: MCC_RscButton 
{
	idc = MCCSTOPCAPTURE;	text = "Stop Capturing"; 
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.3850 * safezoneH + safezoneY;
	w = 0.0650 * safezoneW;
	h = 0.0300 * safezoneH;
	onButtonClick = "ctrlEnable [1014,false];MCC_capture_state=false;";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_MissionSettings: MCC_RscButton 
{
	idc = -1;	text = "Mission Settings";
	x = 0.2550 * safezoneW + safezoneX;
	y = 0.3850 * safezoneH + safezoneY;
	w = 0.0650 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onMouseEnter = __EVAL("[] execVM '"+MCCPATH+"mcc\Pop_menu\mcc_gui.sqf'");
};
class MCC_groupGenerator: MCC_RscButton 
{
	idc = -1;	text = "Group Generator"; 
	x = 0.7300 * safezoneW + safezoneX;
	y = 0.400 * safezoneH + safezoneY;
	w = 0.08500 * safezoneW;
	h = 0.0300 * safezoneH;
	tooltip = "Open Group Generator"; 
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'mcc_groupGen';} else {player globalchat 'Access Denied'};";
};

class MCC_3DEditor: MCC_RscButton 
{
	idc = -1; text = "3D Editor"; 
	x = 0.7300 * safezoneW + safezoneX;
	y = 0.350 * safezoneH + safezoneY;
	w = 0.08500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open 3D editor"; 
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
};
class MCC_boxGenerator: MCC_RscButton 
{
	idc = -1;	text = "Box Genrator";
	x = 0.7300 * safezoneW + safezoneX;
	y = 0.300 * safezoneH + safezoneY;
	w = 0.08500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open Box Generator"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'boxGen';} else {player globalchat 'Access Denied'};";
};
class MCC_StartLocationsTittle: MCC_RscText 
{
	idc = -1; text = "Start Locations:"; 
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.4950 * safezoneH + safezoneY;
	w = 0.1400 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_StartWest: MCC_RscButton 
{
	idc = MCCSTARTWEST;	text = "Blue"; 	
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.5300 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {0,0,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set west start location"; 
	action = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartEast: MCC_RscButton 
{
	idc = MCCSTARTEAST;	text = "Red";
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.5620 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {1,0,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set east start location"; 
	action = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartGuar: MCC_RscButton 
{
	idc = MCCSTARTGUAR; text = "Green";	
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.5950 * safezoneH + safezoneY;		
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {0,1,0,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set GUAR start location"; 
	action = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartCiv: MCC_RscButton 
{
	idc = MCCSTARTCIV; text = "Civ"; 
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.6280 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Set civilans start location"; 
	action = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_StartDisableRespawn: MCC_RscButton 
{
	idc = MCCDISABLERESPAWN; text = "Disable Respawn";
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.6660 * safezoneH + safezoneY;
	w = 0.0650 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	action = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
};
class MCC_CSSettings: MCC_RscText 
{
	idc = -1; text = "Client Side Settings:"; 
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.4280 * safezoneH + safezoneY;
	w = 0.1400 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_EnvironmentTittle: MCC_RscText 
{
	idc = -1;	text = "Environment Settings:"; 
	x = 0.1850 * safezoneW + safezoneX;
	y = 0.5250 * safezoneH + safezoneY;
	w = 0.1400 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_BenchmarkTittle: MCC_RscText 
{
	idc = -1; text = "System Info:"; 
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.7100 * safezoneH + safezoneY;
	w = 0.0700 * safezoneW;
	h = 0.0300 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_clientFPSTittle: MCC_RscText 
{
	idc = -1;
	text = "Client FPS:";
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.7420 * safezoneH + safezoneY;
	w = 0.0600 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_ServerFPSTittle: MCC_RscText 
{
	idc = -1;	
	text = "Server FPS:"; 
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.7740 * safezoneH + safezoneY;
	w = 0.0600 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_HcFPSTittle: MCC_RscText
{
	idc = -1;
	text = "HC FPS:";
	x = 0.3300 * safezoneW + safezoneX;
	y = 0.8060 * safezoneH + safezoneY;
	w = 0.0600 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_clientFPS: MCC_RscText 
{
	idc = MCCCLIENTFPS; 
	x = 0.3800 * safezoneW + safezoneX;
	y = 0.7420 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_ServerFPS: MCC_RscText 
{
	idc = MCCSERVERFPS;
	x = 0.3800 * safezoneW + safezoneX;
	y = 0.7750 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_HcFPS: MCC_RscText
{
	idc = MCCHCFPS;
	x = 0.3800 * safezoneW + safezoneX;
	y = 0.8080 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_zoneTittle: MCC_RscText 
{
	idc = -1;	text = "Zone:";
	x = 0.3420 * safezoneW + safezoneX;
	y = 0.3000 * safezoneH + safezoneY;
	w = 0.0400 * safezoneW;
	h = 0.0300 * safezoneH;
};
class MCC_zone: MCC_RscCombo 
{
	idc = MCCZONENUMBER;	
	x = 0.3900 * safezoneW + safezoneX;
	y = 0.3000 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");
};
class MCC_zoneLocTittle: MCC_RscText 
{
	idc = -1;	text = "Location:"; 	
	x = 0.3420 * safezoneW + safezoneX;
	y = 0.3370 * safezoneH + safezoneY;	
	w = 0.0600 * safezoneW;
	h = 0.0300 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_zoneLoc: MCC_RscCombo 
{
	idc = MCC_ZONE_LOC;	
	x = 0.3900 * safezoneW + safezoneX;
	y = 0.3370 * safezoneH + safezoneY;
	w = 0.0500 * safezoneW;
	h = 0.0300 * safezoneH;
};
class MCC_zoneUpdate: MCC_RscButton 
{
	idc = -1;	text = "Update Zone"; 
	x = 0.3420 * safezoneW + safezoneX;
	y = 0.3900 * safezoneH + safezoneY;
	w = 0.0950 * safezoneW;
	h = 0.0400 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
	tooltip = "Click and drag on the minimap to make a zone"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then {MCC_zone_drawing= true;} else {player globalchat 'Access Denied'};";
};


class MCC_login: MCC_RscButtonMenu 
{
	idc = -1; text = "Login/Logout"; 
	x = 0.185 * safezoneW + safezoneX;
	y = 0.852 * safezoneH + safezoneY;
	w = 0.070 * safezoneW;
	h = 0.044 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Login or logout as the mission maker"; 
	onButtonClick = __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_login.sqf'");
};
class MCC_Close: MCC_RscButtonMenu 
{
	idc = -1; text = "Close"; 
	x = 0.260 * safezoneW + safezoneX;
	y = 0.852 * safezoneH + safezoneY;
	w = 0.070 * safezoneW;
	h = 0.044 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "closeDialog 0";
};
class MCC_saveLoad: MCC_RscButtonMenu 
{
	idc = -1; text = "Save/Load"; 
	x = 0.335 * safezoneW + safezoneX;
	y = 0.852 * safezoneH + safezoneY;
	w = 0.070 * safezoneW;
	h = 0.044 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'MCC_SaveLoadScreen';} else {player globalchat 'Access Denied'};";
};

class MCC_background: MCC_RscText 
{
	idc = -1; text = "";
	x = 0.168549 * safezoneW + safezoneX;
	y = 0.0919812 * safezoneH + safezoneY;
	w = 0.662902 * safezoneW;
	h = 0.816037 * safezoneH;
	colorBackground[] = {0,0,0,0.8};
};
class MCC_pic: MCC_RscPicture 
{
	idc = MCCLOGO; text = __EVAL(MCCPATH +"mcc\dialogs\mcc_background.paa");
	x = 0.1 * safezoneW + safezoneX;
	y = 0.005 * safezoneH + safezoneY;
	w = 0.8 * safezoneW;
	h = 1.01 * safezoneH;
};

};