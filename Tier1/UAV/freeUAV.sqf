currentAO= "UAV";

if (UAVavailable) then 
	{

			onMapSingleClick {"UAV" setmarkerpos _pos; onMapSingleClick ""};
			"UAV" setMarkerType "selector_selectedMission";
			"UAV" setMarkerColor "ColorRed";
			hintsilent "Selecting UAV target";
			playSound "Confirm1";
			UAVavailable=false;
			sleep 60;
			UAVavailable=true;

	} else { hint "UAV still unavailable for relocation" };