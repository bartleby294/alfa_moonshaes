//::///////////////////////////////////////////////
//:: FileName batsreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "nw_i0_plot"
void main()
{
    //check inventory of oPC for oQuestItem and get iNumItems
    string sMark = "ITEM_TAG";
    int Wings = GetNumItems(GetPCSpeaker(), "BatWing");
    int ilevel = GetHitDice(GetPCSpeaker());
    int i;
    if (ilevel = 1)
    {
        for (i=0; i<(Wings); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 20);

            }
    }

    else if (ilevel = 2)
    {
        for (i=0; i<(Wings); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 10);

            }
    }

    else if (ilevel = 3)
    {
        for (i=0; i<(Wings); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 5);

            }
    }

    else if (ilevel = 4)
    {
        for (i=0; i<(Wings); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 2);

            }
    }
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "BatWing");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

        object oPC = GetPCSpeaker();


    object HighDruidSpawnWP = GetNearestObjectByTag("High_Druid_Spawn01");
    object Druid01SpawnWP = GetNearestObjectByTag("Druid01_Spawn01");
    object Druid02SpawnWP = GetNearestObjectByTag("Druid02_Spawn01");
    object OnHBObj = GetNearestObjectByTag("Moonwell01OnHBObj");

    object Light = GetLocalObject(OnHBObj, "lightobject");
    DestroyObject(Light, 1.0);

    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 4);

    //object HighDruid = GetNearestObjectByTag("MoonwellHighDruid");
    object Druid01 = GetNearestObjectByTag("MoonwellDruid01");
    object Druid02 = GetNearestObjectByTag("MoonwellDruid02");
    object Druid03 = GetNearestObjectByTag("MoonwellDruid03");
    object Druid04 = GetNearestObjectByTag("MoonwellDruid04");

    //AssignCommand(HighDruid, ClearAllActions());
    //effect Walk2 = EffectMovementSpeedIncrease(99);
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, HighDruid);

    //AssignCommand(HighDruid, ActionMoveToObject(HighDruidSpawnWP, FALSE,1.0));
    AssignCommand(Druid01, ActionMoveToObject(Druid01SpawnWP, FALSE,1.0));
    AssignCommand(Druid02, ActionMoveToObject(Druid02SpawnWP, FALSE,1.0));

    //DestroyObject(HighDruid, 16.0);
    DestroyObject(Druid01, 16.0);
    DestroyObject(Druid02, 16.0);
    DestroyObject(Druid03, 16.0);
    DestroyObject(Druid04, 16.0);


    //DelayCommand(15.0, AssignCommand(HighDruid, SpeakString("Disappears into forest")));
    DelayCommand(15.0, AssignCommand(Druid01, SpeakString("Disappears into forest")));
    DelayCommand(15.0, AssignCommand(Druid02, SpeakString("Disappears into forest")));
    DelayCommand(15.0, AssignCommand(Druid03, SpeakString("Disappears into forest")));
    DelayCommand(15.0, AssignCommand(Druid04, SpeakString("Disappears into forest")));
}
