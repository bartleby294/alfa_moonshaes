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
  string sRetTemplate = "";

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
       if (sTemplate == "chest_locked")
    {
        //sRetTemplate = "ratden001";
        switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "chest002"; break;
                    case 1: sRetTemplate = "chest003"; break;
                    case 2: sRetTemplate = "chest004"; break;
                    case 3: sRetTemplate = "chest005"; break;
                }
    }

    if (sTemplate == "chest_locked2")
    {
        switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "chest006"; break;
                    case 1: sRetTemplate = "chest007"; break;
                    case 2: sRetTemplate = "chest008"; break;
                    case 3: sRetTemplate = "chest009"; break;
                }
    }

    if (sTemplate == "chest_locked_trapped")
    {
        switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "chest010"; break;
                    case 1: sRetTemplate = "chest011"; break;
                    case 2: sRetTemplate = "chest012"; break;
                    case 3: sRetTemplate = "chest013"; break;
                }
    }
     if (sTemplate == "spidercocoon")
    {

         sRetTemplate = "spidercocoon";

    }
     if (sTemplate == "unstableportal")
    {

         sRetTemplate = "unstableportal";

    }

    if (sTemplate == "box")
    {
        switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "box002"; break;
                    case 1: sRetTemplate = "box003"; break;
                    case 2: sRetTemplate = "box004"; break;
                    case 3: sRetTemplate = "box005"; break;

                }
    }
    if (sTemplate == "ratbox")
    {
        sRetTemplate = "box101";
        /*switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "ratnest001"; break;
                    case 1: sRetTemplate = "box003"; break;
                    case 2: sRetTemplate = "box004"; break;
                    case 3: sRetTemplate = "box005"; break;
                }    */
    }


    if (sTemplate == "furniture")
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "desk001"; break;
                    case 1: sRetTemplate = "desk002"; break;
                    case 2: sRetTemplate = "couch001"; break;
                    case 3: sRetTemplate = "armoire001"; break;
                    case 4: sRetTemplate = "bookshelf001"; break;
                    case 5: sRetTemplate = "cabinet001"; break;
                    case 6: sRetTemplate = "chstdrwrs001"; break;
                    case 7: sRetTemplate = "bookshelf001"; break;
                }
    }


   if (sTemplate == "misc")
    {
        switch( Random( 10 ))
                {
                    case 0: sRetTemplate = "pottedplant001"; break;
                    case 1: sRetTemplate = "pottedplant001"; break;
                    case 2: sRetTemplate = "urn001"; break;
                    case 3: sRetTemplate = "woodpile001"; break;
                    case 4: sRetTemplate = "birdcage001"; break;
                    case 5: sRetTemplate = "barrel001"; break;
                    case 6: sRetTemplate = "barrel001"; break;
                    case 7: sRetTemplate = "pottedplant001"; break;
                    case 8: sRetTemplate = "cot001"; break;
                    case 9: sRetTemplate = "pntingeasel001"; break;
                }
    }

     if (sTemplate == "housethief")
    {
        switch( Random( 10 ))
                {
                    case 0: sRetTemplate = "thief001"; break;
                    case 1: sRetTemplate = "thief002"; break;
                    case 2: sRetTemplate = "thief004"; break;
                    case 3: sRetTemplate = "thief"; break;
                    case 4: sRetTemplate = "cc_thief_01"; break;
                    case 5: sRetTemplate = "cc_thief_02"; break;
                    case 6: sRetTemplate = "cc_thief_03"; break;
                    case 7: sRetTemplate = "streetthug"; break;
                    case 8: sRetTemplate = "streetthug002"; break;
                    case 9: sRetTemplate = "streetthug004"; break;


                    }
    }
     if (sTemplate == "guildthief")
    {
        switch( Random(7 ))
                {
                    case 0: sRetTemplate = "thief003"; break;
                    case 1: sRetTemplate = "thief005"; break;
                    case 2: sRetTemplate = "thief007"; break;
                    case 3: sRetTemplate = "cc_thief_04"; break;
                    case 4: sRetTemplate = "cc_thief_05"; break;
                    case 5: sRetTemplate = "streetthug003"; break;
                    case 6: sRetTemplate = "streetthug001"; break;

                    }
    }

if (sTemplate == "small")
    {
        switch( Random( 18 ))
                {
                    case 0: sRetTemplate = "tavern001"; break;
                    case 1: sRetTemplate = "tavern002"; break;
                    case 2: sRetTemplate = "tavern003"; break;
                    case 3: sRetTemplate = "tavern004"; break;
                    case 4: sRetTemplate = "tavern013"; break;
                    case 5: sRetTemplate = "tavern016"; break;
                    case 6: sRetTemplate = "tavern015"; break;
                    case 7: sRetTemplate = "tavern017"; break;
                    case 8: sRetTemplate = "goblina002"; break;
                    case 9: sRetTemplate = "goblina002"; break;
                    case 10: sRetTemplate = "tavern001"; break;
                    case 11: sRetTemplate = "tavern002"; break;
                    case 12: sRetTemplate = "tavern003"; break;
                    case 13: sRetTemplate = "tavern004"; break;
                    case 14: sRetTemplate = "tavern013"; break;
                    case 15: sRetTemplate = "tavern016"; break;
                    case 16: sRetTemplate = "tavern015"; break;
                    case 17: sRetTemplate = "tavern017"; break;
                }
    }

if (sTemplate == "drunks")
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "sailor003"; break;
                    case 1: sRetTemplate = "sailor004"; break;
                    case 2: sRetTemplate = "hooker001"; break;
                    case 3: sRetTemplate = "sailor005"; break;
                    case 4: sRetTemplate = "ruffian002"; break;
                    case 5: sRetTemplate = "ruffian003"; break;
                    case 6: sRetTemplate = "streetthug005"; break;
                    case 7: sRetTemplate = "streetthug006"; break;
                }
    }

if(sTemplate == "elves")
{
    switch(d4())
    {
            case 1: sRetTemplate = "tavern005"; break;
            case 2: sRetTemplate = "tavern006"; break;
            case 3: sRetTemplate = "tavern007"; break;
            case 4: sRetTemplate = "tavern009"; break;
    }
}



if(sTemplate == "adventurers")
{
    switch(Random(15))
    {
            case 0: sRetTemplate = "adventurer"; break;
            case 1: sRetTemplate = "adventurer001"; break;
            case 2: sRetTemplate = "adventurer002"; break;
            case 3: sRetTemplate = "adventurer003"; break;
            case 4: sRetTemplate = "adventurer004"; break;
            case 5: sRetTemplate = "adventurer005"; break;
            case 6: sRetTemplate = "adventurer006"; break;
            case 7: sRetTemplate = "adventurer007"; break;
            case 8: sRetTemplate = "adventurer008"; break;
            case 9: sRetTemplate = "ruffian001"; break;
            case 10: sRetTemplate = "ruffian"; break;
            case 11: sRetTemplate = "sailor"; break;
            case 12: sRetTemplate = "sailor001"; break;
            case 13: sRetTemplate = "sailor002"; break;
            case 14: sRetTemplate = "hooker"; break;
    }
}

if (sTemplate == "commoner")
    {

    switch( Random( 82 ))
                {
                    case 0: sRetTemplate = "femaledwarvencit"; break;
                    case 1: sRetTemplate = "femaleelvencitiz"; break;
                    case 2: sRetTemplate = "femalegnomishcit"; break;
                    case 3: sRetTemplate = "femalehalfelvenc"; break;
                    case 4: sRetTemplate = "femalehalflingci"; break;
                    case 5: sRetTemplate = "femalehalforccit"; break;
                    case 6: sRetTemplate = "femalehumancitiz"; break;
                    case 7: sRetTemplate = "maledwarvencitiz"; break;
                    case 8: sRetTemplate = "maleelvencitizen"; break;
                    case 9: sRetTemplate = "malegnomishcitiz"; break;
                    case 10: sRetTemplate = "malehalfelvencit"; break;
                    case 11: sRetTemplate = "malehalflingciti"; break;
                    case 12: sRetTemplate = "malehalforccitiz"; break;
                    case 13: sRetTemplate = "malehumancitizen"; break;
                    case 14: sRetTemplate = "malehumanciti001"; break;
                    case 15: sRetTemplate = "femaledwarven001"; break;
                    case 16: sRetTemplate = "femaleelvenci001"; break;
                    case 17: sRetTemplate = "femalegnomish001"; break;
                    case 18: sRetTemplate = "femalehalfelv001"; break;
                    case 19: sRetTemplate = "femalehalflin002"; break;
                    case 20: sRetTemplate = "femalehalforc001"; break;
                    case 21: sRetTemplate = "femalehalforc001"; break;
                    case 22: sRetTemplate = "femalehumanci001"; break;
                    case 23: sRetTemplate = "maledwarvenci003"; break;
                    case 24: sRetTemplate = "maleelvenciti001"; break;
                    case 25: sRetTemplate = "malegnomishci001"; break;
                    case 26: sRetTemplate = "malehalflingc001"; break;
                    case 27: sRetTemplate = "malehalforcci001"; break;
                    case 28: sRetTemplate = "malehumancitizen"; break;
                    case 29: sRetTemplate = "malehumanciti001"; break;
                    case 30: sRetTemplate = "malehumancitizen"; break;
                    case 31: sRetTemplate = "malehumanciti001"; break;
                    case 32: sRetTemplate = "malehumancitizen"; break;
                    case 33: sRetTemplate = "malehumanciti001"; break;
                    case 34: sRetTemplate = "malehumancitizen"; break;
                    case 35: sRetTemplate = "malehumanciti001"; break;
                    case 36: sRetTemplate = "malehumancitizen"; break;
                    case 37: sRetTemplate = "malehumanciti001"; break;
                    case 38: sRetTemplate = "malehumancitizen"; break;
                    case 39: sRetTemplate = "malehumanciti001"; break;
                    case 40: sRetTemplate = "malehumancitizen"; break;
                    case 41: sRetTemplate = "malehumanciti001"; break;
                    case 42: sRetTemplate = "terrier"; break;
                    case 43: sRetTemplate = "malamute"; break;
                    case 44: sRetTemplate = "dog002"; break;
                    case 45: sRetTemplate = "doberman"; break;
                    case 46: sRetTemplate = "dalmatian"; break;
                    case 47: sRetTemplate = "husky"; break;
                    case 48: sRetTemplate = "mastiff"; break;
                    case 49: sRetTemplate = "femalehumanci001"; break;
                    case 50: sRetTemplate = "femalehumancitiz"; break;
                    case 51: sRetTemplate = "femalehumanci001"; break;
                    case 52: sRetTemplate = "femalehumancitiz"; break;
                    case 53: sRetTemplate = "femalehumanci001"; break;
                    case 54: sRetTemplate = "femalehumancitiz"; break;
                    case 55: sRetTemplate = "femalehumanci001"; break;
                    case 56: sRetTemplate = "femalehumancitiz"; break;
                    case 57: sRetTemplate = "femalehumanci001"; break;
                    case 58: sRetTemplate = "femalehumancitiz"; break;
                    case 59: sRetTemplate = "femalehumanci001"; break;
                    case 60: sRetTemplate = "maledwarvencitiz"; break;
                    case 61: sRetTemplate = "maleelvencitizen"; break;
                    case 62: sRetTemplate = "femaledwarvencit"; break;
                    case 63: sRetTemplate = "femaleelvenci001"; break;
                    case 64: sRetTemplate = "maleelvenciti001"; break;
                    case 65: sRetTemplate = "femaleelvencitiz"; break;
                    case 66: sRetTemplate = "malehalflingc001"; break;
                    case 67: sRetTemplate = "malehalflingciti"; break;
                    case 68: sRetTemplate = "femalehalflin002"; break;
                    case 69: sRetTemplate = "femalehalflingci"; break;
                    case 70: sRetTemplate = "femalegnomishcit"; break;
                    case 71: sRetTemplate = "malegnomishci001"; break;
                    case 72: sRetTemplate = "malekid002"; break;
                    case 73: sRetTemplate = "malekid002"; break;
                    case 74: sRetTemplate = "malekid002"; break;
                    case 75: sRetTemplate = "malekid002"; break;
                    case 76: sRetTemplate = "malekid002"; break;
                    case 77: sRetTemplate = "femalekid002"; break;
                    case 78: sRetTemplate = "femalekid002"; break;
                    case 79: sRetTemplate = "femalekid002"; break;
                    case 80: sRetTemplate = "femalekid002"; break;
                    case 81: sRetTemplate = "femalekid002"; break;
    }
 }
