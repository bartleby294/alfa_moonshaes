//
// Spawn Flags
//
void SpawnFlags(object oSpawn, int nFlagTableNumber)
{
    // Initialize Values
    string sSpawnName = GetName(oSpawn);
    string sSpawnTag = GetTag(oSpawn);
    string sFlags, sTemplate;

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    if (nFlagTableNumber == 200) //dwarves for taverns
    {
        sFlags = "SP_CM_SD180_SR4_CD145T3_PC01_RG03C25";
        sTemplate = "NCM_COMMONERS_DWARF";
    }

     if (nFlagTableNumber == 201) //dwarf street-dwellers who despawn at night
    {
        sFlags = "SP_CM_SD180_SR4_CD145T3_PC01_RG03C25_DOD";
        sTemplate = "NCM_COMMONERS_DWARF";
    }

         if (nFlagTableNumber == 205)  //for taverns
    {
        sFlags = "SP_CM_SD180_SR4_CD145T3_PC01_RG03C25";
        sTemplate = "NCM_COMMONERS_HALFLING";
    }

         if (nFlagTableNumber == 206) //street-dwellers who despawn at night
    {
        sFlags = "SP_CM_SD180_SR4_CD145T3_PC01_RG03C25_DOD";
        sTemplate = "NCM_COMMONERS_HALFLING";
    }

        if (nFlagTableNumber == 210) //for taverns
    {
        sFlags = "SP_CM_SD180_SR4_CD145T3_PC01_RG03C25";
        sTemplate = "NCM_COMMONERS_HUMAN";
    }

        if (nFlagTableNumber == 211)  //street-dwellers who despawn at night
    {
        sFlags = "SP_CM_SD180_SR4_CD145T3_PC01_RG03C25_DOD";
        sTemplate = "NCM_COMMONERS_HUMAN";
    }

        if (nFlagTableNumber == 230)  //street pedestrians who despawn at night
    {
        sFlags = "SP_CM_DOD_CD145T3_PC01_SU50";
        sTemplate = "NCM_COMMONERS_PEDESTRIANS";
    }
// -------------------------------------------
// Only Make Modifications Between These Lines
//

    // Record Values
    if (sFlags != "")
    {
        SetLocalString(oSpawn, "f_Flags", sFlags);
    }
    else
    {
        SetLocalString(oSpawn, "f_Flags", sSpawnName);
    }
    if (sTemplate != "")
    {
        SetLocalString(oSpawn, "f_Template", sTemplate);
    }
    else
    {
        SetLocalString(oSpawn, "f_Template", sSpawnTag);
    }
}
