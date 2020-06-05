/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Check for Item to take and Normal intelligence  (style 1 quest)
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "NW_I0_PLOT"

int StartingConditional()
{

    string sGet_Item = GetLocalString(OBJECT_SELF, "item_2_take");

    // Make sure the PC speaker has these items in their inventory
    if((HasItem(GetPCSpeaker(), sGet_Item)) && (!CheckIntelligenceLow()))
    {
        return TRUE;
    }
    return FALSE;
}
