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


         // Sample Complex Replacement
    // Using FT without FT00 will
    // Default to nFlagTableNumber 0
    if (nFlagTableNumber == 0)
    {
        // Old Method of using SpawnTag
        if (sSpawnTag == "myspawns")
        {
            sFlags = "SP_SN02_SA_RW_PC2";
            sTemplate = "NW_DOG";
        }

        if (sSpawnTag == "undead")
        {
            sFlags = "SP_SNO4_PC2";
            sTemplate = "NW_ZOMBIE01";
        }
    }
    //

    // Sample Simple Replacement Flag
    // Completely Replaces Flags
    // On Spawnpoints with FT01
    if (nFlagTableNumber == 1)
    {
        sFlags = "SP_SN04_RW_DOD_PC2";
        sTemplate = "NW_DOG";
    }
    //

    // Sample Template Flags
    // These Flags Get Added
    // To Spawnpoints with FT02
    if (nFlagTableNumber == 2)
    {
        sFlags = "_RW_PC05R";
    }
     if (nFlagTableNumber == 25)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_taverner")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03_SA03_SG_TR30D30_LT504A25B15C5_CD0T3_PC2";
            sTemplate = "taverner";
        }
     }


if (nFlagTableNumber == 26)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_small")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03_SA03_SG_TR30D30_LT505A25B15C5_CD0T3_PC2";
            sTemplate = "small";
        }
     }

