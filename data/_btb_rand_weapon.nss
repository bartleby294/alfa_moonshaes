#include "x2_inc_itemprop"
#include "_btb_rloot_util"

///////Weapons///////
object RandomizeWeapon(object oWeapon){
    oWeapon = IPGetModifiedWeapon(oWeapon, ITEM_APPR_WEAPON_MODEL_BOTTOM,
                                X2_IP_WEAPONTYPE_RANDOM, TRUE);
    oWeapon = IPGetModifiedWeapon(oWeapon, ITEM_APPR_WEAPON_MODEL_MIDDLE,
                                X2_IP_WEAPONTYPE_RANDOM, TRUE);
    oWeapon = IPGetModifiedWeapon(oWeapon, ITEM_APPR_WEAPON_MODEL_BOTTOM,
                                ITEM_APPR_WEAPON_MODEL_TOP, TRUE);
    return oWeapon;
}

object AddRandomMagicWeaponProperty(object oWeapon, int difficulty_lvl) {
    // NOT FINAL RATIOS TESTING ONLY
    int randChance = Random(100) + 1;

    if(difficulty_lvl < 3) {
        // 60% skill
        if(randChance > 0 && randChance < 60) {
            //WriteTimestampedLogEntry("RandomSkillBoost");
            oWeapon = RandomSkillBoost(oWeapon);
        } else {
            //WriteTimestampedLogEntry("RandomSavingThrowBoost");
            oWeapon = RandomSavingThrowBoost(oWeapon);
        }
    } else {
        // 10% skill
        if(randChance > 0 && randChance < 10) {
            //WriteTimestampedLogEntry("RandomSkillBoost");
            oWeapon = RandomSkillBoost(oWeapon);
        }
        // 10% saving throw
        if(randChance >= 10 && randChance < 20) {
            //WriteTimestampedLogEntry("RandomSavingThrowBoost");
            oWeapon = RandomSavingThrowBoost(oWeapon);
        }
        // 10% abilities boost
        if(randChance >= 20 && randChance < 30) {
            //WriteTimestampedLogEntry("RandomAbilityBoost");
            oWeapon = RandomAbilityBoost(oWeapon);
        }
        // 30% Attack  Boost
        if(randChance >= 30 && randChance < 60) {
            int choice = Random(3);
            if(choice == 0) {
                //WriteTimestampedLogEntry("AttackBonusVsAlign");
                oWeapon = AttackBonusVsAlign(oWeapon);
            }
            if(choice == 1) {
                //WriteTimestampedLogEntry("AttackBonusVsRace");
                oWeapon = AttackBonusVsRace(oWeapon);
            }
            if(choice == 2) {
                //WriteTimestampedLogEntry("AttackBonus");
                oWeapon = AttackBonus(oWeapon);
            }
        }
        // 30% Dmg  Boost
        if(randChance >= 60 && randChance < 90) {
            int choice = Random(3);
            if(choice == 0) {
                //WriteTimestampedLogEntry("DmgBonusVsAlign");
                oWeapon = DmgBonusVsAlign(oWeapon);
            }
            if(choice == 1) {
                //WriteTimestampedLogEntry("DmgBonusVsRace");
                oWeapon = DmgBonusVsRace(oWeapon);
            }
            if(choice == 2) {
                //WriteTimestampedLogEntry("DmgBonus");
                oWeapon = DmgBonus(oWeapon);
            }
        }
        // 10% Enchanted
        if(randChance >= 90 && randChance < 100) {
            //WriteTimestampedLogEntry("ACBoostVsRace");
            oWeapon = EnchantmentBonus(oWeapon);
        }

        if(difficulty_lvl > 7 && randChance == 100) {
            // insert specal properties here.
        }
    }
    return oWeapon;
}

string getRandomBaseWeapon() {
    switch (Random(29)) {
            /*AMMUNITION*/
            // ARROWS
        case 0:
            return "nw_wamar001";
            // BOLT
        case 1:
            return "nw_wambo001";
            // BULLET
        case 2:
            return "nw_wambu001";

            /*AXES*/
            // GREAT
        case 3:
            return "nw_waxgr001";
            // HANDAXE
        case 4:
            return "nw_waxhn001";
            // DWARVEN WARAXE
        case 5:
            return "x2_wdwraxe001";
            // BATTLEAXE
        case 6:
            return "nw_waxbt001";

            /*BLADED*/
            // BASTARD SWORD
        case 7:
            return "nw_wswbs001";
            // DAGGER
        case 8:
            return "nw_wswdg001";
            // GREATSWORD
        case 9:
            return "nw_wswgs001";
            // LONGSWORD
        case 10:
            return "nw_wswls001";
            // Rapier
        case 11:
            return "nw_wswrp001";
            // SCIMITAR
        case 12:
            return "nw_wswsc001";
            // SHORT SWORD
        case 13:
            return "nw_wswsc001";

            /*BLUNTS*/
            // CLUB
        case 14:
            return "nw_wblcl001";
            // HEAVY FLAIL
        case 15:
            return "nw_wblfh001";
            // LIGHT FLAIL
        case 16:
            return "nw_wblfl001";
            // LIGHT HAMMER
        case 17:
            return "nw_wblhl001";
            // MACE
        case 18:
            return "nw_wblml001";
            // MORNINGSTAR
        case 19:
            return "nw_wblms001";
            // QUARTERSTAFF
        case 20:
            return "nw_wdbqs001";
            // WHIP
        case 21:
            return "x2_it_wpwhip";
            // HEAVY CROSSBOW
        case 22:
            return "nw_wbwxh001";
            // LIGHT CROSSBOW
        case 23:
            return "nw_wbwxl001";
            // LONG BOW
        case 24:
            return "nw_wbwln001";
            // SHORT BOW
        case 25:
            return "nw_wbwsh001";
            // SLING
        case 26:
            return "nw_wbwsl001";
            // DART
        case 27:
            return "nw_wthdt001";
            // THROWING AXE
        case 28:
            return "nw_wthax001";
    }
    return "nw_wswbs001";
}
