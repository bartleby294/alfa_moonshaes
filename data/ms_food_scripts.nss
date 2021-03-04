#include "nwnx_time"

int FOOD_HEAL_WAIT_TIME = 14400; // 4 Hours in seconds

void GenericFoodEaten(object oPC, object oItem) {

    int curTime = NWNX_Time_GetTimeStamp();
    int lastFood = GetLocalInt(oPC, "last_food_time");

    // Heal PC 1 HP
    if(curTime - lastFood > FOOD_HEAL_WAIT_TIME) {
        WriteTimestampedLogEntry("EATING HEAL: " + GetName(oPC) + " ate "
            + GetName(oItem) + " at " + IntToString(curTime) + " to heal 1hp.");
        SendMessageToPC(oPC, "You were hungry you feel the " + GetName(oItem)
                        + " restore some of your strenth.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1), oPC);
        SetLocalInt(oPC, "last_food_time", curTime);
    // Message PC they are still too full for health effects
    } else {
        SendMessageToPC(oPC, "The Food was good but you aren't very hungry yet.");
    }

}
