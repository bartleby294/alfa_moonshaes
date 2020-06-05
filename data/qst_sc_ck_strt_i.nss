/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Must have starting item
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "custom_tokens"
#include "NW_I0_PLOT"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sItem2Start = GetLocalString(OBJECT_SELF, "item_2_begin");
    if (sItem2Start == "")
    {
        if (DEBUG_CODE == 1)
        {
            SendMessageToPC(oPC, "Blank");
        }
        sItem2Start = "quest_xxxxx_xxxx";
    }
    object oItem2Start = GetObjectByTag(sItem2Start);

    if (DEBUG_CODE == 1)
    {
        string part1 = GetName(oItem2Start);
        string part2 = "FALSE";
        if ( oItem2Start != OBJECT_INVALID || sItem2Start == "quest_xxxxx_xxxx")
        {
            string Message3 = "This Conversation does not have a starting item.";
            SendMessageToPC(oPC, Message3);
        }
        else
        {
            string Message1 = "Item requited to start this quest is: ." + part1 + ".";
            SendMessageToPC(oPC, Message1);
            if (HasItem(oPC, sItem2Start) == 1)
            {
                part2 = "True";
            }
            string Message2 = "You currently have the item:  " + part2;
            SendMessageToPC(oPC, Message2);
        }
    }
         //sItem2Start == ""
    if (  oItem2Start != OBJECT_INVALID || sItem2Start == "quest_xxxxx_xxxx")
    {
        return FALSE;
    }
    else if(HasItem(GetPCSpeaker(), sItem2Start))
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
