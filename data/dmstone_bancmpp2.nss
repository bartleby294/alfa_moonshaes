void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    SetCampaignInt("BANDIT_CAMP", "BANDIT_CAMP_" + GetTag(oArea), 0);
}

