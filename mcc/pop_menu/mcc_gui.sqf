#define MCC_SANDBOX_IDD 1000
#define MCCLOGO 1028

private ["_type","_mccdialog"];

disableSerialization;

//_type = _this select 0;
_mccdialog = findDisplay MCC_SANDBOX_IDD;	


if (isNil "mcc_hide") then { mcc_hide = 1; };

_type = mcc_hide * -1;

switch ( _type ) do
{
	case -1:
	{
		mcc_hide = -1;
		//hintSilent 'Enter'; 
		ctrlSetText [MCCLOGO, ""];
	};


	case 1:
	{
		mcc_hide = 1;
		//hintSilent 'Exit new';
		ctrlSetText [MCCLOGO, MCC_PATH +"mcc\dialogs\mcc_background.paa"];
	};
};