if (sTemplate == "waterdahvians")
    {

    switch( Random( 162 ))
                {
                    case 0: sRetTemplate = "femaledwarvencit"; break;
                    case 1: sRetTemplate = "femaleelvencitiz"; break;
                    case 2: sRetTemplate = "femalegnomishcit"; break;
                    case 3: sRetTemplate = "femalehalfelvenc"; break;
                    case 4: sRetTemplate = "femalehalflingci"; break;
                    case 5: sRetTemplate = "femalehalforccit"; break;
                    case 6: sRetTemplate = "femalehumancitiz"; break;
                    case 7: sRetTemplate = "maledwarvencitiz"; break;
                    case 8: sRetTemplate = "maleelvencitizen"; break;
                    case 9: sRetTemplate = "malegnomishcitiz"; break;
                    case 10: sRetTemplate = "malehalfelvencit"; break;
                    case 11: sRetTemplate = "malehalflingciti"; break;
                    case 12: sRetTemplate = "malehalforccitiz"; break;
                    case 13: sRetTemplate = "malehumancitizen"; break;
                    case 14: sRetTemplate = "malehumanciti001"; break;
                    case 15: sRetTemplate = "femaledwarven001"; break;
                    case 16: sRetTemplate = "femaleelvenci001"; break;
                    case 17: sRetTemplate = "femalegnomish001"; break;
                    case 18: sRetTemplate = "femalehalfelv001"; break;
                    case 19: sRetTemplate = "femalehalflin002"; break;
                    case 20: sRetTemplate = "femalehalforc001"; break;
                    case 21: sRetTemplate = "femalehalforc001"; break;
                    case 22: sRetTemplate = "femalehumanci001"; break;
                    case 23: sRetTemplate = "maledwarvenci003"; break;
                    case 24: sRetTemplate = "maleelvenciti001"; break;
                    case 25: sRetTemplate = "malegnomishci001"; break;
                    case 26: sRetTemplate = "malehalflingc001"; break;
                    case 27: sRetTemplate = "malehalforcci001"; break;
                    case 28: sRetTemplate = "malehumancitizen"; break;
                    case 29: sRetTemplate = "malehumanciti001"; break;
                    case 30: sRetTemplate = "malehumancitizen"; break;
                    case 31: sRetTemplate = "malehumanciti001"; break;
                    case 32: sRetTemplate = "malehumancitizen"; break;
                    case 33: sRetTemplate = "malehumanciti001"; break;
                    case 34: sRetTemplate = "malehumancitizen"; break;
                    case 35: sRetTemplate = "malehumanciti001"; break;
                    case 36: sRetTemplate = "malehumancitizen"; break;
                    case 37: sRetTemplate = "malehumanciti001"; break;
                    case 38: sRetTemplate = "malehumancitizen"; break;
                    case 39: sRetTemplate = "malehumanciti001"; break;
                    case 40: sRetTemplate = "malehumancitizen"; break;
                    case 41: sRetTemplate = "malehumanciti001"; break;
                    case 42: sRetTemplate = "dalmatian"; break;
                    case 43: sRetTemplate = "doberman"; break;
                    case 44: sRetTemplate = "dog002"; break;
                    case 45: sRetTemplate = "husky"; break;
                    case 46: sRetTemplate = "malamute"; break;
                    case 47: sRetTemplate = "terrier"; break;
                    case 48: sRetTemplate = "mastiff"; break;
                    case 49: sRetTemplate = "femalehumanci001"; break;
                    case 50: sRetTemplate = "femalehumancitiz"; break;
                    case 51: sRetTemplate = "femalehumanci001"; break;
                    case 52: sRetTemplate = "femalehumancitiz"; break;
                    case 53: sRetTemplate = "femalehumanci001"; break;
                    case 54: sRetTemplate = "femalehumancitiz"; break;
                    case 55: sRetTemplate = "femalehumanci001"; break;
                    case 56: sRetTemplate = "femalehumancitiz"; break;
                    case 57: sRetTemplate = "femalehumanci001"; break;
                    case 58: sRetTemplate = "femalehumancitiz"; break;
                    case 59: sRetTemplate = "femalehumanci001"; break;
                    case 60: sRetTemplate = "maledwarvencitiz"; break;
                    case 61: sRetTemplate = "maleelvencitizen"; break;
                    case 62: sRetTemplate = "femaledwarvencit"; break;
                    case 63: sRetTemplate = "femaleelvenci001"; break;
                    case 64: sRetTemplate = "maleelvenciti001"; break;
                    case 65: sRetTemplate = "femaleelvencitiz"; break;
                    case 66: sRetTemplate = "malehalflingc001"; break;
                    case 67: sRetTemplate = "malehalflingciti"; break;
                    case 68: sRetTemplate = "femalehalflin002"; break;
                    case 69: sRetTemplate = "femalehalflingci"; break;
                    case 70: sRetTemplate = "femalegnomishcit"; break;
                    case 71: sRetTemplate = "malegnomishci001"; break;
                    case 72: sRetTemplate = "malekid002"; break;
                    case 73: sRetTemplate = "malekid002"; break;
                    case 74: sRetTemplate = "malekid002"; break;
                    case 75: sRetTemplate = "malekid002"; break;
                    case 76: sRetTemplate = "malekid002"; break;
                    case 77: sRetTemplate = "femalekid002"; break;
                    case 78: sRetTemplate = "femalekid002"; break;
                    case 79: sRetTemplate = "femalekid002"; break;
                    case 80: sRetTemplate = "femalekid002"; break;
                    case 81: sRetTemplate = "femalekid002"; break;
            case 82: sRetTemplate = "adventurer"; break;
            case 83: sRetTemplate = "adventurer001"; break;
            case 84: sRetTemplate = "adventurer002"; break;
            case 85: sRetTemplate = "adventurer003"; break;
            case 86: sRetTemplate = "adventurer004"; break;
            case 87: sRetTemplate = "adventurer005"; break;
            case 88: sRetTemplate = "adventurer006"; break;
            case 89: sRetTemplate = "adventurer007"; break;
            case 90: sRetTemplate = "adventurer008"; break;
            case 91: sRetTemplate = "ruffian001"; break;
            case 92: sRetTemplate = "ruffian"; break;
            case 93: sRetTemplate = "sailor"; break;
            case 94: sRetTemplate = "sailor001"; break;
            case 95: sRetTemplate = "sailor002"; break;
            case 96: sRetTemplate = "hooker"; break;
                 case 97: sRetTemplate = "tavern005"; break;
                 case 98: sRetTemplate = "tavern006"; break;
                 case 99: sRetTemplate = "tavern007"; break;
                 case 100: sRetTemplate = "tavern009"; break;
                    case 101: sRetTemplate = "sailor003"; break;
                    case 102: sRetTemplate = "tavern001"; break;
                    case 103: sRetTemplate = "hooker001"; break;
                    case 104: sRetTemplate = "sailor005"; break;
                    case 105: sRetTemplate = "femalehumancitiz"; break;
                    case 106: sRetTemplate = "ruffian003"; break;
                    case 107: sRetTemplate = "adventurer002"; break;
                    case 108: sRetTemplate = "streetthug006"; break;
                 case 109: sRetTemplate = "tavern001"; break;
                    case 110: sRetTemplate = "tavern002"; break;
                    case 112: sRetTemplate = "tavern003"; break;
                    case 113: sRetTemplate = "tavern004"; break;
                    case 114: sRetTemplate = "tavern013"; break;
                    case 115: sRetTemplate = "tavern016"; break;
                    case 116: sRetTemplate = "tavern015"; break;
                    case 117: sRetTemplate = "tavern017"; break;
                    case 118: sRetTemplate = "hooker001"; break;
                    case 119: sRetTemplate = "sailor04"; break;
                    case 120: sRetTemplate = "tavern001"; break;
                    case 121: sRetTemplate = "tavern002"; break;
                    case 122: sRetTemplate = "tavern003"; break;
                    case 123: sRetTemplate = "tavern004"; break;
                    case 124: sRetTemplate = "tavern013"; break;
                    case 125: sRetTemplate = "tavern016"; break;
                    case 126: sRetTemplate = "tavern015"; break;
                    case 127: sRetTemplate = "tavern017"; break;
                          case 128: sRetTemplate = "sailor01"; break;
        case 129: sRetTemplate = "sailor02"; break;
        case 130: sRetTemplate = "sailor03"; break;
        case 131: sRetTemplate = "sailor04"; break;
        case 132: sRetTemplate = "sailor05"; break;
        case 133: sRetTemplate = "sailor06"; break;
        case 134: sRetTemplate = "sailor07"; break;
        case 135: sRetTemplate = "sailor08"; break;
        case 136: sRetTemplate = "sailor09"; break;
        case 137: sRetTemplate = "sailor10"; break;
        case 138: sRetTemplate = "prostitute01"; break;
        case 139: sRetTemplate = "prostitute02"; break;
        case 140: sRetTemplate = "prostitute03"; break;
        case 141: sRetTemplate = "prostitute04"; break;
        case 142: sRetTemplate = "prostitute05"; break;
        case 143: sRetTemplate = "prostitute06"; break;
        case 144: sRetTemplate = "prostitute07"; break;
        case 145: sRetTemplate = "prostitute08"; break;
        case 146: sRetTemplate = "prostitute09"; break;
        case 147: sRetTemplate = "prostitute10"; break;
        case 148: sRetTemplate = "tavern001"; break;
        case 149: sRetTemplate = "tavern002"; break;
        case 150: sRetTemplate = "tavern003"; break;
        case 151: sRetTemplate = "tavern004"; break;
        case 152: sRetTemplate = "tavern005"; break;
        case 153: sRetTemplate = "tavern006"; break;
        case 154: sRetTemplate = "tavern007"; break;
        case 155: sRetTemplate = "tavern008"; break;
        case 156: sRetTemplate = "tavern009"; break;
        case 157: sRetTemplate = "tavern010"; break;
        case 158: sRetTemplate = "tavern011"; break;
        case 159: sRetTemplate = "tavern012"; break;
        case 160: sRetTemplate = "tavern013"; break;
   }
 }


if(sTemplate == "warrens")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "adventurer003"; break;
        case 1: sRetTemplate = "adventurer004"; break;
        case 2: sRetTemplate = "femalehumanci001"; break;
        case 3: sRetTemplate = "tavern013"; break;
        case 4: sRetTemplate = "tavern015"; break;
        case 5: sRetTemplate = "tavern016"; break;
        case 6: sRetTemplate = "tavern017"; break;
        case 7: sRetTemplate = "femalehalflin002"; break;
    }
}
if(sTemplate == "sw_performer")

{
    switch(Random(5))
    {
        case 0: sRetTemplate = "actor"; break;
        case 1: sRetTemplate = "actor001"; break;
        case 2: sRetTemplate = "actor002"; break;
        case 3: sRetTemplate = "actor003"; break;
        case 4: sRetTemplate = "trainedtroll"; break;
    }
}
    // Watch fix by Rick7475
    if (sTemplate == "patrolgroup")
    {
      switch( Random( 12 ))
        {
           case 0: sRetTemplate = "citywatchcivilar"; break;
           case 1: sRetTemplate = "citywatcharmar"; break;
           case 2: sRetTemplate = "citywatcharmar"; break;
           case 3: sRetTemplate = "citywatchmancpl"; break;
           case 4: sRetTemplate = "citywatchmancpl"; break;
           case 5: sRetTemplate = "citywatchman"; break;
           case 6: sRetTemplate = "citywatchman"; break;
           case 7: sRetTemplate = "citywatchman"; break;
           case 8: sRetTemplate = "citywatchman"; break;
           case 9: sRetTemplate = "citywatchwizarde"; break;
           case 10: sRetTemplate = "citywatchwizarde"; break;
           case 11: sRetTemplate = "citywatchwizarde"; break;
        }
    }

     // Watch fix by Rick7475
    if (sTemplate == "watchgroup")
    {
      switch( Random( 12 ))
        {
           case 0: sRetTemplate = "citywatchcivilar"; break;
           case 1: sRetTemplate = "citywatcharmar"; break;
           case 2: sRetTemplate = "citywatcharmar"; break;
           case 3: sRetTemplate = "citywatchmancpl"; break;
           case 4: sRetTemplate = "citywatchmancpl"; break;
           case 5: sRetTemplate = "citywatchman"; break;
           case 6: sRetTemplate = "citywatchman"; break;
           case 7: sRetTemplate = "citywatchman"; break;
           case 8: sRetTemplate = "citywatchman"; break;
           case 9: sRetTemplate = "citywatchwizarde"; break;
           case 10: sRetTemplate = "citywatchwizarde"; break;
           case 11: sRetTemplate = "citywatchwizarde"; break;
        }
    }


    //
    // Added by Rick7475 to restore the sewers to the plumber quest.
    if (sTemplate == "sewers_1")
    {
        switch( Random( 18 ))
                {
                    case 0: sRetTemplate = "ashrat"; break;
                    case 1: sRetTemplate = "stinkbeetle"; break;
                    case 2: sRetTemplate = "ratdisease"; break;
                    case 3: sRetTemplate = "ratdisease"; break;
                    case 4: sRetTemplate = "ratdisease"; break;
                    case 5: sRetTemplate = "wanderrat"; break;
                    case 6: sRetTemplate = "sewerm001"; break;
                    case 7: sRetTemplate = "bat001"; break;
                    case 8: sRetTemplate = "ratdisease"; break;
                    case 9: sRetTemplate = "stinkbeetle"; break;
                    case 10: sRetTemplate = "stinkbeetle"; break;
                    case 11: sRetTemplate = "bat002"; break;
                    case 12: sRetTemplate = "stinkbeetle"; break;
                    case 13: sRetTemplate = "alfa_mouse"; break;
                    case 14: sRetTemplate = "bobtailcat001"; break;
                    case 15: sRetTemplate = "slimygoblin3"; break;
                    case 16: sRetTemplate = "ratdisease"; break;
                    case 17: sRetTemplate = "slimyspider2"; break;
                }
    }
    //added by Arianna to tone down the upper sewers  for  lower levels
      if (sTemplate == "sewers_2")
    {
        switch( Random( 18 ))
                {
                    //case 0: sRetTemplate = "ashrat"; break;
                    //case 1: sRetTemplate = "rn_beetle_med_03"; break;
                    //case 2: sRetTemplate = "nw_rat001"; break;
                    //case 3: sRetTemplate = "nw_rat001"; break;
                    //case 4: sRetTemplate = "ratdisease"; break;
                    //case 5: sRetTemplate = "wanderrat"; break;
                    //case 6: sRetTemplate = "sewerm"; break;
                    //case 7: sRetTemplate = "wanderrat"; break;
                    //case 8: sRetTemplate = "ratdisease"; break;
                    //case 9: sRetTemplate = "stinkbeetle"; break;
                    //case 10: sRetTemplate = "rn_beetle_med_03"; break;
                    //case 11: sRetTemplate = "sewerwasp"; break;
                    //case 12: sRetTemplate = "nw_btlfire"; break;
                    //case 13: sRetTemplate = "tinyspider"; break;
                    //case 14: sRetTemplate = "tinyspider001"; break;
                    //case 15: sRetTemplate = "slimygoblin3"; break;
                    //case 16: sRetTemplate = "nw_rat001"; break;
                    //case 17: sRetTemplate = "tinyspider001"; break;
                }
    }
    if (sTemplate == "sewers_beetles")
            {
            switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "btlfire001"; break;
                    case 1: sRetTemplate = "rn_beetle_med_02"; break;
                    case 2: sRetTemplate = "stagbeetle001"; break;
                    case 3: sRetTemplate = "btlfire003"; break;

                }
    }
    if (sTemplate == "sw_fireb_lesser")
            {
            switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "btlfire001"; break;
                    case 1: sRetTemplate = "rn_beetle_med_01"; break;
                    case 2: sRetTemplate = "btlfire003"; break;
                    case 3: sRetTemplate = "btlfire001"; break;

                }
    }
    if (sTemplate == "sw_fireb")
            {
            switch( Random( 5 ))
                {
                    case 0: sRetTemplate = "btlfire001"; break;
                    case 1: sRetTemplate = "rn_beetle_med_01"; break;
                    case 2: sRetTemplate = "btlfire003"; break;
                    case 3: sRetTemplate = "rn_beetle_med_02"; break;
                    case 4: sRetTemplate = "stagbeetle001"; break;

                }
    }
    if (sTemplate == "sw_fireb_greater")
            {
            switch( Random( 5 ))
                {
                    case 0: sRetTemplate = "stagbeetle001"; break;
                    case 1: sRetTemplate = "rn_beetle_med_02"; break;
                    case 2: sRetTemplate = "btlfire003"; break;
                    case 3: sRetTemplate = "rn_beetle_med_02"; break;
                    case 4: sRetTemplate = "rn_beetle_med001"; break;

                }
    }
    if (sTemplate == "sw_fireelemental")
            {
            switch( Random( 5 ))
                {
                    case 0: sRetTemplate = "fire001"; break;
                    case 1: sRetTemplate = "fire001"; break;
                    case 2: sRetTemplate = "fire001"; break;
                    case 3: sRetTemplate = "fire002"; break;
                    case 4: sRetTemplate = "fire002"; break;

                }
    }

    if (sTemplate == "sw_greyooze_lesser")
    {
        sRetTemplate = "grayoozesmall";


    }
    if (sTemplate == "sw_greyooze")
            {
          sRetTemplate = "grayoozemed";


    }
    if (sTemplate == "sw_greyooze_greater")
            {
           sRetTemplate = "grayoozelrg";

    }
    if (sTemplate == "wallmimichid")
            {
           sRetTemplate = "wallmimichid";

    }







    if (sTemplate == "sewers_spiders")
            {
            switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "tinyspider"; break;
                    case 1: sRetTemplate = "tinyspider001"; break;
                    case 2: sRetTemplate = "LargeSpider"; break;
                    case 3: sRetTemplate = "NW_SPIDSWRD"; break;

                }
    }
    if (sTemplate == "RustMonster")
    {

             sRetTemplate = "RustMonster";

    }
    if (sTemplate == "sewers_goo")
            {
            switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "GelatenousCube"; break;
                    case 1: sRetTemplate = "GreenSlimeS"; break;
                    case 2: sRetTemplate = "GreenSlimeS"; break;
                    case 3: sRetTemplate = "nw_ochrejellymed"; break;

                }
    }
    if (sTemplate == "sewers_snek")
            {
            switch( Random( 2 ))
                {
                    case 0: sRetTemplate = "sewerm"; break;
                    case 1: sRetTemplate = "sewerwasp"; break;

                }
    }
    if (sTemplate == "otyughplaguebear")
            {
            switch( Random( 2 ))
                {
                    case 0: sRetTemplate = "otyughplaguebear"; break;
                    case 1: sRetTemplate = "otyughplaguebear"; break;

                }
    }




    if (sTemplate == "sewers_goblins")
    {

        if(GetIsDay()){

            switch( Random( 15 ))
                {
                    case 0: sRetTemplate = "slimygoblin1"; break;
                    case 1: sRetTemplate = "slimygoblin1"; break;
                    case 2: sRetTemplate = "slimygoblin1"; break;
                    case 3: sRetTemplate = "slimygoblin1"; break;
                    case 4: sRetTemplate = "slimygoblin7"; break;
                    case 5: sRetTemplate = "slimygoblin2"; break;
                    case 6: sRetTemplate = "slimygoblin2"; break;
                    case 7: sRetTemplate = "slimygoblin5"; break;
                    case 8: sRetTemplate = "slimygoblin2"; break;
                    case 9: sRetTemplate = "slimygoblindog"; break;
                    case 10: sRetTemplate = "slimygoblindog"; break;
                    case 11: sRetTemplate = "slimygoblin3"; break;
                    case 12: sRetTemplate = "slimygoblin3"; break;
                    case 13: sRetTemplate = "slimygoblin4"; break;
                    case 14: sRetTemplate = "slimygoblin5"; break;
                }
        }
        else{
            switch( Random( 12 ))
                {
                    case 0: sRetTemplate = "slimygoblin6"; break;
                    case 1: sRetTemplate = "slimygoblin2"; break;
                    case 2: sRetTemplate = "slimygoblin2"; break;
                    case 3: sRetTemplate = "slimygoblin1"; break;
                    case 4: sRetTemplate = "slimygoblin7"; break;
                    case 5: sRetTemplate = "slimygoblin4"; break;
                    case 6: sRetTemplate = "slimygoblin5"; break;
                    case 7: sRetTemplate = "slimygoblindog"; break;
                    case 8: sRetTemplate = "slimygoblindog"; break;
                    case 9: sRetTemplate = "slimygoblin3"; break;
                    case 10: sRetTemplate = "slimygoblin4"; break;
                    case 11: sRetTemplate = "slimygoblin5"; break;
                }
        }
    }

     if (sTemplate == "plaguerats")
    {
      switch( Random( 10 ))
        {
           case 0: sRetTemplate = "plaguerat6"; break;
           case 1: sRetTemplate = "plaguerat6"; break;
           case 2: sRetTemplate = "plaguerat2"; break;
           case 3: sRetTemplate = "plaguerat2"; break;
           case 4: sRetTemplate = "plaguerat3"; break;
           case 5: sRetTemplate = "plaguerat3"; break;
           case 6: sRetTemplate = "plaguerat4"; break;
           case 7: sRetTemplate = "plaguerat4"; break;
           case 8: sRetTemplate = "plaguerat5"; break;
           case 9: sRetTemplate = "plaguerat1"; break;
        }
    }
    if (sTemplate == "plagueratspickpock")
    {
      switch( Random( 10 ))
        {
           case 0: sRetTemplate = "plagueratpick1"; break;
           case 1: sRetTemplate = "plagueratpick1"; break;
           case 2: sRetTemplate = "plagueratpick1"; break;
           case 3: sRetTemplate = "plagueratpick1"; break;
           case 4: sRetTemplate = "plagueratpick2"; break;
           case 5: sRetTemplate = "plagueratpick2"; break;
           case 6: sRetTemplate = "plagueratpick2"; break;
           case 7: sRetTemplate = "plagueratpick3"; break;
           case 8: sRetTemplate = "plagueratpick3"; break;
           case 9: sRetTemplate = "plagueratpick4"; break;
        }
    }


    if (sTemplate == "sewers_goblins_night")
    {
      switch( Random( 12 ))
        {
           case 0: sRetTemplate = "slimygoblin6"; break;
           case 1: sRetTemplate = "slimygoblin6"; break;
           case 2: sRetTemplate = "slimygoblin2"; break;
           case 3: sRetTemplate = "slimygoblin1"; break;
           case 4: sRetTemplate = "slimygoblin7"; break;
           case 5: sRetTemplate = "slimygoblin4"; break;
           case 6: sRetTemplate = "slimygoblin5"; break;
           case 7: sRetTemplate = "slimygoblin6"; break;
           case 8: sRetTemplate = "slimygoblindog"; break;
           case 9: sRetTemplate = "slimygoblin3"; break;
           case 10: sRetTemplate = "slimygoblin4"; break;
           case 11: sRetTemplate = "slimygoblin5"; break;
        }
    }

    if (sTemplate == "sewers_orcs")  //Changed to Xanathar
    {
        switch( Random( 10 ))
                {
                    case 0: sRetTemplate = "xanatharslaver1"; break;
                    case 1: sRetTemplate = "xanatharslaver1"; break;
                    case 2: sRetTemplate = "xanatharslaver1"; break;
                    case 3: sRetTemplate = "xanatharslaver1"; break;
                    case 4: sRetTemplate = "beholder003"; break;
                    case 5: sRetTemplate = "xanatharslaver1"; break;
                    case 6: sRetTemplate = "xanatharenforcer"; break;
                    case 7: sRetTemplate = "xanatharenforcer"; break;
                    case 8: sRetTemplate = "xanatharslaver2"; break;
                    case 9: sRetTemplate = "xanatharofficer"; break;
                }
    }
    if (sTemplate == "sewers_ogres")
    {
        switch( Random( 10 ))
                {
                    case 0: sRetTemplate = "rn_ogre_02"; break;
                    case 1: sRetTemplate = "rn_ogre_02"; break;
                    case 2: sRetTemplate = "rn_ogre_02"; break;
                    case 3: sRetTemplate = "rn_ogre_02"; break;
                    case 4: sRetTemplate = "ogrewar"; break;
                    case 5: sRetTemplate = "ogrewar"; break;
                    case 6: sRetTemplate = "ogrewar"; break;
                    case 7: sRetTemplate = "ogremagi"; break;
                    case 8: sRetTemplate = "ogremagi2"; break;
                    case 9: sRetTemplate = "ogrewar001"; break;
                }
    }
    if (sTemplate == "lower_sewers_skum")
    {
        switch( Random( 10 ))
                {
                    case 0: sRetTemplate = "rn_ogre_02"; break;
                    case 1: sRetTemplate = "xanatharslavera"; break;
                    case 2: sRetTemplate = "xanatharenforcea"; break;
                    case 3: sRetTemplate = "skum"; break;
                    case 4: sRetTemplate = "skum"; break;
                    case 5: sRetTemplate = "zhentspy003"; break;
                    case 6: sRetTemplate = "cityguardarchera"; break;
                    case 7: sRetTemplate = "watchwiza"; break;
                    case 8: sRetTemplate = "cityguardsmanofa"; break;
                    case 9: sRetTemplate = "skum"; break;
                }
    }

 if (sTemplate == "goblins_mid")
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "slimygoblin1"; break;
                    case 1: sRetTemplate = "slimygoblin2"; break;
                    case 2: sRetTemplate = "slimygoblin3"; break;
                    case 3: sRetTemplate = "slimygoblin4"; break;
                    case 4: sRetTemplate = "rn_goblin_05"; break;
                    case 5: sRetTemplate = "rn_goblin_07"; break;
                    case 6: sRetTemplate = "goblina002"; break;
                    case 7: break;
                }
    }

