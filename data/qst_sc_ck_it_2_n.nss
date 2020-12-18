/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Check for 1 of 2 Items to take and low intelligence  (style 2 quest)
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
        return FALSE;
    }
    else if(((HasItem(GetPCSpeaker(), sGet_Item)) || (HasItem(GetPCSpeaker(), sGet_Item2))) &&(!CheckIntelligenceLow()))
    {
        if(HasItem(GetPCSpeaker(), sGet_Item))
        {
            object oGet_Item = GetObjectByTag(sGet_Item);
            object oGet_Item2 = GetObjectByTag(sGet_Item2);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            SetCustomToken(ITEM_WANT_NAME_2, GetName(oGet_Item2));
            return TRUE;
        }
        else
        {
            object oGet_Item = GetObjectByTag(sGet_Item2);
            object oGet_Item2 = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            SetCustomToken(ITEM_WANT_NAME_2, GetName(oGet_Item2));
            return TRUE;
        }
    }
    else
    {
            return FALSE;
    }
}
