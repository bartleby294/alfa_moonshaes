/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Starting Conditions for giving the item for the NPC a Cost.
        Sets Custom Tokens for Price and Item Name.
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 09, 2004
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "custom_tokens"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPcGold = GetGold( oPC);

    string sItem_2_Sell = GetLocalString(OBJECT_SELF, "item_2_sell");
    object oItem_2_Sell = GetObjectByTag(sItem_2_Sell);
    SetCustomToken(ITEM_SELL_NAME, GetName(oItem_2_Sell));

    int iItem_Cost = GetLocalInt(OBJECT_SELF, "item_cost");
    SetCustomToken(ITEM_COST, IntToString( iItem_Cost ));

    if( iPcGold <= iItem_Cost)
    {
        return FALSE;
    }
    return TRUE;
}
