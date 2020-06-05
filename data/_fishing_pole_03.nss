#include "nw_i0_2q4luskan"
#include "x0_i0_position"

void main()
{
   object  oPC = OBJECT_SELF;
   object oArea = GetArea(oPC);
   object oItem = GetItemActivated();
   location oItemLoc = GetItemActivatedTargetLocation();

   location oPCLoc = GetLocation(oPC);

   float oPCfacing = GetFacingFromLocation(oPCLoc)+90;
   vector oItemVec = GetPositionFromLocation(oItemLoc);

   location oItemLocFinal = Location(oArea, oItemVec, oPCfacing);

   AssignCommand(oPC, ActionSpeakString("*Cleans fish and sets up a spit.*"));
   CreateObjectVoid(OBJECT_TYPE_PLACEABLE , "_fish_placeable01", oItemLocFinal , FALSE);

   int rand2 = d20(2)+d10(10);

   if(GetTag(oItem) == "_fishing_item14")
   {
        int rand = d100(1);

        if(rand == 100)
        {
           DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString("*As you start to gut the fish a small tin soldier falls out.*")));
           DelayCommand(2.3, CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item08", GetLocation(oPC) , FALSE));
           return;
        }
   }
   if(rand2 == 50)
   {
       DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString("*You notice a lure stuck in the fishes mouth.*")));
       DelayCommand(2.3, CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item10", GetLocation(oPC) , FALSE));
       return;
   }


}
