//Bartleby's random loot scripts
//parameters of 'generateLootByChance' are as follows:
//generateLootByChance(GPVALUEOFCHEST, OBJECTFORLOOT, DIFFICULTYLEVELOFLOOT, %GOLDCHANCE,
//%POTIONSCHANCE, %ARMOR CHANCE, %GEMSCHANCE, %JEWELRYCHANCE, %WEAPONSCHANCE)

#include "_btb_random_loot"

void main() {
     int lootGened = GetLocalInt(OBJECT_SELF, "lootgenyet");
         if(lootGened == FALSE && Random (3) > 0) {
            generateLootByChance(120, OBJECT_SELF, 4, 10, 30, 10, 20, 10, 20) ;
}
     SetLocalInt(OBJECT_SELF, "lootgenyet", TRUE);

}

