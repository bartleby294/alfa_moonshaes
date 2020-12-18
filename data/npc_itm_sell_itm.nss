/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Starting Conditions
        sets the name of the item to sell
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 09, 2004
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "custom_tokens"

int StartingConditional()
{
    string sItem_2_Sell = GetLocalString(OBJECT_SELF, "item_2_sell");
    object oItem_2_Sell = GetObjectByTag(sItem_2_Sell);
    string sItem_Name = GetName(oItem_2_Sell);
    SetCustomToken(ITEM_SELL_NAME, sItem_Name);
    return TRUE;
}
