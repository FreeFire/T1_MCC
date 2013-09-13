

// Start camera/cinematic mode.
private "_cam";
_cam = "camera" camCreate [position player select 0,position player select 1,2];
_cam camSetTarget player;
_cam cameraEffect ["internal", "BACK"];
_cam camCommit 0;

// Enable and disable night vision to fix white screen bug.
camUseNVG true;
sleep 0.01;
camUseNVG false;

// Disable camera/cinematic mode.
_cam cameraeffect ["terminate", "back"];
camdestroy _cam;