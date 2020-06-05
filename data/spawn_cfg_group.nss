/*
//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
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

string GetTemplateByCR(int nCR, string sGroupType)
{
  string sRetTemplate;

  if (sGroupType == "outdoor")
  {
    switch (nCR)
    {
    case 1:
      switch(d6(1))
      {
        case 1: sRetTemplate = "NW_SKELETON"; break;
        case 2: sRetTemplate = "NW_ZOMBIE01"; break;
        case 3: sRetTemplate = "NW_NIXIE"; break;
        case 4: sRetTemplate = "NW_ORCA"; break;
        case 5: sRetTemplate = "NW_ORCB"; break;
        case 6: sRetTemplate = "NW_BTLFIRE"; break;
      }
      break;
    case 2:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_KOBOLD004"; break;
        case 2: sRetTemplate = "NW_KOBOLD005"; break;
        case 3: sRetTemplate = "NW_KOBOLD003"; break;
        case 4: sRetTemplate = "NW_PIXIE"; break;
    }
      break;
    case 3:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_BTLBOMB"; break;
        case 2: sRetTemplate = "NW_BTLFIRE002"; break;
        case 3: sRetTemplate = "NW_BTLSTINK"; break;
        case 4: sRetTemplate = "NW_NYMPH"; break;
      }
      break;
    default:
       sRetTemplate = "";
       break;
    }
  }

  else if (sGroupType == "crypt")
  {
    switch (nCR)
    {
    case 1:
      switch(d4(1))
      {
        case 1:
        case 2: sRetTemplate = "NW_SKELETON"; break;
        case 3: sRetTemplate = "NW_ZOMBIE01"; break;
        case 4: sRetTemplate = "NW_ZOMBIE02"; break;
      }
      break;
    case 2:
      sRetTemplate = "NW_GHOUL";
      break;
    case 3:
      sRetTemplate = "NW_SHADOW";
      break;
    default:
       sRetTemplate = "";
       break;
    }  }

  else
  {
    // unknown group type
    sRetTemplate = "";
  }

  return sRetTemplate;
}


// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
  float fCR, fEquivSq, fTemp;

  if (fEquiv == 0.0)
  {
    return 0.0;
  }

  fEquivSq = fEquiv * fEquiv;
  fTemp = log(fEquivSq);
  fTemp /= log(2.0);
  fCR = fEncounterLevel + fTemp;

  return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
  if (fCR > fEncounterLevel || fCR < 1.0)
  {
    return 1.;
  }

  float fEquiv, fExponent, fDenom;

  fExponent = fEncounterLevel - fCR;
  fExponent *= 0.5;
  fDenom = pow(2.0, fExponent);
  fEquiv =  1.0 / fDenom;

  return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
    // Initialize
    string sRetTemplate;

    // Initialize Values
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

//
// Only Make Modifications Between These Lines
// -------------------------------------------




    // road_low/med/high
    //
    // Random Monster Scripting by Steven Wells (aka Sareena) -- 02/05/03
    //
    // Example flags: SP_SN10_RS15_SD1P_SA_SR60_PC10R_CD120_DS2_RW_SG
    //
    // RS15-20 works well so far, LT is assigned by script, SD is still being tweaked and I've run
    // into a bug (or server limitation?) that makes SD1=4.5 minutes, SD2=9 minutes, etc...,
    // I use SN10 for all wandering monsters since this script determines actual number and it's
    // easier to adjust this script to change numbers than to adjust a lot of spawns.
    //
    // NOTE: With SN10, DimRet will not give reduced experience until 10 mobs have spawned.
    // Since most spawns are 2-8 mobs, they will be giving experience longer than normal.  This
    // is a known bug.
    //
    // Edit encounters in the section marked EDIT HERE to reflect those on your server.
    // If you number encounter types like I have (i.e. sw_bandit_01, sw_bandit_02, etc) you can
    // have mixed spawn groups.  Put lower level versions in lower numbers.
    //
    // If the number of encounter changes, edit random numbers selector to correspond.
    //

    if (GetStringLeft(sTemplate, 8) == "endless_")
    {
        int nCounterCur;    // current counter
        int nCounterMax;    // maximum number in a particular encounter
        int nRandom;        // general random number
        //int nLoot = 500;    // default loot merchant to be used for treasure if not specified
        int nStart;         // starting blueprint _xx suffix number (ie to start at _03 would be 3)
        int nMaxVariance;   // total number of consecutive _xx values (ie _03 to _08 would be 5)
        string sBlue;       // blueprint prefix
        string sCurrentTemplate = GetLocalString(oSpawn, "TemplateCur");  // current monster template

        // ********************************* CUSTOMIZE BELOW HERE *****************************************************************

        if (sCurrentTemplate == "")
        {
            if (GetStringRight(sTemplate, 4) == "_low")
                nRandom = Random(3) +1;
            if (GetStringRight(sTemplate, 4) == "_med")
                nRandom = Random(3) +4;
            if (GetStringRight(sTemplate, 5) == "_high")
                nRandom = Random(3) +7;
            if (GetStringRight(sTemplate, 6) == "_trog1")
                nRandom = Random(3) +10;
            if (GetStringRight(sTemplate, 6) == "_trog2")
                nRandom = Random(2) +13;
            if (GetStringRight(sTemplate, 6) == "_trog3")
                nRandom = Random(1) +15;

            switch (nRandom)
            {
                // low has 2 mobs
                case 1:  sBlue = "sw_bb_";   nCounterMax = Random(2) +0; nMaxVariance = 1; nStart = 1; break;
                case 2:  sBlue = "sw_goblin_";   nCounterMax = Random(3) +1; nMaxVariance = 2; nStart = 1; break;
                case 3:  sBlue = "sw_goblin_";   nCounterMax = Random(2) +1; nMaxVariance = 3; nStart = 1; break;
                // med has 3 mobs
                case 4:  sBlue = "sw_goblin_";   nCounterMax = Random(2) +2; nMaxVariance = 5; nStart = 1; break;
                case 5:  sBlue = "sw_goblin_";   nCounterMax = Random(2) +1; nMaxVariance = 3; nStart = 3; break;
                case 6:  sBlue = "sw_goblin_";    nCounterMax = Random(4) +1; nMaxVariance = 5; nStart = 1; break;
                // hi6gh has 3 mob
                case 7:  sBlue = "sw_goblin_";    nCounterMax = Random(3) +1; nMaxVariance = 3; nStart = 6; break;
                case 8:  sBlue = "sw_goblin_";    nCounterMax = Random(4) +1; nMaxVariance = 5; nStart = 6; break;
                case 9:  sBlue = "sw_goblin_";    nCounterMax = Random(3) +3; nMaxVariance = 3; nStart = 8; break;
                //   trog1 has 3
                case 10:  sBlue = "sw_trog_";    nCounterMax = Random(4) +2; nMaxVariance = 1; nStart = 1; break;
                case 11:  sBlue = "sw_trog_";    nCounterMax = Random(2) +1; nMaxVariance = 2; nStart = 1; break;
                case 12:  sBlue = "sw_trog_";    nCounterMax = Random(2) +0; nMaxVariance = 3; nStart = 2; break;
                //trog2 has 2
                case 13:  sBlue = "sw_trog_";    nCounterMax = Random(2) +2; nMaxVariance = 3; nStart = 1; break;
                case 14:  sBlue = "sw_trog_";    nCounterMax = Random(3) +1; nMaxVariance = 4; nStart = 2; break;
                //trog3 has 1
                case 15:  sBlue = "sw_trog_";    nCounterMax = Random(2) +2; nMaxVariance = 3; nStart = 3; break;


        // ********************************* CUSTOMIZE ABOVE HERE *****************************************************************
            }
            SetLocalInt(oSpawn, "CounterMax", nCounterMax);
            //SetLocalInt(oSpawn, "f_LootTable", nLoot);
            SetLocalInt(oSpawn, "MaxVariance", nMaxVariance);
            SetLocalInt(oSpawn, "Start", nStart);
            SetLocalString(oSpawn, "Blue", sBlue);
        }

        // Set variables for the current mob
        nCounterCur = GetLocalInt(oSpawn, "CounterCur");
        nCounterMax = GetLocalInt(oSpawn, "CounterMax");
        //nLoot = GetLocalInt(oSpawn, "f_LootTable");
        nMaxVariance = GetLocalInt(oSpawn, "MaxVariance");
        nStart = GetLocalInt(oSpawn, "Start");
        sBlue = GetLocalString(oSpawn, "Blue");

        // Spawn random multiple template mobs (must follow Sareena's mob template numbering)
        if ((nCounterCur <= nCounterMax) && (GetStringRight(sBlue,1) == "_"))
        {
            nRandom = Random(nMaxVariance) + nStart;
            switch (nRandom)
            {
                case 1:  sCurrentTemplate = sBlue + "01"; break;
                case 2:  sCurrentTemplate = sBlue + "02"; break;
                case 3:  sCurrentTemplate = sBlue + "03"; break;
                case 4:  sCurrentTemplate = sBlue + "04"; break;
                case 5:  sCurrentTemplate = sBlue + "05"; break;
                case 6:  sCurrentTemplate = sBlue + "06"; break;
                case 7:  sCurrentTemplate = sBlue + "07"; break;
                case 8:  sCurrentTemplate = sBlue + "08"; break;
                case 9:  sCurrentTemplate = sBlue + "09"; break;
                case 10:  sCurrentTemplate = sBlue + "10"; break;
                case 11:  sCurrentTemplate = sBlue + "11"; break;
                case 12:  sCurrentTemplate = sBlue + "12"; break;
                case 13:  sCurrentTemplate = sBlue + "13"; break;
                case 14:  sCurrentTemplate = sBlue + "14"; break;
                case 15:  sCurrentTemplate = sBlue + "15"; break;


            }

            sRetTemplate = sCurrentTemplate;
            SetLocalString(oSpawn, "TemplateCur", sRetTemplate);

        //    SetLocalInt(oSpawn, "f_LootTable", nLoot);  // default loot for mob

            nCounterCur++;
            SetLocalInt(oSpawn, "CounterCur", nCounterCur);
        }

        // Spawn single template mobs
        else if ((nCounterCur <= nCounterMax) && (GetStringRight(sBlue,1) != "_"))
        {
            sRetTemplate = sBlue;
            SetLocalString(oSpawn, "TemplateCur", sRetTemplate);

            nCounterCur++;
            SetLocalInt(oSpawn, "CounterCur", nCounterCur);
        }

        // All spawns are done, clear the variables for next spawn
        else
        {
            sCurrentTemplate = "";
            DelayCommand(10.0, DeleteLocalString(oSpawn, "TemplateCur"));
            DelayCommand(10.0, DeleteLocalInt(oSpawn, "CounterCur"));
            DelayCommand(10.0, DeleteLocalInt(oSpawn, "CounterMax"));
            //DelayCommand(10.0, DeleteLocalInt(oSpawn, "f_LootTable"));
            DelayCommand(10.0, DeleteLocalInt(oSpawn, "MaxVariance"));
            DelayCommand(10.0, DeleteLocalString(oSpawn, "Blue"));
        }
    }
    //

// -------------------------------------------
// Only Make Modifications Between These Lines
//
    return sRetTemplate;
}
*/
//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
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

