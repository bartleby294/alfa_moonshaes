//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_rwd2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 75);


                            // Set the variables
    SetLocalInt(GetPCSpeaker(), "iElsworthquest", 7);

    // Create alignment shift +1 GOOD

    {
    object oReader = GetPCSpeaker();
    AdjustAlignment(oReader, ALIGNMENT_GOOD, 1, FALSE);
       }
    }
