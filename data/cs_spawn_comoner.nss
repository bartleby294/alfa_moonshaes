//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT9
/*
 * Default OnSpawn handler with XP1 revisions.
 * This corresponds to and produces the same results
 * as the default OnSpawn handler in the OC.
 *
 * This can be used to customize creature behavior in three main ways:
 *
 * - Uncomment the existing lines of code to activate certain
 *   common desired behaviors from the moment when the creature
 *   spawns in.
 *
 * - Uncomment the user-defined event signals to cause the
 *   creature to fire events that you can then handle with
 *   a custom OnUserDefined event handler script.
 *
 * - Add new code _at the end_ to alter the initial
 *   behavior in a more customized way.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/11/2002
//:://////////////////////////////////////////////////

#include "x0_i0_anims"
// #include "x0_i0_walkway" - in x0_i0_anims
#include "x0_i0_treasure"

#include "alfa_include"

void main()
{
    // ***** Spawn-In Conditions ***** //


    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    SetListeningPatterns();

    //***** ALFA MOD: Danmar's PuppetMaster functionality
    //**
    if ( gALFA_USE_PUPPET_MASTER )
    {
      ALFA_InitPuppetMaster( FALSE );
    }
    //**
    //****** end ALFA MOD
    //SpeakString("Howdy");
    int nResult = d100(1);
    object oItem;
    if(nResult == 1)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_001", OBJECT_SELF);
    }
    else if(nResult == 2)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_002", OBJECT_SELF);
    }
    else if(nResult == 3)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_003", OBJECT_SELF);
    }
    else if(nResult == 4)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_004", OBJECT_SELF);
    }
    else if(nResult == 5)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_005", OBJECT_SELF);
    }
    else if(nResult == 6)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_006", OBJECT_SELF);
    }
    else if(nResult == 7)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_007", OBJECT_SELF);
    }
    else if(nResult == 8)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_008", OBJECT_SELF);
    }
    else if(nResult == 9)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_009", OBJECT_SELF);
    }
    else if(nResult == 10)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_010", OBJECT_SELF);
    }
    else if(nResult == 11)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_011", OBJECT_SELF);
    }
    else if(nResult == 12)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_012", OBJECT_SELF);
    }
    else if(nResult == 13)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_013", OBJECT_SELF);
    }
    else if(nResult == 14)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_014", OBJECT_SELF);
    }
    else if(nResult == 15)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_015", OBJECT_SELF);
    }
    else if(nResult == 16)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_016", OBJECT_SELF);
    }
    else if(nResult == 17)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_017", OBJECT_SELF);
    }
    else if(nResult == 18)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_018", OBJECT_SELF);
    }
    else if(nResult == 19)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_019", OBJECT_SELF);
    }
    else if(nResult == 20)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_020", OBJECT_SELF);
    }
    else if(nResult == 21)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_021", OBJECT_SELF);
    }
    else if(nResult == 22)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_022", OBJECT_SELF);
    }
    else if(nResult == 23)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_023", OBJECT_SELF);
    }
    else if(nResult == 24)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_024", OBJECT_SELF);
    }
    else if(nResult == 25)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_025", OBJECT_SELF);
    }
    else if(nResult == 26)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_026", OBJECT_SELF);
    }
    else if(nResult == 27)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_027", OBJECT_SELF);
    }
    else if(nResult == 28)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_028", OBJECT_SELF);
    }
    else if(nResult == 29)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_029", OBJECT_SELF);
    }
    else if(nResult == 30)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_030", OBJECT_SELF);
    }
    else if(nResult == 31)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_031", OBJECT_SELF);
    }
    else if(nResult == 32)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_032", OBJECT_SELF);
    }
    else if(nResult == 33)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_033", OBJECT_SELF);
    }
    else if(nResult == 34)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_034", OBJECT_SELF);
    }
    else if(nResult == 35)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_035", OBJECT_SELF);
    }
    else if(nResult == 36)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_036", OBJECT_SELF);
    }
    else if(nResult == 37)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_037", OBJECT_SELF);
    }
    else if(nResult == 38)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_038", OBJECT_SELF);
    }
    else if(nResult == 39)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_039", OBJECT_SELF);
    }
    else if(nResult == 40)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_040", OBJECT_SELF);
    }
    else if(nResult == 41)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_041", OBJECT_SELF);
    }
    else if(nResult == 42)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_042", OBJECT_SELF);
    }
    else if(nResult == 43)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_043", OBJECT_SELF);
    }
    else if(nResult == 44)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_044", OBJECT_SELF);
    }
    else if(nResult == 45)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_045", OBJECT_SELF);
    }
    else if(nResult == 46)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_046", OBJECT_SELF);
    }
    else if(nResult == 47)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_047", OBJECT_SELF);
    }
    else if(nResult == 48)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_048", OBJECT_SELF);
    }
    else if(nResult == 49)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_049", OBJECT_SELF);
    }
    else if(nResult == 50)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_050", OBJECT_SELF);
    }
    else if(nResult == 51)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_001", OBJECT_SELF);
    }
    else if(nResult == 52)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_002", OBJECT_SELF);
    }
    else if(nResult == 53)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_003", OBJECT_SELF);
    }
    else if(nResult == 54)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_004", OBJECT_SELF);
    }
    else if(nResult == 55)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_005", OBJECT_SELF);
    }
    else if(nResult == 56)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_006", OBJECT_SELF);
    }
    else if(nResult == 57)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_007", OBJECT_SELF);
    }
    else if(nResult == 58)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_008", OBJECT_SELF);
    }
    else if(nResult == 59)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_009", OBJECT_SELF);
    }
    else if(nResult == 60)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_010", OBJECT_SELF);
    }
    else if(nResult == 61)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_011", OBJECT_SELF);
    }
    else if(nResult == 62)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_012", OBJECT_SELF);
    }
    else if(nResult == 63)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_013", OBJECT_SELF);
    }
    else if(nResult == 64)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_014", OBJECT_SELF);
    }
    else if(nResult == 65)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_015", OBJECT_SELF);
    }
    else if(nResult == 66)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_016", OBJECT_SELF);
    }
    else if(nResult == 67)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_017", OBJECT_SELF);
    }
    else if(nResult == 68)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_018", OBJECT_SELF);
    }
    else if(nResult == 69)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_019", OBJECT_SELF);
    }
    else if(nResult == 70)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_020", OBJECT_SELF);
    }
    else if(nResult == 71)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_021", OBJECT_SELF);
    }
    else if(nResult == 72)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_022", OBJECT_SELF);
    }
    else if(nResult == 73)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_023", OBJECT_SELF);
    }
    else if(nResult == 74)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_024", OBJECT_SELF);
    }
    else if(nResult == 75)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_025", OBJECT_SELF);
    }
    else if(nResult == 76)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_026", OBJECT_SELF);
    }
    else if(nResult == 77)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_027", OBJECT_SELF);
    }
    else if(nResult == 78)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_028", OBJECT_SELF);
    }
    else if(nResult == 79)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_029", OBJECT_SELF);
    }
    else if(nResult == 80)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_030", OBJECT_SELF);
    }
    else if(nResult == 81)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_031", OBJECT_SELF);
    }
    else if(nResult == 82)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_032", OBJECT_SELF);
    }
    else if(nResult == 83)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_033", OBJECT_SELF);
    }
    else if(nResult == 84)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_034", OBJECT_SELF);
    }
    else if(nResult == 85)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_035", OBJECT_SELF);
    }
    else if(nResult == 86)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_036", OBJECT_SELF);
    }
    else if(nResult == 87)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_037", OBJECT_SELF);
    }
    else if(nResult == 88)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_038", OBJECT_SELF);
    }
    else if(nResult == 89)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_039", OBJECT_SELF);
    }
    else if(nResult == 90)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_040", OBJECT_SELF);
    }
    else if(nResult == 91)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_041", OBJECT_SELF);
    }
    else if(nResult == 92)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_042", OBJECT_SELF);
    }
    else if(nResult == 93)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_043", OBJECT_SELF);
    }
    else if(nResult == 94)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_044", OBJECT_SELF);
    }
    else if(nResult == 95)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_045", OBJECT_SELF);
    }
    else if(nResult == 96)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_046", OBJECT_SELF);
    }
    else if(nResult == 97)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_047", OBJECT_SELF);
    }
    else if(nResult == 98)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_048", OBJECT_SELF);
    }
    else if(nResult == 99)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_049", OBJECT_SELF);
    }
    else if(nResult == 100)
    {
        SpeakString("Clothes Made");
        oItem = CreateItemOnObject("000_cloth_050", OBJECT_SELF);
    }


    else
        SpeakString("Can't Find My Clothes");
    ActionEquipItem(oItem, INVENTORY_SLOT_CHEST);

    WalkWayPoints();


    //* Create a small amount of treasure on the creature
    // CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF);


    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //

}
