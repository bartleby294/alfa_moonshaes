//::///////////////////////////////////////////////
//:: FileName batstart
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "qst__pqj_inc"
#include "nw_i0_tool"
#include "x0_i0_partywide"
#include "custom_tokens"

void main()
{
    // Set the variables
    SetCampaignInt("RepeatableStatics", "defiledcavernsbats", 1, GetPCSpeaker());
    object oPC = GetPCSpeaker();
}
