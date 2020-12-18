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
    if(!(RetrieveQuestState(sName, oPC) == 7))
    {
        return FALSE;
    }
    else
    {
        string sMail2Give = "quest_" + sName + "_08";
        object oMail2Give = GetObjectByTag(sMail2Give);
        SetCustomToken(ITEM_MAIL_PACKAGE, GetName(oMail2Give));
        if (DEBUG_CODE == 1)
        {
            string Message2 = GetName(oMail2Give) + " - - > " + sMail2Give;
            SendMessageToPC(oPC, Message2);
            if(GetObjectByTag(sMail2Give) == OBJECT_INVALID)
            {
                SendMessageToPC(oPC, "OBJECT_INVALID");
            }
        }
        return TRUE;
    }
}
