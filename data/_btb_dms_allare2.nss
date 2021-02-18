#include "spawn_functions"

void main()
{
    int nNth;
    object oSpawn;
    string sSpawnNum;
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    int nSpawns = GetLocalInt(GetArea(oPC), "Spawns");
    SendMessageToPC(oPC, "Activating");
    SendMessageToPC(oPC, "nSpawns: " + IntToString(nSpawns));
    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        // Retrieve Spawn
        sSpawnNum = "Spawn" + PadIntToString(nNth, 2);
        SendMessageToPC(oPC, "sSpawnNum: " + sSpawnNum);
        oSpawn = GetLocalObject(oArea, sSpawnNum);
        SendMessageToPC(oPC, "SpawnTag: " + GetTag(oSpawn));
        NESS_ActivateSpawn(oSpawn);
    }
}
