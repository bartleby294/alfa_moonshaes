#include "loot_cfg_notify"
#include "loot_base_item"

int NotifyType;
float NotifyDistance;
int DMNotify;
int EnableHiddenPocket;
int StealthModeType;
int StealthSpotPenalty;
int CombatSpotPenalty;
int SpottedNotifyType;
int AutoDistributeGold;

void lootNotify(object oItem, object oPC) {
    cfg_LootNotify();
    /* setup rest of vars */
    int bModDebug = GetLocalInt(GetModule(),"bModDebug");
    int iContinue,x,y;
    int iBaseItemType = GetBaseItemType(oItem);
    string sPCName = GetName(oPC);
    string sItemName = GetName(oItem);
    vector v1=GetPosition(oPC);
    vector v2;
    location locDrop;

    // calculate item encumbrance
    x = GetLocalInt(GetModule(),"baseitem_size_" + IntToString(iBaseItemType));
    if (!x) x = 1;
    float fItemEncumberance = IntToFloat(x) * IntToFloat(GetWeight(oItem)) / 10.0;
    if (bModDebug) SendMessageToPC(GetFirstPC(),"[DOA_lootnotify] Item encumbrance: "+FloatToString(fItemEncumberance));

    object oTemp, oNewItem;
    object oArea = GetArea(oPC);
    object oBag = GetItemPossessedBy(oPC, "doa_hiddenpocket");

    /* item name manipulation */
    if (!GetIdentified(oItem)) sItemName = GetBaseItemName(oItem);
    sItemName = GetBaseItemPreposition(oItem) + sItemName;

    /* hidden pocket -- where'd the item go? */
    iContinue = FALSE; // reassigned var
    if (GetIsObjectValid(oBag)) {
        if (bModDebug) SendMessageToPC(GetFirstPC(),"[DOA_lootnotify] PC possesses hidden pocket");
        SetLocalInt(oItem, "looted", 1);
        oTemp = GetFirstItemInInventory(oBag);
        while (GetIsObjectValid(oTemp)) {
            if (GetLocalInt(oTemp, "looted")) {
                if (bModDebug) SendMessageToPC(GetFirstPC(),"[DOA_lootnotify] Item went in hidden pocket");
                iContinue = TRUE;
                break;
            }
            oTemp = GetNextItemInInventory(oBag);
        }
        DeleteLocalInt(oItem, "looted");
    }

    /* item in hidden pocket -- too big? */
    if (iContinue) {
        if (fItemEncumberance > 12.0f) { // break hidden pocket
            SendMessageToPC(oPC, "Your Hidden Pocket was ripped apart by attempting to place " + sItemName + " into it. The contents in the Hidden Pocket fall to the ground.");
            if (DMNotify) SendMessageToAllDMs("[DOA Party Loot Notification] "+sPCName+" attempted to place " + sItemName + " into their Hidden Pocket. The item was too big, destroying the Hidden Pocket and causing its contents to fall to the ground.");
            oTemp = GetFirstItemInInventory(oBag);
            while (GetIsObjectValid(oTemp)) {
                while (TRUE) { // find valid drop loc
                    v2=Vector(v1.x-1.0+IntToFloat(d8())/4.0,v1.y-1.0+IntToFloat(d8())/4.0,v1.z);
                    locDrop=Location(oArea,v2,IntToFloat(Random(360)));
                    if (GetFirstObjectInShape(SHAPE_SPHERE, 1.0, locDrop, TRUE, OBJECT_TYPE_PLACEABLE) == OBJECT_INVALID) break;
                    x++; if (x > 10) break; //giveup
                }
                oNewItem = CopyObject(oTemp,locDrop);
                SetPlotFlag(oTemp, FALSE);
                oTemp = GetNextItemInInventory(oBag);
            }
            SetPlotFlag(oBag, FALSE);
            DestroyObject(oBag);
            iContinue = FALSE; // normal looting notification, no point adding injury to insult ;)
        }
    }

    /* check if enabled or in party, last exit before reporting */
    if (!bModDebug) {
        x = 0;
        oTemp = GetFirstFactionMember(oPC);
        while (GetIsObjectValid(oTemp)) {
            x++;
            oTemp = GetNextFactionMember(oPC);
            if (x > 1) break;
        }
        if ((NotifyType == 0) || (x == 1)) {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));
            return;
        }
    }

    /* item in hidden pocket -- is hidden pocket enabled and PC has pickpocket skills? */
    x = TRUE; if (iContinue && EnableHiddenPocket && GetHasSkill(SKILL_PICK_POCKET, oPC)) x = FALSE;
    iContinue = x; // reassigned var, proxy for iContinue

    /* let's report */
    if (iContinue) { // normal looting
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));
        if ((NotifyType == 2) || (NotifyType == 3)) {
            FloatingTextStringOnCreature("- " +sPCName+ " has looted " +sItemName+ " -", oPC, TRUE);
        }
        if ((NotifyType == 1) || (NotifyType == 3)) {
            oTemp = GetFirstFactionMember(oPC);
            oTemp = GetNextFactionMember(oPC);
            while (GetIsObjectValid(oTemp)) {
                if (GetDistanceBetween(oPC, oTemp) < NotifyDistance) SendMessageToPC(oTemp, "[Party] "+ sPCName + " has looted " + sItemName);
                oTemp = GetNextFactionMember(oPC);
            }
        }
        if (DMNotify) SendMessageToAllDMs("[DOA Party Loot Notification] "+sPCName+" has looted " +sItemName);
    } else { // hidden pocket looting
        iContinue = TRUE; // reassigned var
        int iPCSkill = d20() + GetSkillRank(SKILL_PICK_POCKET, oPC);
        int iItemSpotBonus = FloatToInt(pow((fItemEncumberance/2.0),2.0f)) + 4;
        /* Function evaluates to:
           Encumberance 1   2   3   4   5   6   7   8   9   10  11  12
           Difficulty   4   5   6   8   10  13  16  20  24  29  34  40 */

        if (iItemSpotBonus > iPCSkill) {  // pickpocket requires two rolls, first for difficulty of object
            // failed roll, fumbles item to ground
            SendMessageToPC(oPC, "You fumble the attempt to conceal " + sItemName + " in your Hidden Pocket and it falls to the ground. (Difficulty="+IntToString(iItemSpotBonus)+" vs. PC pickpocket roll="+IntToString(iPCSkill)+")");
            if (DMNotify) SendMessageToAllDMs("[DOA Party Loot Notification] "+sPCName+" fumbled the attempt to conceal looting " +sItemName);
            while (TRUE) { // find valid drop loc
                v2=Vector(v1.x-1.0+IntToFloat(d8())/4.0,v1.y-1.0+IntToFloat(d8())/4.0,v1.z);
                locDrop=Location(oArea,v2,IntToFloat(Random(360)));
                if (GetFirstObjectInShape(SHAPE_SPHERE, 1.0, locDrop, TRUE, OBJECT_TYPE_PLACEABLE) == OBJECT_INVALID) break;
                x++; if (x > 10) break; //giveup
            }
            oNewItem = CopyObject(oItem,locDrop);
            SetPlotFlag(oItem, FALSE);
            DestroyObject(oItem);
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));
            iContinue = FALSE;
        }
        if (iContinue) {  // pickpocket requires two rolls, second for spot
            iPCSkill = d20() + GetSkillRank(SKILL_PICK_POCKET, oPC);
            oTemp = GetFirstFactionMember(oPC);
            oTemp = GetNextFactionMember(oPC);
            if ((GetStealthMode(oPC) == STEALTH_MODE_ACTIVATED) && (StealthModeType == 1)) { iPCSkill = iPCSkill - StealthSpotPenalty; // negative number added
            } else { y = d20() + GetSkillRank(SKILL_HIDE, oPC); } // reassigned var y = PCHideSkill
            while (GetIsObjectValid(oTemp)) {
                if ((GetDistanceBetween(oPC, oTemp) < NotifyDistance) && !(GetIsDead(oTemp))) {
                    EnableHiddenPocket = TRUE; // reassigned var = PartyMemberAwake
                    effect eEffect = GetFirstEffect(oTemp);
                    while (GetIsEffectValid(eEffect)) {
                        if ((GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS) || (GetEffectType(eEffect) == EFFECT_TYPE_SLEEP)) {
                            EnableHiddenPocket = FALSE;
                            break;
                        }
                        eEffect = GetNextEffect(oTemp);
                    }
                    if (EnableHiddenPocket) {
                        x = d20() + GetSkillRank(SKILL_SPOT, oTemp); // reassigned var x = PartyMemberSkill
                        if ((GetStealthMode(oPC) == STEALTH_MODE_ACTIVATED) && (StealthModeType == 2)) { // yet another contest ;)
                            if (x < y) EnableHiddenPocket = FALSE; // reassigned var
                        }
                        if (EnableHiddenPocket) {
                            if (GetIsObjectValid(GetAttemptedAttackTarget()) || GetIsObjectValid(GetAttemptedSpellTarget()))  x = x + CombatSpotPenalty;
                            if ((x + iItemSpotBonus) > (iPCSkill)) {
                                if (SpottedNotifyType == 3) {
                                    iContinue = FALSE;
                                    break;
                                } else {
                                    if (SpottedNotifyType == 1) SendMessageToPC(oTemp, "You spotted " + sPCName + " attempting to conceal looting " + sItemName);
                                    if (SpottedNotifyType == 2) FloatingTextStringOnCreature("You spotted " +sPCName+ " attempting to conceal looting " +sItemName, oTemp, FALSE);
                                    if (DMNotify) SendMessageToAllDMs("[DOA Party Loot Notification] "+GetName(oTemp)+" spotted "+sPCName+" attempting to conceal looting " +sItemName);
                                }
                            }
                        }
                    }
                }
                oTemp = GetNextFactionMember(oPC);
            }
        }
        /* bad thief :) */
        if (!(iContinue) && ((NotifyType == 2) || (NotifyType == 3))) {
            FloatingTextStringOnCreature("- " +sPCName+ " attempted to conceal looting " +sItemName+ " -", oPC, TRUE);
        }
        if (!(iContinue) && ((NotifyType == 1) || (NotifyType == 3))) {
            oTemp = GetFirstFactionMember(oPC);
            oTemp = GetNextFactionMember(oPC);
            while (GetIsObjectValid(oTemp)) {
                if (GetDistanceBetween(oPC, oTemp) < NotifyDistance) SendMessageToPC(oTemp, "[Party] "+ sPCName + " attempted to conceal looting " + sItemName);
                oTemp = GetNextFactionMember(oPC);
            }
        }
        if (iContinue && DMNotify) SendMessageToAllDMs("[DOA Party Loot Notification] "+sPCName+" successfully concealed looting " +sItemName);
        else if (!(iContinue) && DMNotify) SendMessageToAllDMs("[DOA Party Loot Notification] "+sPCName+" attempted to conceal looting " +sItemName);
    }
}

//void main(){}

