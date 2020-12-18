void main()
{
object oPC = GetPCSpeaker();
object oItem = GetItemPossessedBy(oPC,"alfa_tradebar");
GiveGoldToCreature(oPC, 475);
DestroyObject(oItem);
}
