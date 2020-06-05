/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0 Version 1
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Quest style 8  - Var 6 - Set name for use in conversations
        August 25, 2004 updated for Scrolls looked funny in conversation
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "custom_tokens"

int StartingConditional()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    // Inspect local variables
    if(!(RetrieveQuestState(sName, oPC) == 6))
    {
        return FALSE;
    }
    else
    {
        string sName = GetLocalString(OBJECT_SELF, "quest_name");
        object oPC = GetPCSpeaker();

        string sGet_Item = GetLocalString(OBJECT_SELF, "item_col_6");
        object oGet_Item = GetObjectByTag(sGet_Item);
        if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
        {
            string sItemName = "Scroll of " + GetName(oGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, sItemName);
        }
        else
        {
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
        }
        return TRUE;
    }

}
