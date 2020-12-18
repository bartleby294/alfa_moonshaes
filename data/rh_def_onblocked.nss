/*******************************************************************************
Script:     Default NPC OnBlocked script modified for Hour-based Waypoints
Filename:   rh_def_onblocked
Modifier:   Thomas J. Hamman (Rhone)

This change was made from the original nw_c2_defaulte:

*   If the NPC tries to go through a locked door, and he has the right key for
    it in his inventory, he will automatically unlock and open the door.  This
    is best when combined with an OnOpen script for the door that handles
    reclosing and relocking it several seconds after an NPC opens it.
*******************************************************************************/

void main()
{
    object oDoor = GetBlockingDoor();
    string sKey = GetLockKeyTag(oDoor);

    if (GetLocked(oDoor))
        if (GetItemPossessedBy(OBJECT_SELF, sKey) != OBJECT_INVALID) {
            SetLocked(oDoor, FALSE);
            DoDoorAction(oDoor, DOOR_ACTION_OPEN);
            return;
        }

    if(GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 5)
    {
        if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN) && GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 7 )
        {
            DoDoorAction(oDoor, DOOR_ACTION_OPEN);
        }
        else if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH))
        {
            DoDoorAction(oDoor, DOOR_ACTION_BASH);
        }
    }
}
