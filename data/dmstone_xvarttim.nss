void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int xvartTime = GetCampaignInt("XVART_RAIDS", "XVART_RAID_" + GetTag(oArea));
    string xvartTimeStr = IntToString(xvartTime);
    SetCustomToken(21471647, xvartTimeStr);
}

