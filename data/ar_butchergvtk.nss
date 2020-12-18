//::///////////////////////////////////////////////
//:: FileName ar_butchergvtk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/6/2005 12:35:27 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some gold
	GiveGoldToCreature(GetPCSpeaker(), 3);

	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 5);


	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "DeerMeat");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