if (sTemplate == "goblins_high")  //added by ayergo for sewer orcs for consistency
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "UndeadGoblinWarrior"; break;
                    case 1: sRetTemplate = "ServantoftheUndyingPrince"; break;
                    case 2: sRetTemplate = "gobchiefa001"; break;
                    case 3: sRetTemplate = "slimygoblin4"; break;
                    case 4: sRetTemplate = "rn_goblin_05"; break;
                    case 5: sRetTemplate = "rn_goblin_07"; break;
                    case 6: sRetTemplate = "goblina002"; break;
                    case 7:  break;
                }
    }
if (sTemplate == "sm_orcs")
    {
        switch( Random( 5 ))
                {
                    case 0: sRetTemplate = "SM_orc1"; break;
                    case 1: sRetTemplate = "SM_orc2"; break;
                    case 2: sRetTemplate = "SM_orc_Shaman"; break;
                    case 3: sRetTemplate = "SM_orc_Patroller"; break;

                }
    }
if (sTemplate == "sm_monster")
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "ALFA_TROLL"; break;
                    case 1: sRetTemplate = "NW_UMBERHULK"; break;
                    case 2: sRetTemplate = "rn_rustmonster"; break;
                    case 3: sRetTemplate = "GelatenousCube"; break;
                    case 4: sRetTemplate = "nw_ettin"; break;
                    case 5: sRetTemplate = "nw_gnthill"; break;

                }
    }



//rat hills tables


if (sTemplate == "rat_hills")  //spawn of rats
    {
        switch( Random( 15))
                {
                    case 0: sRetTemplate = "rn_infectedrat"; break;
                    case 1: sRetTemplate = "rn_direrat_01"; break;//10 hp rat
                    case 2: sRetTemplate = "ratdire002"; break;
                    case 3: sRetTemplate = "NW_RATDIRE001"; break;
                    case 4: sRetTemplate = "NW_RAT001"; break;
                    case 5: sRetTemplate = "rat004"; break;
                    case 6: sRetTemplate = "rat002"; break;
                    case 7: sRetTemplate = "AshRat"; break;
                    case 8: sRetTemplate = "rat004"; break;
                    case 9: sRetTemplate = "rat002"; break;
                    case 10: sRetTemplate = "rat004"; break;
                    case 11: sRetTemplate = "rat002"; break;
                    case 12: sRetTemplate = "rat004"; break;
                    case 13: sRetTemplate = "rat002"; break;
                    case 14: sRetTemplate = "rat004"; break;
                }
    }
    if (sTemplate == "rat_hills0")  //spawn of rats
    {
        switch( Random(3))
                {

                case 0: sRetTemplate = "rat004"; break;
                case 1: sRetTemplate = "rat002"; break;
                case 2: sRetTemplate = "rat004"; break;
            }
}


if (sTemplate == "rat_hills1")  //spawn of rats
    {
        switch( Random( 6))
                {

                case 1: sRetTemplate = "rat004"; break;
                case 2: sRetTemplate = "rat002"; break;
                case 3: sRetTemplate = "rat004"; break;
                case 4: sRetTemplate = "rat002"; break;
                case 5: sRetTemplate = "rat004"; break;
                case 0: sRetTemplate = "AshRat"; break;
            }
}

if (sTemplate == "rat_hills2")  //spawn of rats
    {
        switch( Random( 9))
                {

                case 1: sRetTemplate = "diseased_rat"; break;
                case 2: sRetTemplate = "NW_RATDIRE001"; break;
                case 3: sRetTemplate = "rat004"; break;
                case 4: sRetTemplate = "rat002"; break;
                case 5: sRetTemplate = "rn_marsupialrat"; break;
                case 6: sRetTemplate = "AshRat"; break;
                case 7: sRetTemplate = "ratdire002"; break;
                case 8: sRetTemplate = "rn_marsupialrat"; break;
                case 0: sRetTemplate = "rn_infectedrat"; break;

            }
}

if (sTemplate == "rat_hills3")  //spawn of rats
    {
        switch( Random( 9))
                {

                case 1: sRetTemplate = "diseased_rat"; break;
                case 2: sRetTemplate = "NW_RATDIRE001"; break;
                case 3: sRetTemplate = "rn_direrat_01"; break;
                case 4: sRetTemplate = "rn_marsupialrat"; break;
                case 5: sRetTemplate = "Plague_Rat"; break;
                case 6: sRetTemplate = "AshRat"; break;
                case 7: sRetTemplate = "ratdire002"; break;
                case 8: sRetTemplate = "rn_direrat_01"; break;//10 hp rat
                case 0: sRetTemplate = "rn_infectedrat"; break;

            }
}

  /*****  Appears broken, always spawns gelatenouscube  Removed until it can be debugged
    if (GetStringLeft(sTemplate, 9) == "rat_hills")
    {
        int nCounterCur;    // current counter, starts at 1st mob
        int nCounterMax;    // maximum number in a particular encounter
        int nRandom;        // general random number
        int nLoot = 500;    // default loot merchant to be used for treasure if not specified
        int nStart;         // starting blueprint _xx suffix number (ie to start at _03 would be 3)
        int nMaxVariance;   // total number of consecutive _xx values (ie _03 to _08 would be 5)
        string sBlue;       // blueprint prefix
        string sCurrentTemplate = GetLocalString(oSpawn, "TemplateCur");  // current monster template



        if (sCurrentTemplate == "")
        {
            nRandom = Random(14) +1;

            switch (nRandom)
            {
                case 1: sBlue = "gelatenouscube"; nCounterMax = 1; nMaxVariance = 0; nStart = 0; nLoot = 551; break;
                case 2: sBlue = "rn_beetle_med_03"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 3: sBlue = "rn_lizardfolk"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 4: sBlue = "rn_beetle_med_01"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 551; break;
                case 5: sBlue = "stinkbeetle"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 6: sBlue = "rn_spider_05"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 7: sBlue = "smallblackpud"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 8: sBlue = "rn_skeleton_06"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 9: sBlue = "rn_wolf_03"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 10: sBlue = "smallblackpud"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 11: sBlue = "rn_ant_01"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 12: sBlue = "ratdire001_01"; nCounterMax = 1; nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 13: sBlue = "rn_beetle_med_02"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                case 14: sBlue = "rn_viper_04"; nCounterMax = d2() ; nMaxVariance = 0; nStart = 0; nLoot = 500; break;



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
        if ((nCounterCur < nCounterMax) && (GetStringRight(sBlue,1) == "_"))   //changed <= to <
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
            }

            sRetTemplate = sCurrentTemplate;
            SetLocalString(oSpawn, "TemplateCur", sRetTemplate);

        //    SetLocalInt(oSpawn, "f_LootTable", nLoot);  // default loot for mob

            nCounterCur++;
            SetLocalInt(oSpawn, "CounterCur", nCounterCur);
        }

        // Spawn single template mobs
        else if ((nCounterCur < nCounterMax) && (GetStringRight(sBlue,1) != "_"))  //changed <= to <
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
    }        */

