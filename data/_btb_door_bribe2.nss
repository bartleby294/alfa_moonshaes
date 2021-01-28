void main()
{
    object oTarget = OBJECT_SELF;

    // Get the creature who triggered this event.
    object oPC = GetClickingObject();

    // Abort if the PC does not have at least 2000 gold.
    if ( GetGold(oPC) < 2000 )
        return;

    TakeGoldFromCreature(2000, oPC, TRUE);

    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
}
