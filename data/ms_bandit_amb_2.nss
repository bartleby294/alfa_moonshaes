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
#include "_btb_ban_util"

void pcSpotListenCheck(object curPC, int bandHide, int bandMoveSilently) {

    int spotSuccess = FALSE;
    int listenSuccess = FALSE;
    int listenCheck = d20(1) + GetSkillRank(SKILL_LISTEN, curPC, FALSE);
    int spotCheck = d20(1) + GetSkillRank(SKILL_SPOT, curPC, FALSE);

    if(spotCheck > d20() + bandHide) {
        spotSuccess = TRUE;
    }

    if(listenCheck > d20() + bandMoveSilently) {
        listenSuccess = TRUE;
    }

    string pcMsg = "";

    /* Bandits just saw you you spot the ambush*/
    if(spotSuccess && !listenSuccess) {
        writeToLog("Spot Success");
        switch (Random(3) + 1)
        {
            case 1:
                 pcMsg = "Did that bush just move?";
            case 2:
                 pcMsg = "Was that a shadow up ahead?";
            case 3:
                 pcMsg = "A rabbit runs hurriedly across your path.";
        }
    }

    if(!spotSuccess && listenSuccess) {
        writeToLog("Listen Success");
        switch (Random(3) + 1)
        {
            case 1:
                 pcMsg = "Was that a muffled voice?";
            case 2:
                 pcMsg = "You hear a twig snap.";
            case 3:
                 pcMsg = "It seems unnaturally quiet here?";
        }
    }

    if(spotSuccess && listenSuccess) {
        writeToLog("Spot and Listen Success");
        switch (Random(3) + 1)
        {
            case 1:
                 pcMsg = "You see a bush move and rustle unnaturally ahead.";
            case 2:
                 pcMsg = "You see a humanoid form snap a branch and move behind a tree ahead.";
            case 3:
                 pcMsg = "You see a crow caw and swoop at the undergrowth in the distance.";
        }
    }

    if(spotSuccess && !listenSuccess) {
        writeToLog("Listen and Spot Fail");
    }

    if(GetStringLength(pcMsg) > 0) {
        SendMessageToPC(curPC, pcMsg);
    }
}

void main()
{

    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) == FALSE || GetIsDM(oPC) == TRUE) {
        return;
    }

    object banditAmbushTrigger3 = GetNearestObjectByTag("bandit_amb_3");
    int bandMoveSilently = GetLocalInt(banditAmbushTrigger3,
                                       MS_BANDIT_AMBUSH_BANDIT_MS);
    int bandHide = GetLocalInt(banditAmbushTrigger3,
                                       MS_BANDIT_AMBUSH_BANDIT_HIDE);
    pcSpotListenCheck(oPC, bandHide,  bandMoveSilently);
}
