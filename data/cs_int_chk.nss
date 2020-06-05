///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//////////////////////////TEMPLATE/////////////////////////////////
///////////////////////DO NOT MODIFY///////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

// This script checks a persistent variable, as defined in "nVariable" on every member of a party.
// If the variable exists on any member of the party, this script fires.
// It is typically used in the Text Appears When of a conversation

#include "sos_include"

int StartingConditional()
{
object oFirstMember = GetPCSpeaker();
object oPC = GetFirstFactionMember(oFirstMember, TRUE);

if (GetIsObjectValid(oPC) == TRUE)
{
if(SOS_GetPersistentInt(oPC, "nVariable") == 1)    //set you Variable name and Value here
        return TRUE;
oPC = GetNextFactionMember(oPC,TRUE);
}
    return FALSE;
}

