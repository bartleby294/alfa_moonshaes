#include "acr_horse_i2"

int MoonshaesCustom(object oPC)
{
   //object  oPC = OBJECT_SELF;
   object oItem = GetItemActivated();

   //regular tent
   if(GetTag(oItem) == "Tent")
   {
        ExecuteScript("_place_tent_01", oPC);
        return TRUE;
   }
    //stool
    if(GetTag(oItem) == "PortableChair01")
   {
        ExecuteScript("_place_stool_04", oPC);
        return TRUE;
   }
   // candle
   if(GetTag(oItem) == "placecandle01i")
   {
     ExecuteScript("_place_candle_01", oPC);
     return TRUE;
   }
   //small tent
   if(GetTag(oItem) == "smuseabletenti")
   {
     ExecuteScript("_place_smtent_01", oPC);
     return TRUE;
   }
    //large tent
    if(GetTag(oItem) == "lguseabletenti")
   {
     ExecuteScript("_place_lgtent_01", oPC);
     return TRUE;
   }
   //drum
   if(GetTag(oItem) == "usabledrumi")
   {
     ExecuteScript("_place_drum_01", oPC);
     return TRUE;
   }
   //book
   if(GetTag(oItem) == "placebooki")
   {
     ExecuteScript("_place_book_01", oPC);
     return TRUE;
   }
   //Archery target
   if(GetTag(oItem) == "placetargeti")
   {
     ExecuteScript("_place_target_01", oPC);
     return TRUE;
   }
   //candle
   if(GetTag(oItem) == "placecandle02i")
   {
     ExecuteScript("_place_candl2_01", oPC);
     return TRUE;
   }
   //shovel
      if(GetTag(oItem) == "workingshovel")
   {
     ExecuteScript("_place_shovel_01", oPC);
     return TRUE;
   }
   //torch rag
   if(GetTag(oItem) == "Rag")
   {
        if( GetItemPossessedBy(oPC, "_walking_stick") != OBJECT_INVALID )
        {
            ExecuteScript("_h_crude_torch", oPC);
            return TRUE;
        }
   }
   //walking stick
   if(GetTag(oItem) == "_walking_stick")
   {
        if( GetItemPossessedBy(oPC, "Rag") != OBJECT_INVALID )
        {
            ExecuteScript("_h_crude_torch", oPC);
            return TRUE;
        }
   }
   //fishing pole 1
   if(GetTag(oItem) == "_fishing_pole")
   {
            ExecuteScript("_fishing_pole_01", oPC);
            return TRUE;
   }

   //fishing pole 2
   if(GetTag(oItem) == "_fishing_pole_02")
   {
     ExecuteScript("_fishing_pole_1b", oPC);
     return TRUE;
   }

   //fishing items
   if(GetTag(oItem) == "_fishing_item02" || GetTag(oItem) == "_fishing_item03" || GetTag(oItem) == "_fishing_item04" ||
         GetTag(oItem) == "_fishing_item05" || GetTag(oItem) == "_fishing_item06" || GetTag(oItem) == "_fishing_item07" ||
         GetTag(oItem) == "_fishing_item14")
   {
     ExecuteScript("_fishing_pole_03", oPC);
     return TRUE;
   }

   if(GetTag(oItem) == "_Beta_Rod_of_Recall")
   {
        AssignCommand(oPC, ActionJumpToObject(GetObjectByTag("BETA_RECALL01"), TRUE));
        return TRUE;
   }
   // DM Control Stone
   if(GetTag(oItem) == "dmcontrolstone" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmcontrolst", oPC);
        return TRUE;
   }

   // DM Bat Bom
   if(GetTag(oItem) == "dmbatsignal1" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsig1", oPC);
        return TRUE;
   }

   // DM Bat Spawn
   if(GetTag(oItem) == "dmbatsignal2" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsig2", oPC);
        return TRUE;
   }

   // DM Fledgling Bat Spawn
   if(GetTag(oItem) == "dmbatsignal3" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsig3", oPC);
        return TRUE;
   }

   // DM Rabid Bat Spawn
   if(GetTag(oItem) == "dmbatsignal4" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsig4", oPC);
        return TRUE;
   }

   // DM Corrupted Bat Spawn
   if(GetTag(oItem) == "dmbatsignal5" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsig5", oPC);
        return TRUE;
   }

   // DM Corrupted Bat Spawn
   if(GetTag(oItem) == "dmbatsounds1" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsnd5", oPC);
        return TRUE;
   }

   if(GetTag(oItem) == "healingsalve") {
        object oTarget = GetItemActivatedTarget();

        if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE) {
            FloatingTextStringOnCreature(
                "You can only apply the healing salve on a creature.",
                oPC, FALSE);
        }else if(oTarget == oPC) {
            FloatingTextStringOnCreature(
                "You can't apply the healing salve on yourself.",
                oPC, FALSE);
        } else if((GetDistanceBetween(oPC, oTarget) <= 3.0)) {
            FloatingTextStringOnCreature("You apply the healing salve.",
                                         oPC, TRUE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(d8()),
                                oTarget);
            int stackSize = GetItemStackSize(oItem);
            if(stackSize > 1) {
                SetItemStackSize(oItem, GetItemStackSize(oItem) - 1);
            } else {
                SetItemCharges(oItem, 0);
            }
        } else {
            FloatingTextStringOnCreature("You're too far away.", oPC, FALSE);
        }
        return TRUE;
    }


   //EG's love letter quest item (letter) - N.B. BART'S INTENTION IS TO EXPAND THIS
   //TO AUTOMATICALLY LINK CONVERSATIONS TO ITEMS VIA TAG
   if(GetTag(oItem) == "ElsworthsLoveLetter")
   {
       ExecuteScript("dlg_elswrth_ltr0", GetItemActivator());
       return TRUE;
   }

    if(GetTag(oItem) == "acr_horse_bridle") {
        FloatingTextStringOnCreature("FOUND A HORSE!!!", oPC, FALSE);
        ALFA_OnActivateHorseItem2();
        return TRUE;
    }

   if(GetTag(oItem) == "sahraskiss") {
        //ActionCastSpellAtObject(SPELL_NEUTRALIZE_POISON, oPC,
        //                        METAMAGIC_ANY, FALSE, 0,
        //                        PROJECTILE_PATH_TYPE_DEFAULT, TRUE);

        effect eCheck = GetFirstEffect(oPC);
        while(GetIsEffectValid(eCheck)) {
            if(GetEffectType(eCheck) == EFFECT_TYPE_POISON){
                RemoveEffect(oPC, eCheck);
                break;
            }
            eCheck = GetNextEffect(oPC);
        }

        return TRUE;
   }

    return FALSE;
}
