/************************ [On Heartbeat] ***************************************
    Filename: nw_c2_default1 or j_ai_onheartbeat
************************* [On Heartbeat] ***************************************
    Removed stupid stuff, special behaviour, sleep.

    Also, note please, I removed waypoints and day/night posting from this.
    It can be re-added if you like, but it does reduce heartbeats.

    Added in better checks to see if we should fire this script. Stops early if
    some conditions (like we can't move, low AI settings) are set.

    Hint: If nothing is used within this script, either remove it from creatures
          or create one witch is blank, with just a "void main(){}" at the top.

    Hint 2: You could add this very small file to your catche of scripts in the
            module properties, as it runs on every creature every 6 seconds (ow!)

    This also uses a system of Execute Script :-D This means the heartbeat, when
    compiled, should be very tiny.

    Note: NO Debug strings!
    Note 2: Remember, I use default SoU Animations/normal animations. As it is
            executed, we can check the prerequisists here, and then do it VIA
            execute script.

    -Working- Best possible, fast compile.
************************* [History] ********************************************
    1.3 - Added more "buffs" to fast buff.
        - Fixed animations (they both WORK and looping ones do loop right!)
        - Loot behaviour!
        - Randomly moving nearer a PC in 25M if set.
        - Removed silly day/night optional setting. Anything we can remove, is a good idea.
************************* [Workings] *******************************************
    This fires off every 6 seconds (with PCs in the area, or AI_LEVEL_HIGH without)
    and therefore is intensive.

    It fires of ExecutesScript things for the different parts - saves CPU stuff
    if the bits are not used.
************************* [Arguments] ******************************************
    Arguments: Basically, none. Nothing activates this script. Fires every 6 seconds.
************************* [On Heartbeat] **************************************/

// - This includes J_Inc_Constants
#include "nwnx_area"

void main()
{
    WriteTimestampedLogEntry("HB TEST");
    object oArea = GetArea(OBJECT_SELF);
    int oAreaPlayerNumber = NWNX_Area_GetNumberOfPlayersInArea(oArea);

    if(oAreaPlayerNumber == 0) {
        WriteTimestampedLogEntry("No PCs Found");
        int noPCSeenIn = GetLocalInt(OBJECT_SELF, "NoPCSeenIn");
        SetLocalInt(OBJECT_SELF, "NoPCSeenIn", noPCSeenIn + 1);
        if(noPCSeenIn > 5) {
            WriteTimestampedLogEntry("Destroying myself");
            DestroyObject(OBJECT_SELF, 2.0);
        }
    } else {
        SetLocalInt(OBJECT_SELF, "NoPCSeenIn", 0);
        WriteTimestampedLogEntry("PCs Found");
    }
}
