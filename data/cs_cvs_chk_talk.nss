// Use this script in the Text Appears When of a conversation after using cs_cvs_set_talk in the first node.
// This script will use the tag of the NPC being spoken with to recognise a persistent variable.
// There is no need to create a new set of scripts for NPC recognition...these 2 scripts will serve


#include "sos_include"
int StartingConditional()
{
    // What's my tag?
    string myTag = GetTag(OBJECT_SELF);

    // Inspect local variables
    if(!(SOS_GetPersistentInt(GetPCSpeaker(), "nFirst" + myTag) == 1))
        return FALSE;

    return TRUE;
}
