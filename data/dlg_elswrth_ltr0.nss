// OnActivateItem Script: dlg_elswrth_ltr
//
// This script activates the letter conversation for the Elsworths Love Letter quest.
//
// Written By: El Grillo
// Last Updated: 28/02/21
//

void main()
{
    object oItem = GetItemActivated();

 if(GetTag(oItem) ==  "ElsworthsLoveLetter")
    {
      //Get the PC first
      object oPC = GetItemActivator();

      //Make the activator start a conversation with itself
      AssignCommand(oPC, ActionStartConversation(oPC, "_cor_letterqultr", TRUE));
            }
         }

  /*****************************************************/

