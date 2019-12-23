//---------------------------------------------------------------------------------------
//  AUTHOR:  statusNone and Xymanek
//  PURPOSE: Required class for MCM to point to default values of all
//	MCM adjustable values
//---------------------------------------------------------------------------------------
//  WOTCStrategyOverhaul Team
//---------------------------------------------------------------------------------------
class ModConfigMenu_Defaults extends Object config(ModConfigMenu_Defaults);

var config bool DAYS_TO_HOURS_DEFAULT;
var config int DAYS_BEFORE_HOURS_DEFAULT;

var config bool ENABLE_TUTORIAL_DEFAULT;

var config bool REMOVE_NICKNAMED_UPGRADES_DEFAULT;

var config bool WARN_BEFORE_EXPIRATION_DEFAULT;
var config int HOURS_BEFORE_WARNING_DEFAULT;

// "i" added to prevent case warnings
var config int iVERSION;