void main()
{
    object chest = GetNearestObjectByTag("randlootchesttes");
    string variable = GetTag(OBJECT_SELF);
    int newVal = GetLocalInt(chest, variable) + 1;
    SetLocalInt(chest, variable, newVal );
    SpeakString(variable + ": " + IntToString(newVal));

}
