/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Quest style mail  Set name for use in conversations
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
    if(!(RetrieveQuestState(sName, oPC) == 9))
    {
        return FALSE;
    }
    else
    {
        int iQst = RetrieveQuestState(sName, oPC);

        iQst++;

        int iValue = iQst + 1;
        string sQst = IntToString(iValue);
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
