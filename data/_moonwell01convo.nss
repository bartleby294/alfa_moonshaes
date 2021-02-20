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
#include "_btb_moonwellcon"

void main()
{
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob");
    SetLocalInt(obHbObj, "state", LEAVING_STATE);
    ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
