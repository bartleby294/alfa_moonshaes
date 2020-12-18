//
// Spawn Loot
//
// History:
//    --/--/--   Neshke            Created
//    12/03/02   Cereborn          Added DanielleB's merchant-based loot tables
//    12/31/02   Cereborn          Use newly added flags for determining the
//                                 probabilities of 1,2, or 3 item drops from
//                                 merchant-based (LT500-LT999) loot tables.
//                                 Fixed an off-by-one bug in the item choosing
//                                 code for for merchant-based loot tables. The
//                                 code was trying to take items 2 through n+1.
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
void CleanInventory(object oSpawned);
//
//
void LootTable(object oSpawn, object oSpawned, int nLootTable)
{
    // Initialize
    object oItem;
    string sTemplate;
    int nStack;
    int i = 0;
    int num = 0;
    int j = 0;

//
// Only Make Modifications Between These Lines
// -------------------------------------------

    // Table 00
   // if (nLootTable == 0)
    {
        // 50% Chance
       // if (d100(1) > 10)
     //   {
            // Created Custom Item with ResRef of magicsword
         //   sTemplate = "magicsword";
       //     nStack = 1;
      //  }
      //  oItem = CreateItemOnObject(sTemplate, oSpawned, nStack);
    //}
    //

    // Random Gold and *Nothing* Else
  //  else */
  if (nLootTable == 1)
    {
        CleanInventory(oSpawned);
        // Add our Items: Gold for Example
        nStack = Random(20) + 1;
        oItem = CreateItemOnObject("nw_it_gold001", oSpawned, nStack);
    }

  if (nLootTable == 2 || nLootTable == 3 || nLootTable ==4)      //goblin loot table low
    {
       CleanInventory(oSpawned);
       num = Random(3) + 1;




       for(j=0;j<=num;j++){

       i = Random(100);



       if (nLootTable == 3){//(if lowbie goblins, only first loot table
         i = 10;


       }

       if (nLootTable == 4){//if tough goblins, better chance of good loot
         i = i + 40;


       }

       if(i<= 65){    //low loot table

        switch (Random(28) )
        {
            case 0:
            nStack = Random(3) + 1;
            oItem = CreateItemOnObject("nw_it_gold001", oSpawned, nStack);
            break;

            case 1:
            nStack = 1;
            oItem = CreateItemOnObject("hc_healkit", oSpawned, nStack);
            break;

            case 2:
            nStack = 1;
            oItem = CreateItemOnObject("alfa_apple", oSpawned, nStack);
            break;

            case 3:
            nStack = 1;
            oItem = CreateItemOnObject("bread", oSpawned, nStack);
            break;

            case 4:
            nStack = 1;
            oItem = CreateItemOnObject("mead", oSpawned, nStack);
            break;

            case 5:
            nStack = 1;
            oItem = CreateItemOnObject("004RustySword", oSpawned, nStack);
            break;

            case 6:
            nStack = 1;
            oItem = CreateItemOnObject("BelayingPin", oSpawned, nStack);
            break;

            case 7:
            nStack = 1;
            oItem = CreateItemOnObject("004ShoddyMace", oSpawned, nStack);
            break;

            case 8:
            nStack = 1;
            oItem = CreateItemOnObject("004Dart1", oSpawned, nStack);
            break;

            case 9:
            nStack = 1;
            oItem = CreateItemOnObject("NW_IT_MSMLMISC20", oSpawned, nStack);
            break;

            case 10:
            nStack = 1;
            oItem = CreateItemOnObject("NW_IT_MSMLMISC24", oSpawned, nStack);
            break;

            case 11:
            nStack = 1;
            oItem = CreateItemOnObject("004Dart1", oSpawned, nStack);
            break;

            case 12:
            nStack = 1;
            oItem = CreateItemOnObject("NW_IT_MPOTION021", oSpawned, nStack);
            break;

            case 13:
            nStack = 1;
            oItem = CreateItemOnObject("NW_IT_MPOTION023", oSpawned, nStack);
            break;

            case 14:
            nStack = 1;
            oItem = CreateItemOnObject("slimygoblinear", oSpawned, nStack);
            break;

            case 15:
            nStack = 1;
            oItem = CreateItemOnObject("slimygoblinear", oSpawned, nStack);
            break;

            case 16:
            nStack = 1;
            oItem = CreateItemOnObject("slimygoblinear", oSpawned, nStack);
            break;

            case 17:
            nStack = 1;
            oItem = CreateItemOnObject("mead", oSpawned, nStack);
            break;

            case 18:
            nStack = 1;
            oItem = CreateItemOnObject("nuts", oSpawned, nStack);
            break;

            case 19:
            nStack = 1;
            oItem = CreateItemOnObject("meat", oSpawned, nStack);
            break;


            }// switch close
        }//if close
        else if(i > 65 && i < 95){    //middle loot table

        switch (Random(9) )
        {
            case 0:
            nStack = Random(10) + 3;
            oItem = CreateItemOnObject("nw_it_gold001", oSpawned, nStack);
            break;

            case 1:
            nStack = 1;
            oItem = CreateItemOnObject("PotionOfCLW", oSpawned, nStack);
            break;

            case 2:
            nStack = 1;
            oItem = CreateItemOnObject("NW_AARCL012", oSpawned, nStack);
            break;

            case 3:
            nStack = 1;
            oItem = CreateItemOnObject("NW_ASHSW001", oSpawned, nStack);
            break;

            case 4:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_arcscr139", oSpawned, nStack);
            break;

            case 5:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_arcscr187", oSpawned, nStack);
            break;

            case 6:
            nStack = 1;
            oItem = CreateItemOnObject("004Baby", oSpawned, nStack);
            break;

            case 7:
            nStack = 1;
            oItem = CreateItemOnObject("NW_IT_MPOTION009", oSpawned, nStack);
            break;

            case 8:
            nStack = 1;
            oItem = CreateItemOnObject("NW_AARCL004", oSpawned, nStack);
            break;

          } // switch close
        }  //else if close

        else {    //high loot table

        switch (Random(9) )
        {
            case 0:
            nStack = Random(20) + 8;
            oItem = CreateItemOnObject("nw_it_gold001", oSpawned, nStack);
            break;

            case 1:
            nStack = 1;
            oItem = CreateItemOnObject("PotionOfCLW", oSpawned, nStack);
            break;

            case 2:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_divscr062", oSpawned, nStack);
            break;

            case 3:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_arcscr072", oSpawned, nStack);
            break;

            case 4:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_arcscr103", oSpawned, nStack);
            break;

            case 5:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_arcscr145", oSpawned, nStack);
            break;

            case 6:
            nStack = 1;
            oItem = CreateItemOnObject("004Baby", oSpawned, nStack);
            break;

            case 7:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_arcscr180", oSpawned, nStack);
            break;

            case 8:
            nStack = 1;
            oItem = CreateItemOnObject("uc_it_arcscr210", oSpawned, nStack);
            break;

            case 9:
            nStack = 1;
            oItem = CreateItemOnObject("NW_IT_MPOTION008", oSpawned, nStack);
            break;

            case 10:
            nStack = 1;
            oItem = CreateItemOnObject("NW_IT_MPOTION019", oSpawned, nStack);
            break;

          } // switch close
        }  //else close
    }

    }//for loop close

    // Merchant-based loot - from DanieleB NESS scripts
    else if( nLootTable >= 500 )
    {
        object oStore = OBJECT_INVALID;
        oStore = GetObjectByTag( "LOOT_" + IntToString(nLootTable));

        object oItem;
        int nCount;
        int nAmount;
        if( GetIsObjectValid( oStore ) )
            {
            // -- check if we already know item count
            nCount = GetLocalInt( oStore , "nItemCount" );
            if( nCount <= 0 )
                {
                // -- Count Items in Store Inventory
                oItem = GetFirstItemInInventory( oStore );
                while( GetIsObjectValid( oItem ) )
                    {
                    nCount++ ;
                    oItem = GetNextItemInInventory( oStore );
                    }
                SetLocalInt( oStore , "nItemCount" , nCount );
                }
            // -- probability for multiple items
            nAmount = d100();

            // Cereborn: removed 12/31/02
            // Old:
            // int nProbOneItem    = 50;   // 50% chance 1 item
            // int nProbTwoItems   = 15;   // 15% chance 2 items
            // int nProbThreeItems = 5;    // 5%  chance 3 items
                                           // 30% chance no items ( implied )
            // New:
            int nProbOneItem    = GetLocalInt(oSpawn, "f_LootTable1ItemChance");
            int nProbTwoItems   = GetLocalInt(oSpawn, "f_LootTable2ItemChance");
            int nProbThreeItems = GetLocalInt(oSpawn, "f_LootTable3ItemChance");

            if( nAmount <= nProbThreeItems )
                nAmount = 3;
            else
            if( nAmount <= nProbThreeItems + nProbTwoItems )
                nAmount = 2;
            else
            if( nAmount <= nProbThreeItems + nProbTwoItems + nProbOneItem )
                nAmount = 1;
            else
                nAmount = 0;
            // -- Generate nAmount items on oSpawned
            while( nAmount > 0 )
                {
                // -- Determine random item
                int nSelected;
                int nRand = Random( nCount ) + 1;
                // -- Get the item
                oItem = GetFirstItemInInventory( oStore );

                for( nSelected = 1 ; nSelected < nRand ; nSelected++ )
                    {
                    oItem = GetNextItemInInventory( oStore );
                    }
                // -- Grab item template
                if (oItem != OBJECT_INVALID)
                {
                    sTemplate = GetResRef( oItem );
                }

                // -- Checks to see if this it is a ammo or thrown item and creates more in the stack
                string sRoot = GetStringLowerCase( GetSubString( sTemplate , 0 , 6 ) );
                if( sRoot == "nw_wam"  || sRoot == "nw_wth" )
                    {
                    nStack = Random( 3  ) + 1;
                    }
                else
                // -- Check if the item is Gold, and creates more in Stack
                //    small amount generated : gold placement should maybe be handled in some other way.
                if( GetStringLowerCase( sTemplate ) == "nw_it_gold001" )
                    nStack = Random( 3  ) + 5;
                else
                if( nStack < 1 )
                    nStack = 1;
                // -- create the item on oSpawned
                oItem = CreateItemOnObject( sTemplate , oSpawned , nStack );
                // -- decerement the Item Amount counter
                nAmount--;
                }
            }
        else
            {
            // Write to log
            PrintString( "Could not find Loot Merchant [" +
                "LOOT_" +
                IntToString( nLootTable ) +
                "] for Spawn Waypoint : " +
                GetName( oSpawn ) );
            }
        }

// -------------------------------------------
// Only Make Modifications Between These Lines
//

}
}
