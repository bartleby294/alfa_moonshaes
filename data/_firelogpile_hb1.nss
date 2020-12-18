void main()
{
    //ExecuteScript("nw_c2_default1", OBJECT_SELF);

   if(GetLocalInt(OBJECT_SELF, "FireState")==1)
   {
      int FireTime = GetLocalInt(OBJECT_SELF, "firetime");

      if(FireTime > 50)
      {
         DestroyObject(GetLocalObject(OBJECT_SELF, "FireObject"));

         object flamesound = GetNearestObjectByTag("FireLarge1");
         SoundObjectSetVolume(flamesound, 0);

         SetLocalInt(OBJECT_SELF, "FireState", 0);
         SetLocalInt(OBJECT_SELF, "firetime", 0);
         return;
      }
      else
      {
        int FireTime = GetLocalInt(OBJECT_SELF, "firetime");
        int FireTime2 = FireTime + 1;
        SetLocalInt(OBJECT_SELF, "firetime", FireTime2);

        //AssignCommand(OBJECT_SELF, SpeakString(IntToString(FireTime)));
      }


   }
}
