
#define MCC_SANDBOX4_IDD 4000
#define MCC_UM_LIST 3069
#define MCC_UM_PIC 3070
#define MCC_MINIMAP 9000

disableSerialization;

private ["_type", "_name", "_worldPos","_dummy", "_unitpos", "_ok", "_markerColor", "_leader", "_markerType", "_tempMarkers", "_tempLines", "_tempVehicles",
		"_targetUnit","_oldUnit","_group","_params","_ctrl","_pressed","_shift","_ctrlKey","_mccdialog","_comboBox","_nul","_dummyUnit","_control","_cam"];

_mccdialog = findDisplay MCC_SANDBOX4_IDD;
_comboBox = _mccdialog displayCtrl MCC_UM_LIST;
_type = _this select 0;

	switch (_type) do
	{
		case 0: //Teleport
		{
		mapClick = false; 
			hint "Click on the map"; 
			onMapSingleClick " 	hint format ['%1 teleported', UMName];
								teleportPos = _pos; 
								mapClick = true;
								onMapSingleClick """";";
			waituntil {mapClick};
			if (MCC_UMUnit==0) then 
				{
					{[[1,compile format ["(objectFromNetID ""%1"") setpos %2",netid _x,teleportPos]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP} foreach MCC_selectedUnits;
				} else 
					{
					{{[[1,compile format ["(objectFromNetID ""%1"") setpos %2",netid _x,teleportPos]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP} foreach (units _x);} foreach MCC_selectedUnits;
				};
		};
		
		case 1:	//Teleport to LHD
		{
			_worldPos = deck modelToWorld [0,0,0];
			if (MCC_UMUnit==0) then 
			{
				{[[1,compile format ["(objectFromNetID ""%1"") setposASL %2",netid _x,[_worldPos select 0, _worldPos select 1, 15.9]]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP} foreach MCC_selectedUnits;
			} 
			else
			{
				{{[[1,compile format ["(objectFromNetID ""%1"")  setposASL %2",netid _x,[_worldPos select 0, _worldPos select 1, 15.9]]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP} foreach (units _x);} foreach MCC_selectedUnits;
			};
		};

		case 2:	//Hijak unit
		{
			if (MCC_UMUnit==0) then 
			{
				_targetUnit = MCC_UMunitsNames select (lbCurSel MCC_UM_LIST);	//Hijacked unit
				if (isplayer _targetUnit) exitwith {hint "Can't hijak other players"};
				Prev_Player = player; 
				Prev_Side = side player; 
				_oldUnit = player; 
				_group = creategroup (side _targetUnit); 
				//_dummyUnit = _group createUnit ["RU_Assistant", position player,[], 0, "NONE"];
				[_targetUnit] joinSilent _group;
				//setPlayable _dummyUnit;
				//selectPlayer _dummyUnit;	//Make the switch
				removeSwitchableUnit _oldUnit;
				_group selectLeader player;
				selectPlayer _targetUnit;
				//deleteVehicle _dummyUnit;
				deletegroup _group;
				MCC_backToplayerIndex = _targetUnit addaction ["Back to player", MCC_path + "mcc\general_scripts\unitManage\backToPlayer.sqf",[], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
				mcc_actionInedx = player addaction ["> Mission generator", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
				_ok = _targetUnit addEventHandler ["Killed", "[_this select 0] joinSilent (Prev_Group);selectPlayer Prev_Player;"];
				/*
				[player] joinSilent grpNull;
				[player] joinSilent _group;
				[_targetUnit] joinSilent _group;
				_group selectLeader player;
				_null = _targetUnit addaction ["Back to player", "\mcc_sandbox_mod\mcc\general_scripts\unitManage\backToPlayer.sqf"];
				[_oldUnit] joinSilent grpNull; 
				setPlayable _targetUnit;
				selectPlayer _targetUnit;	//Make the switch
				removeSwitchableUnit _oldUnit;
				_oldUnit setcaptive true; 
				_ok = _targetUnit addEventHandler ["Killed", "[_this select 0] joinSilent (Prev_Group);selectPlayer Prev_Player;"];*/
			}
			else
			{hint "Can only hijak units not groups"};
		};
			
		case 3:	//Markers
		{
			if (!MCC_trackMarker) then {
				MCC_trackMarker = true; 
				while {MCC_trackMarker} do {
					_tempMarkers = [];
					_tempLines = [];
					_tempVehicles = [];
						{
							_leader = leader _x; 
									{
										switch (format ["%1", side  _x]) do 
											{
											case "EAST": //East
												{
												_markerColor = "ColorRed";
												}; 
												
											case "WEST": //West
												{
												_markerColor = "ColorBlue";
												};
												
											case "GUER": //Resistance
												{
												_markerColor = "ColorGreen";
												};
											};
										if ((vehicle _x) != _x) then 
											{
											if (!((vehicle _x) in _tempVehicles)) then
												{
												_tempVehicles set [count _tempVehicles, vehicle _x];
												if ((vehicle _x) iskindof "Car") then {_markerType = "b_mech_inf";};
												if ((vehicle _x) iskindof "Tank") then {_markerType = "b_armor";};
												if ((vehicle _x) iskindof "Air") then {_markerType = "b_air";};
												if ((vehicle _x) iskindof "Boat") then {_markerType = "b_recon";};
												createMarkerLocal [format["%1", _x], getpos (vehicle _x)];
												format["%1", _x] setMarkerTypelocal _markerType;
												format["%1", _x] setMarkerColorlocal _markerColor;
												_tempMarkers set [count _tempMarkers, format["%1", _x]];
												};
											} else
											{
											createMarkerLocal [format["%1", _x], getpos _x];
											format["%1", _x] setMarkerTypelocal "mil_dot";
											format["%1", _x] setMarkerColorlocal _markerColor;
											_tempMarkers set [count _tempMarkers, format["%1", _x]];
											if ( _x != _leader) then 
												{
												[getpos _x , getpos _leader ,format ["%1", _x]] call MCC_fnc_drawLine;
												_tempLines set [count _tempLines, format["line_%1", _x]];
												};
											};
										} foreach units _x; 
						} foreach allGroups;
						sleep 3; 
						{
						deletemarkerlocal _x;
						} foreach _tempMarkers;
						{
							deletemarkerlocal _x;
						} foreach _tempLines;
					};
					//Incase we came down here let's clean up
					{
					deletemarkerlocal _x;
					} foreach _tempMarkers;
					{
						deletemarkerlocal _x;
					} foreach _tempLines;
			} else {
				MCC_trackMarker = false; 
				};
		};
		
		case 4:	//Indevidual Marker
		{
		if ((lbCurSel MCC_UM_LIST)>=0) then 
			{
			if (MCC_UMisJoining) then {					//Joining
				MCC_UMisJoining = false;
				if (MCC_UMUnit==0) then 
					{
						UMName =  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST);
						//[UMJoin] joinSilent grpNull;
						[UMJoin] joinSilent (group UMName);
						} else {
								UMName = UMgroupNames select (lbCurSel MCC_UM_LIST);
								//(units UMName) joinSilent grpNull;
								(units UMJoin) joinSilent UMName;
								deletegroup UMName;
							};
			};
			if (MCC_UMUnit==0) then 
				{UMName =  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)} 
				else {UMName = leader (UMgroupNames select (lbCurSel MCC_UM_LIST))};
				deletemarkerlocal "currentUnitSelected";
				createMarkerLocal ["currentUnitSelected", getpos UMName];
				"currentUnitSelected" setMarkerTypelocal "Select";
				"currentUnitSelected" setMarkerColorlocal "ColorRed";
				_control = _mccdialog displayCtrl MCC_MINIMAP;
				_control ctrlMapAnimAdd [1, 0.3, getpos UMName];
				ctrlMapAnimCommit _control;
				
				if (MCC_PIPcam != ObjNull) then {
					MCC_PIPcam cameraEffect ["TERMINATE", "BACK"];
					camDestroy MCC_PIPcam;
					};
					
				MCC_PIPcam = "camera" camCreate getPos player;
				waitUntil {MCC_PIPcam != ObjNull};
				
				MCC_PIPcam attachTo [vehicle (UMName),[10,15,10]]; // ->todo: grab this from a custom config
				if(vehicle (UMName) isKindOf "Man") then {MCC_PIPcam  camSetFov 0.15} else {MCC_PIPcam  camSetFov 0.8}; 
				MCC_PIPcam  camSetTarget vehicle (UMName);
				MCC_PIPcam cameraEffect ["INTERNAL", "BACK", "rendertarget10"];
				MCC_PIPcam camCommit 1; // commit Changes
				
				private ["_effectParams"];
				_effectParams = switch (MCC_UMPIPView) do {
					// Normal
					case 0: {
						[3, 1, 1, 1, 0.1, [0, 0.4, 1, 0.1], [0, 0.2, 1, 1], [0, 0, 0, 0]]
					};
					
					// Night vision
					case 1: {
						[1]
					};
					
					// Thermal imaging
					case 2: {
						[2]
					};
				};
	
				// Set effect
				"rendertarget10" setPiPEffect _effectParams;
				_control = _mccdialog displayCtrl MCC_UM_PIC;
				[_control] call MCC_fnc_pipOpen;
				_control ctrlsettext"#(argb,256,256,1)r2t(rendertarget10,1.0);";
			};
		};
		
		case 5:	//High command: Assighn Commander
		{
		if ((lbCurSel MCC_UM_LIST)>=0) then 
			{
			if (MCC_UMUnit==1) then 
				{
				hint "Only units can be assighned as high commanders";
				} 
				else 
				{
				UMName =  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST);
				["highCommand", [UMName, 0]] call CBA_fnc_globalEvent;
				};
			};
		};

		case 6:	//High command: Clear ALL groups
		{
		if ((lbCurSel MCC_UM_LIST)>=0) then 
			{
			if (MCC_UMUnit==0) then 
				{UMName =  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)} 
				else {UMName = leader (UMgroupNames select (lbCurSel MCC_UM_LIST))};
			hint "cleared all High Command units"; 
			["highCommand", [UMName, 1]] call CBA_fnc_globalEvent;
			};
		};
		
		case 7:	//High command: Add group
		{
		if ((lbCurSel MCC_UM_LIST)>=0) then 
			{
			if (MCC_UMUnit==0) then 
				{UMName =  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)} 
				else {UMName = leader (UMgroupNames select (lbCurSel MCC_UM_LIST))};
			["highCommand", [UMName, 2]] call CBA_fnc_globalEvent;
			};
		};

		case 8:	//Multi-Selection
		{
			_params = _this select 1;

			_ctrl = _params select 0;
			_pressed = _params select 1;
			_shift = _params select 4;
			_ctrlKey = _params select 5;
			
			if (MCC_UMUnit==0) then {
				if (_ctrlKey) then {
					if !((MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)) in MCC_selectedUnits) then
						{
						MCC_selectedUnits = MCC_selectedUnits + [MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)];
						lbSetColor [MCC_UM_LIST, (lbCurSel MCC_UM_LIST), [0, 1, 1, 1]];
						hint format ["%1", MCC_selectedUnits];
						} else {
							MCC_selectedUnits = MCC_selectedUnits - [MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)];
							lbSetColor [MCC_UM_LIST, (lbCurSel MCC_UM_LIST), [1, 1, 1, 1]];
							//hint format ["%1", MCC_selectedUnits];
							};
					} else {
						MCC_selectedUnits = [MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)];
						for [{_x=0},{_x<(lbSize MCC_UM_LIST)},{_x=_x+1}] do {
							lbSetColor [MCC_UM_LIST, _x, [1, 1, 1, 1]];
							}
						lbSetColor [MCC_UM_LIST, (lbCurSel MCC_UM_LIST), [0, 1, 1, 1]];
						//hint format ["%1", MCC_selectedUnits];
						};
				};
						
			if (MCC_UMUnit==1) then {
				if (_ctrlKey) then {
					if !((UMgroupNames select (lbCurSel MCC_UM_LIST)) in MCC_selectedUnits) then
						{
						MCC_selectedUnits = MCC_selectedUnits + [UMgroupNames select (lbCurSel MCC_UM_LIST)];
						lbSetColor [MCC_UM_LIST, (lbCurSel MCC_UM_LIST), [0, 1, 1, 1]];
						} else {
							MCC_selectedUnits = MCC_selectedUnits - [UMgroupNames select (lbCurSel MCC_UM_LIST)];
							lbSetColor [MCC_UM_LIST, (lbCurSel MCC_UM_LIST), [1, 1, 1, 1]];
							};
					} else {
						MCC_selectedUnits = [UMgroupNames select (lbCurSel MCC_UM_LIST)];
						for [{_x=0},{_x<(lbSize MCC_UM_LIST)},{_x=_x+1}] do {
							lbSetColor [MCC_UM_LIST, _x, [1, 1, 1, 1]];
							}
						lbSetColor [MCC_UM_LIST, (lbCurSel MCC_UM_LIST), [0, 1, 1, 1]];
						//hint format ["%1", MCC_selectedUnits];
						};
				};
		};
		
		case 9:	//HALO
		{
			hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
			MCC_UMParadropRequestMarker = true; 
			MCC_UMparadropIsHalo = true; 
			/*
			onMapSingleClick " 	hint format ['%1 Paradroped', UMName];
								['paradrop', [_pos, MCC_selectedUnits, MCC_UMUnit, true]] call CBA_fnc_globalEvent;
								onMapSingleClick """";";*/
		};
				
		case 10:	//ParaDrop
		{
			hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
			MCC_UMParadropRequestMarker = true; 
			MCC_UMparadropIsHalo = false; 
			/*
			onMapSingleClick " 	hint format ['%1 Paradroped', UMName];
								['paradrop', [_pos, MCC_selectedUnits, MCC_UMUnit, false]] call CBA_fnc_globalEvent;
								onMapSingleClick """";";*/
		};
		
		case 11:	//Broadcast
		{
			hint "Live feed is broadcasting";
			if (MCC_UMUnit==0) then 
				{UMName =  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST)} 
				else {UMName = leader (UMgroupNames select (lbCurSel MCC_UM_LIST))};
			[[netid UMName, MCC_UMPIPView],"MCC_fnc_broadcast",true,false] spawn BIS_fnc_MP;
		};
		
		case 12:	//Delete
		{
			if (MCC_UMUnit==0) then 
				{
					UMName =  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST);
					while {!(isnull UMName) && !(isplayer UMName)} do {deletevehicle vehicle UMName};
					} else {
						UMName = UMgroupNames select (lbCurSel MCC_UM_LIST);
						{while {!(isnull _x) && !(isplayer _x)} do {deletevehicle vehicle _x};}foreach units UMName;
						};
		};
		
		case 13:	//Join
		{
			hint "Click on the unit or group to select it then click on the unit or group you want it to join to"; 
			if (MCC_UMUnit==0) then 
				{
					UMJoin=  MCC_UMunitsNames select (lbCurSel MCC_UM_LIST);
					} else {
						UMJoin = UMgroupNames select (lbCurSel MCC_UM_LIST);
						};
			MCC_UMisJoining = true;
		};
		
		default //default - no match
		{
			player globalchat format ["Access Denied: type %1", _type];
		};
	};
	