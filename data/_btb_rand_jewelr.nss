#include "_btb_rloot_util"
// NOTE TAGS FOR ALL JEWLERY ARE UPPER CASED!!!

//////////JEWLERY//////////
object AddRandomMagicJewelryProperty(object oJewelry, int difficulty_lvl) {
    return oJewelry;
}

object AddRandomMagicJewelryProperty2(object oJewelry, int difficulty_lvl) {
    // NOT FINAL RATIOS TESTING ONLY
    int randChance = Random(100) + 1;

    if(difficulty_lvl < 3) {
        // 60% skill
        if(randChance > 0 && randChance < 60) {
            //WriteTimestampedLogEntry("RandomSkillBoost");
            oJewelry = RandomSkillBoost(oJewelry);
        } else {
            //WriteTimestampedLogEntry("RandomSavingThrowBoost");
            oJewelry = RandomSavingThrowBoost(oJewelry);
        }
    } else {
        // 10% skill
        if(randChance > 0 && randChance < 10) {
            //WriteTimestampedLogEntry("RandomSkillBoost");
            oJewelry = RandomSkillBoost(oJewelry);
        }
        // 20% saving throw
        if(randChance >= 10 && randChance < 20) {
            //WriteTimestampedLogEntry("RandomSavingThrowBoost");
            oJewelry = RandomSavingThrowBoost(oJewelry);
        }
        // 20% abilities boost
        if(randChance >= 20 && randChance < 30) {
            //WriteTimestampedLogEntry("RandomAbilityBoost");
            oJewelry = RandomAbilityBoost(oJewelry);
        }
        // 20% Attack  Boost
        if(randChance >= 30 && randChance < 60) {
            int choice = Random(3);
            if(choice == 0) {
                //WriteTimestampedLogEntry("AttackBonusVsAlign");
                oJewelry = AttackBonusVsAlign(oJewelry);
            }
            if(choice == 1) {
                //WriteTimestampedLogEntry("AttackBonusVsRace");
                oJewelry = AttackBonusVsRace(oJewelry);
            }
            if(choice == 2) {
                //WriteTimestampedLogEntry("AttackBonus");
                oJewelry = AttackBonus(oJewelry);
            }
        }
        // 20% Dmg  Boost
        if(randChance >= 60 && randChance < 90) {
            int choice = Random(3);
            if(choice == 0) {
                //WriteTimestampedLogEntry("DmgBonusVsAlign");
                oJewelry = DmgBonusVsAlign(oJewelry);
            }
            if(choice == 1) {
                //WriteTimestampedLogEntry("DmgBonusVsRace");
                oJewelry = DmgBonusVsRace(oJewelry);
            }
            if(choice == 2) {
                //WriteTimestampedLogEntry("DmgBonus");
                oJewelry = DmgBonus(oJewelry);
            }
        }
        // 10% Enchanted
        if(randChance >= 90 && randChance < 100) {
            //WriteTimestampedLogEntry("ACBoostVsRace");
            oJewelry = EnchantmentBonus(oJewelry);
        }

        if(difficulty_lvl > 7 && randChance == 100) {
            // insert specal properties here.
        }
    }
    return oJewelry;
}

string getRandomJewelry() {

    /*AMULET*/
    switch (Random(6)) {
        case(0):
            // Copper Necklace
            return "nw_it_mneck020";
        case(1):
            // Gold Necklace
            return "nw_it_mneck022";
        case(2):
            //Silver Necklace
            return "nw_it_mneck021";

            /*RINGS*/
        case(3):
            // Copper Ring
            return "nw_it_mring021";
        case(4):
            // Gold Ring
            return "nw_it_mring023";
        case(5):
            // Silver Ring
            return "nw_it_mring022";
    }

    return "";
}
