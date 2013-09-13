#define MCC_SaveLoadScreen_IDD 7000
#define MCC_LOAD_INPUT 7001

private ["_tempText"];
disableSerialization;

_tempText = ctrlText MCC_LOAD_INPUT;
ctrlSetText [MCC_LOAD_INPUT,format ["%1",MCC_safe]];
