////////////////////////////////////////////////////////////////////////////////
//                                                  //                        //
// _kb_loot_corpse (include version)                //      VERSION 1.6       //
//                                                  //                        //
//  by Keron Blackfeld on 07/13/2002                ////////////////////////////
//  update on 07/27/2002                                                      //
//  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
//  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  CONFIGURING THE SCRIPT                                                    //
//                                                                            //
//  This script supports some configuration by the user. Following the        //
//  void LeaveCorpse() of the _kb_loot_corpse, you'll find a section where    //
//  you can set a few things. These include: (with default values displayed)  //
//                                                                            //
//                                                                            //
//  int nUseLootable =  TRUE    This enables the script. Setting is to FALSE  //
//                              disables it.                                  //
//                                                                            //
//  int nMoveEquipped = TRUE    Setting this to FALSE will stop the script    //
//                              from moving equipped items (other than        //
//                              Armour and Weapons/Shield) to the lootable    //
//                              corpse. (For preventing the move/copy of      //
//                              Armour and Weapons/Shield, use the next four  //
//                              toggles.) Remember that CREATURE SLOTTED      //
//                              items are NEVER moved anyway.                 //
//                                                                            //
//  int nCopyArmour  =  TRUE    This will use the TAG to guess the ResRef for //
//                              creating a copy of the Armour the creature or //
//                              NPC is wearing. If you do not want to use     //
//                              this function, you may want to consider the   //
//                              next one (nMoveArmour).                       //
//                                                                            //
//  int nMoveArmour  = FALSE    Setting this TRUE will just move the armour   //
//                              from the Chest Slot to the Lootable Corpse    //
//                              Object on death. This can be a visual issue   //
//                              when used with NPCs - since when the armour   //
//                              is moved, the NPC will become 'naked'.        //
//                                                                            //
//  *** If you do not wish to use either of the armour functions, just set    //
//      both values to FALSE. Then just add an additional suit of armour to   //
//      NPCs and creatures you want to have Drop their armour.                //
//                                                                            //
//  int nDropWeapons =  TRUE    This will use the TAG to guess the ResRef for //
//                              dropping the weapons on the ground - which is //
//                              accomplished by creating new ones on the      //
//                              ground and destroying the ones in the NPC's   //
//                              inventory.                                    //
//                                                                            //
//  int nMoveWeapons = FALSE    Setting this TRUE will just move the weapons  //
//                              to the Lootable Object just as the rest of    //
//                              inventory is handled.                         //
//                                                                            //
//  *** If you do not wish to use either of the weapon functions, just set    //
//      both values to FALSE. Then just add additional weapons or a shield to //
//      NPCs and creatures you want to have Drop those items.                 //
//                                                                            //
//  int nUseBlood =     TRUE    Set this to TRUE if you want a Bloodspot to   //
//                              appear under the corpse for a little extra    //
//                              gory appeal.                                  //
//                                                                            //
//  int nCorpseFade =   0120    This is the delay in actual seconds that the  //
//                              corpse will remain before is fades. If you    //
//                              set this to 0 (zero) it will turn off the     //
//                              corpse fade - allowing all bodies and loot    //
//                              to remain indefinitely.                       //
//                                                                            //
//  int nKeepEmpties =  TRUE    Set this to FALSE if you want EMPTY corpses   //
//                              to fade immediately after their invenotry is  //
//                              emptied.                                      //
//                                                                            //
//  int nOverrideForPlacedCorpses = TRUE    Set this to TRUE if you want the  //
//                                          'Spawned Corpses' you place to be //
//                                          permament. Setting it to FALSE    //
//                                          will cause your Placed Dead       //
//                                          creatures to act as the settings  //
//                                          above dictate. (i.e. Fading Out   //
//                                          after the delay or being emptied) //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


/*******************************************************************************
 ** This script was borrowed from the Hard Core Ruleset, where they use it to **
 ** move a Dead PC's inventory to a lootable corpse object. Credit where      **
 ** credit is due, I always say. :)                                           **
 *******************************************************************************/
void strip_equiped(object oDeadNPC, object oLootCorpse, object oEquip)
{
    if(GetIsObjectValid(oEquip))
    {
        AssignCommand(oLootCorpse, ActionTakeItem(oEquip, oDeadNPC));
    }
}