if (nFlagTableNumber == 27)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_elves")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03_SA03_SG_TR30D30_LT504A25B15C5_CD0T3_PC02";
            sTemplate = "elves";
        }
     }

      if (nFlagTableNumber == 28)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sewers_2")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN02M01_SA_SG_CD120T3_SD120_RS50_DS2_PC5_RW_RHD50_PC2";


            switch( Random( 8 ))
            {
                case 0: sTemplate = "rat_hills3"; break;
                case 1: sTemplate = "sewers_beetles"; break;
                case 2: sTemplate = "sw_ants"; break;
                case 3: sTemplate = "sewers_spiders"; break;
                case 4: sTemplate = "RustMonster"; break;
                case 5: sTemplate = "sewers_snek"; break;
                case 6: sTemplate = "sewers_goo"; break;
                case 7: sTemplate = "otyughplaguebear"; break;
             }


        }
     }
    if (nFlagTableNumber == 29)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_undead")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD30_SG_CD0T3_RW_RHD50_PC2";
            sTemplate = "undead";
        }
    }

   if (nFlagTableNumber == 33)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_adventurers")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03_SA03_SG_TR30D30_LT504A25B15C5_CD0T3_PC2";
            sTemplate = "adventurers";
        }
     }
    if (nFlagTableNumber == 65)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_performer")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_PC01_SF_CD0T3_PC2";
            sTemplate = "sw_performer";
        }
     }
      if (nFlagTableNumber == 79)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "rat_hills")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // CD = Corpse Decay
            // SD = Delay Spawning
            // IS = Initial spawn state
            // RS = Random Spawn
            // DS = Deactivate
            // PC = Only if PC in Area
            // RW = Random Walk
            // RH = Return Home

            sFlags = "SP_SN03_SA_SG_CD120T3_SU30_DS2_SD60_RS50_DS2_PC5_RW_RHD50";
            sTemplate = "rat_hills";
        }
        else if (sSpawnTag == "rat_hills0")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // CD = Corpse Decay
            // SD = Delay Spawning
            // IS = Initial spawn state
            // RS = Random Spawn
            // DS = Deactivate
            // PC = Only if PC in Area
            // RW = Random Walk
            // RH = Return Home

            sFlags = "SP_SN03_SA_SG_DS2_SU30_SD60_RS50_DS2_PC5_RHD50";
            sTemplate = "rat_hills0";
        }
        else if (sSpawnTag == "rat_hills1")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // CD = Corpse Decay
            // SD = Delay Spawning
            // IS = Initial spawn state
            // RS = Random Spawn
            // DS = Deactivate
            // PC = Only if PC in Area
            // RW = Random Walk
            // RH = Return Home

            sFlags = "SP_SN04M01_SA_SG_DS2_SU30_SD60_RS50_DS2_PC5_RW_RHD50";
            sTemplate = "rat_hills1";
        }
        else if (sSpawnTag == "rat_hills2")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // CD = Corpse Decay
            // SD = Delay Spawning
            // IS = Initial spawn state
            // RS = Random Spawn
            // DS = Deactivate
            // PC = Only if PC in Area
            // RW = Random Walk
            // RH = Return Home

            sFlags = "SP_SN04M02_SA_SG_DS2_SU30_SD60_RS50_DS2_PC5_RW_RHD50";
            sTemplate = "rat_hills2";
        }
        else if (sSpawnTag == "rat_hills3")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // CD = Corpse Decay
            // SD = Delay Spawning
            // IS = Initial spawn state
            // RS = Random Spawn
            // DS = Deactivate
            // PC = Only if PC in Area
            // RW = Random Walk
            // RH = Return Home

            sFlags = "SP_SN04_SA_SG_DS2_SU20_SD60_RS50_DS2_PC5_RW_RHD50";
            sTemplate = "rat_hills3";
        }
        else if (sSpawnTag == "sw_plaguerats") {

            sFlags = "SP_SN04M02_SA_SG_SD90_DS2_RS55_DS2_PC5_RW_RHD50_SU30_RG10_LT675A30B20C10";
              sTemplate = "plaguerats";
            }

       else if (sSpawnTag == "sw_plagueratscit") {

              if(GetIsDay())
                sFlags = "SP_SN04M02_SA_SG_SD90_DS2_RS05_DS2_PC5_RHD50_SU30_RG10_LT675A30B20C10";
              else
                sFlags = "SP_SN04M02_SA_SG_SD90_DS2_RS40_DS2_PC5_NOD_RHD50_SU30_RG10_LT675A30B20C10";

              sTemplate = "plaguerats";
            }
        else if (sSpawnTag == "sw_plagueratsnight") {

              if(GetIsDay())
                sFlags = "SP_SN01_SA_SG_SD90_DS2_RS05_DS2_PC5_RHD50_SU30_RG10_LT675A30B20C10";
              else
                sFlags = "SP_SN02M01_SA_SG_SD90_DS2_RS25_DS2_PC5_RHD50_SU30_NOD_RG15_LT675A30B20C10";

              sTemplate = "plagueratspickpock";
         }
        else if (sSpawnTag == "sw_garbage") {

            sFlags = "SP_PL3T10_SF_RG25_LT501A20B35C25";
              sTemplate = "ratnest002";
            }






    }

    if (nFlagTableNumber == 80)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_vermin_lesser")
        {

            sFlags = "SP_SN06M05_SA_SG_SD90_DS2_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_vermin_lesser";
        }
        else if (sSpawnTag == "sw_vermin")
        {

            sFlags = "SP_SN04M03_SA_SG_SD90_DS2_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_vermin";
        }
        else if (sSpawnTag == "sw_vermin_greater")
        {

            sFlags = "SP_SN03M02_SA_SG_SD90_DS2_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_vermin_greater";
        }
        else if (sSpawnTag == "spidercocoon"){
            sFlags = "SP_PL3T10_SF_RG80M20_LT666A60B40C20";
            sTemplate = "spidercocoon";
        }

    }

    if (nFlagTableNumber == 81)
    {
       if (sSpawnTag == "herbs"){
            sFlags = "SP_PL3T10_SD200_SF_SR60_RS08_LT700A97B03C00";
            sTemplate = "herbs";
        } // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "herbs2"){
            sFlags = "SP_SN10M4_PL3T10_SD200_SF_SR60_RS65_LT701A97B03C00";
            sTemplate = "herbs";
        }

    }

    if (nFlagTableNumber == 82)
    {
        ;// These use the GROUP flag -- see spawn_cfg_group file

    }

    if (nFlagTableNumber == 83)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_beasts")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD60_SG_LT503A05B02C01_CD0T3_RW_RHD40";
            sTemplate = "sw_beasts";
        }
    }

    if (nFlagTableNumber == 84)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_demon_lesser")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD60_SG_LT501A05B02C01_CD0T3_RW_RHD40";
            sTemplate = "sw_demon_lesser";
        }
        if (sSpawnTag == "sw_demon_night")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff




              sFlags = "SP_SN03M01_NOD_SA_SG_SD90_RS40_DS2_DS2_PC5_RW_RHD50_SU30";//"SP_SN03M01_SA_SG_SD90_DS2_RS99_NOD_DS2_PC5_RHD50_SU30_RG5";
              sTemplate = "sw_demon_night";

        }

        if (sSpawnTag == "unstableportal"){

              sFlags = "SP_PL3T10_SF_RS60_SD90_NOD";
              sTemplate = "unstableportal";
        }

    }

    if (nFlagTableNumber == 85)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_demon")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD60_SG_LT501A45B30C15_CD0T3_RW_RHD30";
            sTemplate = "sw_demon";
        }
    }

    if (nFlagTableNumber == 86)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_demon_greater")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD60_SG_LT502A40B20C05_CD0T3_RW_RHD30";
            sTemplate = "sw_demon_greater";
        }
    }

    if (nFlagTableNumber == 87)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_undead_lesser")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD120_RS40_DS2_PC5_RW_RHD50_SU30_RG5_LT506A20B10C05";
            sTemplate = "sw_undead_lesser";
        }
        else if (sSpawnTag == "sw_undead")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD120_RS55_DS2_PC5_RW_RHD50_SU30_RG10_LT506A40B10C10";
            sTemplate = "sw_undead";
        }
        else if (sSpawnTag == "sw_undead2")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD120_RS55_DS2_PC5_RW_RHD50_SU30_RG20_LT507A06B04C02";
            sTemplate = "sw_undead2";
        }
        else if (sSpawnTag == "sw_skel2")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD120_RS55_DS2_PC5_RW_RHD50_SU30_RG20_LT507A06B04C02";
            sTemplate = "sw_skel2";
        }
        else if (sSpawnTag == "sw_undead_night")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_NOD_SA_SG_SD90_DS2_RS30_DS2_PC5_RW_RHD50_SU30_RG5_LT506A20B15C10";
            sTemplate = "sw_undead_lesser";
        }
        else if (sSpawnTag == "sw_shadow")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SA_SG_SD120_DS2_PC5_RW_RHD50_SU30_RG5";
            sTemplate = "sw_shadow";
        }
         else if (sSpawnTag == "sarcophagus2"){
            sFlags = "SP_PL3_SD200_SF_RS25_RG300M50_LT507A50B30C20";

            switch(Random(3))
             {
                case 0: sTemplate = "sarcophagus2"; break;
                case 1: sTemplate = "sarcophagus3"; break;
                case 2: sTemplate = "sarcophagus4"; break;
            }

        }
        else if (sSpawnTag == "sarcophagus1"){
            sFlags = "SP_PL3T75_SD200_SF_RS50_RG15M2_LT600A30B20C10";

            switch(Random(3))
             {
                case 0: sTemplate = "alfa_sarcophgus1"; break;
                case 1: sTemplate = "alfa_sarcophgus4"; break;
                case 2: sTemplate = "alfa_sarcophgus5"; break;
            }

        }
    }

    if (nFlagTableNumber == 88)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_undead1")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD60_SG_LT501A20B05C01_RW_RHD50";
            sTemplate = "sw_undead";
        }
    }

    if (nFlagTableNumber == 89)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_undead_high")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD60_SG_LT502A30B20C10_CD0T3_RW_RHD30";
            sTemplate = "sw_undead_high";
        }
    }

    if (nFlagTableNumber == 90)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_undead_impos")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_TR50_SD60_SG_LT502A60B40C20_CD0T3_RW_RHD30";
            sTemplate = "sw_undead_impos";
        }
    }
     if (nFlagTableNumber == 99)
     {
       // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_bandits")
        {
          sFlags = "SP_SN02_TR50_PC2_SG_PC03_LT504A025_CD0T3_RW_RHD30";
            sTemplate = "sw_bandits";
            }


    }

     if (nFlagTableNumber == 100)
     {
       // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "SW_sewers_orcs")
        {
            sFlags = "SP_SN04M02_SA_SG_SD120_DS2_RS66_DS2_PC5_RW_RHD50_SU30_RG25_LT666A30B20C10";
            sTemplate = "sewers_orcs";
        }
        else if (sSpawnTag == "SW_sewers_ogres")
        {
            sFlags = "SP_SN04M01_SA_SG_SD200_DS2_RS66_DS2_PC5_RW_RHD50_SU30_RG20_LT665A05B04C02";
            sTemplate = "sewers_ogres";
        }
        else if (sSpawnTag == "lower_sewers")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN06M03_SA_SG_SD120_RS40_DS2_PC5_RW_RHD50_PC2";


            switch( Random( 7 ))
            {
                case 0: sTemplate = "sw_demon_lesser"; break;
                case 1: sTemplate = "sw_undead_high"; break;
                case 2: sTemplate = "sw_trolls"; break;
                case 3: sTemplate = "sewers_spiders"; break;
                case 4: sTemplate = "RustMonster"; break;
                case 5: sTemplate = "sw_trolls"; break;
                case 6: sTemplate = "sw_vermin_greater"; break;
             }


        }
        else if (sSpawnTag == "lower_sewers_skum")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff



            sFlags = "SP_SN04M02_SA_SG_SD120_DS2_RS66_DS2_PC5_RW_RHD50_SU30_RG100";
            sTemplate = "lower_sewers_skum";


        }


    }


     if (nFlagTableNumber == 101)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_goblins_mid")
        {

            sFlags = "SP_SN03_SA_SG_SD200_IS1D0_RS50_DS2_PC5_RW_RHD50_LT2";
            sTemplate = "goblins_mid";
        }
    }




      if (nFlagTableNumber == 102)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_sewers_goblins")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff

            /*sFlags = "SP_SN06M03_SA_SG_SD90_DS2_RS55_DS2_PC5_RW_RHD50_SU30_RG5_LT500A30B20C10";
            sTemplate = "sewers_goblins";  */

            if(GetIsDay()){
              sFlags = "SP_SN06M03_SA_SG_SD90_DS2_RS55_DS2_PC5_RW_RHD50_SU30_RG5_LT500A30B20C10";
              sTemplate = "sewers_goblins";
            }
            else{
              sFlags = "SP_SN08M05_SA_SG_SD90_DS2_RS90_DS2_PC5_RW_RHD50_SU30_RG5_LT500A30B20C10";
              sTemplate = "sewers_goblins_night";
            }




        }
         if (sSpawnTag == "slimygoblinchest")
        {
            sFlags = "SP_PL3T50_SF_SD120_RS35_SU30_RG40M8_LT601A50B30C20";
            sTemplate = "slimygoblinchest";

        }


    }










     if (nFlagTableNumber == 103)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_goblins_high")
        {

            sFlags = "SP_SN03_SA_SG_SD200_IS1D0_DS2_PC5_RW_RHD50_LT4";
            sTemplate = "goblins_high";
        }
    }

     if (nFlagTableNumber == 104)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sm_orcs")
        {

            sFlags = "SP_SN03_SA_SG_SD200_IS1D0_DS2_PC5_RW_RHD50_LT4";
            sTemplate = "sm_orcs";
        }
    }
     if (nFlagTableNumber == 105)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sm_monster")
        {

            sFlags = "SP_SN01_SA_SG_SD200_IS1D0_DS2_PC5_RW_RHD50";
            sTemplate = "sm_monster";
        }
    }
     if (nFlagTableNumber == 106)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_fireb_lesser")
        {

            sFlags = "SP_SN06M05_SA_SG_SD90_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_fireb_lesser";
        }
        else if (sSpawnTag == "sw_fireb")
        {

            sFlags = "SP_SN04M03_SA_SG_SD90_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_fireb";
        }
        else if (sSpawnTag == "sw_fireb_greater")
        {

            sFlags = "SP_SN04M03_SA_SG_SD90_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_fireb_greater";
        }
        else if (sSpawnTag == "scrollpile"){
            sFlags = "SP_PL3T10_SD120_SF_RS55_RG10M2_LT667A50B35C20";
            sTemplate = "scrollpile";
        }
        else if (sSpawnTag == "scrollpileb"){
            sFlags = "SP_PL3T10_SD200_SF_RS55_RG40M5_LT667A80B65C55";
            sTemplate = "scrollpile";
        }
        else if (sSpawnTag == "sw_fireelemental"){
            sFlags = "SP_SN04M03_SA_SG_SD120_DS2_RS55_PC5_RW_RHD50_SU30";
            sTemplate = "sw_fireelemental";
        }

    }
     if (nFlagTableNumber == 107)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_greyooze_lesser")
        {

            sFlags = "SP_SN03M01_SA_SG_RS60_SD90_DS2_PC3_RW_RHD50_SU30";
            sTemplate = "sw_greyooze_lesser";
        }
        else if (sSpawnTag == "sw_greyooze")
        {

            sFlags = "SP_SN01M02_SA_SG_RS40_SD90_DS2_PC3_RW_RHD50_SU30";
            sTemplate = "sw_greyooze";
        }
        else if (sSpawnTag == "sw_greyooze_greater")
        {

            sFlags = "SP_SN01_SA_SG_RS30_SD90_DS2_PC3_RW_RHD50_SU30";
            sTemplate = "sw_greyooze_greater";
        }

    }
    if (nFlagTableNumber == 108)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_scaladar")
        {

            sFlags = "SP_SN03M01_SA_SG_RS60_SD120_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_scaladar";
        }
        if (sSpawnTag == "sw_constructs")
        {

            sFlags = "SP_SN03M01_SA_SG_RS60_SD120_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_constructs";
        }


    }
     if (nFlagTableNumber == 109)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_bloodyhand")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD180_RS70_DS2_PC5_RW_RHD50_SU30_RG50_LT668A25B15C10";
            sTemplate = "sw_bloodyhand";
        }
        else if (sSpawnTag == "sw_livingmagic")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN02M01_SA_SG_SD180_RS70_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_livingmagic";
        }

         else if (sSpawnTag == "sw_bloodychest"){
            sFlags = "SP_PL3T10_SD190_SF_RS25_RG800M150_LT668A80B65C55";
             switch(Random(3))
             {
                case 0: sTemplate = "bloodyhandchest3"; break;
                case 1: sTemplate = "bloodyhandchest2"; break;
                case 2: sTemplate = "bloodyhandchest1"; break;
            }
        }
    }

     if (nFlagTableNumber == 110)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_lizardsnake")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SA_SG_SD150_RS30_DS2_PC5_RW_RHD50_SU30_RG50_LT669A40B30C20";
            sTemplate = "sw_lizardsnake";
        }
        else if (sSpawnTag == "sw_croc")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD150_RS30_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_croc";
        }
        else if (sSpawnTag == "sw_seawraith")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SA_SG_SD150_RS30_DS2_PC5_RW_RHD50_SU30_RG75";
            sTemplate = "sw_seawraith";
        }
        else if (sSpawnTag == "sw_lizardeggs")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_PL3T10_SF_RS35_SD120";
            sTemplate = "lizardeggs";
        }

        else if (sSpawnTag == "sw_umberlee_patrol")
        {

                sFlags = "SP_SN08M04_SA_SG_RS75_SD120_PR01T2C_PC05";

                sTemplate = "umberlee_patrol";
        }

        else if (sSpawnTag == "sw_umb_were")
        {
          sFlags = "SP_SN06M03_SA_SG_RS85_SD120_PC05_RW_RG300";
          sTemplate = "umberlee_were";
        }





        else if (sSpawnTag == "sw_sunktreasure")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff


            switch(Random(3)){


            case 0:
            sFlags = "SP_PL3_SD200_SF_RS45";
            sTemplate = "orestone_5";
            break;

            case 1:
            sFlags = "SP_PL3_SD200_SF_RS35";
            sTemplate = "orestone_6";
            break;

            case 2:
            sFlags = "SP_PL3T10_SD120_SF_RS60_RG800M150_LT672A50B15C05";
            sTemplate = "ay_buriedchest";
            break;

            }
        }


    }

     if (nFlagTableNumber == 111)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_dweomervore")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
             if(GetIsDay()){
               sFlags = "SP_SN01_SA_SG_SD150_RS05_DS2_PC5_RW_RHD50_SU30_RG200M50_LT670A40B10C03";
             }
             else{
               sFlags = "SP_SN01_SA_SG_SD150_RS07_DS2_PC5_RW_RHD50_SU30_RG200M50_LT670A50B10C03";
             }
            sTemplate = "sw_dweomervore";
        }




    }


     if (nFlagTableNumber == 112)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "sw_cult_low")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN04M01_SA_SG_SD120_RS60_DS2_PC5_RW_RHD50_SU30_RG75M10_LT671A01B01C03";
            sTemplate = "sw_cult_low";
        }
        else if (sSpawnTag == "sw_cult_hi")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD120_RS50_DS2_PC5_RW_RHD50_SU30_RG200M50_LT671A40B20C10";
            sTemplate = "sw_cult_hi";
        }
        if (sSpawnTag == "sw_cult_patrol")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5


            if(GetIsDay()){
              sFlags = "SP_SN05M03_SA_SG_SD120_PR01T1C_PC05_RG5_LT671A15B10C03";
              sTemplate = "sw_cult_hi";
            }
            else{
              sFlags = "SP_SN05M03_SA_SG_SD120_PR01T1C_PC05_RG5_LT671A30B20C10";
              sTemplate = "sw_cult_low";
            }
        }




    }

     if (nFlagTableNumber == 113)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "sw_frostfungus")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SA_SG_SD120_RS50_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_frostfungus";
        }
        else if (sSpawnTag == "sw_plants")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SA_SG_SD120_RS50_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_plants";
        }
        else if (sSpawnTag == "sw_plants2")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN06M03_SA_SG_SD120_RS70_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_plants2";
        }
        else if (sSpawnTag == "sw_undead_high")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SA_SG_SD120_RS40_DS2_PC5_RW_RHD50_SU30_RG100M20_LT607A30B20C10";
            sTemplate = "sw_undead_high";
        }
        else if (sSpawnTag == "sarcophagus2"){
            sFlags = "SP_PL3_SD200_SF_RS25_RG100M20_LT607A50B30C20";

            switch(Random(3))
             {
                case 0: sTemplate = "sarcophagus2"; break;
                case 1: sTemplate = "sarcophagus3"; break;
                case 2: sTemplate = "sarcophagus4"; break;
            }

        }
     }


    if (nFlagTableNumber == 114)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "sw_lightningbugs_sm")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN02M01_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_lightningbugs_sm";
        }
        else if (sSpawnTag == "sw_lightningbugs_me")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN04M02_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_lightningbugs_me";
        }
         else if (sSpawnTag == "sw_airelem_sm")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN02M01_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_airelem_sm";
        }
         else if (sSpawnTag == "sw_airelem_lg")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN02M01_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_airelem_lg";
        }
        else if (sSpawnTag == "orestone0"){
            sFlags = "SP_PL3_SD200_SF_RS25";

            switch(Random(3))
             {
                case 0: sTemplate = "orestone_1"; break;
                case 1: sTemplate = "orestone_1"; break;
                case 2: sTemplate = "orestone_2"; break;
            }

        }
        else if (sSpawnTag == "orestone1"){
            sFlags = "SP_PL3_SD200_SF_RS35";

            switch(Random(3))
             {
                case 0: sTemplate = "orestone_1"; break;
                case 1: sTemplate = "orestone_2"; break;
                case 2: sTemplate = "orestone_3"; break;
            }

        }
        else if (sSpawnTag == "orestone2"){
            sFlags = "SP_PL3_SD200_SF_RS45";

            switch(Random(3))
             {
                case 0: sTemplate = "orestone_2"; break;
                case 1: sTemplate = "orestone_3"; break;
                case 2: sTemplate = "orestone_4"; break;
            }

        }


     }




 if (nFlagTableNumber == 115)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "sw_herbivores")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            if(GetIsDay()){
              sFlags = "SP_SN02M01_SA_SG_SD120_SR75_RS10_DS2_PC5_RW_RHD50_SU30";
            }
            else
              sFlags = "SP_SN02M01_SA_SG_SD120_SR10_RS10_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_herbivores";
        }
        if (sSpawnTag == "sw_kryptanimals")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            if(GetIsDay()){
              sFlags = "SP_SN05M01_SA_SG_SD120_SR75_RS50_DS2_PC5_RW_RHD50_SU30";
            }
            else
              sFlags = "SP_SN02M01_SA_SG_SD120_SR10_RS15_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_kryptanimals";
        }
        if (sSpawnTag == "sw_krypforest")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            if(GetIsNight()){
              sFlags = "SP_SN05M01_SA_SG_SD120_SR75_RS60_DS2_PC5_RW_RHD50_SU30";
            }
            else
              sFlags = "SP_SN02M01_SA_SG_SD120_SR10_RS10_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_kryptforest";
        }
        else if (sSpawnTag == "sw_carnivores")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN04M02_SA_SG_SD120_RS25_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_carnivores";
        }
        else if (sSpawnTag == "sw_elves")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN04M02_SA_SG_SD120_RS90_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_elves";
        }


        else if (sSpawnTag == "orestone0"){
            sFlags = "SP_PL3_SD200_SF_RS25";

            switch(Random(3))
             {
                case 0: sTemplate = "orestone_1"; break;
                case 1: sTemplate = "orestone_1"; break;
                case 2: sTemplate = "orestone_2"; break;
            }

        }






   if (sSpawnTag == "sw_hobgob_patrol")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5



            //int iForest = Random(100);


                sFlags = "SP_SN08M04_SA_SG_RS75_SD120_PR02T2_PC05";


                sTemplate = "ww_hobgoblin_hi";




        }


   if (sSpawnTag == "sw_drow_patrol")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5



            //int iForest = Random(100);


                sFlags = "SP_SN08M04_SA_SG_RS75_SD120_PR66T1C_PC05";


                sTemplate = "ww_drow";




        }


    if (sSpawnTag == "sw_drow")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5


              if(GetIsDay())
                sFlags = "SP_SN06M04_SA_SG_SD120_RS50_RW_PC05_RG10_LT673A30B20C10";
              else
                sFlags = "SP_SN09M06_SA_SG_SD120_RS50_RW_PC05_RG10_LT673A50B30C20";

              sTemplate = "ww_drow";



        }










        if (sSpawnTag == "sw_forest_patrol")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5



            //int iForest = Random(100);

            if(d6() < 5){

              if(GetIsDay()){
                sFlags = "SP_SN01_SA_SG_RS08_SD120_PR01T2_PC05";
                sTemplate = "sw_forest_low";
              }
              else{
                sFlags = "SP_SN01_SA_SG_RS20_SD120_PR01T2_PC05";
                sTemplate = "sw_forest_hi";
              }
            }
            else{
              if(GetIsDay())
                sFlags = "SP_SN06M03_SA_SG_RS09_SD120_PR01T2_PC05";
              else
                sFlags = "SP_SN08M03_SA_SG_RS25_SD120_PR01T2_PC05";

              switch(Random(3))
                {
                case 0: sTemplate = "ww_spider"; break;
                case 1: sTemplate = "ww_stinkbeetle"; break;
                case 2: sTemplate = "ww_hobgoblin"; break;
                }
            }

        }

        if (sSpawnTag == "sw_krypt_patrol")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5




              int iOdds = d100();
              sFlags = "SP_SN04M02_SA_SG_RS99_SD120_PR03T1C_PC05";

              if(iOdds < 30){

                sTemplate = "sw_manticore";
              }
              else if(iOdds >= 30 && iOdds < 60){
                sTemplate = "sw_leucrotta";

              }
              else if(iOdds >= 60 && iOdds < 90){
                sTemplate = "sw_wyvern";
              }
              else{
                sTemplate = "sw_bulette";

              }




        }



        if (sSpawnTag == "sw_hobgoblins")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5


              if(GetIsDay())
                sFlags = "SP_SN06M04_SA_SG_SD120_RS50_RW_PC05_RG10_LT673A30B20C10";
              else
                sFlags = "SP_SN09M05_SA_SG_SD120_RS50_RW_PC05_RG10_LT673A50B30C20";

              sTemplate = "ww_hobgoblin";



        }
        if (sSpawnTag == "sw_hobgoblins_hi")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5


              if(GetIsDay())
                sFlags = "SP_SN06M04_SA_SG_SD120_RS50_RW_PC05_RG10_LT673A30B20C10";
              else
                sFlags = "SP_SN09M05_SA_SG_SD120_RS50_RW_PC05_RG10_LT673A50B30C20";

              sTemplate = "ww_hobgoblin_hi";



        }



     }


   if (nFlagTableNumber == 116)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "sw_carnivores")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN07M03_SA_SG_SD120_RS60_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_carnivores";
        }
        else if (sSpawnTag == "sw_malar")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN05M03_SA_SG_SD120_RS70_DS2_PC5_RW_RHD50_SU30_RG100M10";
            sTemplate = "sw_malar";
        }
     }



    if (nFlagTableNumber == 117)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "sw_constructs")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_constructs";
        }
        else if (sSpawnTag == "sw_frostmonster")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN04M02_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_frostmonster";
        }
         else if (sSpawnTag == "sw_aurilites")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN02M01_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30_RG100M10_LT673A20B10C05";
            sTemplate = "sw_aurilites";
        }
         else if (sSpawnTag == "sw_frostmonsterhard")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN02M01_SA_SG_SD120_RS65_DS2_PC5_RW_RHD50_SU30";
            sTemplate = "sw_frostmonsterhard";
        }

        else if (sSpawnTag == "orestone2"){
            sFlags = "SP_PL3_SD200_SF_RS25";

            switch(Random(8))
             {
                case 0: sTemplate = "unstableporta001"; break;
                case 1: sTemplate = "unstableporta001"; break;
                case 2: sTemplate = "orestone_4"; break;
                case 3: sTemplate = "unstableporta001"; break;
                case 4: sTemplate = "mimicchest";
                        sFlags = "SP_PL3_SD200_SF_RS45_RG200M20_LT673A50B30C20";
                        break;
                case 5: sTemplate = "mimicchest";
                        sFlags = "SP_PL3_SD200_SF_RS45_RG200M20_LT673A50B30C20";
                        break;
                case 6: sTemplate = "aurilchest";
                        sFlags = "SP_PL3_SD200_SF_RS45_RG200M20_LT673A50B30C20";
                        break;
                case 7: sTemplate = "aurilchest";
                        sFlags = "SP_PL3_SD200_SF_RS45_RG200M20_LT673A50B30C20";
                        break;
            }

        }


     }



    if (nFlagTableNumber == 118)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "wallmimichid")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN01_SA_SG_SD200_RS02_DS2_PC5_RHD50_SU30_RG100M10";
            sTemplate = "wallmimichid";
            //sRetTemplate = "wallmimichid";
        }

    }


    if (nFlagTableNumber == 119)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "sw_hauntedinn")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN03M01_SG_SD120_DS2_PC5_RW_TR10_RHD50_RG5_NOD";
            sTemplate = "sw_hauntedinn";
        }
        else if (sSpawnTag == "chestlow"){
           sFlags = "SP_PL3_SD200_SF_RS75_RG100M10_NOD_LT507A50B30C20";


           sTemplate = "chestlow";


        }
        else if (sSpawnTag == "innbones"){
           sFlags = "SP_PL3_SD200_SF_RS75_RG100M10_NOD_LT507A50B30C20";


           sTemplate = "innbones";


        }




    }




    if (nFlagTableNumber == 201)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_slimypatrol")
        {
            // SN09M05 = Keep 5 to 9 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR01T1C = walk wapoints that start with PR01 and T1 do it circular path starting with nearest
            // PC05 = only spawn if PC in area, despawn after 5 minutes
            // LT501A05B02C01 Loot table 501 (merchant in DM area) and probability of one two or three items
            // RG5 random gold 0 - 5


            if(GetIsDay()){
              sFlags = "SP_SN06M04_SA_SG_SD90_PR01T1C_PC05_RG5_LT500A30B20C10";

              //sFlags = "SP_SN04M02_SA_SG_SD90_DS2_RS55_DS2_PC5_RW_RHD50_SU30_RG10_LT675A30B20C10";
              if(d20() < 6){
                sTemplate = "plaguerats";
              }
              else
                sTemplate = "sewers_goblins";
            }
            else{
              sFlags = "SP_SN07M05_SA_SG_SD90_PR01T1C_PC05_RG5_LT500A30B20C10";
              if(d20() < 3)
                sTemplate = "plaguerats";
              else
                sTemplate = "sewers_goblins_night";
            }
        }


        if (sSpawnTag == "animal_swarm")
        {
                // SN16 = Keep 12 alive
                // SA = spawn all at once
                // IS = Initial spawn state
                // RS = Random Spawn
                // DS = Deactivate
                // TR = Only with PC in Proximity
                // RW = Random Walk

          switch(Random(2))
          {
            case 0: sFlags = "SP_SN16M8_SA_RS25_DS3_DI50_TR20D30_RW";
                    sTemplate = "NW_RAT001";break;
            case 1: sFlags = "SP_SN16M8_SA_RS25_DS3_DI50_TR20D30_RW";
                    sTemplate = "mg_swarmbat";break;
          }
        }



    }











   if (nFlagTableNumber == 202)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
         if (sSpawnTag == "sw_umberlee_patrol")
        {

                sFlags = "SP_SN10M05_SA_SG_RS25_SD120_PR01T2_PC05";

                sTemplate = "umberlee_patrol";
        }

        if (sSpawnTag == "sw_umb_were")
        {
          sFlags = "SP_SN10M05_SA_SG_RS25_SD120_PR01T2_PC05";
          sTemplate = "umberlee_were";
        }

    }


























