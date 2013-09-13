#define MCC_SANDBOX_IDD 1000

#define MCCSTARTWEST 1015
#define MCCSTARTEAST 1016
#define MCCSTARTGUAR 1017
#define MCCSTARTCIV 1018
#define MCCDISABLERESPAWN 1019

private ["_side","_null","_mccdialog","_pos"];

disableSerialization;

_side = _this select 0;

_mccdialog = findDisplay MCC_SANDBOX_IDD;

if (mcc_missionmaker == (name player)) then 
{
	if !mcc_isloading then 
	{
		switch (_side) do
		{
			case 0:	//West
			{ 
				if ( MCC_enable_west ) then 
				{
					hint "click on map where you want your start location"; 
					onMapSingleClick "	
							MCC_START_WEST  = _pos;
							publicVariable ""MCC_START_WEST"";
							onMapSingleClick """";
							mcc_safe=mcc_safe + FORMAT [""
														MCC_START_WEST  = %1;
														publicVariable 'MCC_START_WEST';
														""							  
														,MCC_START_WEST
														];
							hint ""Start WEST location updated.""
						";
					//ctrlEnable [MCCSTARTWEST,false];
					MCC_enable_west=false; 
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlEnable true;
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetText "Respawn Enabled";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetTextColor [0,1,0,1];
				}
				else
				{
					hint "start location has already been set"; 
				};
			};
			
			case 1:	//East
			{ 
				if ( MCC_enable_east ) then 
				{				
					hint "click on map where you want your start location"; 
					onMapSingleClick "	
							MCC_START_EAST  = _pos;
							publicVariable ""MCC_START_EAST"";
							onMapSingleClick """";
							mcc_safe=mcc_safe + FORMAT [""
														MCC_START_EAST  = %1;
														publicVariable 'MCC_START_EAST';
														""							  
														,MCC_START_EAST
														];
							hint ""Start East location updated.""
						";
					//ctrlEnable [MCCSTARTEAST,false];
					MCC_enable_east=false; 
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlEnable true;
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetText "Respawn Enabled";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetTextColor [0,1,0,1];
				}
				else
				{
					hint "start location has already been set"; 
				};
			};
			
			case 2:	//Guer
			{
				if ( MCC_enable_gue ) then 
				{
					hint "click on map where you want your start location"; 
					onMapSingleClick "	
							MCC_START_GUAR  = _pos;
							publicVariable ""MCC_START_GUAR"";
							onMapSingleClick """";
							mcc_safe=mcc_safe + FORMAT [""
														MCC_START_GUAR  = %1;
														publicVariable 'MCC_START_GUAR';
														""							  
														,MCC_START_GUAR
														];
							hint ""Start Guer location updated.""
						";
					//ctrlEnable [MCCSTARTGUAR,false];
					MCC_enable_gue=false; 
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlEnable true;
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetText "Respawn Enabled";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetTextColor [0,1,0,1];
				}
				else
				{
					hint "start location has already been set"; 
				};
			};
			
			case 3:	//Civ
			{
				if ( MCC_enable_civ ) then 
				{
					hint "click on map where you want your start location"; 
					onMapSingleClick "	
							MCC_START_CIV  = _pos;
							publicVariable ""MCC_START_CIV"";
							onMapSingleClick """";
							mcc_safe=mcc_safe + FORMAT [""
														MCC_START_CIV  = %1;
														publicVariable 'MCC_START_CIV';
														""							  
														,MCC_START_CIV
														];
							hint ""Start Guer location updated.""
						";
					//ctrlEnable [MCCSTARTCIV,false];
					MCC_enable_civ=false; 
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlEnable true;
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetText "Respawn Enabled";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetTextColor [0,1,0,1];
				}
				else
				{
					hint "start location has already been set"; 
				};
			};
			
			case 4:	//Disable respawn
			{ 
				if ( MCC_enable_respawn ) then 
				{ 
					MCC_enable_respawn = false;
					hint "respawn is off";
					diag_log "respawn is off";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetText "Respawn Disabled";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetTextColor [1,0,0,1];
				}
				else
				{
					MCC_enable_respawn = true;
					hint "respawn is on";
					diag_log "respawn is on";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetText "Respawn Enabled";
					(_mccdialog displayctrl MCCDISABLERESPAWN) ctrlSetTextColor [0,1,0,1];
				};
				publicVariable "MCC_enable_respawn";
			};
			
			case 5:	//Start on LHD
			{ 
				if (MCCLHDSpawned) then {
					_pos = deck modelToWorld [0,0,0];
					MCC_START_GUAR  = _pos;
					MCC_START_EAST  = _pos;
					MCC_START_WEST  = _pos;
					MCC_START_LHD	= _pos; 
					publicVariable "MCC_START_GUAR";
					publicVariable "MCC_START_WEST";
					publicVariable "MCC_START_EAST";
					publicVariable "MCC_START_LHD";
					mcc_safe=mcc_safe + FORMAT ["
												MCC_START_GUAR  = %1;
												MCC_START_EAST  = %2;
												MCC_START_WEST  = %3;
												publicVariable 'MCC_START_GUAR';
												publicVariable 'MCC_START_WEST';
												publicVariable 'MCC_START_EAST';
												"							  
												,MCC_START_GUAR
												,MCC_START_EAST
												,MCC_START_WEST
												];
					hint "Start location updated.";
					ctrlEnable [START_GUE,false];
					ctrlEnable [START_RED,false];
					ctrlEnable [START_BLUE,false];
					ctrlEnable [START_LHD,false];
					MCC_enable_gue=false; 
					MCC_enable_east=false;
					MCC_enable_west=false; 	
					MCC_enable_LHD=false;						
				} else {hint "Spawn a LHD first"}; 
			};
		};
		//closeDialog 0;
		//_null = [] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf";
	};
} 
else 
{
	player globalchat "Access Denied"
};
		


