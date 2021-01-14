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

object getRandomTorso(object oArmor) {
    int breakout = 0;
    int acValue = GetItemACValue(oArmor);
    int randChest = Random(103);
    oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                   ITEM_APPR_ARMOR_MODEL_TORSO, randChest);

    while(GetItemACValue(oArmor) != acValue) {
        randChest = Random(103);
        oArmor = UpdateArmorAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                   ITEM_APPR_ARMOR_MODEL_TORSO, randChest);
        WriteTimestampedLogEntry("-----------------------");
        WriteTimestampedLogEntry("randChest: " + IntToString(randChest));
        WriteTimestampedLogEntry("Orig AC: " + IntToString(acValue));
        WriteTimestampedLogEntry("New  AC: " + IntToString(GetItemACValue(oArmor)));
        breakout = breakout + 1;
        if(breakout > 50) {
            WriteTimestampedLogEntry("Break Out");
            WriteTimestampedLogEntry("-----------------------");
            return OBJECT_INVALID;
        }
        WriteTimestampedLogEntry("-----------------------");
    }

    return oArmor;
}

object randomizeStyle(object oArmor) {

    object oFallbackArmor = oArmor;
    object oNewArmor = getRandomTorso(oArmor);
    if(oNewArmor == OBJECT_INVALID) {
        return oFallbackArmor;
    } else {
        DestroyObject(oFallbackArmor);
    }

    /*int randBicept = IPGetRandomArmorAppearanceType(
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

    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LBICEP, randBicept);
    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RBICEP, randBicept);

    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LFOOT, randFoot);
    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RFOOT, randFoot);

    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LFOREARM,
                                      randForearm);
    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RFOREARM,
                                      randForearm);

    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LHAND, randHand);
    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RHAND, randHand);

    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LSHIN, randShin);
    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RSHIN, randShin);

    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LSHOULDER,
                                      randShoulder);
    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RSHOULDER,
                                      randShoulder);

    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_LTHIGH, randThigh);
    oNewArmor = UpdateArmorAppearance(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_RTHIGH, randThigh);

    oNewArmor = IPGetModifiedArmor(oNewArmor, ITEM_APPR_ARMOR_MODEL_BELT,
                                    X2_IP_ARMORTYPE_RANDOM, TRUE);
    oNewArmor = IPGetModifiedArmor(oNewArmor, ITEM_APPR_ARMOR_MODEL_NECK,
                                    X2_IP_ARMORTYPE_RANDOM, TRUE);
    oNewArmor = IPGetModifiedArmor(oNewArmor, ITEM_APPR_ARMOR_MODEL_PELVIS,
                                    X2_IP_ARMORTYPE_RANDOM, TRUE);*/

    return oNewArmor;
}

string getRandomBaseArmor() {
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
