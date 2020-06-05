/*** Jump PC to Waypoint Based on Placeable Object Tag
    - for Converstation Action Taken
    By: Ulias (Shawn Marcil)     Last Modified: September 22, 2004

    Description
    ---------------
    Jumps the PC to a Waypoint (or other placeable object) that
    has a tag the same as the placeable object's tag that triggered
    this script with the addition of a "WP_" prefix.

    Example:
    Trigger - Placeable Object Tag: bookshelf_PK0001
    Destination - Waypoint Tag: WP_bookshelf_PK0001
*/

const int DEBUG = FALSE;

void main()
{
    object oPC = GetPCSpeaker();
    string sPlaceableTag = GetTag(OBJECT_SELF);
    string sDestinationWP = "WP_" + sPlaceableTag; // destination Waypoint tag
    object oDestination = GetObjectByTag(sDestinationWP);
    location lDestinationWP = GetLocation(oDestination);

    //if (DEBUG) {
    //    SendMessageToPC(oPC, "Jump PC ---------");
    //    SendMessageToPC(oPC, "from sPlaceableTag: " + sPlaceableTag);
    //    SendMessageToPC(oPC, "to sDestinationWP: " + sDestinationWP);
    //}

    AssignCommand(oPC, ActionJumpToLocation(lDestinationWP));
}