if (nFlagTableNumber == 500)
    {
        // These use the GROUP flag -- see spawn_cfg_group file

        if (sSpawnTag == "vampire_lair")
        {
            // SN03 = Keep 2 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // CD = Corpse Decay
            // SD = Delay Spawning
            // IS = Initial spawn state
            // RS = Random Spawn
            // DS = Deactivate
            // PC = Only if PC in Area
            // RW = Random Walk
            // RH = Return Home

            sFlags = "SP_SN03M1_SA_SG_NOD_CD120T3_SU30_DS1_SD1_RS50_PC5_RW_RG50M05_LT674A30B20C10";
            sTemplate = "vampire_lair";
        }
        if (sSpawnTag == "vampire_wander")
        {
            // SN03 = Keep 2 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // CD = Corpse Decay
            // SD = Delay Spawning
            // IS = Initial spawn state
            // RS = Random Spawn
            // DS = Deactivate
            // PC = Only if PC in Area
            // RW = Random Walk
            // RH = Return Home
            if(d100() < 10){
              sFlags = "SP_SN01_NOD_SA_SG_SD90_DS2_RS01_DS2_PC5_RW_RHD50_SU30_RG50M05_LT674A35B10C05";
              sTemplate = "vampire_wander";
            }
            else{
              sFlags = "SP_SN01_NOD_SA_SG_SD90_DS2_RS01_DS2_PC5_RW_RHD50_SU30";
              sTemplate = "mg_swarmbat";
            }
        }


        else if (sSpawnTag == "mg_vampcof1"){

            sFlags = "SP_PL3_SD200_SF_RS20_RG200M20_LT674A40B30C20";
            sTemplate = "mg_vampcof1";
        }
        else if (sSpawnTag == "mg_vampcof2"){

            sFlags = "SP_PL3_SD200_SF_RS30_RG200M20_LT674A890B10C01";
            sTemplate = "mg_vampcof2";
        }




     }








    if (nFlagTableNumber == 30)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_housethief")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SD45_NOD_PC2_SF_SU30_LT504A022B014C004_TR50_RH50_HL01";
            sTemplate = "housethief";
        }
    }
      if (nFlagTableNumber == 36)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_guildthief")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SB_SD45_HR19T24_PC2_SF_CD003T3_LT504A022B014C004_TR50_RH50_HL01";
            sTemplate = "guildthief";
        }
    }


