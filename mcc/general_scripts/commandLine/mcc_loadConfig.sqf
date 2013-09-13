#define MCC_SaveLoadScreen_IDD 7000

#define MCC_LOAD_INPUT 7001
disableSerialization;
private ["_type", "_string", "_command", "_mccdialog"];

if (mcc_missionmaker == (name player)) then {
	_type = _this select 0;
	_mccdialog = findDisplay MCC_SaveLoadScreen_IDD;
	_string = "";

	switch (_type) do
	{
		case 0:	//Load MCC Mission config code
		{ 		
			_string = ctrlText MCC_LOAD_INPUT;
			if !(_string == "" ) then 
			{
				sleep 0.5;
				//MCC_mcc_screen=0;
				closeDialog 0;
				//[] execVM '\mcc_sandbox_mod\mcc\dialogs\mcc_PopupMenu.sqf';

				sleep 0.3;
				_command = 'mcc_isloading=true;closedialog 0;titleText ["Loading Mission","BLACK FADED",5];' + _string + 'mcc_isloading=false;titleText ["Mission Loaded","BLACK IN",5];'; 
				[] spawn compile _command;
			}
			else 
			{
				player globalchat "ERROR: No MCC Mission configuration pasted from clipboard!";
			};
		};
		
		case 1: //Save MCC Mission config code to Clipboard
		{
			copyToClipboard mcc_safe;
			
			player globalchat "Saved MCC Mission configuration to Clipboard. Save config code for later re-use!";
			player globalchat "To rebuild mission copy to clipboard (ctrl-c), paste in load frame (crtl-v), and press load";
			
			ctrlSetText [MCC_LOAD_INPUT, _string];
		};
		
		// Case 2 DOESN'T FULLY WORK BECAUSE OF LIMITED CHARACTER BUFFER FOR DIAG_LOG COMMAND
		/*
		case 2:	//Save MCC Mission config code 
		{
			copyToClipboard mcc_safe;
			diag_log format ["
	================ MCC Mission save START =============================

	%1

	================ MCC Mission save END =============================
	", mcc_safe];

			player globalchat "Saved MCC Mission configuration to ArmA2oa.rpt logfile and Clipboard!";
			player globalchat "To rebuild your mission copy config to clipboard (ctrl-c), paste in load frame (crtl-v), and press load";
			
			ctrlSetText [MCC_LOAD_INPUT, _string];
		};
		*/	
	};
} else {player globalchat "Access Denied";}