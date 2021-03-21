//Bartleby's random loot scripts
//parameters of 'generateLootByChance' are as follows:
//generateLootByChance(GPVALUEOFCHEST, OBJECTFORLOOT, DIFFICULTYLEVELOFLOOT, %GOLDCHANCE,
//%POTIONSCHANCE, %ARMOR CHANCE, %GEMSCHANCE, %JEWELRYCHANCE, %WEAPONSCHANCE)

#include "_btb_random_loot"

void main() {
     int lootGened = GetLocalInt(OBJECT_SELF, "lootgenyet");

            generateLootByChance(33, OBJECT_SELF, 5, 1, 99, 0, 0, 0, 0) ;

     SetLocalInt(OBJECT_SELF, "lootgenyet", TRUE);
        }