/*
    if (nFlagTableNumber == 31)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_watchgroup")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SN01_PC2_NOD_PC03_RG006M001C10_SG_CD030T2_LT504A020B002C001_RS80_RH30_HL10";
            sTemplate = "watchgroup";
        }

        if (sSpawnTag == "sw_patrolgroup")
        {
            sFlags = "SP_SN04_SA_SG_PR31T2_CD300T2_PC2";
            sTemplate = "patrolgroup";
        }

        // This one adds to the current spawn tags, so you can
        // specify the number you want in the waypoint name
        if (sSpawnTag ==  "sw_num_watchman")
        {
            sFlags = sSpawnName + "_SA_CD300T2_PC2";
            sTemplate = "citywatchman";
        }
    }

    else if (nFlagTableNumber == 32)
    {
        if (sSpawnTag == "k_patrol_010")
        {
            sFlags = "SP_SN05_SA_PR10_SS10_HB10_CD300T2_PC2";
            sTemplate = "k_patrol_010";
        }
    }
     */

        // These use the GROUP flag -- see spawn_cfg_group file

//   PLn|Tn|Pn
//   : Placeable Object
//   : Spawns a Placeable Object with Behavior
//   :   Behavior 0: Default Behavior
//   :   Behavior 1: Despawn if Empty
//   :   Behavior 2: Refill if Empty
//   :   Behavior 3: Refresh (despawn/respawn) every P000 minutes; default
//   :   (if no Pn specified) is 60 minutes
//   : Optional Flag: T00
//   :   Trap Disabled Chance
//   :   00% to 99% chance of Trap Disabled
//   :   Trap must already be part of Placeable's Template
//   :   Default 100% Chance Trap is Disabled
//   : Optional Flag: P00
//   :   Refresh period (in minutes)
if (nFlagTableNumber == 41)
    {
        if (sSpawnTag == "sw_box")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC200_PL0_LT508A10B05C01_TR50_SD200P";
            sTemplate = "box";
            //sTemplate = "ratnest001";
        }
        if (sSpawnTag == "sw_ratbox")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC200_PL0_LT508A10B05C01_TR50_SD200P";
            sTemplate = "ratbox";
            //sTemplate = "ratnest001";
        }

    }


    if (nFlagTableNumber == 42)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_chest_locked")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC200_PL0_LT508A30B05C01_SD200P";
            sTemplate = "chest_locked";
        }

    }

    if (nFlagTableNumber == 43)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_chest_locked2")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC200_PL0_LT507A30B05C01_SD200P";
            sTemplate = "chest_locked2";
        }
    }

    if (nFlagTableNumber == 44)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_chest_locked_trapped")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC200_PL0_LT506A20B05C01_SD200P";
            sTemplate = "chest_locked_trapped";
        }
    }

    if (nFlagTableNumber == 45)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_furniture")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_LT508_PC_PL0";
            sTemplate = "furniture";
        }
    }

    if (nFlagTableNumber == 46)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_misc")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC_PL0";
            sTemplate = "misc";
        }
    }

