#include "x2_inc_itemprop"

///////ARMOR///////
object randomizeStyle(object oArmor, object chest){

    int acValue = GetItemACValue(oArmor);

    int randChest = Random(103);//IPGetRandomArmorAppearanceType(oArmor,
                                                  //ITEM_APPR_ARMOR_MODEL_TORSO);
    object oNewArmor = CopyItemAndModify(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                         ITEM_APPR_ARMOR_MODEL_TORSO, randChest,
                                         TRUE);
    DestroyObject(oArmor);
    //DestroyObject(oArmor);
    while(GetItemACValue(oNewArmor) != acValue) {

        int test = IPGetRandomArmorAppearanceType(oNewArmor,
                                                   ITEM_APPR_ARMOR_MODEL_TORSO);
        string say1 = "test: " + IntToString(test);
        AssignCommand(chest, ActionSpeakString(say1));

        randChest = Random(103);
        DestroyObject(oNewArmor);
        oNewArmor = CopyItemAndModify(oNewArmor, ITEM_APPR_TYPE_ARMOR_MODEL,
                                      ITEM_APPR_ARMOR_MODEL_TORSO, randChest,
                                      TRUE);
    }

    string say1 = "acValue: " + IntToString(acValue);
    string say2 = "oNewArmor acValue: " + IntToString(GetItemACValue(oNewArmor));
    string say3 = "randChest: " + IntToString(randChest);
    AssignCommand(chest, ActionSpeakString(say1));
    AssignCommand(chest, ActionSpeakString(say2));
    AssignCommand(chest, ActionSpeakString(say3));
/*
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


    oArmor = IPGetModifiedArmor(oArmor, ITEM_APPR_ARMOR_MODEL_BELT, X2_IP_ARMORTYPE_RANDOM, TRUE);
*/




    //object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify, iNewApp, TRUE);

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
