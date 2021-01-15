#include "x2_inc_itemprop"
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

    WriteTimestampedLogEntry("acValue: " + IntToString(acValue));
    WriteTimestampedLogEntry("randChest: " + IntToString(randChest));
    //WriteTimestampedLogEntry(": " + IntToString(acValue));
    //WriteTimestampedLogEntry(": " + IntToString(acValue));
    return UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                   ITEM_APPR_ARMOR_MODEL_TORSO, randChest);
}

object randomizeStyle(object oArmor) {

    WriteTimestampedLogEntry("randomizeStyle:");
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

    WriteTimestampedLogEntry("randBicept:" + IntToString(randBicept));
    WriteTimestampedLogEntry("randFoot:"   + IntToString(randFoot));
    WriteTimestampedLogEntry("randForearm:" + IntToString(randForearm));
    WriteTimestampedLogEntry("randFoot:"   + IntToString(randFoot));

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
    WriteTimestampedLogEntry("acValue: " + IntToString(GetItemACValue(oArmor)));
    WriteTimestampedLogEntry("randHand:" + IntToString(randHand));
    WriteTimestampedLogEntry("randShin:"   + IntToString(randShin));
    WriteTimestampedLogEntry("randShoulder:" + IntToString(randShoulder));
    WriteTimestampedLogEntry("randThigh:"   + IntToString(randThigh));

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

    WriteTimestampedLogEntry("randArmorResref2: " + resRef + IntToString(randArmor));

    return resRef + IntToString(randArmor);
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
