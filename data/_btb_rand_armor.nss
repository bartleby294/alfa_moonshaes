#include "x2_inc_itemprop"
#include "_btb_rloot_util"

///////ARMOR///////
object UpdateArmorAppearance(object oItem, int nType, int nIndex, int nNewValue,
                             int bCopyVars=FALSE, int nDestroySource=TRUE) {
    object oNew = CopyItemAndModify(oItem, nType, nIndex, nNewValue, bCopyVars);
    if(nDestroySource) {
        DestroyObject(oItem);
    }
    return oNew;
}

int isValidTorsoId(int id) {
    if( id == 9 || id == 10 || id == 60 || id == 61 || id == 62 || id == 63
                || id == 65 || id == 71 || id == 93 || id == 94 || id == 95
                || id == 96 || id == 100 || id == 106) {
        return FALSE;
    }
    return TRUE;
}

int isBareTorso(int id) {
    if( id == 0 || id == 30 || id == 32 || id == 34 || id == 35) {
        return TRUE;
    }
    return FALSE;
}

object randomizeStyle(object oArmor) {

    //WriteTimestampedLogEntry("randomizeStyle: start");
    int randBicept = IPGetRandomArmorAppearanceType(
                                          oArmor, ITEM_APPR_ARMOR_MODEL_LBICEP);
    int randFoot = IPGetRandomArmorAppearanceType(
                                          oArmor, ITEM_APPR_ARMOR_MODEL_LFOOT);
    int randForearm = IPGetRandomArmorAppearanceType(
                                        oArmor, ITEM_APPR_ARMOR_MODEL_LFOREARM);
    int randHand = IPGetRandomArmorAppearanceType(
                                          oArmor, ITEM_APPR_ARMOR_MODEL_LHAND);
    int randShin = IPGetRandomArmorAppearanceType(
                                          oArmor, ITEM_APPR_ARMOR_MODEL_LSHIN);
    int randShoulder = IPGetRandomArmorAppearanceType(
                                       oArmor, ITEM_APPR_ARMOR_MODEL_LSHOULDER);
    int randThigh = IPGetRandomArmorAppearanceType(
                                          oArmor, ITEM_APPR_ARMOR_MODEL_LTHIGH);

    int armorTorso = IPGetArmorAppearanceType(oArmor,
                                              ITEM_APPR_ARMOR_MODEL_TORSO,
                                              X2_IP_ARMORTYPE_NEXT);
    if(isBareTorso(armorTorso) == TRUE) {
        randHand = 0;
        randForearm = 0;
        randBicept = 0;
    }

    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LBICEP, randBicept);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RBICEP, randBicept);

    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LFOOT, randFoot);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RFOOT, randFoot);

    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LFOREARM,
                                      randForearm);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RFOREARM,
                                      randForearm);

    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LHAND, randHand);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RHAND, randHand);

    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LSHIN, randShin);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RSHIN, randShin);

    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LSHOULDER,
                                      randShoulder);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RSHOULDER,
                                      randShoulder);

    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LTHIGH, randThigh);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RTHIGH, randThigh);

    oArmor = IPGetModifiedArmor(oArmor, ITEM_APPR_ARMOR_MODEL_BELT,
                                    X2_IP_ARMORTYPE_RANDOM, TRUE);
    oArmor = IPGetModifiedArmor(oArmor, ITEM_APPR_ARMOR_MODEL_NECK,
                                    X2_IP_ARMORTYPE_RANDOM, TRUE);
    oArmor = IPGetModifiedArmor(oArmor, ITEM_APPR_ARMOR_MODEL_PELVIS,
                                    X2_IP_ARMORTYPE_RANDOM, TRUE);
    // Select Colors
    int nColorType;
    for(nColorType = 0; nColorType < 6; nColorType++) {
        oArmor = IPDyeArmor(oArmor, nColorType, Random(64));
    }
    //WriteTimestampedLogEntry("randomizeStyle: end");
    return oArmor;
}

string getRandomBaseArmor() {

    int randArmor = Random(99);
    string resRef = "gen_armor_0";
    while(!isValidTorsoId(randArmor)) {
        randArmor = Random(99);
    }

    if(randArmor < 10) {
        resRef = resRef + "0";
    }

    //WriteTimestampedLogEntry("randArmorResref2: " + resRef
    //                         + IntToString(randArmor));

    return resRef + IntToString(randArmor);
}

