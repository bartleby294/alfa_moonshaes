//#include "omega_include"
void main()
{

    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sItem = GetTag(oItem);
    string sName = GetName(oItem);
    location lLoc = GetItemActivatedTargetLocation();
    string sRef = GetResRef(oItem);
    object oOwner = GetItemPossessor(oItem);

 if(sItem == "043_BLAKBRDL_01")
    {

       // get the Bridle's activator and target, put target info into local vars on activator
       SetLocalObject(oOwner, "BBTarget", oTarget);
       SetLocalLocation(oOwner, "BBLoc", lLoc);

       object oTest=GetFirstPC();
       string sTestName = GetPCPlayerName(OBJECT_SELF);
       // Test to make sure the activator is a DM, or is a DM
       // controlling a creature.

       //while (GetIsObjectValid(oTest) == TRUE)
       //{
          //if (GetPCPlayerName(oTest) == sTestName && GetIsDM(oTest) == FALSE)
          //{
              //DestroyObject(oItem);
              //SendMessageToPC(oOwner,"You are mortal and this is not yours!");
              //return;
          //}
          //oTest=GetNextPC();
       //}
      //Make the activator start a conversation with itself
      AssignCommand(oOwner, ActionStartConversation(OBJECT_SELF, "c_horse_07", TRUE));
           }
           object oMyTarget = GetLocalObject(oOwner, "BBTarget");
              if (GetIsObjectValid(oMyTarget) == TRUE)
              {
           string oTname = GetName(oMyTarget);
           string oDname = GetDeity(oMyTarget);
           //setting custom tokens for coversation
           SetCustomToken(6910, oTname); //Target name
           SetCustomToken(6911, oDname); //Diety Name
           }
           else
           {
           SetCustomToken(6910, "A Location");  //Target name if location
    }
   }
