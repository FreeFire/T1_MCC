// By: Ollem
// Version: 1.0 (February 2013)
#define MCC_SANDBOX_IDD 1000
#define MCC_SaveLoadScreen_IDD 7000

#define MCC_LOAD_INPUT 7001

#define MCCST_CENTER 0x02
#define MCCST_MULTI 16
#define MCCCT_EDIT 2

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_SaveLoadScreen 
{
	idd = MCC_SaveLoadScreen_IDD;
	movingEnable = true;
	onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\MCC_SaveLoadScreenInit.sqf'");

	controlsBackground[] = 
	{
		MCC_SaveLoadBackground	
	};
  

	//---------------------------------------------
	objects[] = 
	{ 
	};

	controls[] = 
	{
		MCC_SaveLoadHeader,
		MCC_LoadHeader,
		MCC_LoadFrame,
		MCC_SaveButton,
		MCC_LoadButton,
		MCC_CancelButton
	};
  
 //========================================= Background ========================================
	//class MCC_SaveLoadScreen_Bckgrnd : MCC_RscPicture {idc = -1; moving = true;x = 0.3;y = 0.2;w = 0.3;h = 0.2; text = "\ca\ui\data\ui_background_armory_co.paa";};
	
	class MCC_SaveLoadBackground: MCC_RscText
	{
		idc = -1;
		moving = true;
		x = 0.0125046;
		y = 0.127815;
		w = 0.974662;
		h = 0.777441;
		colorBackground[] = {0,0,0,0.5};
	};
 //========================================= Input ========================================
	class MCC_SaveLoadHeader: MCC_RscText
	{
		style = MCCST_CENTER;
		idc = -1;
		text = "Save / Load MCC configuration";
		x = 0.0154685;
		y = 0.133702;
		w = 0.964633;
		h = 0.084668;
		colorBackground[] = {0,0,0,0.5};
	};

	class MCC_LoadHeader: MCC_RscText
	{
		idc = -1;
		text = "Paste (crtl-v) MCC configuration code here:";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		x = 0.0419628;
		y = 0.255713;
		w = 0.473819;
		h = 0.0428685;
		colorText[] = {1,1,1,1};
		colorBackground[] = {1,0,1,0};
	};
	  
	//========================================= Text Input Box =========================================
	//class MCC_LoadInput : MCC_RscText {idc = MCC_LOAD_INPUT;type = MCCCT_EDIT;style = MCCST_MULTI;colorBackground[] = { 0, 0, 0, 0 };colorText[] = { 1, 1, 1, 1 };colorSelection[] = { 1, 1, 1, 1 };colorBorder[] = { 1, 1, 1, 1 };BorderSize = 0.01;autocomplete = false;x = 0.5; y = 0.275;w = 0.4; h = 0.04;sizeEx = 0.03;text = "";};
  
	class MCC_LoadFrame: MCC_RscText
	{
		idc = MCC_LOAD_INPUT;
		text = "";
		type = MCCCT_EDIT;
		style = MCCST_MULTI;
		x = 0.0376232;
		y = 0.30503;
		w = 0.924754;
		h = 0.44116;
		colorSelection[] = { 1, 1, 1, 1 };
		colorDisabled[] = { 0, 0, 0, 1 };
		autocomplete = false;
		access = ReadAndWrite;
	};
 
	//========================================= Buttons ========================================
	class MCC_SaveButton: MCC_RscButton
	{
		idc = -1;
		text = "Save";
		x = 0.0184155;
		y = 0.75013;
		w = 0.215645;
		h = 0.12;
		tooltip = "Save current MCC configuration to ClipBoard";
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
	};

	class MCC_LoadButton: MCC_RscButton
	{
		idc = -1;
		text = "Load";
		x = 0.765958;
		y = 0.75013;
		w = 0.214167;
		h = 0.12;
		tooltip = "Paste MCC mission configuration code from clipboard (crtl-v) in text box first";
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
	};
	
	class MCC_CancelButton: MCC_RscButton
	{
		idc = -1;
		text = "Close";
		x = 0.381799;
		y = 0.75013;
		w = 0.215645;
		h = 0.12;
		onButtonClick = "closeDialog 0;";		
	};
	
	//========================================= End Controls ========================================
};
