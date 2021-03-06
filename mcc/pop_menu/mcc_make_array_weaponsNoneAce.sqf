private 
["_CfgWeapons", "_type",  "_i",  "_CfgWeapon", "_weaponDisplayName","_cfgclass","_picture", "_bino_index", "_item_index",
	"_launchers_index","_mg_index","_pistol_index", "_rifle_index", "_ammo_index"];

_launchers_index = 0;
_mg_index = 0;
_pistol_index = 0;
_rifle_index = 0;
_bino_index = 0;
_item_index = 0;
_ammo_index = 0;

_CfgWeapons 		= configFile >> "CfgWeapons" ;
for "_i" from 1 to (count _CfgWeapons - 1) do
	{
	_CfgWeapon = _CfgWeapons select _i;
	_weaponDisplayName 	= getText(_CfgWeapon >> "displayname");
	_cfgclass 			= (configName (_CfgWeapon));  
	_picture			= getText(_CfgWeapon >> "picture");
	_type				= getNumber(_CfgWeapon >> "type");
	if (isClass _CfgWeapon && !(_picture=="")) then 
		{
		if (_type == 1) then	//Rifle
			{  
				W_RIFLES set[_rifle_index,[_cfgclass,_weaponDisplayName,_picture]];
				_rifle_index = _rifle_index + 1;
			};
		
		if (_type == 2) then	//Pistols
			{
				W_PISTOLS set[_pistol_index,[_cfgclass,_weaponDisplayName,_picture]];
				_pistol_index = _pistol_index + 1;
			};
		
		if (_type == 5) then	//MG
			{
				W_MG set[_mg_index,[_cfgclass,_weaponDisplayName,_picture]];
				_mg_index = _mg_index + 1;
			};
			
		if (_type == 4) then	//Launchers
			{
				W_LAUNCHERS set[_launchers_index,[_cfgclass,_weaponDisplayName,_picture]];
				_launchers_index = _launchers_index + 1;
			};
		
		if (_type == 131072) then	//Item
			{
				W_ITEMS set[_item_index,[_cfgclass,_weaponDisplayName,_picture]];
				_item_index = _item_index + 1;
			};	
			
		if (_type == 4096) then	//binos
			{
				W_BINOS set[_bino_index,[_cfgclass,_weaponDisplayName,_picture]];
				_bino_index = _bino_index + 1;
			};
		};
	};
	
_CfgWeapons 	= configFile >> "CfgMagazines" ;
for "_i" from 1 to (count _CfgWeapons - 1) do
	{
	_CfgWeapon = _CfgWeapons select _i;
	_weaponDisplayName 	= getText(_CfgWeapon >> "displayname");
	_cfgclass 			= (configName (_CfgWeapon));  
	_picture			= getText(_CfgWeapon >> "picture");
	if (isClass _CfgWeapon && !(_picture=="")) then 
		{	
		U_MAGAZINES set[_ammo_index,[_cfgclass,_weaponDisplayName,_picture]];
		_ammo_index = _ammo_index + 1;
		};
	};