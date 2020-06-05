void main()
{
     object firstbate;
     object oItem;
     object oPC = OBJECT_SELF;
     object fish_hole = GetNearestObjectByTag("fishing_hole", oPC, 1);
     float distance = GetDistanceBetween(oPC, fish_hole);
     int distanceInt = FloatToInt(distance);
     int rand = d20(1)+20;
     float RANDfloat = IntToFloat(rand);

     SetLocalInt(oPC, "firstbait", 0);
     SetLocalInt(oPC, "baitstate", 0);

if(fish_hole == OBJECT_INVALID)
{
    AssignCommand(oPC, ActionSpeakString("This doesnt look like a good place to fish."));
    return;
}

  if(GetLocalInt(oPC, "fishstate") != 1)
  {
    //checks to see if youre in casting range
    if(distanceInt < 8)
    {
     DelayCommand(2.1, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 2.0) ));
     DelayCommand(5.1, AssignCommand(oPC, ActionPlayAnimation(7, 1.0, RANDfloat-4) ));

     DelayCommand(2.6, PlaySound("it_whip"));
     DelayCommand(3.0, PlaySound("as_na_splash1"));
     //DelayCommand(5.2, PlaySound("cb_whirlwind"));
     //DelayCommand(7.2, PlaySound("cb_sw_whip1"));
     //DelayCommand(9.2, PlaySound("cb_sw_whip2"));




      int randomnum = d100(1);

       //string randstring = IntToString(randomnum);
      //AssignCommand(oPC, ActionSpeakString(randstring));

       oItem = GetFirstItemInInventory(oPC);
        //checks your inv for bate
        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == "LiveBaitFishing")
            {
              if((GetLocalInt(oPC, "baitstate") == 0))
               {
                  SetLocalInt(oPC, "baitstate", 1);
               }
            }
            if (GetTag(oItem) == "_fishing_item09")
            {
               if(!(GetLocalInt(oPC, "baitstate") > 1))
               {
                  SetLocalInt(oPC, "baitstate", 2);
               }
            }
            if (GetTag(oItem) == "_fishing_item10")
            {
              SetLocalInt(oPC, "baitstate", 3);
            }

            oItem = GetNextItemInInventory(oPC);
         }

         //sets chance you catch something based on the bate you use
        if(GetLocalInt(oPC, "baitstate") == 3)
        {
            DelayCommand(RANDfloat - 0.2, PlaySound("as_na_splash2"));
            DelayCommand(RANDfloat, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.5) ));
            AssignCommand(oPC, ActionSpeakString("*Uses expensive lure.*"));
            DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));

           if(randomnum > 49)
           {
                DelayCommand(RANDfloat - 1, PlaySound("as_na_splash2"));
                DelayCommand(RANDfloat-2, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.7) ));
                DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
                DelayCommand(RANDfloat+5, ExecuteScript("_fishing_pole_02", oPC));
                DelayCommand(RANDfloat+1, SetLocalInt(oPC, "fishstate",0));
                return;
           }
            oItem = GetFirstItemInInventory(oPC);
           if(d100(1) == 100)
                {
                    oItem = GetFirstItemInInventory(oPC);

                    while (!(oItem == OBJECT_INVALID))
                    {
                        if (GetTag(oItem) == "_fishing_item10")
                        {
                            DelayCommand(RANDfloat+2, DestroyObject(oItem));
                            DelayCommand(RANDfloat+0.5, AssignCommand(oPC, ActionSpeakString("*The lure becomes snaged when you try to reel it in and the line breaks.*")));
                            break;
                        }
                        oItem = GetNextItemInInventory(oPC);
                    }
                }
        }

        if(GetLocalInt(oPC, "baitstate") == 2)
        {
            DelayCommand(RANDfloat - 0.2, PlaySound("as_na_splash2"));
            DelayCommand(RANDfloat, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.5) ));
            AssignCommand(oPC, ActionSpeakString("*Uses fly.*"));
            DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));

           if(randomnum > 74)
           {
                DelayCommand(RANDfloat - 1, PlaySound("as_na_splash2"));
                DelayCommand(RANDfloat-2, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.7) ));
               DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
               DelayCommand(RANDfloat+5, ExecuteScript("_fishing_pole_02", oPC));
               DelayCommand(RANDfloat+1, SetLocalInt(oPC, "fishstate",0));
                return;
           }
            oItem = GetFirstItemInInventory(oPC);
           if(d20(3) == 60)
             {
                oItem = GetFirstItemInInventory(oPC);

                while (!(oItem == OBJECT_INVALID))
                {
                    if (GetTag(oItem) == "_fishing_item09")
                    {
                        DelayCommand(0.01, DestroyObject(oItem));
                        DelayCommand(RANDfloat+0.5, AssignCommand(oPC, ActionSpeakString("*The lure becomes snaged when you try to reel it in and the line breaks.*")));
                        break;
                    }
                    oItem = GetNextItemInInventory(oPC);
                }
             }
        }
        //uses charges
        if(GetLocalInt(oPC, "baitstate") == 1)
        {
            DelayCommand(RANDfloat - 0.2, PlaySound("as_na_splash2"));
            DelayCommand(RANDfloat, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.5) ));
            AssignCommand(oPC, ActionSpeakString("*Uses live bait.*"));
            DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));

             oItem = GetFirstItemInInventory(oPC);
            //checks your inv for bate
            while (!(oItem == OBJECT_INVALID))
            {   // string bob = GetTag(oItem);
                  //DelayCommand(1.02, AssignCommand(oPC, ActionSpeakString(bob)));
                 if(GetTag(oItem) == "LiveBaitFishing")
                 {
                    int charges = GetItemCharges(oItem);
                    if(charges == 1)
                    {
                      DelayCommand(1.3, AssignCommand(oPC, ActionSpeakString("*Empties bait jar.*")));
                    }
                    int newcharges = charges - 1;
                    DelayCommand(0.03, SetItemCharges(oItem, newcharges));
                    break;
                 }
                    oItem = GetNextItemInInventory(oPC);
            }

           if(randomnum > 87)
           {
                 DelayCommand(RANDfloat - 1, PlaySound("as_na_splash2"));
                 DelayCommand(RANDfloat-2, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.7) ));
                DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
                DelayCommand(RANDfloat+5, ExecuteScript("_fishing_pole_02", oPC));
                DelayCommand(RANDfloat+1, SetLocalInt(oPC, "fishstate",0));
                return;
           }
        }

        if(GetLocalInt(oPC, "baitstate") == 0)
        {
           DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));

           if(randomnum > 93)
           {
                DelayCommand(RANDfloat - 1, PlaySound("as_na_splash2"));
                DelayCommand(RANDfloat-2, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.7) ));
               DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
               DelayCommand(RANDfloat+5, ExecuteScript("_fishing_pole_02", oPC));
               DelayCommand(RANDfloat+1, SetLocalInt(oPC, "fishstate",0));
               return;
           }
        }


         DelayCommand(RANDfloat - 1, PlaySound("as_na_splash2"));
         DelayCommand(RANDfloat-2, AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 0.7) ));
         DelayCommand(RANDfloat-3.1, AssignCommand(oPC, ActionSpeakString("*Not even a nibble.*")));
         DelayCommand(RANDfloat-1.1, AssignCommand(oPC, ActionSpeakString("*Reels in line.*")));
         DelayCommand(RANDfloat+1, SetLocalInt(oPC, "fishstate",0));
         return;
    }

    AssignCommand(oPC, ActionSpeakString("This doesnt look like a good place to fish."));
  }
}
