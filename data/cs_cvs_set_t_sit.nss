// use this script in the Actions Taken of the first line of a conversation. Use cs_cvs_chk_talk in a node above.
// This script will use the tag of the NPC being spoken with to create a persistent variable.
// There is no need to create a new set of scripts for NPC recognition...these 2 scripts will serve

// This script serves the additional purpose of making the NPC sit down on a placeable with the tag: "Chair"
// To make the NPC continue sitting after the conversation begins, put the script "cs_cvs_stay_sit" in the
// Actions Taken of the first node of conversation.

#include "sos_include"
void main()
{
    // Who is talking to us?
    object oPC = GetPCSpeaker();

    // And what is our tag?
    string myTag = GetTag(OBJECT_SELF);

    // Set the variable.
    SOS_SetPersistentInt(oPC, "nFirst" + myTag, 1);

    if(GetCommandable(OBJECT_SELF)){
     //This sets the NPC as the speaker
    {
        BeginConversation();
         //This starts the conversation script.
        }
    ClearAllActions();
     // Clears the actions so the NPC will not follow you with his/her eyes
    int nChair = 1;
    object oChair;
    oChair = GetNearestObjectByTag("Chair", OBJECT_SELF, nChair);
    ActionSit(oChair);
     //Sits the NPC down
    }
}
