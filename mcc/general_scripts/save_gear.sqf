private ["_unit","_goggles","_handgunitems","_primaryWeaponItems", "_headgear","_uniform","_uniformItems","_vest","_magazines",
         "_vestItems","_secondaryWeaponItems","_handgunWeapon","_backpack","_backpackItems","_primaryWeapon","_secondaryWeapon","_null"];

_unit = _this;
_goggles = goggles _unit; 			//Can't  save gear after killed EH
_headgear = headgear _unit; 
_uniform = uniform _unit; 
_vest = vest _unit;
_backpack = backpack _unit;

_primaryWeaponItems = primaryWeaponItems _unit;
_secondaryWeaponItems = secondaryWeaponItems _unit;
_handgunitems = handgunItems _unit; 
_uniformItems = uniformItems _unit;
_vestItems = vestItems _unit;
_backpackItems = backpackItems _unit;

_primaryWeapon = primaryWeapon _unit;
_secondaryWeapon = secondaryWeapon _unit;
_handgunWeapon = handgunWeapon _unit; 
_magazines = magazines _unit;	
_unit removeAction mcc_actionInedx;

WaitUntil {alive player};

removeGoggles player;
removeHeadgear player;
removeUniform player;
removeVest player;

player addGoggles _goggles;
player addHeadgear _headgear;
player addUniform _uniform;
player addVest _vest;
removeBackpack player;
if !( _backpack == "" ) then { player addBackpack _backpack; };

removeAllWeapons player;
removeAllItems player; 

{player additem _x} foreach _uniformItems;
{player additem _x} foreach _vestItems;
{player additem _x} foreach _backpackItems;

player addWeapon _primaryWeapon;
{player addPrimaryWeaponItem _x} foreach _primaryWeaponItems;
player addWeapon _secondaryWeapon;
{player addSecondaryWeaponItem _x} foreach _secondaryWeaponItems;
player addWeapon _handgunWeapon;
{player addHandgunItem _x} foreach _handgunitems;

{player addMagazine _x} forEach _magazines;

player selectWeapon _primaryWeapon;
_muzzles = getArray(configFile>>"cfgWeapons" >> _primaryWeapon >> "muzzles");
player selectWeapon (_muzzles select 0);
mcc_actionInedx = player addaction ["> Mission generator", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
//if !( MCC_Lite ) then { _null = player addaction ["<t color=""#FFCC00"">Open MCC Console</t>", MCC_path + "mcc\general_scripts\console\conoleOpenMenu.sqf",[0],-1,false,true,"teamSwitch",MCC_consoleString]; };
