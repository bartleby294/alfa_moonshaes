//::///////////////////////////////////////////////
//:: FileName _cregalqust_taki
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "StampedWrit");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    // Set the variables
    SetCampaignInt("MinorQuests", "iCregalquest", 3, GetPCSpeaker());

}
