#include "spawn_functions"

void main()
{
    int nNth;
    object oSpawn;
    string sSpawnNum;
    object oPC = GetPCSpeaker();

    int nSpawns = GetLocalInt(GetArea(oPC), "Spawns");

    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        // Retrieve Spawn
        sSpawnNum = "Spawn" + PadIntToString(nNth, 2);
        oSpawn = GetLocalObject(oPC, sSpawnNum);
        NESS_DeactivateSpawn(oSpawn);
    }
}
