// By: Shay_gman
// Version: 1.1 (February 2011)
#define boxGen_IDD 2995

#define ALLGEAR_IDD 8500
#define BOXGEAR_IDD 8501
#define GEARCLASS_IDD 8502

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class boxGen {
  idd = boxGen_IDD;
  movingEnable = true;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_init.sqf'"); 
  
  controlsBackground[] = 
  {
	MCC_Bckgrnd,
	allGearBackground,
	boxGearBackground
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
  allGearList,
  boxGearList,
  boxGeneratorTittle,
  gearClassTitle,
  gearClasCombo,
  addAllButton,
  addOneButton,
  removeOneButtton,
  generateBoxButton,
  boxGeneratorFrame,
  closeGeneratorButton
  };
  
 //========================================= Background========================================
	class MCC_Bckgrnd : MCC_RscText {idc = -1; moving = true;colorBackground[] = { 0, 0, 0, 0.6 };x = 0.03125;y = 0.025;w = 0.75;h = 0.625; text = "";};
	class allGearBackground : MCC_RscText {idc = -1;moving = true;colorBackground[] = { 0, 0, 0, 0.6 };colorText[] = { 1, 1, 1, 0 };x = 0.046875;y = 0.175;w = 0.3;h = 0.375;text = "";};
	class boxGearBackground : MCC_RscText {idc = -1;moving = true;colorBackground[] = { 0, 0, 0, 0.6 };colorText[] = { 1, 1, 1, 0 };x = 0.45;y = 0.175;w = 0.3;h = 0.375;text = "";};
	class boxGeneratorFrame: MCC_RscFrame{idc = -1;x = 0.03125;y = 0.025;w = 0.75;h = 0.625;};
 //========================================= Controls========================================
  	class allGearList: MCC_RscListBox {idc = ALLGEAR_IDD;x = 0.046875;y = 0.175;w = 0.3;h = 0.375;sizeEx =0.04;};
	class boxGearList: MCC_RscListBox {idc = BOXGEAR_IDD;x = 0.45;y = 0.175;w = 0.3;h = 0.375;sizeEx =0.04;};
	class gearClasCombo: MCC_RscCombo{idc = GEARCLASS_IDD;x = 0.12;y = 0.1;style = MCCST_LEFT;colorText[] = { 1, 1, 1, 1 };colorSelect[] = { 1.0, 0.35, 0.3, 1 };	colorBackground[] = { 0, 0, 0, 0.6 };
									colorSelectBackground[] = { 0, 0, 0, 1 };sizeEx =0.028;w = 0.2; h = 0.032;onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");};
	//Tittles
	class boxGeneratorTittle: MCC_RscText {idc = -1;text = "Box Generator:";sizeEx =0.06;x = 0.046875;y = 0.05;w = 0.3;h = 0.0412699;colorText[] = {0,1,1,1};colorBackground[] = {1,1,1,0};};
	class gearClassTitle:MCC_RscText{idc = -1;text = "Class:";sizeEx =0.03;x = 0.046875;y = 0.1;w = 0.0791664;h = 0.0412699;colorText[] = {1,1,1,1};colorBackground[] = {1,1,1,0};};
	//Buttons
	class addAllButton: MCC_RscButton{idc = -1;text = ">>";x = 0.37;y = 0.225;w = 0.0625;h = 0.05;action =  __EVAL("[1] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");};  
	class addOneButton: MCC_RscButton{idc = -1;text = ">";x = 0.37;y = 0.3;w = 0.0625;h = 0.05;action =  __EVAL("[2] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");};  
	class removeOneButtton: MCC_RscButton{idc = -1;text = "Clear";x = 0.37;y = 0.375;w = 0.0625;h = 0.05;action =  __EVAL("[3] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");};  
	class generateBoxButton: MCC_RscButton{idc = -1;text = "Generate";x = 0.6;y = 0.575;w = 0.125;h = 0.05;action =  __EVAL("[4] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");}; 
	class closeGeneratorButton: MCC_RscButton{idc = -1;text = "Close";x = 0.45;y = 0.575;w = 0.125;h = 0.05;action = "closeDialog 0;deleteVehicle tempBox";};
 };