int getRandomTorsoId(int ac) {
    if(ac == 0) {
        int random = Random(41);
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 1) {
        int random = Random(3) + 42;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 2) {
        int random = Random(7) + 45;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 3) {
        int random = Random(4) + 52;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 4) {
        int random = Random(15) + 56;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 5) {
        int random = Random(6) +71;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 6) {
        int random = Random(6) + 77;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 7) {
        int random = Random(5) + 83;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 8) {
        int random = Random(11) + 88;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 9) {
        return 99;
    }
    if(ac == 10) {
        int random = Random(2) + 101;
        if(isValidTorsoId(random)){
            return random;
        }
    }
    if(ac == 11) {
        return 103;
    }
    if(ac == 12) {
        return 104;
    }
    if(ac == 13) {
        return 105;
    }
    return -1;
}

object getRandomTorso(object oArmor) {
    int acValue = GetItemACValue(oArmor);
    int randChest = getRandomTorsoId(acValue);

    while (randChest < 0) {
        randChest = getRandomTorsoId(acValue);
    }

    return UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                   ITEM_APPR_ARMOR_MODEL_TORSO, randChest);
}

string getRandomBaseArmorOLD() {
    switch (Random(16)) {
        // Clothing
        case 0:
            return "nw_cloth022";
            /*HEAVY ARMOR*/
            // Full Plate
        case 1:
            return "nw_aarcl007";
            // Half Plate
        case 2:
            return "nw_aarcl006";
            // Splint Mail
        case 3:
            return "nw_aarcl005";
            /*LIGHT ARMOR*/
            // Chain Shirt
        case 4:
            return "nw_aarcl012";
            // Leather Armor
        case 5:
            return "nw_aarcl001";
            // Padded Armor
        case 6:
            return "nw_aarcl009";
            // Studded Leather
        case 7:
            return "nw_aarcl002";

            /*MEDIUM ARMOR*/
            // Breast Plate
        case 8:
            return "nw_aarcl010";
            // Chainmail
        case 9:
            return "nw_aarcl004";
            // Hide Armor
        case 10:
            return "nw_aarcl008";
            // Scale Mail
        case 11:
            return "nw_aarcl003";

            /*SHEILDS*/
            // Heavy Sheild
        case 12:
            return "it_iwoodshldl001";
            // Large Sheild
        case 13:
            return "nw_ashlw001";
            // Small Sheild
        case 14:
            return "nw_ashsw001";
            // Tower Sheilld
        case 15:
            return "nw_ashto001";
    }
    // Clothing
    return "nw_cloth022";
}

object AddRandomMagicArmorProperty(object oArmor, int difficulty_lvl) {
    // NOT FINAL RATIOS TESTING ONLY
    int randChance = Random(100) + 1;

    if(difficulty_lvl < 3) {
        // 60% skill
        if(randChance > 0 && randChance < 60) {
            //WriteTimestampedLogEntry("RandomSkillBoost");
            oArmor = RandomSkillBoost(oArmor);
        } else {
            //WriteTimestampedLogEntry("RandomSavingThrowBoost");
            oArmor = RandomSavingThrowBoost(oArmor);
        }
    } else {
        // 30% skill
        if(randChance > 0 && randChance < 30) {
            //WriteTimestampedLogEntry("RandomSkillBoost");
            oArmor = RandomSkillBoost(oArmor);
        }
        // 30% saving throw
        if(randChance >= 30 && randChance < 60) {
            //WriteTimestampedLogEntry("RandomSavingThrowBoost");
            oArmor = RandomSavingThrowBoost(oArmor);
        }
        // 10% abilities boost
        if(randChance >= 60 && randChance < 70) {
            //WriteTimestampedLogEntry("RandomAbilityBoost");
            oArmor = RandomAbilityBoost(oArmor);
        }
        // 20% AC Boost
        if(randChance >= 70 && randChance < 90) {
            int choice = Random(3);
            if(choice == 0) {
                //WriteTimestampedLogEntry("ACBoostVsAlign");
                oArmor = ACBoostVsAlign(oArmor);
            }
            if(choice == 1) {
                //WriteTimestampedLogEntry("ACBoostVsDmgType");
                oArmor = ACBoostVsDmgType(oArmor);
            }
            if(choice == 2) {
                //WriteTimestampedLogEntry("ACBoostVsRace");
                oArmor = ACBoostVsRace(oArmor);
            }
        }
        // 10% AC Boost
        if(randChance >= 90 && randChance < 100) {
            //WriteTimestampedLogEntry("ACBoostVsRace");
            oArmor = ACBoost(oArmor);
        }

        if(difficulty_lvl > 7 && randChance == 100) {
            // insert specal properties here.
        }
    }
    return oArmor;
}


