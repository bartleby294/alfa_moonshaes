//Bartleby's random potion loot script

#include "_btb_rand_potion"

void main(){
    int lootGened = GetLocalInt(OBJECT_SELF, "lootgenyet");
    if(lootGened == FALSE && Random (2) == 1) {
        string resref = getRandomPotionUnderMaxGP(50);
        CreateItemOnObject(resref);
    }
    SetLocalInt(OBJECT_SELF, "lootgetyet", TRUE);
}
