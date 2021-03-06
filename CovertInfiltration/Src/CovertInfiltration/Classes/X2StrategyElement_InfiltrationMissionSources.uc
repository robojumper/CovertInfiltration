//---------------------------------------------------------------------------------------
//  AUTHOR:  Xymanek
//  PURPOSE: Creates a MissionSource that proxies all calls to X2ActivityTemplate_Mission
//---------------------------------------------------------------------------------------
//  WOTCStrategyOverhaul Team
//---------------------------------------------------------------------------------------

class X2StrategyElement_InfiltrationMissionSources extends X2StrategyElement_DefaultMissionSources;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> MissionSources;

	MissionSources.AddItem(CreateActivitySourceTemplate());

	return MissionSources;
}

static function X2DataTemplate CreateActivitySourceTemplate()
{
	local X2MissionSourceTemplate Template;

	`CREATE_X2TEMPLATE(class'X2MissionSourceTemplate', Template, class'X2ActivityTemplate_Mission'.const.MISSION_SOURCE_NAME);
	Template.bShowRewardOnPin = true;

	Template.OnSuccessFn = ActivityOnSuccess;
	Template.OnFailureFn = ActivityOnFailure;
	Template.OnExpireFn = ActivityOnExpire;
	
	Template.OnTriadSuccessFn = ActivityOnTriadSuccess;
	Template.OnTriadFailureFn = ActivityOnTriadFailure;

	Template.GetMissionDifficultyFn = ActivityGetMissionDifficulty;
	Template.WasMissionSuccessfulFn = ActivityWasMissionSuccessful;
	Template.GetOverworldMeshPathFn = ActivityGetOverworldMeshPath;
	Template.GetSitrepsFn = ActivityGetSitreps;

	Template.RequireLaunchMissionPopupFn = ActivityRequireLaunchMissionPopup;
	Template.CanLaunchMissionFn = ActivityCanLaunchMission;

	return Template;
}

static function ActivityOnSuccess (XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.OnSuccess != none)
	{
		ActivityTemplate.OnSuccess(NewGameState, ActivityState);
	}
}

static function ActivityOnFailure (XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.OnFailure != none)
	{
		ActivityTemplate.OnFailure(NewGameState, ActivityState);
	}
}

static function ActivityOnExpire (XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.OnExpire != none)
	{
		ActivityTemplate.OnExpire(NewGameState, ActivityState);
	}
}

static function ActivityOnTriadSuccess (XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.OnTriadSuccess != none)
	{
		ActivityTemplate.OnTriadSuccess(NewGameState, ActivityState);
	}
}

static function ActivityOnTriadFailure (XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.OnTriadFailure != none)
	{
		ActivityTemplate.OnTriadFailure(NewGameState, ActivityState);
	}
}

static function int ActivityGetMissionDifficulty (XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.GetMissionDifficulty != none)
	{
		return ActivityTemplate.GetMissionDifficulty(ActivityState);
	}

	// Copied from XComGameState_MissionSite::GetMissionDifficulty
	`RedScreen("No difficulty function for activity. Defaulting to medium difficulty");
	return 2;
}

static function bool ActivityWasMissionSuccessful (XComGameState_BattleData BattleDataState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObjectID(BattleDataState.m_iMissionID);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.WasMissionSuccessful != none)
	{
		return ActivityTemplate.WasMissionSuccessful(BattleDataState);
	}

	`CI_Warn("Could not find the activity template for this mission!");

	// Default is won. See XComGameState_BattleData::SetVictoriousPlayer
	return true;
}

static function string ActivityGetOverworldMeshPath (XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.GetOverworldMeshPath != none)
	{
		return ActivityTemplate.GetOverworldMeshPath(ActivityState);
	}

	// See XComGameState_MissionSite::GetStaticMesh
	return "";
}

static function array<name> ActivityGetSitreps (XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	local array<name> EmptyArray;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.GetSitreps != none)
	{
		return ActivityTemplate.GetSitreps(MissionState, ActivityState);
	}

	// See XComGameState_MissionSite::SetMissionData
	EmptyArray.Length = 0; // Prevent compiler whining
	return EmptyArray;
}

static function bool ActivityRequireLaunchMissionPopup (XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.RequireLaunchMissionPopup != none)
	{
		return ActivityTemplate.RequireLaunchMissionPopup(MissionState, ActivityState);
	}

	return false;
}

static function bool ActivityCanLaunchMission (XComGameState_MissionSite MissionState)
{
	local X2ActivityTemplate_Mission ActivityTemplate;
	local XComGameState_Activity ActivityState;
	
	ActivityState = class'XComGameState_Activity'.static.GetActivityFromPrimaryObject(MissionState);
	ActivityTemplate = X2ActivityTemplate_Mission(ActivityState.GetMyTemplate());

	if (ActivityTemplate.CanLaunchMission != none)
	{
		return ActivityTemplate.CanLaunchMission(MissionState, ActivityState);
	}

	return true;
}
