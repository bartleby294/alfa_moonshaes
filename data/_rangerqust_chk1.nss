//::///////////////////////////////////////////////
//:: FileName dlg_maurachk0
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: El Grillo
//:: Created On: 16/3/2021
//:://////////////////////////////////////////////
//This uses 'GetCampaignInt' instead of the standard script wizard 'GetLocalInt', in order to access campaign quest integers that are
//persistent across server resets.
//
//
//GetCampaignInt(
//string sCampaignName,
//string sVarName,
//object oPlayer = OBJECT_INVALID
//);

int StartingConditional()
{
    // Inspect the campaign variable
    if(!(GetCampaignInt("MinorQuests", "iRangerquest", GetPCSpeaker()) == 1))
      return FALSE;

      return TRUE;
}


