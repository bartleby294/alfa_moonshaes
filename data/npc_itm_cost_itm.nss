/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Starting Conditions for giving the item for the NPC a Cost.
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 09, 2004
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "custom_tokens"

int StartingConditional()
{
    int iItem_Cost = GetLocalInt(OBJECT_SELF, "item_cost");
    SetCustomToken(ITEM_COST, IntToString( iItem_Cost ));
    return TRUE;
}
