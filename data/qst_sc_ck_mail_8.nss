/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        mail quest conversations
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "x0_i0_partywide"
#include "nw_i0_plot"
#include "custom_tokens"

int StartingConditional()
{
    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    // Inspect local variables
    if(!(RetrieveQuestState(sName, oPC) == 8))
    {
        return FALSE;
    }
    else
    {
        int iQst = RetrieveQuestState(sName, oPC);
        iQst += 2;
        string sQst = IntToString(iQst);
        int length = GetStringLength(sQst);
        if (length == 1)
        {
            sQst = "_0" + sQst;
        }
        else if (length == 2)
        {
            sQst = "_" + sQst;
        }

        string sMail2Give = "quest_" + sName + sQst;
        object oMail2Give = GetObjectByTag(sMail2Give);
        SetCustomToken(ITEM_MAIL_PACKAGE, GetName(oMail2Give));
        return TRUE;
    }
}
