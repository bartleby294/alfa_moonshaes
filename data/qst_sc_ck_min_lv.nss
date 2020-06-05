/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

       Used to set minimum Level required for Questing.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "custom_tokens"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int ilevel = GetLocalInt(OBJECT_SELF, "min_level");
    // Restrict based on the player's class
    if ( ilevel <= 0)
    {
        ilevel = 1;
    }
    int iPassed = 0;

    if (DEBUG_CODE == 1)
    {
        string part1 = IntToString(ilevel);
        string Message1 = "Minimum level for this Quest = " + part1;
        SendMessageToPC(oPC, Message1);
        string part2 = IntToString(GetHitDice(oPC));
        string Message2 = "You are currently Level:  " + part2;
        SendMessageToPC(oPC, Message2);
    }

    if (ilevel == 1)
    {
        return FALSE;
    }
    else if (GetHitDice(oPC) < ilevel)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