if (nFlagTableNumber == 47)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_rug")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC_PL0";
            sTemplate = "rug";
        }
    }

if (nFlagTableNumber == 48)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_commoner")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_HR07T18_SN03_SR20_SG_PC01_TR30D30_LT505A25B15C5_RW_RHD80";
            sTemplate = "commoner";
        }
        if (sSpawnTag == "sw_warrens")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_HR07T18_SN03_SR20_SG_PC01_TR30D30_LT505A25B15C5_RW_RHD80";
            sTemplate = "warrens";
        }
    }

if (nFlagTableNumber == 49)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_comsingle")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_DOD_SN01_SG_PC05_TR30D30_RW_RHD80";
            sTemplate = "comsingle";
        }
    }
if (nFlagTableNumber == 50)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_warehouseitem")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff
            sFlags = "SP_SG_SF_PC200_PL0_LT509A20B05C01_SD200P ";
            sTemplate = "warehouseitem ";
        }
    }

if (nFlagTableNumber == 51)
    {

        if (sSpawnTag == "sw_ratden")
        {
             //   PLn|Tn|Pn
//   : Placeable Object
//   : Spawns a Placeable Object with Behavior
//   :   Behavior 0: Default Behavior
//   :   Behavior 1: Despawn if Empty
//   :   Behavior 2: Refill if Empty
//   :   Behavior 3: Refresh (despawn/respawn) every P000 minutes; default
//   :   (if no Pn specified) is 60 minutes
//   : Optional Flag: T00
//   :   Trap Disabled Chance
//   :   00% to 99% chance of Trap Disabled
//   :   Trap must already be part of Placeable's Template
//   :   Default 100% Chance Trap is Disabled
//   : Optional Flag: P00
//   :   Refresh period (in minutes)
            sFlags = "SP_SG_SF_PC200_PL0_LT508A30B05C01_SD200P";
            sTemplate = "chest_locked";
        }
    }


   // Sample Complex Replacement
    // Using FT without FT00 will
    // Default to nFlagTableNumber 0
    if (nFlagTableNumber == 0)
    {
        // Old Method of using SpawnTag
        if (sSpawnTag == "alleythief")
        {
            sFlags = "SP_SD99_TR30";
            sTemplate = "alleythief";
        }

        if (sSpawnTag == "undead")
        {
            sFlags = "SP_SNO4";
            sTemplate = "NW_ZOMBIE01";
        }
    }
    //

    // Sample Simple Replacement Flag
    // Completely Replaces Flags
    // On Spawnpoints with FT01
    if (nFlagTableNumber == 1)
    {
        sFlags = "SP_PC01";
        sTemplate = "alleythief";
    }
    //

    // Sample Template Flags
    // These Flags Get Added
    // To Spawnpoints with FT02

    if (nFlagTableNumber == 2)
    {
        sFlags = "_RW_PC05R";
    }
      if (nFlagTableNumber == 31)
    {
        // These use the GROUP flag -- see spawn_cfg_group file
        if (sSpawnTag == "sw_watchgroup")
        {
            // SN05 = Keep 4 alive
            // SG = spawn group (check spawn_cfg_group file for sTemplate
            // SA = spawn all at once
            // PR31T1 = walk wapoints that start with PR31 and T1 do it circular path
            // CD = drop a corpse, but just inventory on them, no wielded or worn stuff

            //if(Random(100) %2){
            //"SP_SN04M02_SA_SG_SD90_PR01T1C_PC05_RG5_LT500A30B20C10"
            sFlags = "SP_SN04_SA_SG_SD120_RS05_DOD_PR31T1_PC05_CD300T2";
            sTemplate = "watchgroup";
            //}
        }

        if (sSpawnTag == "sw_patrolgroup")
        {
            //if(Random(100) %2){
            sFlags = "SP_SN05_SA_SG_SD120_RS05_DOD_PR31T2_CD300T2_PC2";
            sTemplate = "patrolgroup";
            //}
        }

        // This one adds to the current spawn tags, so you can
        // specify the number you want in the waypoint name
        if (sSpawnTag ==  "sw_num_watchman")
        {
            sFlags = sSpawnName + "RS10_SA_CD300T2_PC2";
            sTemplate = "citywatchman";
        }
    }

    else if (nFlagTableNumber == 32)
    {
        if (sSpawnTag == "k_patrol_010")
        {
            sFlags = "SP_SN05_SA_PR10_SS10_HB10_CD300T2_PC2";
            sTemplate = "k_patrol_010";
        }
    }



   // Sample Complex Replacement
    // Using FT without FT00 will
    // Default to nFlagTableNumber 0
    /*if (nFlagTableNumber == 0)
    {
        // Old Method of using SpawnTag
        if (sSpawnTag == "alleythief")
        {
            sFlags = "SP_SD99";
            sTemplate = "alleythief";
        }

        if (sSpawnTag == "undead")
        {
            sFlags = "SP_SNO4";
            sTemplate = "NW_ZOMBIE01";
        }
    }
    //

    // Sample Simple Replacement Flag
    // Completely Replaces Flags
    // On Spawnpoints with FT01
    if (nFlagTableNumber == 2)
    {
        sFlags = "SP_PR11_PC01";
        sTemplate = "alleythief";
    }
    //

    // Sample Template Flags
    // These Flags Get Added
    // To Spawnpoints with FT02
    if (nFlagTableNumber == 2)
    {
        sFlags = "_RW_PC05R";
    }
    //
    */


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
