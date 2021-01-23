#include "_btb_rloot_util"
// NOTE TAGS FOR ALL JEWLERY ARE UPPER CASED!!!

//////////JEWLERY//////////
object AddRandomMagicJewelryProperty(object oJewelry, int difficulty_lvl) {
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
        // 20% skill
        if(randChance > 0 && randChance < 20) {
            //WriteTimestampedLogEntry("RandomSkillBoost");
            oJewelry = RandomSkillBoost(oJewelry);
        }
        // 20% saving throw
        if(randChance >= 20 && randChance < 40) {
            //WriteTimestampedLogEntry("RandomSavingThrowBoost");
            oJewelry = RandomSavingThrowBoost(oJewelry);
        }
        // 20% abilities boost
        if(randChance >= 40 && randChance < 60) {
            //WriteTimestampedLogEntry("RandomAbilityBoost");
            oJewelry = RandomAbilityBoost(oJewelry);
        }
        // 15% AC Boost
        if(randChance >= 60 && randChance < 75) {
            int choice = Random(3);
            if(choice == 0) {
                //WriteTimestampedLogEntry("ACBoostVsAlign");
                oJewelry = ACBoostVsAlign(oJewelry);
            }
            if(choice == 1) {
                //WriteTimestampedLogEntry("ACBoostVsDmgType");
                oJewelry = ACBoostVsDmgType(oJewelry);
            }
            if(choice == 2) {
                //WriteTimestampedLogEntry("ACBoostVsRace");
                oJewelry = ACBoostVsRace(oJewelry);
            }
        }
        // 20% AC Boost
        if(randChance >= 75 && randChance < 95) {
            //WriteTimestampedLogEntry("ACBoostVsRace");
            oJewelry = ACBoost(oJewelry);
        }
        // 5% Magic Charges
        if(randChance >= 95 && randChance <= 100) {
            //WriteTimestampedLogEntry("ACBoostVsRace");
            oJewelry = MagicCharge(oJewelry, difficulty_lvl);
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