//dungeon tables

    if (GetStringLeft(sTemplate, 8) == "dungeon_")
    {
        int nCounterCur;    // current counter, starts at 1st mob
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

            if (GetStringRight(sTemplate, 4) == "_cr1")
            {
                nRandom = Random(10) +1;

                switch (nRandom)
                {
                    case 1: sBlue = "rn_infectedrat"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 2: sBlue = "rn_beetle_med_01"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 3: sBlue = "rn_kobold_"; nCounterMax = d6() +3; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 4: sBlue = "rn_skeleton_"; nCounterMax = d3() +1; nMaxVariance = 4; nStart = 1; nLoot = 999; break;
                    case 5: sBlue = "rn_zombie_"; nCounterMax = d3(); nMaxVariance = 2; nStart = 1; nLoot = 999; break;
                    case 6: sBlue = "rn_spider_02"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 7: sBlue = "rn_krenshar"; nCounterMax = 1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 8: sBlue = "rn_goblin_"; nCounterMax = d4() +2; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 9: sBlue = "rn_direrat_01"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 10: sBlue = "rn_stirge"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                }
            }
            else if (GetStringRight(sTemplate, 4) == "_cr2")
            {
                nRandom = Random(11) +1;

                switch (nRandom)
                {
                    case 1: sBlue = "rn_spider_03"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 2: sBlue = "rn_hobgoblin_"; nCounterMax = d4() +2; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 3: sBlue = "rn_lizardfolk_"; nCounterMax = d3(); nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 4: sBlue = "rn_orc_"; nCounterMax = d4() +2; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 5: sBlue = "rn_zombie_"; nCounterMax = d4() +2; nMaxVariance = 2; nStart = 1; nLoot = 999; break;
                    case 6: sBlue = "rn_ghoul"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 7: sBlue = "rn_beetle_med_02"; nCounterMax = d3()+1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 8: sBlue = "rn_ant_01"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                    case 9: sBlue = "rn_gnoll_"; nCounterMax = d3(); nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 10: sBlue = "rn_adventurer_"; nCounterMax = d3(); nMaxVariance = 7; nStart = 1; nLoot = 999; break;
                    case 11: sBlue = "rn_ironfang_"; nCounterMax = d3(); nMaxVariance = 7; nStart = 1; nLoot = 550; break;
                }
            }
            else if (GetStringRight(sTemplate, 4) == "_cr3")
            {
                nRandom = Random(12) +1;

                switch (nRandom)
                {
                    case 1: sBlue = "rn_stinger_01"; nCounterMax = 1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 2: sBlue = "rn_beetle_med_03"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 3: sBlue = "rn_spider_04"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 4: sBlue = "rn_imp"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 500; break;
                    case 5: sBlue = "rn_gnoll_"; nCounterMax = d3() +2; nMaxVariance = 4; nStart = 1; nLoot = 999; break;
                    case 6: sBlue = "rn_duergar_"; nCounterMax = d4() +1; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 7: sBlue = "rn_derro_"; nCounterMax = d3(); nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 8: sBlue = "rn_ghast_01"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 9: sBlue = "gelatenouscube"; nCounterMax = 1; nMaxVariance = 0; nStart = 0; nLoot = 551; break;
                    case 10: sBlue = "rn_rustedbld_"; nCounterMax = d3(); nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 11: sBlue = "rn_kobold_"; nCounterMax = d6() +2; nMaxVariance = 7; nStart = 1; nLoot = 550; break;
                    case 12: sBlue = "rn_ironfang_"; nCounterMax = d3()+2; nMaxVariance = 7; nStart = 1; nLoot = 550; break;
                }
            }
            else if (GetStringRight(sTemplate, 4) == "_cr4")
            {
                nRandom = Random(12) +1;

                switch (nRandom)
                {
                    case 1: sBlue = "rn_orc_"; nCounterMax = d6() +3; nMaxVariance = 7; nStart = 1; nLoot = 550; break;
                    case 2: sBlue = "rn_goblin_"; nCounterMax = d6() +3; nMaxVariance = 7; nStart = 1; nLoot = 550; break;
                    case 3: sBlue = "rn_adventurer_"; nCounterMax = d4() +2; nMaxVariance = 4; nStart = 1; nLoot = 999; break;
                    case 4: sBlue = "rn_stinger_01"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 550; break;
                    case 5: sBlue = "rn_rustedbld_"; nCounterMax = d4() +1; nMaxVariance = 5; nStart = 1; nLoot = 550; break;
                    case 6: sBlue = "rn_derro_"; nCounterMax = d3() +2; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 7: sBlue = "rn_ogre_"; nCounterMax = d3(); nMaxVariance = 2; nStart = 1; nLoot = 550; break;
                    case 8: sBlue = "rn_rustmonster"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 9: sBlue = "rn_wight"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 10: sBlue = "rn_lizardfolk_"; nCounterMax = d4() +2; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 11: sBlue = "rn_formian_02"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 550; break;
                    case 12: sBlue = "rn_vampire_01"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                }
            }
            else if (GetStringRight(sTemplate, 4) == "_cr5")
            {
                nRandom = Random(11) +1;

                switch (nRandom)
                {
                    case 1: sBlue = "rn_spider_05"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 2: sBlue = "rn_bugbear_"; nCounterMax = d3() +2; nMaxVariance = 4; nStart = 1; nLoot = 550; break;
                    case 3: sBlue = "rn_ogre_"; nCounterMax = d3() +1; nMaxVariance = 2; nStart = 1; nLoot = 550; break;
                    case 4: sBlue = "rn_mummy_01"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 5: sBlue = "rn_wraith_01"; nCounterMax = d2(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 6: sBlue = "rn_mephit_"; nCounterMax = d3(); nMaxVariance = 9; nStart = 1; nLoot = 550; break;
                    case 7: sBlue = "rn_worg_01"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 8: sBlue = "rn_skeleton_06"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 9: sBlue = "rn_ant_02"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 10: sBlue = "rn_werewolf_01"; nCounterMax = d3(); nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                    case 11: sBlue = "rn_wererat_01"; nCounterMax = d3() +1; nMaxVariance = 0; nStart = 0; nLoot = 999; break;
                }

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
        if ((nCounterCur < nCounterMax) && (GetStringRight(sBlue,1) == "_"))   //changed <= to <
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
            }

            sRetTemplate = sCurrentTemplate;
            SetLocalString(oSpawn, "TemplateCur", sRetTemplate);

        //    SetLocalInt(oSpawn, "f_LootTable", nLoot);  // default loot for mob

            nCounterCur++;
            SetLocalInt(oSpawn, "CounterCur", nCounterCur);
        }

        // Spawn single template mobs
        else if ((nCounterCur < nCounterMax) && (GetStringRight(sBlue,1) != "_"))  //changed <= to <
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
    if (sTemplate == "rustedblades")
    {
        int nBlade = Random(7) + 1;
        sRetTemplate = "rn_rustedbld_0" + IntToString(nBlade);
    }
    //


if (sTemplate == "sailors")
{
    switch(Random(33))
    {
        case 0: sRetTemplate = "sailor01"; break;
        case 1: sRetTemplate = "sailor02"; break;
        case 2: sRetTemplate = "sailor03"; break;
        case 3: sRetTemplate = "sailor04"; break;
        case 4: sRetTemplate = "sailor05"; break;
        case 5: sRetTemplate = "sailor06"; break;
        case 6: sRetTemplate = "sailor07"; break;
        case 7: sRetTemplate = "sailor08"; break;
        case 8: sRetTemplate = "sailor09"; break;
        case 9: sRetTemplate = "sailor10"; break;
        case 10: sRetTemplate = "prostitute01"; break;
        case 11: sRetTemplate = "prostitute02"; break;
        case 12: sRetTemplate = "prostitute03"; break;
        case 13: sRetTemplate = "prostitute04"; break;
        case 14: sRetTemplate = "prostitute05"; break;
        case 15: sRetTemplate = "prostitute06"; break;
        case 16: sRetTemplate = "prostitute07"; break;
        case 17: sRetTemplate = "prostitute08"; break;
        case 18: sRetTemplate = "prostitute09"; break;
        case 19: sRetTemplate = "prostitute10"; break;
        case 20: sRetTemplate = "tavern001"; break;
        case 21: sRetTemplate = "tavern002"; break;
        case 22: sRetTemplate = "tavern003"; break;
        case 23: sRetTemplate = "tavern004"; break;
        case 24: sRetTemplate = "tavern005"; break;
        case 25: sRetTemplate = "tavern006"; break;
        case 26: sRetTemplate = "tavern007"; break;
        case 27: sRetTemplate = "tavern008"; break;
        case 28: sRetTemplate = "tavern009"; break;
        case 29: sRetTemplate = "tavern010"; break;
        case 30: sRetTemplate = "tavern011"; break;
        case 31: sRetTemplate = "tavern012"; break;
        case 32: sRetTemplate = "tavern013"; break;
    }
}

if(sTemplate == "sw_vermin_lesser")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "rn_spider_01"; break;
        case 1: sRetTemplate = "rn_spider_01"; break;
        case 2: sRetTemplate = "rn_spider_01"; break;
        case 3: sRetTemplate = "tinyspider"; break;
        case 4: sRetTemplate = "tinyspider001"; break;
        case 5: sRetTemplate = "tinyspider002"; break;
        case 6: sRetTemplate = "rn_spider_01"; break;
        case 7: sRetTemplate = "rn_spider_02"; break;
        case 8: sRetTemplate = "rn_spider_02"; break;
        case 10: sRetTemplate = "rn_spider_02"; break;
    }
}

if(sTemplate == "sw_vermin")

{
    switch(Random(11))
    {
        case 0: sRetTemplate = "rn_spider_03"; break;
        case 1: sRetTemplate = "rn_spider_03"; break;
        case 2: sRetTemplate = "rn_spider_03"; break;
        case 3: sRetTemplate = "rn_spider_02"; break;
        case 4: sRetTemplate = "drider1"; break;
        case 5: sRetTemplate = "nw_spidphase"; break;
        case 6: sRetTemplate = "nw_spidswrd"; break;
        case 7: sRetTemplate = "rn_spider_04"; break;
        case 8: sRetTemplate = "rn_spider_04"; break;
        case 9: sRetTemplate = "spidphase002"; break;
        case 10: sRetTemplate = "spidphase002"; break;
    }
}

if(sTemplate == "sw_vermin_greater")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "rn_spider_05"; break;
        case 1: sRetTemplate = "drider2"; break;
        case 2: sRetTemplate = "nw_spiddire"; break;
        case 3: sRetTemplate = "rn_spider_05"; break;
        case 4: sRetTemplate = "drider1"; break;
        case 5: sRetTemplate = "drider1"; break;
        case 6: sRetTemplate = "rn_ettercap_01"; break;
        case 7: sRetTemplate = "rn_ettercap_01"; break;
    }
}

if(sTemplate == "sw_beasts")

{
    switch(Random(22))
    {
        case 0: sRetTemplate = "nw_grayrend"; break;
        case 1: sRetTemplate = "nw_horror"; break;
        case 2: sRetTemplate = "nw_devour"; break;
        case 3: sRetTemplate = "nw_umberhulk"; break;
        case 4: sRetTemplate = "nw_minotaur"; break;
        case 5: sRetTemplate = "nw_minchief"; break;
        case 6: sRetTemplate = "nw_minotaurboss"; break;
        case 7: sRetTemplate = "nw_minwiz"; break;
        case 8: sRetTemplate = "manticore"; break;
        case 9: sRetTemplate = "drider"; break;
        case 10: sRetTemplate = "drider001"; break;
        case 11: sRetTemplate = "thexanathar001"; break;
        case 12: sRetTemplate = "gelatenouscube"; break;
        case 13: sRetTemplate = "mindflayer"; break;
        case 14: sRetTemplate = "rustmonster"; break;
        case 15: sRetTemplate = "grayooze"; break;
        case 16: sRetTemplate = "blackpudding"; break;
        case 17: sRetTemplate = "ochrejelly"; break;
        case 18: sRetTemplate = "ochrejelly001"; break;
        case 19: sRetTemplate = "ochrejelly002"; break;
        case 20: sRetTemplate = "nishruu"; break;
        case 21: sRetTemplate = "nyth"; break;
    }
}

if(sTemplate == "sw_demon_lesser")

{
    switch(Random(13))
    {
        case 0: sRetTemplate = "rn_mephit_06"; break;
        case 1: sRetTemplate = "nw_dmquasit"; break;
        case 2: sRetTemplate = "nw_mepsalt"; break;
        case 3: sRetTemplate = "nw_mepsteam"; break;
        case 4: sRetTemplate = "nw_mepmagma"; break;
        case 5: sRetTemplate = "nw_mepfire"; break;
        case 6: sRetTemplate = "rn_mephit_06"; break;
        case 7: sRetTemplate = "rn_mephit_06"; break;
        case 8: sRetTemplate = "rn_mephit_06"; break;
        case 9: sRetTemplate = "nw_mepice"; break;
        case 10: sRetTemplate = "rn_mephit_06"; break;
        case 11: sRetTemplate = "nw_mepwater"; break;
        case 12: sRetTemplate = "nw_hellhound"; break;
        //case 13: sRetTemplate = "grayooze"; break;
        //case 14: sRetTemplate = "gelatenouscube"; break;
    }
}

if(sTemplate == "sw_demon_night")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "rn_imp"; break;
        case 1: sRetTemplate = "nw_hellhound"; break;
        case 2: sRetTemplate = "rn_mephit_09"; break;  //salt mephit
        case 3: sRetTemplate = "rn_mephit_07"; break;  //steam mephit
        case 4: sRetTemplate = "rn_mephit_05"; break;  //magma mephit
        case 5: sRetTemplate = "rn_mephit_04"; break;  //fire mephit
        case 6: sRetTemplate = "rn_mephit_02"; break;  //dust mephit
        case 7: sRetTemplate = "rn_imp"; break;
        case 8: sRetTemplate = "rn_imp"; break;
        case 9: sRetTemplate = "nw_hellhound"; break;

    }
}
if(sTemplate == "sw_bloodyhand")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "rn_imp"; break;
        case 1: sRetTemplate = "ogremagi"; break;
        case 2: sRetTemplate = "ogrewar"; break;
        case 3: sRetTemplate = "sewertroll"; break;
        case 4: sRetTemplate = "sewertrollsor"; break;
        case 5: sRetTemplate = "trollhunter"; break;
        case 6: sRetTemplate = "minotaurbezerk"; break;
        case 7: sRetTemplate = "sewertroll"; break;
        case 8: sRetTemplate = "rn_imp"; break;
        case 9: sRetTemplate = "ogrewar"; break;

    }
}

if(sTemplate == "sw_livingmagic")

{

        sRetTemplate = "livingmagic";

}

if(sTemplate == "sw_lizardsnake")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "marshlizardman01"; break;
        case 1: sRetTemplate = "marshlizardman01"; break;
        case 2: sRetTemplate = "marshlizardma001"; break;
        case 3: sRetTemplate = "marshlizardma001"; break;
        case 4: sRetTemplate = "marshlizardma001"; break;
        case 5: sRetTemplate = "marshlizardma001"; break;
        case 6: sRetTemplate = "marshlizardman01"; break;
        case 7: sRetTemplate = "yuan_ti003"; break;
        case 8: sRetTemplate = "yuan_ti002"; break;
        case 9: sRetTemplate = "yuan_ti004"; break;

    }
}

if(sTemplate == "sw_croc")

{

        sRetTemplate = "saltwatercrocodi";

}



if(sTemplate == "sw_scaladar")

{

  sRetTemplate = "scaladar";


}

if(sTemplate == "sw_constructs")

{
    switch(Random(4))
    {
        case 0: sRetTemplate = "ay_guardgoyle"; break;
        case 1: sRetTemplate = "ay_guardgoyle"; break;
        case 2: sRetTemplate = "ay_claygolem"; break;
        case 3: sRetTemplate = "ay_stonegolem"; break;


    }
}


if(sTemplate == "sw_dweomervore")

{

  sRetTemplate = "dweomervore";


}
if(sTemplate == "sw_cult_low")

{
    switch(Random(13))
    {
        case 0: sRetTemplate = "dragoncultfollow"; break;
        case 1: sRetTemplate = "dragoncultfollow"; break;
        case 2: sRetTemplate = "dragoncultfollow"; break;
        case 3: sRetTemplate = "cultistofcyric"; break;
        case 4: sRetTemplate = "cultistofcyric"; break;
        case 5: sRetTemplate = "cultistofcyric"; break;
        case 6: sRetTemplate = "dweomervore002"; break;
        case 7: sRetTemplate = "zhentspy003"; break;
        case 8: sRetTemplate = "dragoncultfol001"; break;
        case 9: sRetTemplate = "marshlizardman01"; break;
        case 10: sRetTemplate = "cultistofcyric"; break;
        case 11: sRetTemplate = "dragoncultfollow"; break;
        case 12: sRetTemplate = "saltwatercrocodi"; break;
    }
}
if(sTemplate == "sw_cult_hi")

{
    switch(Random(16))
    {
        case 0: sRetTemplate = "dragoncultfollow"; break;
        case 1: sRetTemplate = "dragoncultfol001"; break;
        case 2: sRetTemplate = "dragoncultfol001"; break;
        case 3: sRetTemplate = "cultistofcyric"; break;
        case 4: sRetTemplate = "cultistofcyri001c"; break;
        case 5: sRetTemplate = "cultistofcyri001"; break;
        case 6: sRetTemplate = "cultistofcyri001"; break;
        case 7: sRetTemplate = "zhentspy003"; break;
        case 8: sRetTemplate = "zhentspy003"; break;
        case 9: sRetTemplate = "marshlizardman01"; break;
        case 10: sRetTemplate = "cultistofcyric"; break;
        case 11: sRetTemplate = "cultistofcyricwi"; break;
        case 12: sRetTemplate = "cultistofcyriccl"; break;
        case 13: sRetTemplate = "wyverncult"; break;
        case 14: sRetTemplate = "wyverncult"; break;
        case 15: sRetTemplate = "dweomervore002"; break;
    }
}

