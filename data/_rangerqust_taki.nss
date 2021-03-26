//::///////////////////////////////////////////////
//:: FileName _rangerqust_taki
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{

	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "Hunterssupplies");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
