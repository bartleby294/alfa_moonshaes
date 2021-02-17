void MoonshaesCustom(object oPC)
{
   //object  oPC = OBJECT_SELF;
   object oItem = GetItemActivated();

   //regular tent
   if(GetTag(oItem) == "Tent")
   {
        ExecuteScript("_place_tent_01", oPC);
   }
    //stool
    if(GetTag(oItem) == "PortableChair01")
   {
        ExecuteScript("_place_stool_04", oPC);
   }
   // candle
   if(GetTag(oItem) == "placecandle01i")
   {
     ExecuteScript("_place_candle_01", oPC);
   }
   //small tent
   if(GetTag(oItem) == "smuseabletenti")
   {
     ExecuteScript("_place_smtent_01", oPC);
   }
    //large tent
    if(GetTag(oItem) == "lguseabletenti")
   {
     ExecuteScript("_place_lgtent_01", oPC);
   }
   //drum
   if(GetTag(oItem) == "usabledrumi")
   {
     ExecuteScript("_place_drum_01", oPC);
   }
   //book
   if(GetTag(oItem) == "placebooki")
   {
     ExecuteScript("_place_book_01", oPC);
   }
   //Archery target
   if(GetTag(oItem) == "placetargeti")
   {
     ExecuteScript("_place_target_01", oPC);
   }
   //candle
   if(GetTag(oItem) == "placecandle02i")
   {
     ExecuteScript("_place_candl2_01", oPC);
   }
   //shovel
      if(GetTag(oItem) == "workingshovel")
   {
     ExecuteScript("_place_shovel_01", oPC);
   }
   //torch rag
   if(GetTag(oItem) == "Rag")
   {
        if( GetItemPossessedBy(oPC, "_walking_stick") != OBJECT_INVALID )
        {
            ExecuteScript("_h_crude_torch", oPC);
        }
   }
   //walking stick
   if(GetTag(oItem) == "_walking_stick")
   {
        if( GetItemPossessedBy(oPC, "Rag") != OBJECT_INVALID )
        {
            ExecuteScript("_h_crude_torch", oPC);
        }
   }
   //fishing pole 1
   if(GetTag(oItem) == "_fishing_pole")
   {
            ExecuteScript("_fishing_pole_01", oPC);
   }

   //fishing pole 2
   if(GetTag(oItem) == "_fishing_pole_02")
   {
     ExecuteScript("_fishing_pole_1b", oPC);
   }

   //fishing items
   if(GetTag(oItem) == "_fishing_item02" || GetTag(oItem) == "_fishing_item03" || GetTag(oItem) == "_fishing_item04" ||
         GetTag(oItem) == "_fishing_item05" || GetTag(oItem) == "_fishing_item06" || GetTag(oItem) == "_fishing_item07" ||
         GetTag(oItem) == "_fishing_item14")
   {
     ExecuteScript("_fishing_pole_03", oPC);
   }

   if(GetTag(oItem) == "_Beta_Rod_of_Recall")
   {
        AssignCommand(oPC, ActionJumpToObject(GetObjectByTag("BETA_RECALL01"), TRUE));
   }
   // DM Control Stone
   if(GetTag(oItem) == "dmcontrolstone" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmcontrolst", oPC);
   }

   // DM Control Stone
   if(GetTag(oItem) == "dmbatsignal1" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsig1", oPC);
   }

   // DM Control Stone
   if(GetTag(oItem) == "dmbatsignal2" && GetIsDM(oPC))
   {
        ExecuteScript("_btb_dmbatsig2", oPC);
   }
}
