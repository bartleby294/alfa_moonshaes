//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
if(Random (2) == 1) {
    CreateObject(OBJECT_TYPE_ITEM, "batwing", GetLocation(OBJECT_SELF));
    }
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
