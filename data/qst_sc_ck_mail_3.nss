/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        mail quest conversations
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "custom_tokens"
int StartingConditional()
{
    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    // Inspect local variables
    if(!(RetrieveQuestState(sName, oPC) == 3))
    {
        return FALSE;
    }
    else
    {
        string sMail2Give = "quest_" + sName + "_04";
        object oMail2Give = GetObjectByTag(sMail2Give);
        SetCustomToken(ITEM_MAIL_PACKAGE, GetName(oMail2Give));

        if (DEBUG_CODE == 1)
        {
            SendMessageToPC(oPC, sMail2Give);
            SendMessageToPC(oPC, GetName(oMail2Give));
        }
        return TRUE;
    }
}
