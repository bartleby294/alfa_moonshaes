/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Quest style mail  with normal intelligence to set conversation stuff
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "custom_tokens"
#include "NW_I0_PLOT"

int StartingConditional()
{
    if ((!CheckIntelligenceLow()) == 1)
    {
        string sMail2Give = GetLocalString(OBJECT_SELF, "mail_2_get");
        object oMail2Give = GetObjectByTag(sMail2Give);
        SetCustomToken(ITEM_MAIL_PACKAGE, GetName (oMail2Give));
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