if(sTemplate == "sw_demon")

{
    switch(Random(13))
    {
        case 0: sRetTemplate = "nw_rakshasa"; break;
        case 1: sRetTemplate = "nw_dmsucubus"; break;
        case 2: sRetTemplate = "nw_dmvrock"; break;
        case 3: sRetTemplate = "nw_slaadbl"; break;
        case 4: sRetTemplate = "nw_slaadgrn"; break;
        case 5: sRetTemplate = "nw_slaadred"; break;
        case 6: sRetTemplate = "blackpudding"; break;
        case 7: sRetTemplate = "nishruu"; break;
        case 8: sRetTemplate = "howler"; break;
        case 9: sRetTemplate = "nyth"; break;
        case 10: sRetTemplate = "nw_yuan_ti001"; break;
        case 11: sRetTemplate = "nw_yuan_ti002"; break;
        case 12: sRetTemplate = "nw_yuan_ti003"; break;
    }
}

if(sTemplate == "sw_demon_greater")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "nw_slaadgray"; break;
        case 1: sRetTemplate = "nw_demon"; break;
        case 2: sRetTemplate = "nw_slaaddeth"; break;
        case 3: sRetTemplate = "nw_slaaddthboss"; break;
        case 4: sRetTemplate = "nw_slaadgryboss"; break;
        case 5: sRetTemplate = "marilith"; break;
        case 6: sRetTemplate = "boneooze"; break;
        case 7: sRetTemplate = "banshee"; break;
    }
}

if(sTemplate == "sw_undead_lesser")

{
    switch(Random(20))
    {
        case 0: sRetTemplate = "skeleton001"; break;
        case 1: sRetTemplate = "rn_zombie_01"; break;
        case 2: sRetTemplate = "tide_waterdha001"; break;
        case 3: sRetTemplate = "rn_ghast_01"; break;
        case 4: sRetTemplate = "skeleton002"; break;
        case 5: sRetTemplate = "skeleton003"; break;
        case 6: sRetTemplate = "skeleton004"; break;
        case 7: sRetTemplate = "skeleton005"; break;
        case 8: sRetTemplate = "skeleton006"; break;
        case 9: sRetTemplate = "skeleton007"; break;
        case 10: sRetTemplate = "skeleton008"; break;
        case 11: sRetTemplate = "skeleton009"; break;
        case 12: sRetTemplate = "skeleton010"; break;
        case 13: sRetTemplate = "skeleton011"; break;
        case 14: sRetTemplate = "skeleton012"; break;
        case 15: sRetTemplate = "skeleton013"; break;
        case 16: sRetTemplate = "skeleton014"; break;
        case 17: sRetTemplate = "skelwarrioray"; break;
        case 18: sRetTemplate = "skelwarrioray"; break;
        case 19: sRetTemplate = "skelwarrioray"; break;
    }
}

if(sTemplate == "sw_undead")

{
    switch(Random(22))
    {
        case 0: sRetTemplate = "rn_ghast_01"; break;
        case 1: sRetTemplate = "rn_ghoullord"; break;
        case 2: sRetTemplate = "rn_ghoul"; break;
        case 3: sRetTemplate = "rn_wight_01"; break;
        case 4: sRetTemplate = "tide_advent001"; break;
        case 5: sRetTemplate = "tide_advent004"; break;
        case 6: sRetTemplate = "tide_advent001"; break;
        case 7: sRetTemplate = "tide_waterdha002"; break;
        case 8: sRetTemplate = "lp_skeleton_05"; break;
        case 9: sRetTemplate = "skelpriest001"; break;
        case 10: sRetTemplate = "rn_ghast_01"; break;
        case 11: sRetTemplate = "rn_ghast_01"; break;
        case 12: sRetTemplate = "rn_wraith_01"; break;
        case 13: sRetTemplate = "zombwarr018"; break;
        case 14: sRetTemplate = "zombwarr018"; break;
        case 15: sRetTemplate = "rn_wraith_01"; break;
        case 16: sRetTemplate = "rn_wraith_01"; break;
        case 17: sRetTemplate = "rn_ghoul"; break;
        case 18: sRetTemplate = "rn_ghoul"; break;
        case 19: sRetTemplate = "rn_ghoul"; break;
        case 20: sRetTemplate = "fledgelingvampir"; break;
        case 21: sRetTemplate = "rn_ghoul"; break;
    }
}
if(sTemplate == "sw_undead2")

{
    switch(Random(22))
    {
        case 0: sRetTemplate = "ragezombie1"; break;
        case 1: sRetTemplate = "ragezombie1"; break;
        case 2: sRetTemplate = "ragezombie1"; break;
        case 3: sRetTemplate = "ragezombie2"; break;
        case 4: sRetTemplate = "ragezombie2"; break;
        case 5: sRetTemplate = "ragezombie2"; break;
        case 6: sRetTemplate = "rn_mummy_01"; break;
        case 7: sRetTemplate = "shriekspirit"; break;
        case 8: sRetTemplate = "nw_skelmage"; break;
        case 9: sRetTemplate = "nw_skelpriest"; break;
        case 10: sRetTemplate = "hoodwraith2"; break;
        case 11: sRetTemplate = "hoodwraith2"; break;
        case 12: sRetTemplate = "nw_zombtyrant"; break;
        case 13: sRetTemplate = "nw_zombwarr01"; break;
        case 14: sRetTemplate = "nw_zombwarr02"; break;
        case 15: sRetTemplate = "nw_spectre"; break;
        case 16: sRetTemplate = "nw_wraith"; break;
        case 17: sRetTemplate = "ghast001"; break;
        case 18: sRetTemplate = "ghast001"; break;
        case 19: sRetTemplate = "shriekspirit"; break;
        case 20: sRetTemplate = "ragezombie1"; break;
        case 21: sRetTemplate = "ragezombie1"; break;
    }
}
if(sTemplate == "sw_skel2")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "shriekspirit"; break;
        case 1: sRetTemplate = "skelwarrioray2"; break;
        case 2: sRetTemplate = "skelwarrioray2"; break;
        case 3: sRetTemplate = "skelwarrioray2"; break;
        case 4: sRetTemplate = "skelwiz2"; break;
        case 5: sRetTemplate = "skelwiz2"; break;
        case 6: sRetTemplate = "skelpriest2"; break;
        case 7: sRetTemplate = "shriekspirit"; break;

    }
}

if(sTemplate == "sw_shadow")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "ay_shadow01"; break;
        case 1: sRetTemplate = "ay_shadow01"; break;
        case 2: sRetTemplate = "ay_shadow01"; break;
        case 3: sRetTemplate = "ay_shadow01"; break;
        case 4: sRetTemplate = "ay_shadow01"; break;
        case 5: sRetTemplate = "ay_shadow01"; break;
        case 6: sRetTemplate = "ay_shadow01"; break;
        case 7: sRetTemplate = "ay_shadow02"; break;

    }
}

if(sTemplate == "sw_hauntedinn")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "ay_shadow01"; break;
        case 1: sRetTemplate = "ay_shadow01"; break;
        case 2: sRetTemplate = "ay_shadow01"; break;
        case 3: sRetTemplate = "cityguardghost1"; break;
        case 4: sRetTemplate = "cityguardghost1"; break;
        case 5: sRetTemplate = "cityguardghost1"; break;
        case 6: sRetTemplate = "cityguardghost2"; break;
        case 7: sRetTemplate = "ay_shadow02"; break;

    }
}


if(sTemplate == "sw_seawraith")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "seawraith"; break;
        case 1: sRetTemplate = "seawraith"; break;
        case 2: sRetTemplate = "seawraith"; break;
        case 3: sRetTemplate = "seawraith"; break;
        case 4: sRetTemplate = "seawraith3"; break;
        case 5: sRetTemplate = "seawraith3"; break;
        case 6: sRetTemplate = "seawraith2"; break;
        case 7: sRetTemplate = "seawraith2"; break;

    }
}

if(sTemplate == "umberlee_patrol")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "makoshark"; break;
        case 1: sRetTemplate = "makoshark"; break;
        case 2: sRetTemplate = "makoshark"; break;
        case 3: sRetTemplate = "makoshark"; break;
        case 4: sRetTemplate = "hammerheadshark"; break;
        case 5: sRetTemplate = "hammerheadshark"; break;
        case 6: sRetTemplate = "hammerheadshark"; break;
        case 7: sRetTemplate = "greatwhiteshark"; break;

    }
}


if(sTemplate == "umberlee_were")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "werecrab"; break;
        case 1: sRetTemplate = "werecrab"; break;
        case 2: sRetTemplate = "werecrab"; break;
        case 3: sRetTemplate = "werecrab"; break;
        case 4: sRetTemplate = "werecrab"; break;
        case 5: sRetTemplate = "werecrab"; break;
        case 6: sRetTemplate = "werepenguin"; break;
        case 7: sRetTemplate = "werepenguin"; break;

    }
}










if (sTemplate == "vampire_lair")  //spawn of vampires
    {
        switch( Random(9))
        {
                    case 0: sRetTemplate = "mg_vampwarrior"; break;
                    case 1: sRetTemplate = "mg_vamprogue"; break;
                    case 2: sRetTemplate = "mg_vampmage"; break;
                    case 3: sRetTemplate = "mg_vampcleric"; break;
                    case 4: sRetTemplate = "mg_vampireboy"; break;
                    case 5: sRetTemplate = "mg_vampiregirl"; break;
                    case 6: sRetTemplate = "mg_vampbard"; break;
                    case 7: sRetTemplate = "mg_vampdruid"; break;
                    case 8: sRetTemplate = "mg_vampmonk"; break;
        }
    }

if (sTemplate == "vampire_wander")  //spawn of vampires
    {
        switch( Random(20))
        {
                    case 0: sRetTemplate = "mg_vampwarrior"; break;
                    case 1: sRetTemplate = "mg_vamprogue"; break;
                    case 2: sRetTemplate = "mg_vampmage"; break;
                    case 3: sRetTemplate = "mg_vampcleric"; break;
                    case 4: sRetTemplate = "mg_vamprogue"; break;
                    case 5: sRetTemplate = "mg_vamprogue"; break;
                    case 6: sRetTemplate = "mg_vampbard"; break;
                    case 7: sRetTemplate = "mg_vampdruid"; break;
                    case 8: sRetTemplate = "mg_vampmonk"; break;
                    case 9: sRetTemplate = "mg_swarmbat"; break;
                    case 10: sRetTemplate = "mg_swarmbat"; break;
                    case 11: sRetTemplate = "mg_swarmbat"; break;
                    case 12: sRetTemplate = "mg_swarmbat"; break;
                    case 13: sRetTemplate = "mg_swarmbat"; break;
                    case 14: sRetTemplate = "mg_swarmbat"; break;
                    case 15: sRetTemplate = "mg_swarmbat"; break;
                    case 16: sRetTemplate = "mg_swarmbat"; break;
                    case 17: sRetTemplate = "mg_swarmbat"; break;
                    case 18: sRetTemplate = "mg_swarmbat"; break;
                    case 19: sRetTemplate = "mg_swarmbat"; break;
        }
    }

if(sTemplate == "sw_frostfungus")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "rn_violetfungus"; break;
        case 1: sRetTemplate = "rn_violetfungus"; break;
        case 2: sRetTemplate = "rn_violetfungus"; break;
        case 3: sRetTemplate = "rn_violetfungus"; break;
        case 4: sRetTemplate = "rn_violetfungus"; break;
        case 5: sRetTemplate = "frostfungusspore"; break;
        case 6: sRetTemplate = "frostfungusspore"; break;
        case 7: sRetTemplate = "frostfungusspore"; break;

    }
}

if(sTemplate == "sw_constructs")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "ay_clkhornet"; break;
        case 1: sRetTemplate = "ay_clkhornet"; break;
        case 2: sRetTemplate = "ay_clkhornet"; break;
        case 3: sRetTemplate = "ay_clkhornet"; break;
        case 4: sRetTemplate = "steamspiderco001"; break;
        case 5: sRetTemplate = "steamspiderco001"; break;
        case 6: sRetTemplate = "steamspiderco001"; break;
        case 7: sRetTemplate = "ay_clkbehemoth"; break;

    }
}

if(sTemplate == "sw_frostmonster")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "ay_yeti"; break;
        case 1: sRetTemplate = "ay_yeti"; break;
        case 2: sRetTemplate = "ay_frozenwat"; break;
        case 3: sRetTemplate = "ay_frozenwat"; break;
        case 4: sRetTemplate = "ay_frozenwat"; break;
        case 5: sRetTemplate = "ay_frozenwat"; break;
        case 6: sRetTemplate = "ay_frozenwat"; break;
        case 7: sRetTemplate = "ay_frozenwat"; break;

    }
}

if(sTemplate == "sw_aurilites")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "aurilranger1"; break;
        case 1: sRetTemplate = "aurilranger1"; break;
        case 2: sRetTemplate = "aurilranger2"; break;
        case 3: sRetTemplate = "aurilranger2"; break;
        case 4: sRetTemplate = "aurilfighter1"; break;
        case 5: sRetTemplate = "aurilfighter1"; break;
        case 6: sRetTemplate = "aurilfighter1"; break;
        case 7: sRetTemplate = "aurilwizard1"; break;

    }
}



if(sTemplate == "sw_frostmonsterhard")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "ay_icedemon"; break;
        case 1: sRetTemplate = "ay_frozenwat"; break;
        case 2: sRetTemplate = "ay_yeti"; break;
        case 3: sRetTemplate = "ay_yeti"; break;
        case 4: sRetTemplate = "ay_yeti"; break;
        case 5: sRetTemplate = "ay_frozenwat001"; break;
        case 6: sRetTemplate = "ay_frozenwat001"; break;
        case 7: sRetTemplate = "ay_frozenwat001"; break;

    }
}





if(sTemplate == "sw_lightningbugs_sm")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "lightningbugsm"; break;
        case 1: sRetTemplate = "lightningbugsm"; break;
        case 2: sRetTemplate = "lightningbugsm"; break;
        case 3: sRetTemplate = "lightningbugsm"; break;
        case 4: sRetTemplate = "lightningbugsm"; break;
        case 5: sRetTemplate = "lightningbugwa"; break;
        case 6: sRetTemplate = "lightningbugwa"; break;
        case 7: sRetTemplate = "lightningbugwa"; break;

    }
}

if(sTemplate == "sw_airelem_sm")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "airelementalsm"; break;
        case 1: sRetTemplate = "airelementalsm"; break;
        case 2: sRetTemplate = "airelementalsm"; break;
        case 3: sRetTemplate = "lightningbuglg"; break;
        case 4: sRetTemplate = "lightningbuglg"; break;
        case 5: sRetTemplate = "lightningbuglg"; break;
        case 6: sRetTemplate = "airelementalsm"; break;
        case 7: sRetTemplate = "airelementalsm"; break;

    }
}

if(sTemplate == "sw_airelem_lg")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "airelementalsm"; break;
        case 1: sRetTemplate = "airelementalsm"; break;
        case 2: sRetTemplate = "airelementalsm"; break;
        case 3: sRetTemplate = "airelementals001"; break;
        case 4: sRetTemplate = "airelementals001"; break;
        case 5: sRetTemplate = "airelementals001"; break;
        case 6: sRetTemplate = "airelementalsm"; break;
        case 7: sRetTemplate = "airelementalsm"; break;

    }
}






if(sTemplate == "sw_herbivores")

