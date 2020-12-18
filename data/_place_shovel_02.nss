void main()
{
    object oItem = OBJECT_SELF;
    object oPC = GetLastAttacker(oItem);

    AssignCommand(oPC, ActionSpeakString("*Fills in hole.*"));
}
