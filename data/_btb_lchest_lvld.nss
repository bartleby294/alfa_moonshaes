void main()
{
    object chest = GetNearestObjectByTag("randlootchesttes");
    int lootLvl = GetLocalInt(chest, "loot_lvl") - 1;
    SetLocalInt(chest, "loot_lvl", lootLvl );
    SpeakString("Level Value: " + IntToString(lootLvl));

}
