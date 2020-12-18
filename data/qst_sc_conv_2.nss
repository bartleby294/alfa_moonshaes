/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        starting conversations  2
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "nw_i0_plot"
#include "custom_tokens"

int StartingConditional()
{
    SetCustomToken(CONVERSATION_2, GetLocalString(OBJECT_SELF, "Conv_2"));
    return TRUE;
}
