/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Starting Conditions
        Makes sure the Player Does not have the item
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 09, 2004
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "nw_i0_tool"

int StartingConditional()
{

    string sGet_Item = GetLocalString(OBJECT_SELF, "item_2_sell");

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), sGet_Item))
        return TRUE;

    return FALSE;
}
