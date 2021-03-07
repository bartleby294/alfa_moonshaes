void main()
{
    int amount = 10;
    object chest = GetNearestObjectByTag("randlootchesttes");
    string variable = GetTag(OBJECT_SELF);

    if(variable == "lootGP") {
        amount = 1000;
    }

    int newVal = GetLocalInt(chest, variable) + amount;
    SetLocalInt(chest, variable, newVal );
    SpeakString(variable + ": " + IntToString(newVal));

}
