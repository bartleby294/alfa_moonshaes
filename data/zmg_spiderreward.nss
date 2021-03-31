//::///////////////////////////////////////////////
//:: FileName zmg_spiderreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some gold
	GiveGoldToCreature(GetPCSpeaker(), 10);

	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 10);


	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "004_rn_spidergland");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