{
    switch(Random(33))
    {
        case 0: sRetTemplate = "deer002"; break;
        case 1: sRetTemplate = "deer002"; break;
        case 2: sRetTemplate = "deer002"; break;
        case 3: sRetTemplate = "deer002"; break;
        case 4: sRetTemplate = "deer003"; break;
        case 5: sRetTemplate = "deer003"; break;
        case 6: sRetTemplate = "deer004"; break;
        case 7: sRetTemplate = "rabbit001"; break;
        case 8: sRetTemplate = "rabbit001"; break;
        case 9: sRetTemplate = "rabbit001"; break;
        case 10: sRetTemplate = "rabbit001"; break;
        case 11: sRetTemplate = "rabbit001"; break;
        case 12: sRetTemplate = "rabbit001"; break;
        case 13: sRetTemplate = "rabbit001"; break;
        case 14: sRetTemplate = "rabbit001"; break;
        case 15: sRetTemplate = "rabbit001"; break;
        case 16: sRetTemplate = "rabbit001"; break;
        case 17: sRetTemplate = "rabbit001"; break;
        case 18: sRetTemplate = "raccoon01"; break;
        case 19: sRetTemplate = "skunk001"; break;
        case 20: sRetTemplate = "skunk001"; break;
        case 21: sRetTemplate = "rabbit001"; break;
        case 22: sRetTemplate = "rabbit001"; break;
        case 23: sRetTemplate = "rabbit001"; break;
        case 24: sRetTemplate = "rabbit001"; break;
        case 25: sRetTemplate = "rabbit001"; break;
        case 26: sRetTemplate = "rabbit001"; break;
        case 27: sRetTemplate = "ay_eagle"; break;
        case 28: sRetTemplate = "beargrizzly"; break;
        case 29: sRetTemplate = "bearblck001"; break;
        case 30: sRetTemplate = "bearblck001"; break;
        case 31: sRetTemplate = "raccoon01"; break;
        case 32: sRetTemplate = "skunk001"; break;


    }
}

if(sTemplate == "sw_kryptanimals")

{
    switch(Random(50))
    {
        case 0: sRetTemplate = "deer002"; break;
        case 1: sRetTemplate = "deer002"; break;
        case 2: sRetTemplate = "deer002"; break;
        case 3: sRetTemplate = "deer002"; break;
        case 4: sRetTemplate = "deer003"; break;
        case 5: sRetTemplate = "deer003"; break;
        case 6: sRetTemplate = "deer004"; break;
        case 7: sRetTemplate = "rabbit001"; break;
        case 8: sRetTemplate = "rabbit001"; break;
        case 9: sRetTemplate = "rabbit001"; break;
        case 10: sRetTemplate = "rabbit001"; break;
        case 11: sRetTemplate = "rabbit001"; break;
        case 12: sRetTemplate = "rabbit001"; break;
        case 13: sRetTemplate = "rabbit001"; break;
        case 14: sRetTemplate = "rabbit001"; break;
        case 15: sRetTemplate = "rabbit001"; break;
        case 16: sRetTemplate = "rabbit001"; break;
        case 17: sRetTemplate = "rabbit001"; break;
        case 18: sRetTemplate = "raccoon01"; break;
        case 19: sRetTemplate = "skunk001"; break;
        case 20: sRetTemplate = "skunk001"; break;
        case 21: sRetTemplate = "rabbit001"; break;
        case 22: sRetTemplate = "rabbit001"; break;
        case 23: sRetTemplate = "rabbit001"; break;
        case 24: sRetTemplate = "rabbit001"; break;
        case 25: sRetTemplate = "rabbit001"; break;
        case 26: sRetTemplate = "rabbit001"; break;
        case 27: sRetTemplate = "ay_eagle"; break;
        case 28: sRetTemplate = "beargrizzly"; break;
        case 29: sRetTemplate = "bearblck001"; break;
        case 30: sRetTemplate = "beardire001"; break;
        case 31: sRetTemplate = "beardire001"; break;
        case 32: sRetTemplate = "boar"; break;
        case 33: sRetTemplate = "boar"; break;
        case 34: sRetTemplate = "boar"; break;
        case 35: sRetTemplate = "badger001"; break;
        case 36: sRetTemplate = "badger001"; break;
        case 37: sRetTemplate = "badger001"; break;
        case 38: sRetTemplate = "direbadger"; break;
        case 39: sRetTemplate = "direbadger"; break;
        case 40: sRetTemplate = "direboar"; break;
        case 41: sRetTemplate = "direboar"; break;
        case 42: sRetTemplate = "beardire001"; break;
        case 43: sRetTemplate = "ay_eagle"; break;
        case 44: sRetTemplate = "beargrizzly"; break;
        case 45: sRetTemplate = "beardire001"; break;
        case 46: sRetTemplate = "direbadger"; break;
        case 47: sRetTemplate = "badger001"; break;
        case 48: sRetTemplate = "boar"; break;
        case 49: sRetTemplate = "unicorn"; break;

    }
}


if(sTemplate == "sw_carnivores")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "ac_wolf005"; break;
        case 1: sRetTemplate = "ac_wolf005"; break;
        case 2: sRetTemplate = "ac_wolf005"; break;
        case 3: sRetTemplate = "ac_wolf005"; break;
        case 4: sRetTemplate = "ac_wolf005"; break;
        case 5: sRetTemplate = "ac_wolf005"; break;
        case 6: sRetTemplate = "rn_worg_01"; break;
        case 7: sRetTemplate = "rn_worg_01"; break;
        case 8: sRetTemplate = "rn_worg_01"; break;
        case 9: sRetTemplate = "rn_wolf_03"; break;


    }
}


if(sTemplate == "sw_malar")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "wererat002"; break;
        case 1: sRetTemplate = "wererat002"; break;
        case 2: sRetTemplate = "wererat002"; break;
        case 3: sRetTemplate = "banditwerewolf"; break;
        case 4: sRetTemplate = "banditwerewolf"; break;
        case 5: sRetTemplate = "banditwerewolf"; break;
        case 6: sRetTemplate = "werecat004"; break;
        case 7: sRetTemplate = "werecat004"; break;
        case 8: sRetTemplate = "wereboar"; break;
        case 9: sRetTemplate = "wereboar"; break;


    }
}
if(sTemplate == "sw_elves")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "ww_elfranger020"; break;
        case 1: sRetTemplate = "ww_elfranger020"; break;
        case 2: sRetTemplate = "ww_elfranger1"; break;
        case 3: sRetTemplate = "ww_elfranger1"; break;
        case 4: sRetTemplate = "ww_elffighter1"; break;
        case 5: sRetTemplate = "ww_elffighter1"; break;
        case 6: sRetTemplate = "ww_elfranger020"; break;
        case 7: sRetTemplate = "ww_elfranger1"; break;
        case 8: sRetTemplate = "ww_elfranger020"; break;
        case 9: sRetTemplate = "ww_elfmage1"; break;


    }
}





if(sTemplate == "sw_forest_low")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "owlbear2"; break;
        case 1: sRetTemplate = "owlbear2"; break;
        case 2: sRetTemplate = "owlbear2"; break;
        case 3: sRetTemplate = "owlbear2"; break;
        case 4: sRetTemplate = "owlbear2"; break;
        case 5: sRetTemplate = "banditnormal"; break;
        case 6: sRetTemplate = "banditnormal"; break;
        case 7: sRetTemplate = "trollhunter"; break;
        case 8: sRetTemplate = "wyvern001"; break;
        case 9: sRetTemplate = "wyvern001"; break;
    }
}

if(sTemplate == "sw_forest_hi")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "grayrender001"; break;
        case 1: sRetTemplate = "wereboar"; break;
        case 2: sRetTemplate = "banditwerewolf"; break;
        case 3: sRetTemplate = "owlbear2"; break;
        case 4: sRetTemplate = "owlbear2"; break;
        case 5: sRetTemplate = "banditnormal"; break;
        case 6: sRetTemplate = "banditnormal"; break;
        case 7: sRetTemplate = "trollhunter"; break;
        case 8: sRetTemplate = "wyvern001"; break;
        case 9: sRetTemplate = "wyvern001"; break;
    }
}

if(sTemplate == "sw_kryptforest")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "grayrender001"; break;
        case 1: sRetTemplate = "manticore01"; break;
        case 2: sRetTemplate = "manticore01"; break;
        case 3: sRetTemplate = "bulette"; break;
        case 4: sRetTemplate = "leucrotta"; break;
        case 5: sRetTemplate = "trollhunter"; break;
        case 6: sRetTemplate = "trollhunter"; break;
        case 7: sRetTemplate = "wyvern001"; break;
        case 8: sRetTemplate = "wyvern001"; break;
        case 9: sRetTemplate = "wyvern001"; break;
    }
}

if(sTemplate == "sw_manticore")
{
     sRetTemplate = "manticore01";
}

if(sTemplate == "sw_wyvern")
{
     sRetTemplate = "wyvern001";
}

if(sTemplate == "sw_leucrotta")
{
     sRetTemplate = "leucrotta";
}

if(sTemplate == "sw_bulette")
{
     sRetTemplate = "bulette";
}


if(sTemplate == "ww_spider")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "rn_spider_03"; break;
        case 1: sRetTemplate = "rn_spider_03"; break;
        case 2: sRetTemplate = "rn_spider_03"; break;
        case 3: sRetTemplate = "rn_spider_04"; break;
        case 4: sRetTemplate = "rn_spider_04"; break;
        case 5: sRetTemplate = "spidphase002"; break;
        case 6: sRetTemplate = "spidphase002"; break;
        case 7: sRetTemplate = "spidphase002"; break;
        case 8: sRetTemplate = "rn_ettercap_01"; break;
        case 9: sRetTemplate = "rn_ettercap_01"; break;
    }
}

if(sTemplate == "ww_stinkbeetle")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "stinkbeetlesm"; break;
        case 1: sRetTemplate = "stinkbeetlesm"; break;
        case 2: sRetTemplate = "stinkbeetlesm"; break;
        case 3: sRetTemplate = "stinkbeetlesm"; break;
        case 4: sRetTemplate = "stinkbeetlesm"; break;
        case 5: sRetTemplate = "stinkbeetlesm"; break;
        case 6: sRetTemplate = "stinkbeetlesm"; break;
        case 7: sRetTemplate = "stinkbeetle"; break;
        case 8: sRetTemplate = "stinkbeetle"; break;
        case 9: sRetTemplate = "stinkbeetle"; break;
    }
}

if(sTemplate == "ww_stinkbeetle")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "stinkbeetlesm"; break;
        case 1: sRetTemplate = "stinkbeetlesm"; break;
        case 2: sRetTemplate = "stinkbeetlesm"; break;
        case 3: sRetTemplate = "stinkbeetlesm"; break;
        case 4: sRetTemplate = "stinkbeetlesm"; break;
        case 5: sRetTemplate = "stinkbeetlesm"; break;
        case 6: sRetTemplate = "stinkbeetlesm"; break;
        case 7: sRetTemplate = "stinkbeetle"; break;
        case 8: sRetTemplate = "stinkbeetle"; break;
        case 9: sRetTemplate = "stinkbeetle"; break;
    }
}

if(sTemplate == "ww_hobgoblin")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "zhobgoblin1"; break;
        case 1: sRetTemplate = "zhobgoblin1"; break;
        case 2: sRetTemplate = "zhobgoblin1a"; break;
        case 3: sRetTemplate = "zhobgoblin2a"; break;
        case 4: sRetTemplate = "zhobgoblin2"; break;
        case 5: sRetTemplate = "zhobgoblin2"; break;
        case 6: sRetTemplate = "rn_worg_01"; break;
        case 7: sRetTemplate = "zhobgoblin3"; break;
        case 8: sRetTemplate = "zhobgoblin3"; break;
        case 9: sRetTemplate = "zhobgoblin4"; break;
    }
}

if(sTemplate == "ww_hobgoblin_hi")
{
    switch(Random(11))
    {
        case 0: sRetTemplate = "zhobgoblin1"; break;
        case 1: sRetTemplate = "zhobgoblin7"; break;
        case 2: sRetTemplate = "zhobgoblin1a"; break;
        case 3: sRetTemplate = "zhobgoblin2a"; break;
        case 4: sRetTemplate = "zhobgoblin7"; break;
        case 5: sRetTemplate = "zhobgoblin2"; break;
        case 6: sRetTemplate = "zhobgoblin9"; break;
        case 7: sRetTemplate = "zhobgoblin3"; break;
        case 8: sRetTemplate = "zhobgoblin8"; break;
        case 9: sRetTemplate = "zhobgoblin4"; break;
        case 10: sRetTemplate = "zhobgoblin9"; break;
    }
}

if(sTemplate == "ww_drow")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "droelimalwar"; break;
        case 1: sRetTemplate = "droelimalwar"; break;
        case 2: sRetTemplate = "droelifemwar"; break;
        case 3: sRetTemplate = "droelifemwar"; break;
        case 4: sRetTemplate = "drowelitescout"; break;
        case 5: sRetTemplate = "drowelitescout"; break;
        case 6: sRetTemplate = "droelifemwar"; break;
        case 7: sRetTemplate = "drowwizard"; break;
        case 8: sRetTemplate = "drowwizard"; break;
        case 9: sRetTemplate = "drowpriestess"; break;
    }
}





if(sTemplate == "sw_plants")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "ay_tyrantfogzom"; break;
        case 1: sRetTemplate = "ay_tyrantfogzom"; break;
        case 2: sRetTemplate = "mg_deathshriek"; break;
        case 3: sRetTemplate = "mg_undeadshamble"; break;
        case 4: sRetTemplate = "mg_undeadshamble"; break;
        case 5: sRetTemplate = "mg_deathshriek"; break;
        case 6: sRetTemplate = "mg_necrovine"; break;
        case 7: sRetTemplate = "frostfungusspore"; break;

    }
}

if(sTemplate == "sw_plants2")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "mg_deathshriek"; break;
        case 1: sRetTemplate = "ay_tyrantfogzom"; break;
        case 2: sRetTemplate = "mg_huecuvamonk"; break;
        case 3: sRetTemplate = "mg_huecuvamonk"; break;
        case 4: sRetTemplate = "mg_undeadshamble"; break;
        case 5: sRetTemplate = "mg_undeadmusk"; break;
        case 6: sRetTemplate = "mg_undeadmusk"; break;
        case 7: sRetTemplate = "mg_huecuvamonk"; break;

    }
}

if(sTemplate == "sw_undead_high")

{
    switch(Random(14))
    {
        case 0: sRetTemplate = "mumfight001"; break;
        case 1: sRetTemplate = "mg_bleakborn"; break;
        case 2: sRetTemplate = "mg_vampcleric"; break;
        case 3: sRetTemplate = "mg_vamprogue"; break;
        case 4: sRetTemplate = "mg_vampwarrior"; break;
        case 5: sRetTemplate = "vampire001"; break;
        case 6: sRetTemplate = "mg_vampmage"; break;
        case 7: sRetTemplate = "skelpriest2"; break;
        case 8: sRetTemplate = "mg_huecuvamonk2"; break;
        case 9: sRetTemplate = "bodak001"; break;
        case 10: sRetTemplate = "mg_huecuvamonk2"; break;
        case 11: sRetTemplate = "mg_huecuvamonk2"; break;
        case 12: sRetTemplate = "mg_huecuvamonk2"; break;
        case 13: sRetTemplate = "skelwiz2"; break;
    }
}

if(sTemplate == "sw_undead_impos")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "nw_mummyboss"; break;
        case 1: sRetTemplate = "nw_doomkghtboss"; break;
        case 2: sRetTemplate = "nw_mohrg"; break;
        case 3: sRetTemplate = "nw_skeldevour"; break;
        case 4: sRetTemplate = "nw_vampire003"; break;
        case 5: sRetTemplate = "nw_vampire004"; break;
        case 6: sRetTemplate = "nw_vampire002"; break;
        case 7: sRetTemplate = "nw_vampire001"; break;
    }
}
if(sTemplate == "sw_trolls")

{
    switch(Random(8))
    {
        case 0: sRetTemplate = "sewertroll"; break;
        case 1: sRetTemplate = "sewertroll"; break;
        case 2: sRetTemplate = "sewertroll"; break;
        case 3: sRetTemplate = "sewertroll"; break;
        case 4: sRetTemplate = "sewertroll"; break;
        case 5: sRetTemplate = "sewertroll"; break;
        case 6: sRetTemplate = "sewertrollsor"; break;
        case 7: sRetTemplate = "sewertrollsor"; break;
    }
}

