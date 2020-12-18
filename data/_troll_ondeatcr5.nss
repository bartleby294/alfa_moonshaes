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
    ExecuteScript("nw_c2_default7", OBJECT_SELF);

    object killer = GetLastAttacker(OBJECT_SELF);
    object killer2 = GetLastAttacker(OBJECT_SELF);
    location TrollLoc = GetLocation(OBJECT_SELF);
    string Data = "CR5 Troll killed by:";

    while(killer != OBJECT_INVALID)
    {
        Data = Data + "/n" + GetPCPlayerName(killer);
        killer = GetNextFactionMember(killer, TRUE);
    }

    object TrollToken = CreateItemOnObject("rewardtokencr5no", killer2, 1);
    SetLocalString(TrollToken, "Data", Data);
}
