#include "_btb_util"

void torchObject(object obj) {
    ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        EffectDamage(101, DAMAGE_TYPE_DIVINE,
                                     DAMAGE_POWER_NORMAL),
                        obj);
    object invis = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_invisibleob",
                                GetLocation(obj));
    SetName(invis, " ");
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                        EffectVisualEffect(VFX_DUR_INFERNO_CHEST),
                        invis, 3.0);
    DestroyObject(invis, 3.1);
}

void torchWeb(object oPC) {
    torchObject(OBJECT_SELF);
    SendMessageToPC(oPC, "Your torch sets the webs aflame.");
}

void fireSpreadCheck(object oPC) {
    if(d20() < 5) {
        object cocoon = GetNearestObjectByTag("SpiderwebCocoon2");
        if(cocoon != OBJECT_INVALID
            && GetDistanceBetween(OBJECT_SELF, cocoon) < 8.0) {
            torchObject(cocoon);
            SendMessageToPC(oPC, "The fire spreads to a near by cocoon.");
        }
    }
}

void spawnSpiders(object oPC) {
    int i = 0;
    int maxSpawn = Random(2) + 1;
    while (i < maxSpawn){
        CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_03",
                     pickLoc(oPC, Random(30)/10.0, 0.0), TRUE);
        i++;
    }
}

void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    if(GetTag(oItem) == "NW_IT_TORCH001"
       || GetTag(oItem) == "_h_crude_torch"
       || GetTag(oItem) == "hc_torch") {
        torchWeb(oPC);
        fireSpreadCheck(oPC);
        spawnSpiders(oPC);
    }
}



