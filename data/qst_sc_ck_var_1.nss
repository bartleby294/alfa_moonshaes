/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        used with variable 1 to set starting conditons for Converstaiton
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "custom_tokens"
int StartingConditional()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    // Inspect local variables
    if(!(PQJ_RetrieveHighestPartyQuestState(oPC, sName) == 1))
    {
        return FALSE;
    }
    else
    {
        string sGet_Item = GetLocalString(OBJECT_SELF, "item_2_take");
        object oGet_Item = GetObjectByTag(sGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));

        string sGet_Item2 = GetLocalString(OBJECT_SELF, "item_2_take1");
        object oGet_Item2 = GetObjectByTag(sGet_Item2);
        SetCustomToken(ITEM_WANT_NAME_2, GetName(oGet_Item2));

        int iMax_Item = GetLocalInt(OBJECT_SELF, "num_item");
        SetCustomToken(MAX_ITEMS, IntToString( iMax_Item ));

        string sQst_Num = sName + "_N";
        int iNum = GetLocalInt(GetObjectByTag(SAVE_TO_ITEM), sQst_Num);
        SetCustomToken(TURNED_IN_ITEMS, IntToString( iNum ));

        return TRUE;
  }

}
