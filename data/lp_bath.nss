void main()
{
    object oPC = GetEnteringObject();
    object oPlayer = GetLastUsedBy ();
    object opool = OBJECT_SELF;
    if (GetIsPC(oPlayer)) {
        AssignCommand( oPlayer, ActionUnequipItem( GetItemInSlot(INVENTORY_SLOT_CHEST , oPlayer) ) );
    }
    if (GetIsPC (oPlayer)) {
        if (GetIsObjectValid(opool) && !GetIsObjectValid (GetSittingCreature (opool)))
        {
            AssignCommand (oPlayer, ActionWait(2.0));
            AssignCommand (oPlayer, ActionSit (opool));
            AssignCommand(GetLastUsedBy(),ActionSpeakString("*Washes up in the bath*"));
        }
    }
}