if(sTemplate == "bather")
{
    switch( Random(66))
    {
        case 0: sRetTemplate = "tavern014"; break;
        case 1: sRetTemplate = "tavern020"; break;
        case 2: sRetTemplate = "tavern021"; break;
        case 3: sRetTemplate = "tavern022"; break;
        case 4: sRetTemplate = "tavern023"; break;
        case 5: sRetTemplate = "tavern024"; break;
        case 6: sRetTemplate = "tavern025"; break;
        case 7: sRetTemplate = "tavern026"; break;
        case 8: sRetTemplate = "tavern027"; break;
        case 9: sRetTemplate = "tavern028"; break;
        case 10: sRetTemplate = "tavern029"; break;
        case 11: sRetTemplate = "tavern030"; break;
        case 12: sRetTemplate = "tavern031"; break;
        case 13: sRetTemplate = "tavern032"; break;
        case 14: sRetTemplate = "tavern036"; break;
        case 15: sRetTemplate = "tavern023"; break;
        case 16: sRetTemplate = "tavern024"; break;
        case 17: sRetTemplate = "tavern025"; break;
        case 18: sRetTemplate = "tavern028"; break;
        case 19: sRetTemplate = "tavern023"; break;
        case 20: sRetTemplate = "tavern024"; break;
        case 21: sRetTemplate = "tavern025"; break;
        case 22: sRetTemplate = "tavern028"; break;
        case 23: sRetTemplate = "tavern014"; break;
        case 24: sRetTemplate = "tavern020"; break;
        case 25: sRetTemplate = "tavern021"; break;
        case 26: sRetTemplate = "tavern022"; break;
        case 27: sRetTemplate = "tavern026"; break;
        case 28: sRetTemplate = "tavern027"; break;
        case 29: sRetTemplate = "tavern030"; break;
        case 30: sRetTemplate = "tavern031"; break;
        case 31: sRetTemplate = "tavern026"; break;
        case 32: sRetTemplate = "tavern027"; break;
        case 33: sRetTemplate = "tavern030"; break;
        case 34: sRetTemplate = "tavern031"; break;
        case 35: sRetTemplate = "tavern026"; break;
        case 36: sRetTemplate = "tavern027"; break;
        case 37: sRetTemplate = "tavern030"; break;
        case 38: sRetTemplate = "tavern031"; break;
        case 39: sRetTemplate = "tavern026"; break;
        case 40: sRetTemplate = "tavern027"; break;
        case 41: sRetTemplate = "tavern030"; break;
        case 42: sRetTemplate = "tavern031"; break;
        case 43: sRetTemplate = "tavern026"; break;
        case 44: sRetTemplate = "tavern027"; break;
        case 45: sRetTemplate = "tavern030"; break;
        case 46: sRetTemplate = "tavern031"; break;
        case 47: sRetTemplate = "tavern026"; break;
        case 48: sRetTemplate = "tavern027"; break;
        case 49: sRetTemplate = "tavern030"; break;
        case 50: sRetTemplate = "tavern031"; break;
        case 51: sRetTemplate = "tavern026"; break;
        case 52: sRetTemplate = "tavern027"; break;
        case 53: sRetTemplate = "tavern030"; break;
        case 54: sRetTemplate = "tavern031"; break;
        case 55: sRetTemplate = "tavern033"; break;
        case 56: sRetTemplate = "tavern035"; break;
        case 57: sRetTemplate = "tavern033"; break;
        case 58: sRetTemplate = "tavern035"; break;
        case 59: sRetTemplate = "tavern033"; break;
        case 60: sRetTemplate = "tavern035"; break;
        case 61: sRetTemplate = "tavern034"; break;
        case 62: sRetTemplate = "tavern032"; break;
        case 63: sRetTemplate = "tavern034"; break;
        case 64: sRetTemplate = "tavern026"; break;
        case 65: sRetTemplate = "tavern031"; break;
    }
}


if (sTemplate == "taverner")
    {
        switch( Random( 66 ))
                {
                    case 0: sRetTemplate = "tavern001"; break;
                    case 1: sRetTemplate = "tavern002"; break;
                    case 2: sRetTemplate = "tavern003"; break;
                    case 3: sRetTemplate = "tavern004"; break;
                    case 4: sRetTemplate = "tavern005"; break;
                    case 5: sRetTemplate = "tavern006"; break;
                    case 6: sRetTemplate = "tavern007"; break;
                    case 7: sRetTemplate = "tavern008"; break;
                    case 8: sRetTemplate = "tavern009"; break;
                    case 9: sRetTemplate = "tavern010"; break;
                    case 10: sRetTemplate = "tavern011"; break;
                    case 11: sRetTemplate = "tavern012"; break;
                    case 12: sRetTemplate = "tavern013"; break;
                    case 13: sRetTemplate = "tavern015"; break;
                    case 14: sRetTemplate = "tavern016"; break;
                    case 15: sRetTemplate = "tavern017"; break;
                    case 16: sRetTemplate = "tavern018"; break;
                    case 17: sRetTemplate = "tavern019"; break;
                    case 18: sRetTemplate = "tavern008"; break;
                    case 19: sRetTemplate = "tavern010"; break;
                    case 20: sRetTemplate = "tavern011"; break;
                    case 21: sRetTemplate = "tavern012"; break;
                    case 22: sRetTemplate = "tavern008"; break;
                    case 23: sRetTemplate = "tavern010"; break;
                    case 24: sRetTemplate = "tavern011"; break;
                    case 25: sRetTemplate = "tavern012"; break;
                    case 26: sRetTemplate = "tavern008"; break;
                    case 27: sRetTemplate = "tavern010"; break;
                    case 28: sRetTemplate = "tavern011"; break;
                    case 29: sRetTemplate = "tavern012"; break;
                    case 30: sRetTemplate = "tavern008"; break;
                    case 31: sRetTemplate = "tavern010"; break;
                    case 32: sRetTemplate = "tavern011"; break;
                    case 33: sRetTemplate = "tavern012"; break;
                    case 34: sRetTemplate = "tavern008"; break;
                    case 35: sRetTemplate = "tavern010"; break;
                    case 36: sRetTemplate = "tavern011"; break;
                    case 37: sRetTemplate = "tavern012"; break;
                    case 38: sRetTemplate = "tavern001"; break;
                    case 39: sRetTemplate = "tavern002"; break;
                    case 40: sRetTemplate = "tavern003"; break;
                    case 41: sRetTemplate = "tavern004"; break;
                    case 42: sRetTemplate = "tavern005"; break;
                    case 43: sRetTemplate = "tavern006"; break;
                    case 44: sRetTemplate = "tavern007"; break;
                    case 45: sRetTemplate = "tavern009"; break;
                    case 46: sRetTemplate = "tavern005"; break;
                    case 47: sRetTemplate = "tavern006"; break;
                    case 48: sRetTemplate = "tavern007"; break;
                    case 49: sRetTemplate = "tavern009"; break;
                    case 50: sRetTemplate = "tavern015"; break;
                    case 51: sRetTemplate = "tavern016"; break;
                    case 52: sRetTemplate = "tavern018"; break;
                    case 53: sRetTemplate = "tavern019"; break;
                    case 54: sRetTemplate = "tavern018"; break;
                    case 55: sRetTemplate = "tavern019"; break;
                    case 56: sRetTemplate = "tavern018"; break;
                    case 57: sRetTemplate = "tavern019"; break;
                    case 58: sRetTemplate = "tavern008"; break;
                    case 59: sRetTemplate = "tavern010"; break;
                    case 60: sRetTemplate = "tavern011"; break;
                    case 61: sRetTemplate = "tavern012"; break;
                    case 62: sRetTemplate = "tavern008"; break;
                    case 63: sRetTemplate = "tavern010"; break;
                    case 64: sRetTemplate = "tavern011"; break;
                    case 65: sRetTemplate = "tavern012"; break;
                }
     }


if (sTemplate == "comsingle")
    {
        switch( Random( 28 ))
                {
                    case 0: sRetTemplate = "femaledwarvencit"; break;
                    case 1: sRetTemplate = "femaleelvencitiz"; break;
                    case 2: sRetTemplate = "femalegnomishcit"; break;
                    case 3: sRetTemplate = "femalehalfelvenc"; break;
                    case 4: sRetTemplate = "femalehalflingci"; break;
                    case 5: sRetTemplate = "femalehalforccit"; break;
                    case 6: sRetTemplate = "femalehumancitiz"; break;
                    case 7: sRetTemplate = "maledwarvencitiz"; break;
                    case 8: sRetTemplate = "maleelvencitizen"; break;
                    case 9: sRetTemplate = "malegnomishcitiz"; break;
                    case 10: sRetTemplate = "malehalfelvencit"; break;
                    case 11: sRetTemplate = "malehalflingciti"; break;
                    case 12: sRetTemplate = "malehalforccitiz"; break;
                    case 13: sRetTemplate = "malehumancitizen"; break;
                    case 14: sRetTemplate = "malehumanciti001"; break;
                    case 15: sRetTemplate = "femaledwarven001"; break;
                    case 16: sRetTemplate = "femaleelvenci001"; break;
                    case 17: sRetTemplate = "dog001"; break;
                    case 18: sRetTemplate = "dog001"; break;
                    case 19: sRetTemplate = "femalehalflin002"; break;
                    case 20: sRetTemplate = "dog001"; break;
                    case 21: sRetTemplate = "femalehalforc001"; break;
                    case 22: sRetTemplate = "femalehumanci001"; break;
                    case 23: sRetTemplate = "dog001"; break;
                    case 24: sRetTemplate = "dog001"; break;
                    case 25: sRetTemplate = "dog001"; break;
                    case 26: sRetTemplate = "dog001"; break;
                    case 27: sRetTemplate = "dog001"; break;
                    }
    }
   if (sTemplate == "lp_lesser_skullkid")
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "lp_skullchild_1"; break;
                    case 1: sRetTemplate = "lp_skullchild_1"; break;
                    case 2: sRetTemplate = "lp_skullchild_1"; break;
                    case 3: sRetTemplate = "lp_skullchild_2"; break;
                    case 4: sRetTemplate = "lp_skullchild_2"; break;
                    case 5: sRetTemplate = "lp_skullchild_2"; break;
                    case 6: sRetTemplate = "lp_skullchild_3"; break;
                    case 7: sRetTemplate = "lp_skullchild_4"; break;
                }
    }
if (sTemplate == "lp_greater_skullkid")
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "lp_skullchild_2"; break;
                    case 1: sRetTemplate = "lp_skullchild_4"; break;
                    case 2: sRetTemplate = "lp_skullchild_4"; break;
                    case 3: sRetTemplate = "lp_skullchild_5"; break;
                    case 4: sRetTemplate = "lp_skullchild_5"; break;
                    case 5: sRetTemplate = "lp_skullchild_3"; break;
                    case 6: sRetTemplate = "lp_skullchild_3"; break;
                    case 7: sRetTemplate = "lp_skullchild_6"; break;
                }
    }
    if (sTemplate == "lp_skeleton_easy")
    {
        switch( Random( 8 ))
                {
                    case 0: sRetTemplate = "rn_skeleton_01"; break;
                    case 1: sRetTemplate = "rn_skeleton_01"; break;
                    case 2: sRetTemplate = "rn_skeleton_02"; break;
                    case 3: sRetTemplate = "rn_skeleton_02"; break;
                    case 4: sRetTemplate = "rn_skeleton_03"; break;
                    case 5: sRetTemplate = "rn_skeleton_04"; break;
                    case 6: sRetTemplate = "rn_skeleton_04"; break;
                    case 7: sRetTemplate = "lp_skeleton_05"; break;
                }
    }
     if (sTemplate == "lp_zombie_basic")
    {
        switch( Random( 7 ))
                {
                    case 0: sRetTemplate = "rn_zombie_01"; break;
                    case 1: sRetTemplate = "rn_zombie_01"; break;
                    case 2: sRetTemplate = "rn_zombie_01"; break;
                    case 3: sRetTemplate = "rn_zombie_02"; break;
                    case 4: sRetTemplate = "rn_zombie_02"; break;
                    case 5: sRetTemplate = "rn_zombie_02"; break;
                    case 6: sRetTemplate = "lp_illithidzo_2"; break;
                }
    }
      if (sTemplate == "lp_bonedeliver_easy")
    {
        switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "lp_bonedelver_1"; break;
                    case 1: sRetTemplate = "lp_bonedelver_1"; break;
                    case 2: sRetTemplate = "lp_bonedelver_2"; break;
                    case 3: sRetTemplate = "lp_bonedelver_2"; break;
                }
    }
          if (sTemplate == "lp_bonedeliver_hard")
    {
        switch( Random( 6 ))
                {
                    case 0: sRetTemplate = "lp_bonedelver_3"; break;
                    case 1: sRetTemplate = "lp_bonedelver_3"; break;
                    case 2: sRetTemplate = "lp_bonedelver_4"; break;
                    case 3: sRetTemplate = "lp_bonedelver_4"; break;
                    case 4: sRetTemplate = "lp_bonedelver_1"; break;
                    case 5: sRetTemplate = "lp_bonedelver_2"; break;
                }
    }
        if (sTemplate == "lp_bonebatmix")
    {
        switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "lp_bonebat_1"; break;
                    case 1: sRetTemplate = "lp_bonebat_1"; break;
                    case 2: sRetTemplate = "lp_bonebat_1"; break;
                    case 3: sRetTemplate = "lp_bonebat_2"; break;
                    }
    }
        if (sTemplate == "lp_illthidzombie_lesser") //I know I know couldn't resist:P
    {
        switch( Random( 3 ))
                {
                    case 0: sRetTemplate = "lp_illithidzo_1"; break;
                    case 1: sRetTemplate = "lp_illithidzo_2"; break;
                    case 2: sRetTemplate = "lp_illithidzo_3"; break;
                    }
    }
          if (sTemplate == "lp_littlebig_spidomix")
    {
        switch( Random( 4 ))
                {
                    case 0: sRetTemplate = "lp_tinyspido"; break;
                    case 1: sRetTemplate = "lp_tinyspido"; break;
                    case 2: sRetTemplate = "lp_tinyspido"; break;
                    case 3: sRetTemplate = "lp_spido"; break;
                }
    }

    if (sTemplate == "rug")
    {
        switch( Random( 12 ))
                {
                    case 0: sRetTemplate = "alfa_lokthrowrug1"; break;
                    case 1: sRetTemplate = "alfa_lokthrowrug2"; break;
                    case 2: sRetTemplate = "alfa_lokthrowrug3"; break;
                    case 3: sRetTemplate = "alfa_lokthrowrug4"; break;
                    case 4: sRetTemplate = "alfa_lokthrowrug5"; break;
                    case 5: sRetTemplate = "alfa_lokthrowrug6"; break;
                    case 6: sRetTemplate = "alfa_lokthrowrug7"; break;
                    case 7: sRetTemplate = "alfa_lokthrowrug8"; break;
                    case 8: sRetTemplate = "alfa_lokthrowrug9"; break;
                    case 9: sRetTemplate = "alfa_lokthrowrug10"; break;
                    case 10: sRetTemplate = "alfa_lokthrowrug11"; break;
                    case 11: sRetTemplate = "alfa_lokthrowrug"; break;
                    }
    }

    if (sTemplate == "undead")
    {
        switch( Random( 30 ))
                {
                    case 0: sRetTemplate = "skeleton001"; break;
                    case 1: sRetTemplate = "skelpriest001"; break;
                    case 2: sRetTemplate = "zombie002"; break;
                    case 3: sRetTemplate = "zombie003"; break;
                    case 4: sRetTemplate = "zombwarr017"; break;
                    case 5: sRetTemplate = "ghoul001"; break;
                    case 6: sRetTemplate = "ghast001"; break;
                    case 7: sRetTemplate = "allip001"; break;
                    case 8: sRetTemplate = "shadow001"; break;
                    case 9: sRetTemplate = "mummy001"; break;
                    case 10: sRetTemplate = "skeleton001"; break;
                    case 11: sRetTemplate = "skeleton001"; break;
                    case 12: sRetTemplate = "skeleton001"; break;
                    case 13: sRetTemplate = "skelpriest001"; break;
                    case 14: sRetTemplate = "zombie002"; break;
                    case 15: sRetTemplate = "zombie003"; break;
                    case 16: sRetTemplate = "skeleton001"; break;
                    case 17: sRetTemplate = "skeleton001"; break;
                    case 18: sRetTemplate = "skelpriest001"; break;
                    case 19: sRetTemplate = "zombie002"; break;
                    case 20: sRetTemplate = ""; break;
                    case 21: sRetTemplate = ""; break;
                    case 22: sRetTemplate = ""; break;
                    case 23: sRetTemplate = ""; break;
                    case 24: sRetTemplate = ""; break;
                    case 25: sRetTemplate = ""; break;
                    case 26: sRetTemplate = ""; break;
                    case 27: sRetTemplate = ""; break;
                    case 28: sRetTemplate = ""; break;
                    case 29: sRetTemplate = ""; break;
                    }
    }

