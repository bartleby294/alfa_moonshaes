void main()
{
    object chest = GetObjectByTag("randlootchesttes");
    int lootGP = GetLocalInt(chest, "loot_gp") - 1000;
    SetLocalInt(chest, "loot_gp", lootGP );
    SpeakString("Gold Value: " + IntToString(lootGP));

}
