//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_ltr4
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 20);

    // Set the variables
    SetCampaignInt("MinorQuests", "iElsworthquest", 11, GetPCSpeaker());



   //create alignment shifts +1 EVIL +1 CHAOTIC

   object oReader = GetPCSpeaker();
   AdjustAlignment(oReader, ALIGNMENT_EVIL, 1, FALSE);


   AdjustAlignment(oReader, ALIGNMENT_CHAOTIC, 1, FALSE);
   }
