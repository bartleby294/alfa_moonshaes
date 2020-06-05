// use this script in the Actions Taken of the first line of a conversation. Use cs_cvs_chk_talk in a node above.
// This script will use the tag of the NPC being spoken with to create a persistent variable.
// There is no need to create a new set of scripts for NPC recognition...these 2 scripts will serve

#include "sos_include"
void main()
{
    // Who is talking to us?
    object oPC = GetPCSpeaker();

    // And what is our tag?
    string myTag = GetTag(OBJECT_SELF);

    // Set the variable.
    SOS_SetPersistentInt(oPC, "nFirst" + myTag, 1);
}




