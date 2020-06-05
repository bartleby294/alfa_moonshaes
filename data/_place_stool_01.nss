void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetNearestObjectByTag("UseableStool01", oPC, 1);
    //object oItem = GetLastSpeaker();

    AssignCommand(oPC, ActionSpeakString("*sits*"));
    AssignCommand(oPC,ActionSit(oItem));
}
