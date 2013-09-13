#define MCC_SANDBOX2_IDD 2000

#define AIRDROP_CLASS 5508
#define AIRDROP_TYPE 5509 

#define MCC_CASPLANETYPE 2002
#define MCC_CASTYPE 2003

disableSerialization;
private ["_type","_dlg"];
_type = _this select 0;
_dlg = findDisplay MCC_SANDBOX2_IDD;

switch (_type) do
	{
	   case 0:		//AirDrop Car
		{
			MCC_spawnkind = [MCC_airDropArray];
			MCC_planeType = ["C130J_US_EP1"];
		};
		
	    case 1:		//CAS 
		{
			MCC_spawnkind	= [MCC_CASBombs select (lbCurSel MCC_CASTYPE)];
			MCC_planeType	= [(MCC_CASPlanes select (lbCurSel MCC_CASPLANETYPE)) select 1];
		};
		
		 case 2:	//CAS Add		
		{
			MCC_spawnkind		= [MCC_CASBombs select (lbCurSel MCC_CASTYPE)];
			MCC_planeType		= [(MCC_CASPlanes select (lbCurSel MCC_CASPLANETYPE)) select 1];
			if (MCC_capture_state) then	{
				MCC_capture_var = MCC_capture_var + FORMAT ['MCC_CASConsoleArray set [count MCC_CASConsoleArray,[%1, %2]];
					publicVariable "MCC_CASConsoleArray";
					[[2,{["CommunicationMenuItemAdded",["%4 CAS available","%3data\ammo_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					'
					,MCC_spawnkind
					,MCC_planeType
					,MCC_path
					,MCC_spawnkind select 0
					];
				} else {
					mcc_safe = mcc_safe + FORMAT ['MCC_CASConsoleArray set [count MCC_CASConsoleArray,[%1, %2]];
					publicVariable "MCC_CASConsoleArray";'
					,MCC_spawnkind
					,MCC_planeType
					];
					MCC_CASConsoleArray set [count MCC_CASConsoleArray,[MCC_spawnkind, MCC_planeType]]; 
					publicVariable "MCC_CASConsoleArray"; 
					[[2,compile format ['["CommunicationMenuItemAdded",["%1 CAS available","%2data\ammo_icon.paa",""]] call bis_fnc_showNotification;',MCC_spawnkind select 0,MCC_path]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					};
		};
		
		 case 3:	//Airdrop Add		
		{
			MCC_spawnkind		= [MCC_airDropArray];
			MCC_planeType		= ["C130J_US_EP1"];
			if (MCC_capture_state) then	{
				MCC_capture_var = MCC_capture_var + FORMAT ['MCC_ConsoleAirdropArray set [count MCC_ConsoleAirdropArray,[%1, %2]];
					publicVariable "MCC_ConsoleAirdropArray";'
					,MCC_spawnkind
					,MCC_planeType
					];
				} else {
					mcc_safe = mcc_safe + FORMAT ['MCC_ConsoleAirdropArray set [count MCC_ConsoleAirdropArray,[%1, %2]];
					publicVariable "MCC_ConsoleAirdropArray";'
					,MCC_spawnkind
					,MCC_planeType
					];
					MCC_ConsoleAirdropArray set [count MCC_ConsoleAirdropArray,[MCC_spawnkind, MCC_planeType]]; 
					publicVariable "MCC_ConsoleAirdropArray"; 
					};
		};
	};

if (_type == 0 || _type == 1) then {
	hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
	MCC_CASrequestMarker = true;
	}; 
	
if (_type == 2) then {
	hint format ["CAS: %1, Plane: %2 Added to player's console",MCC_spawnkind,MCC_planeType];
	//server globalchat format ["%1",MCC_CASConsoleArray];	//debug
	}; 	
	
if (_type == 3) then {
	hint format ["Airdrop: %1, Added to player's console",MCC_spawnkind];
	//server globalchat format ["%1",MCC_ConsoleAirdropArray];	//debug
	};
