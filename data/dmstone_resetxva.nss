void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    SetCampaignInt("XVART_RAIDS", "XVART_RAID_" + GetTag(oArea), 0);
}


