//::///////////////////////////////////////////////
//:: FileName dlg_maurasuccess
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some gold
	GiveGoldToCreature(GetPCSpeaker(), 25);

	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 25);


	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "UnspecifiedMeatMash");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
