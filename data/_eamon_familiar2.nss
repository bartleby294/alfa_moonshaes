#include "_btb_dms_rsi_con"

void main()
{
    // check if DM has toggled off custom scripts.
    int curState = GetLocalInt(GetArea(OBJECT_SELF), EAMON_STATE);
    if (curState == CONVERSATION_DM_DISABLED) {
        return;
    }

    object oPC = GetEnteringObject();
    string opening;
    string middle;
    string last;
    string oPCName = GetName(oPC);

    if(!GetIsPC(oPC)) {
        return;
    }

    int stringcutoff = FindSubString(oPCName, " ");

    string oPCFirstName = GetStringLeft(oPCName, stringcutoff);

    int Familiarity = GetCampaignInt("moonshaes","Eamon_familiarity", oPC);
    Familiarity = Familiarity + 1;
    int x = d4(1);

    if(x==1)
    {
       opening = "**Looks up from wiping down bar** ";
       SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
    }
    if(x==2)
    {
      opening = "**Spits in a mug and wipes it out** ";
      SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
    }
    if(x==3)
    {
      opening = "**Smiles broadly** ";
      SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
    }
    if(x==4)
    {
      opening = "**Nods to you as you aproach** ";
      SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
    }

    if(Familiarity <= 5)
    {
      middle = "Can i get you anything? ";
      SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
    }

    if(Familiarity > 5 && Familiarity <= 20)
    {
      middle = "What'll it be?";
      SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
    }

    if(Familiarity > 20 && Familiarity <= 45)
    {
      middle =  "Hello " + oPCFirstName +" right?  What'll ya have?";
         //SetCustomToken(999, middle);
         //SetCustomToken(998, last);
      SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
       //AssignCommand(GetNearestObjectByTag("Eamon"), SpeakOneLinerConversation( "_eamon_fam01" , oPC));
          // return;
    }

    if(Familiarity > 45 && Familiarity <= 150)
    {
      middle = "Whatll it be today " + oPCFirstName;
      SetCampaignInt("moonshaes","Eamon_familiarity", Familiarity, oPC);
           // SetCustomToken(999, middle);
            //SetCustomToken(998, last);
        //AssignCommand(GetNearestObjectByTag("Eamon"), SpeakOneLinerConversation( "_eamon_fam01" , oPC));
           //return;
    }

    if(Familiarity > 150)
    {
      middle = "The usual " + oPCFirstName + "?";
          //SetCustomToken(999, opening + middle);
           //SetCustomToken(998, last);
            //AssignCommand(GetNearestObjectByTag("Eamon"), SpeakOneLinerConversation( "_eamon_fam01" , oPC));
           //return;
    }

   AssignCommand(GetNearestObjectByTag("Eamon"), SpeakString( opening + middle));
}
