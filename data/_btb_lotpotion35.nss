//Bartleby's random potions script; 22/3/2021
//Create a new copy of this script if you want to change the maximum GP value of the potion to be generated
//Then just add this script to the 'OnOpen' field of your container
//
//N.B. ADJUSTED DOWN TO 51GP VALUE

#include "_btb_rand_potion"

void main(){
    int lootGened = GetLocalInt(OBJECT_SELF, "lootgetyet");
    if(lootGened == FALSE && Random (2) == 1) {
        string resref = getRandomPotionUnderMaxGP(51);
        CreateItemOnObject(resref);
    }
    SetLocalInt(OBJECT_SELF, "lootgetyet", TRUE);
}