string GetTemplateByCR(int nCR, string sGroupType)
{
  string sRetTemplate;

  if (sGroupType == "outdoor")
  {
    switch (nCR)
    {
    case 1:
      switch(d6(1))
      {
        case 1: sRetTemplate = "NW_SKELETON"; break;
        case 2: sRetTemplate = "NW_ZOMBIE01"; break;
        case 3: sRetTemplate = "NW_NIXIE"; break;
        case 4: sRetTemplate = "NW_ORCA"; break;
        case 5: sRetTemplate = "NW_ORCB"; break;
        case 6: sRetTemplate = "NW_BTLFIRE"; break;
      }
      break;
    case 2:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_KOBOLD004"; break;
        case 2: sRetTemplate = "NW_KOBOLD005"; break;
        case 3: sRetTemplate = "NW_KOBOLD003"; break;
        case 4: sRetTemplate = "NW_PIXIE"; break;
    }
      break;
    case 3:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_BTLBOMB"; break;
        case 2: sRetTemplate = "NW_BTLFIRE002"; break;
        case 3: sRetTemplate = "NW_BTLSTINK"; break;
        case 4: sRetTemplate = "NW_NYMPH"; break;
      }
      break;
    default:
       sRetTemplate = "";
       break;
    }
  }

  else if (sGroupType == "crypt")
  {
    switch (nCR)
    {
    case 1:
      switch(d4(1))
      {
        case 1:
        case 2: sRetTemplate = "NW_SKELETON"; break;
        case 3: sRetTemplate = "NW_ZOMBIE01"; break;
        case 4: sRetTemplate = "NW_ZOMBIE02"; break;
      }
      break;
    case 2:
      sRetTemplate = "NW_GHOUL";
      break;
    case 3:
      sRetTemplate = "NW_SHADOW";
      break;
    default:
       sRetTemplate = "";
       break;
    }  }

  else
  {
    // unknown group type
    sRetTemplate = "";
  }

  return sRetTemplate;
}


// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
  float fCR, fEquivSq, fTemp;

  if (fEquiv == 0.0)
  {
    return 0.0;
  }

  fEquivSq = fEquiv * fEquiv;
  fTemp = log(fEquivSq);
  fTemp /= log(2.0);
  fCR = fEncounterLevel + fTemp;

  return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
  if (fCR > fEncounterLevel || fCR < 1.0)
  {
    return 1.;
  }

  float fEquiv, fExponent, fDenom;

  fExponent = fEncounterLevel - fCR;
  fExponent *= 0.5;
  fDenom = pow(2.0, fExponent);
  fEquiv =  1.0 / fDenom;

  return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
    // Initialize
    string sRetTemplate;

    // Initialize Values
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

//
// Only Make Modifications Between These Lines
// -------------------------------------------




    // road_low/med/high
    //
    // Random Monster Scripting by Steven Wells (aka Sareena) -- 02/05/03
    //
    // Example flags: SP_SN10_RS15_SD1P_SA_SR60_PC10R_CD120_DS2_RW_SG
    //
    // RS15-20 works well so far, LT is assigned by script, SD is still being tweaked and I've run
    // into a bug (or server limitation?) that makes SD1=4.5 minutes, SD2=9 minutes, etc...,
    // I use SN10 for all wandering monsters since this script determines actual number and it's
    // easier to adjust this script to change numbers than to adjust a lot of spawns.
    //
    // NOTE: With SN10, DimRet will not give reduced experience until 10 mobs have spawned.
    // Since most spawns are 2-8 mobs, they will be giving experience longer than normal.  This
    // is a known bug.
    //
    // Edit encounters in the section marked EDIT HERE to reflect those on your server.
    // If you number encounter types like I have (i.e. sw_bandit_01, sw_bandit_02, etc) you can
    // have mixed spawn groups.  Put lower level versions in lower numbers.
    //
    // If the number of encounter changes, edit random numbers selector to correspond.
    //

    if (GetStringLeft(sTemplate, 8) == "endless_")
    {
        int nCounterCur;    // current counter
        int nCounterMax;    // maximum number in a particular encounter
        int nRandom;        // general random number
        int nLoot = 500;    // default loot merchant to be used for treasure if not specified
        int nStart;         // starting blueprint _xx suffix number (ie to start at _03 would be 3)
        int nMaxVariance;   // total number of consecutive _xx values (ie _03 to _08 would be 5)
        string sBlue;       // blueprint prefix
        string sCurrentTemplate = GetLocalString(oSpawn, "TemplateCur");  // current monster template

        // ********************************* CUSTOMIZE BELOW HERE *****************************************************************

        if (sCurrentTemplate == "")
        {
            if (GetStringRight(sTemplate, 4) == "_low")
                nRandom = Random(3) +1;
            if (GetStringRight(sTemplate, 4) == "_med")
                nRandom = Random(3) +4;
            if (GetStringRight(sTemplate, 5) == "_high")
                nRandom = Random(3) +7;
            if (GetStringRight(sTemplate, 6) == "_trog1")
                nRandom = Random(3) +10;
            if (GetStringRight(sTemplate, 6) == "_trog2")
                nRandom = Random(2) +13;
            if (GetStringRight(sTemplate, 6) == "_trog3")
                nRandom = Random(1) +15;

            switch (nRandom)
            {
                // low has 2 mobs
                case 1:  sBlue = "sw_bb_";   nCounterMax = Random(2) +0; nMaxVariance = 1; nStart = 1; nLoot = 901; break;
                case 2:  sBlue = "sw_goblin_";   nCounterMax = Random(3) +1; nMaxVariance = 2; nStart = 1; nLoot = 501; break;
                case 3:  sBlue = "sw_goblin_";   nCounterMax = Random(2) +1; nMaxVariance = 3; nStart = 1; nLoot = 501; break;
                // med has 3 mobs
                case 4:  sBlue = "sw_goblin_";   nCounterMax = Random(2) +2; nMaxVariance = 5; nStart = 1; nLoot = 501; break;
                case 5:  sBlue = "sw_goblin_";   nCounterMax = Random(2) +1; nMaxVariance = 3; nStart = 3; nLoot = 501; break;
                case 6:  sBlue = "sw_goblin_";    nCounterMax = Random(4) +1; nMaxVariance = 5; nStart = 1; nLoot = 501; break;
                // hi6gh has 3 mob
                case 7:  sBlue = "sw_goblin_";    nCounterMax = Random(3) +1; nMaxVariance = 3; nStart = 6; nLoot = 501; break;
                case 8:  sBlue = "sw_goblin_";    nCounterMax = Random(4) +1; nMaxVariance = 5; nStart = 6; nLoot = 501; break;
                case 9:  sBlue = "sw_goblin_";    nCounterMax = Random(3) +3; nMaxVariance = 3; nStart = 8; nLoot = 501; break;
                //   trog1 has 3
                case 10:  sBlue = "sw_trog_";    nCounterMax = Random(4) +2; nMaxVariance = 1; nStart = 1; nLoot = 502; break;
                case 11:  sBlue = "sw_trog_";    nCounterMax = Random(2) +1; nMaxVariance = 2; nStart = 1; nLoot = 502; break;
                case 12:  sBlue = "sw_trog_";    nCounterMax = Random(2) +0; nMaxVariance = 3; nStart = 2; nLoot = 502; break;
                //trog2 has 2
                case 13:  sBlue = "sw_trog_";    nCounterMax = Random(2) +2; nMaxVariance = 3; nStart = 1; nLoot = 502; break;
                case 14:  sBlue = "sw_trog_";    nCounterMax = Random(3) +1; nMaxVariance = 4; nStart = 2; nLoot = 502; break;
                //trog3 has 1
                case 15:  sBlue = "sw_trog_";    nCounterMax = Random(2) +2; nMaxVariance = 3; nStart = 3; nLoot = 502; break;


        // ********************************* CUSTOMIZE ABOVE HERE *****************************************************************
            }
            SetLocalInt(oSpawn, "CounterMax", nCounterMax);
            SetLocalInt(oSpawn, "f_LootTable", nLoot);
            SetLocalInt(oSpawn, "MaxVariance", nMaxVariance);
            SetLocalInt(oSpawn, "Start", nStart);
            SetLocalString(oSpawn, "Blue", sBlue);
        }

        // Set variables for the current mob
        nCounterCur = GetLocalInt(oSpawn, "CounterCur");
        nCounterMax = GetLocalInt(oSpawn, "CounterMax");
        nLoot = GetLocalInt(oSpawn, "f_LootTable");
        nMaxVariance = GetLocalInt(oSpawn, "MaxVariance");
        nStart = GetLocalInt(oSpawn, "Start");
        sBlue = GetLocalString(oSpawn, "Blue");

        // Spawn random multiple template mobs (must follow Sareena's mob template numbering)
        if ((nCounterCur <= nCounterMax) && (GetStringRight(sBlue,1) == "_"))
        {
            nRandom = Random(nMaxVariance) + nStart;
            switch (nRandom)
            {
                case 1:  sCurrentTemplate = sBlue + "01"; break;
                case 2:  sCurrentTemplate = sBlue + "02"; break;
                case 3:  sCurrentTemplate = sBlue + "03"; break;
                case 4:  sCurrentTemplate = sBlue + "04"; break;
                case 5:  sCurrentTemplate = sBlue + "05"; break;
                case 6:  sCurrentTemplate = sBlue + "06"; break;
                case 7:  sCurrentTemplate = sBlue + "07"; break;
                case 8:  sCurrentTemplate = sBlue + "08"; break;
                case 9:  sCurrentTemplate = sBlue + "09"; break;
                case 10:  sCurrentTemplate = sBlue + "10"; break;
                case 11:  sCurrentTemplate = sBlue + "11"; break;
                case 12:  sCurrentTemplate = sBlue + "12"; break;
                case 13:  sCurrentTemplate = sBlue + "13"; break;
                case 14:  sCurrentTemplate = sBlue + "14"; break;
                case 15:  sCurrentTemplate = sBlue + "15"; break;


            }

            sRetTemplate = sCurrentTemplate;
            SetLocalString(oSpawn, "TemplateCur", sRetTemplate);

        //    SetLocalInt(oSpawn, "f_LootTable", nLoot);  // default loot for mob

            nCounterCur++;
            SetLocalInt(oSpawn, "CounterCur", nCounterCur);
        }

        // Spawn single template mobs
        else if ((nCounterCur <= nCounterMax) && (GetStringRight(sBlue,1) != "_"))
        {
            sRetTemplate = sBlue;
            SetLocalString(oSpawn, "TemplateCur", sRetTemplate);

            nCounterCur++;
            SetLocalInt(oSpawn, "CounterCur", nCounterCur);
        }

        // All spawns are done, clear the variables for next spawn
        else
        {
            sCurrentTemplate = "";
            DelayCommand(10.0, DeleteLocalString(oSpawn, "TemplateCur"));
            DelayCommand(10.0, DeleteLocalInt(oSpawn, "CounterCur"));
            DelayCommand(10.0, DeleteLocalInt(oSpawn, "CounterMax"));
            DelayCommand(10.0, DeleteLocalInt(oSpawn, "f_LootTable"));
            DelayCommand(10.0, DeleteLocalInt(oSpawn, "MaxVariance"));
            DelayCommand(10.0, DeleteLocalString(oSpawn, "Blue"));
        }
    }
    //

// -------------------------------------------
// Only Make Modifications Between These Lines
//
    return sRetTemplate;
}
