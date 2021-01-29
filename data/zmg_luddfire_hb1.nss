void main()
{
    //ExecuteScript("nw_c2_default1", OBJECT_SELF);

   if(GetLocalInt(OBJECT_SELF, "FireState01")==1)
   {
      int FireTime01 = GetLocalInt(OBJECT_SELF, "firetime01");

      if(FireTime01 > 50)
      {
         DestroyObject(GetLocalObject(OBJECT_SELF, "FireObject01"));

         object flamesound01 = GetNearestObjectByTag("FireLarge1");
         SoundObjectSetVolume(flamesound01, 0);

         SetLocalInt(OBJECT_SELF, "FireState01", 0);
         SetLocalInt(OBJECT_SELF, "firetime01", 0);
         return;
      }
      else
      {
        int FireTime01 = GetLocalInt(OBJECT_SELF, "firetime01");
        int FireTime02 = FireTime01 + 1;
        SetLocalInt(OBJECT_SELF, "firetime01", FireTime02);

        //AssignCommand(OBJECT_SELF, SpeakString(IntToString(FireTime)));
      }


   }
}
