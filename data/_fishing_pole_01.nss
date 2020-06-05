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
    SetLocalInt(oPC, "fishstate", 1);
    //checks to see if youre in casting range
    if(distanceInt < 8)
    {
            DelayCommand(2.6, PlaySound("it_whip"));
             DelayCommand(3.0, PlaySound("as_na_splash1"));

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
        //SetLocalInt(oPC, "firstbait", 0);
        //sets chance you catch something based on the bate you use
        if(GetLocalInt(oPC, "baitstate") == 3)
        {
            AssignCommand(oPC, ActionSpeakString("*Uses expensive lure.*"));
            DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));
           if(randomnum > 49)
           {DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
                DelayCommand(RANDfloat + 0.02,ExecuteScript("_fishing_pole_02", oPC));
                SetLocalInt(oPC, "fishstate",0);
                return;
           }
              oItem = GetFirstItemInInventory(oPC);
                if(d100(1) == 100)
                {
                    while (!(oItem == OBJECT_INVALID))
                    {
                        if (GetTag(oItem) == "_fishing_item10")
                        {
                            DestroyObject(oItem);
                            DelayCommand(RANDfloat+0.5, AssignCommand(oPC, ActionSpeakString("*The lure becomes snaged when you try to reel it in and the line breaks.*")));
                            break;
                        }
                        oItem = GetNextItemInInventory(oPC);
                    }
                }
        }
        if(GetLocalInt(oPC, "baitstate") == 2)
        {
            AssignCommand(oPC, ActionSpeakString("*Uses fly.*"));
            DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));
           if(randomnum > 74)
           {
               DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
               DelayCommand(RANDfloat + 0.02, ExecuteScript("_fishing_pole_02", oPC));
               SetLocalInt(oPC, "fishstate",0);
                return;
           }
            if(d20(3) == 60)
             {
                while (!(oItem == OBJECT_INVALID))
                {
                    if (GetTag(oItem) == "_fishing_item09")
                    {
                        DestroyObject(oItem);
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
            AssignCommand(oPC, ActionSpeakString("*Uses live bait.*"));
            DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));
            oItem = GetFirstItemInInventory(oPC);
            //checks your inv for bate
            while (!(oItem == OBJECT_INVALID))
            {     //string bob = GetTag(oItem);
                  //AssignCommand(oPC, ActionSpeakString(bob));
                 if(GetTag(oItem) == "LiveBaitFishing")
                 {
                    int charges = GetItemCharges(oItem);
                    int newcharges = charges - 1;
                    SetItemCharges(oItem, newcharges);
                    break;
                 }
                    oItem = GetNextItemInInventory(oPC);
            }
           if(randomnum > 87)
           {
                DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
                DelayCommand(RANDfloat + 0.02, ExecuteScript("_fishing_pole_02", oPC));
                SetLocalInt(oPC, "fishstate",0);
                return;
           }
        }
        if(GetLocalInt(oPC, "baitstate") == 0)
        {
           DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("*Casts line.*")));
           if(randomnum > 93)
           {
               DelayCommand(RANDfloat-3, AssignCommand(oPC, ActionSpeakString("*You think you might have a nibble.*")));
               DelayCommand(RANDfloat + 0.02, ExecuteScript("_fishing_pole_02", oPC));
               SetLocalInt(oPC, "fishstate",0);
               return;
           }
        }
         DelayCommand(RANDfloat+2, SetLocalInt(oPC, "fishstate", 0));
         DelayCommand(RANDfloat, AssignCommand(oPC, ActionSpeakString("*Not even a nibble.*")));
         return;
    }
    AssignCommand(oPC, ActionSpeakString("This doesnt look like a good place to fish."));
    SetLocalInt(oPC, "fishstate",0);
  }
}
