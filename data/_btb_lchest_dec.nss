void main()
{
    int amount = 1;
    object chest = GetNearestObjectByTag("randlootchesttes");
    string variable = GetTag(OBJECT_SELF);

    if(variable == "lootGP") {
        amount = 100;
    }

    int newVal = GetLocalInt(chest, variable) - amount;
    SetLocalInt(chest, variable, newVal );
    SpeakString(variable + ": " + IntToString(newVal));

}
