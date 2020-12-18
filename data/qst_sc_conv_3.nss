/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        starting conversations
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "nw_i0_plot"
#include "custom_tokens"

int StartingConditional()
{
    string sGet_Item = GetLocalString(OBJECT_SELF, "item_2_take");
    object oGet_Item = GetObjectByTag(sGet_Item);
    SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));

    int iMax_Item = GetLocalInt(OBJECT_SELF, "num_item");
    SetCustomToken(MAX_ITEMS, IntToString( iMax_Item ));

    return TRUE;
}
