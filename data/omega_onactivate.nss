/******************************************************************
 * Name: omega_include
 * Type: OnActivateItem
 * ---
 * Author: LP (Nick)
 * Date: 02/28/04
 * ---
 * This handles all the basic functions of the activated
 * item as well as defining custom tokens
 ******************************************************************/


void main()
{
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sItem = GetTag(oItem);
    string sName = GetName(oItem);
    location lLoc = GetItemActivatedTargetLocation();
    string sRef = GetResRef(oItem);
    object oOwner = GetItemPossessor(oItem);

 if(sItem == "omega_wand")
    {

       // get the wand's activator and target, put target info into local vars on activator
       SetLocalObject(oOwner, "OMWandTarget", oTarget);
       SetLocalLocation(oOwner, "OMWandLoc", lLoc);

       object oTest=GetFirstPC();
       string sTestName = GetPCPlayerName(OBJECT_SELF);
       // Test to make sure the activator is a DM, or is a DM
       // controlling a creature.

       while (GetIsObjectValid(oTest) == TRUE)
       {
          if (GetPCPlayerName(oTest) == sTestName && GetIsDM(oTest) == FALSE)
          {
              DestroyObject(oItem);
              SendMessageToPC(oOwner,"You are mortal and this is not yours!");
              return;
          }
          oTest=GetNextPC();
       }

      //Make the activator start a conversation with itself
      AssignCommand(oOwner, ActionStartConversation(OBJECT_SELF, "omega_convo", TRUE));
           }
           object oMyTarget = GetLocalObject(oOwner, "OMWandTarget");
              if (GetIsObjectValid(oMyTarget) == TRUE)
              {
           string oTname = GetName(oMyTarget);
           string oDname = GetDeity(oMyTarget);
           //setting custom tokens for coversation
           SetCustomToken(6900, oTname); //Target name
           SetCustomToken(6901, oDname); //Diety Name
           }
           else
           {
           SetCustomToken(6900, "A Location");  //Target name if location
    }
   }


  /*****************************************************/
