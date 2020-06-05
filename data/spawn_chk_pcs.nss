#include "sos_include"
//
// Spawn Check - PCs
//
int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//
int SpawnCheckPCs(object oSpawn)
{
    // Initialize Values
    object oPC;
    object oArea = GetArea(oSpawn);
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    location lSpawn = GetLocation(oSpawn);
    int nCheckPCs = GetLocalInt(oSpawn, "f_SpawnCheckPCs");
    float fCheckPCsRadius = GetLocalFloat(oSpawn, "f_CheckPCsRadius");

    // Block Spawn by Default
    int nProcessSpawn = FALSE;

    // Cycle through PCs
    if (fCheckPCsRadius > -1.0)
    {
        oPC = GetFirstObjectInShape(SHAPE_SPHERE, fCheckPCsRadius, lSpawn, FALSE, OBJECT_TYPE_CREATURE);
    }
    else
    {
        oPC = GetFirstObjectInArea(oArea);
    }
    while (oPC != OBJECT_INVALID)
    {
        if (GetIsPC(oPC) == TRUE)
        {

//
// Only Make Modifications Between These Lines
// -------------------------------------------



            // Checks 1-3 are Endless Cavern Checks
            if (nCheckPCs == 1)
            {
                int nQuest = SOS_GetPersistentInt(oPC, "nEndless");   //name of Variable here
                if (nQuest == 1)                                      //Variable value here
                {
                    // Quest Entry is 1, Spawn!
                    nProcessSpawn = TRUE;
                }
            }
            //
            if (nCheckPCs == 2)
            {
                int nQuest = SOS_GetPersistentInt(oPC, "nEndless");
                if (nQuest == 2)
                {
                    nProcessSpawn = TRUE;
                }
            }

            if (nCheckPCs == 3)
            {
                int nQuest = SOS_GetPersistentInt(oPC, "nEndless");
                if (nQuest == 3)
                {
                    nProcessSpawn = TRUE;
                }
            }

//This check is for the Disciples of Orcus temple
            if (nCheckPCs == 4)
            {
                // Check Journal Quest Entry
                int nQuest = SOS_GetPersistentInt(oPC, "nOrcus");
                if (nQuest == 1)
                {
                    // Quest Entry is 1, Spawn!
                    nProcessSpawn = TRUE;
                }
            }
// -------------------------------------------
// Only Make Modifications Between These Lines
//
        }
        // Retreive Next PC
        if (fCheckPCsRadius > -1.0)
        {
            oPC = GetNextObjectInShape(SHAPE_SPHERE, fCheckPCsRadius, lSpawn, FALSE, OBJECT_TYPE_CREATURE);
        }
        else
        {
            oPC = GetNextObjectInArea(oArea);
        }
    }

    // Return whether Spawn can Proceed
    return nProcessSpawn;
}
