void main()
{
  object oPC = GetPCSpeaker();
  GiveGoldToCreature(oPC,500);
  object oTarget = GetItemPossessedBy(oPC,"alfa_trade_bar");
  DestroyObject(oTarget);
}

