void openDoor(object oDoor){
    // Unlock and open "e_golddoor".
    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));
    // Lock the door after 30 second.
    DelayCommand(30.0, SetLocked(oDoor, TRUE));
}

void main()
{
    object oDoor = OBJECT_SELF;
    // Get the creature who triggered this event.
    object oPC = GetClickingObject();
    // Get the Waypoint representing the free to open side.
    object freeWP = GetNearestObjectByTag("free_side_wp");

    float doorToWP = GetDistanceBetween(oDoor, freeWP);
    float PCToWP = GetDistanceBetween(oPC, freeWP);

    // if the door to wp distance is less than the pc to the wp
    // distance the pc is on the wrong side of the door and has
    // to pay.
    if(doorToWP < PCToWP) {
        // Abort if the PC does not have at least 2000 gold.
        if ( GetGold(oPC) < 2000 )
            return;
        // Take the gold from the player
        TakeGoldFromCreature(2000, oPC, TRUE);
        openDoor(oDoor);
    // otherwise the pc is free to leave.
    } else {
        openDoor(oDoor);
    }
}
