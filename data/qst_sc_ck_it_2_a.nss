/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Check for 2 Items to take and Normal intelligence  (style 2 quest)
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "NW_I0_PLOT"
#include "custom_tokens"

int StartingConditional()
{

    string sGet_Item = GetLocalString(OBJECT_SELF, "item_2_take");
    string sGet_Item2 = GetLocalString(OBJECT_SELF, "item_2_take1");

    // Make sure the PC speaker has these items in their inventory
    if((HasItem(GetPCSpeaker(), sGet_Item)) && (!CheckIntelligenceLow()) && (HasItem(GetPCSpeaker(), sGet_Item2)))
    {
        return TRUE;
    }
    return FALSE;
}
