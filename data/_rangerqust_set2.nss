//::///////////////////////////////////////////////
//:: FileName dlg_maura_set2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: El Grillo
//:: Created On: 16/3/2021
//:://////////////////////////////////////////////
//This uses 'SetCampaignInt' instead of the standard script wizard 'SetLocalInt', in order to make sure that quest integers are preserved in
//(an automatically created) database, making them persistent across server resets.
//
//
//void SetCampaignInt(
//string sCampaignName,
//string sVarName,
//int nInt,
//object oPlayer = OBJECT_INVALID
//);

void main()
{
    // Set the variables
    SetCampaignInt("MinorQuests", "iRangerquest", 2, GetPCSpeaker());

}

