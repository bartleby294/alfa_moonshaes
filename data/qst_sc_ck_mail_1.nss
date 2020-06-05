/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Check for Mail type quest.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "custom_tokens"
int StartingConditional()
{
    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    // Inspect local variables
    if(!(RetrieveQuestState(sName, oPC) == 1))
    {
        return FALSE;
    }
    else
    {
        string sMail2Give = "quest_" + sName + "_02";
        object oMail2Give = GetObjectByTag(sMail2Give, 0);
        SetCustomToken(ITEM_MAIL_PACKAGE, GetName(oMail2Give));

        if (DEBUG_CODE == 1)
        {
            string part2 = sMail2Give;
            string Message2 = GetTag(oMail2Give) + " - - > " + sMail2Give;
            SendMessageToPC(oPC, Message2);
            if(GetObjectByTag(sMail2Give) == OBJECT_INVALID)
            {
                SendMessageToPC(oPC, "OBJECT_INVALID");
            }
        }
        return TRUE;
    }
}
