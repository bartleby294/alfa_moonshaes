/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Check for Mail type quest.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "nw_i0_tool"

int StartingConditional()
{

    string sGet_Item = GetLocalString(OBJECT_SELF, "mail_2_get");

    if (sGet_Item == "")
    {
        return FALSE;
    }
    else if (!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