/*******************************************************************************
 ** SPECIAL THANKS TO DREZDAR AND MOJO for their help in getting these two    **
 ** drop weapon scripts written. I never would have gotten the vectors right, **
 ** but THEY sure did!                                                        **
 *******************************************************************************/
void DropLeftWeapon(object oDeadNPC)
{
    object oLeftWpn = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDeadNPC);

    if(FindSubString(GetTag(oLeftWpn),"NW_IT_CRE")>-1)
    {
        DestroyObject(oLeftWpn);
        return;
    }
    if(GetIsObjectValid(oLeftWpn))
    {
        vector vCorpseLoc = GetPositionFromLocation(GetLocation(oDeadNPC));
        float fDifferential = 45.0f + IntToFloat(d20());
        float fDistance = 0.5f + (IntToFloat(d10())/10);
        float fVarWpnFace = -20.0f - IntToFloat(d20(2));
        float fFacing = GetFacing(oDeadNPC);
        fFacing = fFacing + fDifferential;
        if (fFacing > 360.0f)
        {   fFacing = 720.0f - fFacing; }
        if (fFacing < 0.0f)
        {   fFacing = 360.0f + fFacing; }
        float fWpnFacing = GetFacing(oDeadNPC) + fVarWpnFace;
        object oArea = GetArea(oDeadNPC);
        //Generate New Location
        float fNewX;
        float fNewY;
        float fNewZ;
        if ((fFacing > 0.0f) && (fFacing < 90.0f))
        {   fNewX = vCorpseLoc.x + ((cos(fFacing))*fDistance); fNewY = vCorpseLoc.y + ((sin(fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
        else if ((fFacing > 90.0f) && (fFacing < 180.0f))
        {   fNewX = vCorpseLoc.x - ((cos(180.0f - fFacing))*fDistance); fNewY = vCorpseLoc.y + ((sin(180.0f - fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
        else if ((fFacing > 180.0f) && (fFacing < 270.0f))
        {   fNewX = vCorpseLoc.x - ((cos(fFacing - 180.0f))*fDistance); fNewY = vCorpseLoc.y - ((sin(fFacing - 180.0f))*fDistance); fNewZ = vCorpseLoc.z; }
        else if ((fFacing > 270.0f) && (fFacing < 360.0f))
        {   fNewX = vCorpseLoc.x + ((cos(360.0f - fFacing))*fDistance); fNewY = vCorpseLoc.y - ((sin(360.0f - fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
        else if (fFacing == 0.0f)
        {   fNewX = vCorpseLoc.x + fDistance; fNewY = vCorpseLoc.y; fNewZ = vCorpseLoc.z; }
        else if (fFacing == 90.0f)
        {   fNewX = vCorpseLoc.x; fNewY = vCorpseLoc.y + fDistance; fNewZ = vCorpseLoc.z; }
        else if (fFacing == 180.0f)
        {   fNewX = vCorpseLoc.x - fDistance; fNewY = vCorpseLoc.y; fNewZ = vCorpseLoc.z; }
        else if (fFacing == 270.0f)
        {   fNewX = vCorpseLoc.x; fNewY = vCorpseLoc.y - fDistance; fNewZ = vCorpseLoc.z; }
        vector vNewFinal = Vector(fNewX, fNewY, fNewZ);
        location lDropLeft = Location(oArea, vNewFinal, fFacing);
        //Drop Weapon
        string sLeftWpnTag = GetStringLeft(GetTag(oLeftWpn), 16);
        DestroyObject(oLeftWpn);
        object oLeftWpn = CreateObject(OBJECT_TYPE_ITEM, sLeftWpnTag, lDropLeft, FALSE);
        AssignCommand(oLeftWpn, SetFacing(fWpnFacing));
        SetLocalObject(oDeadNPC, "oLeftWpn", oLeftWpn);
    }
}
//
void DropRightWeapon(object oDeadNPC)
{
    object oRightWpn = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDeadNPC);

    if(FindSubString(GetTag(oRightWpn),"NW_IT_CRE")>-1)
    {
        DestroyObject(oRightWpn);
        return;
    }
    if(GetIsObjectValid(oRightWpn))
    {
        vector vCorpseLoc = GetPositionFromLocation(GetLocation(oDeadNPC));
        float fDifferential = -45.0f + IntToFloat(d20());
        float fDistance = 0.5f + (IntToFloat(d10())/10);
        float fVarWpnFace = 20.0f - IntToFloat(d20(2));
        float fFacing = GetFacing(oDeadNPC);
        fFacing = fFacing + fDifferential;
        if (fFacing > 360.0f)
        {   fFacing = 720.0f - fFacing; }
        if (fFacing < 0.0f)
        {   fFacing = 360.0f + fFacing; }
        float fWpnFacing = GetFacing(oDeadNPC) + fVarWpnFace;
        object oArea = GetArea(oDeadNPC);
        //Generate New Location
        float fNewX;
        float fNewY;
        float fNewZ;
        if ((fFacing > 0.0f) && (fFacing < 90.0f))
        {   fNewX = vCorpseLoc.x + ((cos(fFacing))*fDistance); fNewY = vCorpseLoc.y + ((sin(fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
        else if ((fFacing > 90.0f) && (fFacing < 180.0f))
        {   fNewX = vCorpseLoc.x - ((cos(180.0f - fFacing))*fDistance); fNewY = vCorpseLoc.y + ((sin(180.0f - fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
        else if ((fFacing > 180.0f) && (fFacing < 270.0f))
        {   fNewX = vCorpseLoc.x - ((cos(fFacing - 180.0f))*fDistance); fNewY = vCorpseLoc.y - ((sin(fFacing - 180.0f))*fDistance); fNewZ = vCorpseLoc.z; }
        else if ((fFacing > 270.0f) && (fFacing < 360.0f))
        {   fNewX = vCorpseLoc.x + ((cos(360.0f - fFacing))*fDistance); fNewY = vCorpseLoc.y - ((sin(360.0f - fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
        else if (fFacing == 0.0f)
        {   fNewX = vCorpseLoc.x + fDistance; fNewY = vCorpseLoc.y; fNewZ = vCorpseLoc.z; }
        else if (fFacing == 90.0f)
        {   fNewX = vCorpseLoc.x; fNewY = vCorpseLoc.y + fDistance; fNewZ = vCorpseLoc.z; }
        else if (fFacing == 180.0f)
        {   fNewX = vCorpseLoc.x - fDistance; fNewY = vCorpseLoc.y; fNewZ = vCorpseLoc.z; }
        else if (fFacing == 270.0f)
        {   fNewX = vCorpseLoc.x; fNewY = vCorpseLoc.y - fDistance; fNewZ = vCorpseLoc.z; }
        vector vNewFinal = Vector(fNewX, fNewY, fNewZ);
        location lDropRight = Location(oArea, vNewFinal, fFacing);
        //Drop Weapon
        string sRightWpnTag = GetStringLeft(GetTag(oRightWpn), 16);
        DestroyObject(oRightWpn);
        object oRightWpn = CreateObject(OBJECT_TYPE_ITEM, sRightWpnTag, lDropRight, FALSE);
        AssignCommand(oRightWpn, SetFacing(fWpnFacing));
        SetLocalObject(oDeadNPC, "oRightWpn", oRightWpn);
    }
}

/*******************************************************************************
 ** This script checks to see if the weapons are still unclaimed. If it finds **
 ** that they are not possessed by someone, it issues the DestroyObjects to   **
 ** eliminate them.                                                           **
 *******************************************************************************/
void DestroyWeapons(object oCorpse)
{
    //Check to see if a PC Possesses the Left Weapon
    object oLeftWpn = GetLocalObject(oCorpse, "oLeftWpn");
    object oLeftTest = GetItemPossessor(oLeftWpn);
    if (oLeftTest == OBJECT_INVALID) DestroyObject(oLeftWpn);
    //Check to see if a PC Possesses the Right Weapon
    object oRightWpn = GetLocalObject(oCorpse, "oRightWpn");
    object oRightTest = GetItemPossessor(oRightWpn);
    if (oRightTest == OBJECT_INVALID) DestroyObject(oRightWpn);
}

/*******************************************************************************
 ** This script is derived from the one above borrowed from the Hard Core     **
 ** Ruleset. It sweeps an objects inventory (all but Creature Slots, which    **
 ** have no bearing here) so that when the object is destroyed no Lootbags    **
 ** are left behind to litter up the landscape & devour system resources.     **
 *******************************************************************************/
void ClearInventory(object oCorpse)
{
    int nAmtGold = GetGold(oCorpse); //Get any gold from the dead creature
    if(nAmtGold) TakeGoldFromCreature(nAmtGold, oCorpse, TRUE);
    //Get any loot the dead creature has equipped - thanks again to the HCR for strip-equiped
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARMS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARROWS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BELT, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOLTS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOOTS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BULLETS, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CLOAK, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_NECK, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCorpse));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oCorpse));
    //Get the remaining loot from the dead creature and move it to the lootable object
    object oLootEQ = GetFirstItemInInventory(oCorpse);
    while(GetIsObjectValid(oLootEQ))
    {
        DestroyObject(oLootEQ);
        oLootEQ = GetNextItemInInventory(oCorpse);
    }
}

void LeaveCorpse()
{
    //SET YOUR ARMOUR, WEAPONS/SHIELD, BLOOD, CORPSE FADE, KEEP EMPTY, AND SPAWNED DEAD OVERRIDE PREFERENCES HERE ///////////////
    //                                                                                                                         //
    int nUseLootable =   TRUE;             // Set this to FALSE if you want disable the lootable corpse functionality          //
    int nMoveEquipped =  TRUE;             // Set this to FALSE if you don't want to move Equipped items to the corpse         //
    int nCopyArmour  =  FALSE;             // This will use the TAG to guess the ResRef for creating a copy of the Armour      //
    int nMoveArmour  =   TRUE;             // Setting this TRUE will just move the armour from the Chest Slot                  //
    int nDropWeapons =  FALSE;             // This will use the TAG to guess the ResRef for dropping the weapons on the ground //
    int nMoveWeapons =   TRUE;             // Setting this TRUE will just move the weapons to the Lootable Object              //
    int nUseBlood =      TRUE;             // Set this to TRUE if you want a Bloodspot to appear under the corpse              //
    int nCorpseFade =    0120;             // Set this to 0 (ZERO) if you DO NOT want the corpses to fade                      //
    int nKeepEmpties =   TRUE;             // Set this to FALSE if you want EMPTY corpses to fade immediately                  //
    int nOverrideForPlacedCorpses =  TRUE; // Set this to TRUE if you want the 'Spawned Corpses' you                           //
    //                                     // place to be permament. Setting it to FALSE will cause                            //
    //                                     // your Placed Dead creatures to act as the settings above dictate.                 //
    //                                                                                                                         //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //ALTER THE FOLLOWING AT YOUR OWN RISK :)
    object oDeadNPC = OBJECT_SELF; //Get the Dead Creature Object
    string sBaseTag = GetTag(oDeadNPC); //Get that TAG of the dead creature
    string sPrefix = GetStringLeft(sBaseTag, 4); //Look for Dead Prefix

    if(GetLocalInt(oDeadNPC,"NORMALCORPSE")) return;

    /* Use the system only for Mobs speciall tagged. */
    if ( GetStringUpperCase(GetStringLeft(sBaseTag,4)) != "DROP"
      && GetStringUpperCase(GetStringRight(sBaseTag,4)) != "DROP" )
    return;

    if(nUseLootable) //If False, do nothing
    {
        location lCorpseLoc = GetLocation(oDeadNPC); //Set the spawnpoint for our lootable object

        //Do 'spawned corpse' if desired
        if (sPrefix == "Dead")
        {
            if (nOverrideForPlacedCorpses)
            {
                nKeepEmpties = TRUE; //Set 'Spawned Dead' corpses to Keep Empties
                nCorpseFade = 0; //Disable Corpse Fade for 'Spawned Dead' corpses
            }
        }

        SetIsDestroyable(FALSE,TRUE,FALSE); //Protect our corpse from decaying
        object oCorpseBlood;
        if (GetRacialType(oDeadNPC) != RACIAL_TYPE_UNDEAD) //Check to see if our NPC is Undead, if not, do Bloodspot Routine
        {
            if (nUseBlood)
            {
                oCorpseBlood = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", lCorpseLoc, FALSE); //Spawn some blood for effect (if nUseBlood == TRUE)
            }
        }
        object oLootCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "invis_corpse_obj", lCorpseLoc, FALSE); //Spawn our lootable object
        SetLocalObject(oLootCorpse, "oHostBody", oDeadNPC); //Set Local for deletion later if needed
        SetLocalObject(oLootCorpse, "oBloodSpot", oCorpseBlood); //Set Local for deletion later if needed
        SetLocalInt(oLootCorpse, "oKeepEmpty", nKeepEmpties); //Set Local for deletion later if needed

        //Get DEAD CREATURE'S INVENTORY
        int nAmtGold = GetGold(oDeadNPC); //Get any gold from the dead creature
        if(nAmtGold)
        {
            object oGold = CreateItemOnObject("nw_it_gold001", oLootCorpse, nAmtGold);
            AssignCommand(oLootCorpse,TakeGoldFromCreature(nAmtGold,oDeadNPC,TRUE));
        }
        if (nMoveEquipped)
        {
            //Get any loot the dead creature has equipped - thanks again to the HCR for strip-equiped
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_ARMS, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_ARROWS, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_BELT, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_BOLTS, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_BOOTS, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_BULLETS, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_CLOAK, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_HEAD, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_LEFTRING, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_NECK, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oDeadNPC));
        }
        //Handle Weapons
        if (nDropWeapons)
        {
            //Drop Weapons
            DropLeftWeapon(oDeadNPC);
            object oCLWpn = GetLocalObject(oDeadNPC, "oLeftWpn");
            SetLocalObject(oLootCorpse, "oLeftWpn", oCLWpn);
            DropRightWeapon(oDeadNPC);
            object oCRWpn = GetLocalObject(oDeadNPC, "oRightWpn");
            SetLocalObject(oLootCorpse, "oRightWpn", oCRWpn);
        }
        if (nMoveWeapons)
        {
            //Move Weapons
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDeadNPC));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDeadNPC));
        }

        //Handle Armour
        if(nMoveArmour)
        {
        SendMessageToAllDMs(GetTag(GetItemInSlot(INVENTORY_SLOT_CHEST, oDeadNPC)));
        SendMessageToAllDMs("Arm: "+IntToString(FindSubString(GetTag(GetItemInSlot(INVENTORY_SLOT_CHEST, oDeadNPC)),"NW_IT_CRE")));
            strip_equiped(oDeadNPC, oLootCorpse, GetItemInSlot(INVENTORY_SLOT_CHEST, oDeadNPC));
        }

        if(nCopyArmour)
        {
            object oArmour = GetItemInSlot(INVENTORY_SLOT_CHEST, oDeadNPC);
            string sArmourTag = GetStringLeft(GetTag(oArmour), 16);
            if(FindSubString(sArmourTag,"NW_IT_CRE")>-1)
            {
                DestroyObject(oArmour);
            }
            else
            {
                object oLootArmour = CreateItemOnObject(sArmourTag, oLootCorpse);
                SetLocalObject(oLootCorpse, "oOrigArmour", oArmour);
                SetLocalObject(oLootCorpse, "oLootArmour", oLootArmour);
            }
        }
        //Get the remaining loot from the dead creature and move it to the lootable object
        object oLootEQ = GetFirstItemInInventory(oDeadNPC);
        while(GetIsObjectValid(oLootEQ))
        {
            if(FindSubString(GetTag(oLootEQ),"NW_IT_CRE")>-1)
            {
                DestroyObject(oLootEQ);
                oLootEQ=GetNextItemInInventory(oDeadNPC);
                continue;
            }
            AssignCommand(oLootCorpse, ActionTakeItem(oLootEQ, oDeadNPC));
            oLootEQ = GetNextItemInInventory(oDeadNPC);
        }

        //Do Corpse Fade out after specified delay (unless flagged 0)
        if (nCorpseFade > 0)
        {
            float fCorpseFade = IntToFloat(nCorpseFade);
            ActionWait(fCorpseFade);
            DelayCommand(fCorpseFade, ClearInventory(oLootCorpse));
            DelayCommand(fCorpseFade, ClearInventory(oDeadNPC));
            DelayCommand(fCorpseFade, DestroyObject(oLootCorpse));
            DelayCommand(fCorpseFade, DestroyObject(oCorpseBlood));
            DelayCommand(fCorpseFade, DestroyWeapons(oDeadNPC));
            DelayCommand(fCorpseFade + 1.0f, SetIsDestroyable(TRUE,TRUE,FALSE));
            DelayCommand(fCorpseFade + 1.5f, DestroyObject(oDeadNPC));
        }
    }
}

