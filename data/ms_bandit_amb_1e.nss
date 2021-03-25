/*
 *  This script is a part of a suite of scripts which should be placed on
 *  nested triggers.
 *
 *  Placed on trigger with tag: "bandit_amb_1":
 *      ms_bandit_amb1e - On Enter, Collects PCs to target/evaluate.
 *  Placed on trigger with tag: "bandit_amb_1":
 *      ms_bandit_amb1x - On Exit,  Removes  PCs to target/evaluate.
 *  Placed on trigger with tag: "bandit_amb_2":
 *      ms_bandit_amb2 - On Enter, Chance for PCs to notice ambush.
 *  Placed on trigger with tag: "bandit_amb_3":
 *      ms_bandit_amb3 - On Enter, Go/No Go and drop bandits if go.
 */
#include "ms_bandit_ambcon"
#include "nwnx_data"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) == FALSE || GetIsDM(oPC) == TRUE) {
        return;
    }

    object banditAmbushTrigger3 = GetNearestObjectByTag("bandit_amb_3");
    NWNX_Data_Array_PushBack_Obj(banditAmbushTrigger3,
                                 MS_BANDIT_AMBUSH_PC_ARRAY, oPC);
}
