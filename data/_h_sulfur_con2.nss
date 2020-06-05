void main()
{
   object oPC =GetLastUsedBy();

   object mistletoe = GetItemPossessedBy(oPC, "_h_mistletoe");
   object water = GetItemPossessedBy(oPC, "_h_mineral_water");


   if( GetItemPossessedBy(oPC, "_h_sulfur") == OBJECT_INVALID )
        {
             if( mistletoe != OBJECT_INVALID && water != OBJECT_INVALID)
             {
               DestroyObject(mistletoe, 0.0);
                DestroyObject(water, 0.1);
                CreateItemOnObject("item010", oPC, 1);
              }
              else
              {
                  CreateItemOnObject("_h_sulfur", oPC, 1);
              }
        }
        else
        {
            AssignCommand(oPC, ActionSpeakString("I already have some of that.") );
        }
}
