//::///////////////////////////////////////////////
//:: Name x2_def_onconv
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Conversation script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object oChair = GetNearestObjectByTag("Chair");
    //Make sure no one is in chair, if not sit-down.
    if(!GetIsObjectValid(GetSittingCreature(oChair)))
     {
     ClearAllActions(); //This is so he don't spin in his chair, following you.
     ActionSit(oChair);
     }
    ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
