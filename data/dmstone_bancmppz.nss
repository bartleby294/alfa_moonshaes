void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    SetCampaignInt("BANDIT_CAMP_PC_LAST_OBSERVED",
                   "BANDIT_CAMP_PC_LAST_OBSERVED" + GetTag(oArea), 0);
}

