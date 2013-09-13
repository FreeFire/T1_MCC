//	Initialize briefing.
[
	[
		"Mission",
		[
			"T1 MCC based mission"
		]
	],
	[
		"Credits",
		[
			"Mission created by Tier 1 Operations. This mission contains files created by various Tier1ops members.<br/>http://www.tier1ops.eu<br/><br/>This mission contains files from UPSMON created by various different people. You may find more info on UPSMON at the official Arma 3 Scripting forum.<br/><br/>This mission utilizes BTC Revive created by the Black Templars Clan, modified by BlackAlpha (Tier1ops).<br/><br/>This mission utilizes TPWCAS AI suppression script created by TPW, Coulum, fabrizio_T and Ollem (Tier1ops).<br/><br/>This mission utilizes Admin Actions created by [KH]Jman, modified by BlackAlpha (Tier1ops).<br/><br/>This mission utilizes Vehice Service script, created by (unknown), modified by BlackAlpha (Tier1ops).<br/><br/>This mission utilizes Folk Group Marker script from the F2 Framework, created by Folk.<br/><br/>This mission utilizes Setskill Script, created by Ollem (Tier1ops) and Sonsalt (Tier1ops).<br/><br/>This mission utilizes ACRE radios created by the ACRE team."
		]
	]
]
call {
	if (not isdedicated) then {
		private "_briefing";
		_briefing = _this;
		waituntil {not isnull player};
		for "_i" from ((count _briefing) - 1) to 0 step -1 do {
			for [{_k = (count (_briefing select _i select 1)) - 1},{_k >= 0},{_k = _k - 1}] do {
				player createDiaryRecord ["Diary", [_briefing select _i select 0,_briefing select _i select 1 select _k]];
			};
		};
	};
};