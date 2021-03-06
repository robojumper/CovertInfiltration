//---------------------------------------------------------------------------------------
//  AUTHOR:  statusNone
//  PURPOSE: Disables non-compliant campaign start options 
//---------------------------------------------------------------------------------------
//  WOTCStrategyOverhaul Team
//---------------------------------------------------------------------------------------

class UIListener_CampaignStartMenu extends UIScreenListener;

var localized string strDisabledTutorialTooltip;
var localized string strDisabledNarrativeContentTooltip;

event OnInit(UIScreen Screen)
{
    local UIShellDifficulty ShellDifficulty;
    local UIShellNarrativeContent ShellNarrativeContent;
    
    if (UIShellDifficulty(Screen) != none)
    {
        ShellDifficulty = UIShellDifficulty(Screen);
        ShellDifficulty.m_TutorialMechaItem.Checkbox.SetChecked(false);
        ShellDifficulty.m_TutorialMechaItem.SetDisabled(true, strDisabledTutorialTooltip);
    }

    if (UIShellNarrativeContent(Screen) != none)
    {
        ShellNarrativeContent = UIShellNarrativeContent(Screen);
        ShellNarrativeContent.m_XpacknarrativeMechaItem.Checkbox.SetChecked(false);
        ShellNarrativeContent.m_XpacknarrativeMechaItem.SetDisabled(true, strDisabledNarrativeContentTooltip);
    }
}