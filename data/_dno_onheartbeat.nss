void main()
{
    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");
     object oArea = GetArea(VarStore1);
     object Bob = GetObjectByTag("bob");
      int DayTrack = MusicBackgroundGetDayTrack(oArea);
       int NightTrack = MusicBackgroundGetNightTrack(oArea);

  if( GetLocalInt(VarStore1, "Siningon") == 0)
  {
    AssignCommand(Bob, ActionSpeakString("ran"));

    if(GetIsDay())
    {
        if(GetLocalInt(VarStore1, "WasNightorDay") == 2)
        {
            MusicBackgroundChangeDay(oArea, NightTrack);
            MusicBackgroundChangeNight(oArea, DayTrack);
            AssignCommand(Bob, ActionSpeakString("changed val to dno night to day"));

        }
        SetLocalInt(VarStore1, "WasNightorDay",1);

    }

    if(GetIsNight())
    {
        if(GetLocalInt(VarStore1, "WasNightorDay") == 1)
        {
            MusicBackgroundChangeDay(oArea, NightTrack);
            MusicBackgroundChangeNight(oArea, DayTrack);
            AssignCommand(Bob, ActionSpeakString("changed val to dno day to night"));
        }
         SetLocalInt(VarStore1, "WasNightorDay",2);
    }


   if(GetIsDusk())
   {
     if(GetLocalInt(VarStore1, "WasNightorDay") == 1)
        {
            MusicBackgroundChangeDay(oArea, NightTrack);
            MusicBackgroundChangeNight(oArea, DayTrack);
            AssignCommand(Bob, ActionSpeakString("changed val to dno day to night dusk"));
        }
         SetLocalInt(VarStore1, "WasNightorDay",2);
   }

   if(GetIsDawn())
   {
     if(GetLocalInt(VarStore1, "WasNightorDay") == 2)
        {
            MusicBackgroundChangeDay(oArea, NightTrack);
            MusicBackgroundChangeNight(oArea, DayTrack);
            AssignCommand(Bob, ActionSpeakString("changed val to dno night to day dawn"));
        }
        SetLocalInt(VarStore1, "WasNightorDay",1);
   }
 }

}