if(sTemplate == "sw_gob_low")

{
    switch(Random(6))
    {
        case 0: sRetTemplate = "nw_goblina"; break;
        case 1: sRetTemplate = "nw_goblinb"; break;
        case 2: sRetTemplate = "nw_kobold001"; break;
        case 3: sRetTemplate = "nw_kobold002"; break;
        case 4: sRetTemplate = "nw_orca"; break;
        case 5: sRetTemplate = "nw_orcb"; break;
    }
}

if(sTemplate == "sw_gob_mid")

{
    switch(Random(7))
    {
        case 0: sRetTemplate = "nw_bugbeara"; break;
        case 1: sRetTemplate = "nw_bugbearb"; break;
        case 2: sRetTemplate = "nw_kobold004"; break;
        case 3: sRetTemplate = "nw_kobold006"; break;
        case 4: sRetTemplate = "nw_kobold005"; break;
        case 5: sRetTemplate = "nw_kobold003"; break;
        case 6: sRetTemplate = "nw_gnoll001"; break;
    }
}

if(sTemplate == "sw_gob_hi")

{
    switch(Random(10))
    {
        case 0: sRetTemplate = "nw_bugwiza"; break;
        case 1: sRetTemplate = "nw_bugwizb"; break;
        case 2: sRetTemplate = "nw_gobwiza"; break;
        case 3: sRetTemplate = "nw_gobwizb"; break;
        case 4: sRetTemplate = "nw_gobchiefa"; break;
        case 5: sRetTemplate = "nw_gobchiefb"; break;
        case 6: sRetTemplate = "nw_gnoll002"; break;
        case 7: sRetTemplate = "nw_orcchiefa"; break;
        case 8: sRetTemplate = "nw_orcchiefb"; break;
        case 9: sRetTemplate = "nw_orcwiza"; break;
    }
}

if(sTemplate == "sw_gob_huge")

{
    switch(Random(2))
    {
        case 0: sRetTemplate = "nw_bugchiefa"; break;
        case 1: sRetTemplate = "nw_bugchiefb"; break;
    }
}

if(sTemplate == "sw_giant")

{
    switch(Random(9))
    {
        case 0: sRetTemplate = "nw_ogre01"; break;
        case 1: sRetTemplate = "nw_ogre02"; break;
        case 2: sRetTemplate = "nw_ogrechief01"; break;
        case 3: sRetTemplate = "nw_ogrechief02"; break;
        case 4: sRetTemplate = "nw_ogremage01"; break;
        case 5: sRetTemplate = "nw_ogremage02"; break;
        case 6: sRetTemplate = "nw_troll"; break;
        case 7: sRetTemplate = "nw_trollchief"; break;
        case 8: sRetTemplate = "nw_trollwiz"; break;
    }
}

if(sTemplate == "sw_giant2")

{
    switch(Random(5))
    {
        case 0: sRetTemplate = "nw_ettin"; break;
        case 1: sRetTemplate = "nw_gnthill"; break;
        case 2: sRetTemplate = "nw_gntmount"; break;
        case 3: sRetTemplate = "nw_ogreboss"; break;
        case 4: sRetTemplate = "nw_trollboss"; break;
    }
}

if(sTemplate == "sw_ants")

{
    switch(Random(7))
    {
        case 0: sRetTemplate = "giantantqueen"; break;
        case 1: sRetTemplate = "giantantsoldier"; break;
        case 2: sRetTemplate = "giantantworker"; break;
        case 3: sRetTemplate = "giantantworker"; break;
        case 4: sRetTemplate = "giantantworker"; break;
        case 5: sRetTemplate = "giantantworker"; break;
        case 6: sRetTemplate = "giantantsoldier"; break;
    }
}

if(sTemplate == "sw_animals")
{
    switch(Random(8))
    {
        case 0: sRetTemplate = "nw_wolf"; break;
        case 1: sRetTemplate = "nw_wolf"; break;
        case 2: sRetTemplate = "nw_wolf"; break;
        case 3: sRetTemplate = "nw_wolf"; break;
        case 4: sRetTemplate = "nw_wolf"; break;
        case 5: sRetTemplate = "nw_boar"; break;
        case 6: sRetTemplate = "nw_boar"; break;
        case 7: sRetTemplate = "nw_boar"; break;
    }
}

if(sTemplate == "sw_bandits")
{
    switch(Random(10))
    {
        case 0: sRetTemplate = "bandit010"; break;
        case 1: sRetTemplate = "bandit009"; break;
        case 2: sRetTemplate = "bandit004"; break;
        case 3: sRetTemplate = "bandit003"; break;
        case 4: sRetTemplate = "humanmerc002"; break;
        case 5: sRetTemplate = "nw_elfmerc001"; break;
        case 6: sRetTemplate = "dwarfmerc003"; break;
        case 7: sRetTemplate = "halfmerc005"; break;
        case 8: sRetTemplate = "bandit011"; break;
    }
}

    // cr_militia
    if (sTemplate == "cr_militia")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "cr_militia_m";
            break;
            case 2:
            sRetTemplate = "cr_militia_f";
            break;
        }
    }
    //

    // pg_guard
    if (sTemplate == "pg_guard")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "pg_guard_m";
            break;
            case 2:
            sRetTemplate = "pg_guard_f";
            break;
        }
    }
    //

    // Goblins
    if (sTemplate == "goblins_low")
    {
        if (d2(1) == 1)
        {
            sRetTemplate = "NW_GOBLINA";
        }
        else
        {
            sRetTemplate = "NW_GOBLINB";
        }
    }
    //

    // Goblins and Boss
    if (sTemplate == "gobsnboss")
    {
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Scaled Encounter
    if (sTemplate == "scaledgobs")
    {
        // Initialize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        // Cycle through PCs in Area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
            oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        // Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            // Spawn Something with CR 1
            case 1:
                sRetTemplate = "cr1creature";
            break;
            //

            // Spawn Something with CR 5
            case 5:
                sRetTemplate = "cr5creature";
            break;
            //
        }
    }
    //

    // Pirates and Boss
    if (sTemplate == "pirates")
    {
        // Delay the Spawn for 45 Minutes
        if (GetLocalInt(oSpawn, "DelayEnded") == FALSE)
        {
            if (GetLocalInt(oSpawn, "DelayStarted") == FALSE)
            {
                // Start the Delay
                SetLocalInt(oSpawn, "DelayStarted", TRUE);
                DelayCommand(20.0, SetLocalInt(oSpawn, "DelayEnded", TRUE));
            }
            sRetTemplate = "";
            return sRetTemplate;
        }
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Advanced Scaled Encounter
    if (sTemplate == "advscaled")
    {
        //Initalize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        //Cycle through PCs in area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
        oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        //Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            //Spawn Something with CR 1
            case 1:
                switch (d6())
                {
                    case 1: sRetTemplate = "cr1example1";
                    case 2: sRetTemplate = "cr1example2";
                    case 3: sRetTemplate = "cr1example3";
                    case 4: sRetTemplate = "cr1example4";
                    case 5: sRetTemplate = "cr1example5";
                    case 6: sRetTemplate = "cr1example6";
                }
            break;
        }
    }
    //

    // Encounters
    if (sTemplate == "encounter")
    {
        // Declare Variables
        int nCounter, nCounterMax;
        string sCurrentTemplate;

        // Retreive and Increment Counter
        nCounter = GetLocalInt(oSpawn, "GroupCounter");
        nCounterMax = GetLocalInt(oSpawn, "CounterMax");
        nCounter++;

        // Retreive CurrentTemplate
        sCurrentTemplate = GetLocalString(oSpawn, "CurrentTemplate");

        // Check CounterMax
        if (nCounter > nCounterMax)
        {
            sCurrentTemplate = "";
            nCounter = 1;
        }

        if (sCurrentTemplate != "")
        {
            // Spawn Another CurrentTemplate
            sRetTemplate = sCurrentTemplate;
        }
        else
        {
            // Choose New CurrentTemplate and CounterMax
            switch (Random(2))
            {
                // Spawn 1-4 NW_DOGs
                case 0:
                sRetTemplate = "NW_DOG";
                nCounterMax = Random(4) + 1;
                break;
            }
            // Record New CurrentTemplate and CounterMax
            SetLocalString(oSpawn, "CurrentTemplate", sRetTemplate);
            SetLocalInt(oSpawn, "CounterMax", nCounterMax);
        }

        // Record Counter
        SetLocalInt(oSpawn, "GroupCounter", nCounter);
    }
    //

    //
    if (sTemplate == "kobolds")
    {
        int nKobold = Random(6) + 1;
        sRetTemplate = "NW_KOBOLD00" + IntToString(nKobold);
    }

    if (GetStringLeft(sTemplate, 7) == "scaled_")
    {
      float fEncounterLevel;
      int nScaledInProgress = GetLocalInt(oSpawn, "ScaledInProgress");
      string sGroupType = GetStringRight(sTemplate,
          GetStringLength(sTemplate) - 7);

      // First Time in for this encounter?
      if (! nScaledInProgress)
      {

        // First time in - find the party level
        int nTotalPCs = 0;
        int nTotalPCLevel = 0;

        object oArea = GetArea(OBJECT_SELF);

        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
          if (GetIsPC(oPC) == TRUE)
          {
              nTotalPCs++;
              nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
          }
          oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
          fEncounterLevel = 0.0;
        }
        else
        {
          fEncounterLevel = IntToFloat(nTotalPCLevel) / IntToFloat(nTotalPCs);
        }

        // Save this for subsequent calls
        SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);

        // We're done when the CRs chosen add up to the
        // desired encounter level
        SetLocalInt(oSpawn, "ScaledCallCount", 0);
        SetLocalInt(oSpawn, "ScaledInProgress", TRUE);
      }


      fEncounterLevel = GetLocalFloat(oSpawn, "ScaledEncounterLevel");
      int nScaledCallCount = GetLocalInt(oSpawn, "ScaledCallCount");

      // For simplicity, I'm not supporting creatures with CR < 1.0)
      if (fEncounterLevel < 1.0)
      {
        // We're done... No creatures have CR low enough to add to this encounter
        sRetTemplate = "";
      }

      else
      {
        // randomly choose a CR at or below the remaining (uncovered) encounter
        // level
        int nCR = Random(FloatToInt(fEncounterLevel)) + 1;

        // cap to the largest CR we currently support in GetTemplateByCR
        if (nCR > 3)
        {
          nCR = 3;
        }

        sRetTemplate = GetTemplateByCR(nCR, sGroupType);


        // Convert CR to Encounter Level equivalent so it can be correctly
        // subtracted.  This does the real scaling work
        float fELEquiv = ConvertCRToELEquiv(IntToFloat(nCR), fEncounterLevel);
        float fElRemaining = 1.0 - fELEquiv;

        fEncounterLevel = ConvertELEquivToCR(fElRemaining, fEncounterLevel);
        SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);
      }

      nScaledCallCount++;
      SetLocalInt(oSpawn, "ScaledCallCount", nScaledCallCount);

      nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

      if (nScaledCallCount >= nSpawnNumber)
      {
        // reset...
        SetLocalInt(oSpawn, "ScaledInProgress", FALSE);
      }
    }



    // Goblins and Boss
    if (sTemplate == "gobsnboss")
    {
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Scaled Encounter
    if (sTemplate == "scaledgobs")
    {
        // Initialize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        // Cycle through PCs in Area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
            oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        // Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            // Spawn Something with CR 1
            case 1:
                sRetTemplate = "cr1creature";
            break;
            //

            // Spawn Something with CR 5
            case 5:
                sRetTemplate = "cr5creature";
            break;
            //
        }
    }
    //

    // Pirates and Boss
    if (sTemplate == "pirates")
    {
        // Delay the Spawn for 45 Minutes
        if (GetLocalInt(oSpawn, "DelayEnded") == FALSE)
        {
            if (GetLocalInt(oSpawn, "DelayStarted") == FALSE)
            {
                // Start the Delay
                SetLocalInt(oSpawn, "DelayStarted", TRUE);
                DelayCommand(20.0, SetLocalInt(oSpawn, "DelayEnded", TRUE));
            }
            sRetTemplate = "";
            return sRetTemplate;
        }
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Advanced Scaled Encounter
    if (sTemplate == "advscaled")
    {
        //Initalize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        //Cycle through PCs in area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
        oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        //Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            //Spawn Something with CR 1
            case 1:
                switch (d6())
                {
                    case 1: sRetTemplate = "cr1example1";
                    case 2: sRetTemplate = "cr1example2";
                    case 3: sRetTemplate = "cr1example3";
                    case 4: sRetTemplate = "cr1example4";
                    case 5: sRetTemplate = "cr1example5";
                    case 6: sRetTemplate = "cr1example6";
                }
            break;
        }
    }
    //

    // Encounters
    if (sTemplate == "encounter")
    {
        // Declare Variables
        int nCounter, nCounterMax;
        string sCurrentTemplate;

        // Retreive and Increment Counter
        nCounter = GetLocalInt(oSpawn, "GroupCounter");
        nCounterMax = GetLocalInt(oSpawn, "CounterMax");
        nCounter++;

        // Retreive CurrentTemplate
        sCurrentTemplate = GetLocalString(oSpawn, "CurrentTemplate");

        // Check CounterMax
        if (nCounter > nCounterMax)
        {
            sCurrentTemplate = "";
            nCounter = 1;
        }

        if (sCurrentTemplate != "")
        {
            // Spawn Another CurrentTemplate
            sRetTemplate = sCurrentTemplate;
        }
        else
        {
            // Choose New CurrentTemplate and CounterMax
            switch (Random(2))
            {
                // Spawn 1-4 NW_DOGs
                case 0:
                sRetTemplate = "NW_DOG";
                nCounterMax = Random(4) + 1;
                break;
            }
            // Record New CurrentTemplate and CounterMax
            SetLocalString(oSpawn, "CurrentTemplate", sRetTemplate);
            SetLocalInt(oSpawn, "CounterMax", nCounterMax);
        }

        // Record Counter
        SetLocalInt(oSpawn, "GroupCounter", nCounter);
    }
    //

    //
    if (sTemplate == "kobolds")
    {
        int nKobold = Random(6) + 1;
        sRetTemplate = "NW_KOBOLD00" + IntToString(nKobold);
    }
    //
    //Sily's Groups
    if (sTemplate == "sily_goblin_scout")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "an_goblin";
            break;
            case 2:
            sRetTemplate = "an_goblin2";
            break;
        }
    }


// -------------------------------------------
// Only Make Modifications Between These Lines
//
    return sRetTemplate;
}
