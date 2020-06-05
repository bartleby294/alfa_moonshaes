void main()
{
   object oPC =GetLastUsedBy();

   object water = GetItemPossessedBy(oPC, "_h_mineral_water");
   object sulfur = GetItemPossessedBy(oPC, "_h_sulfur");


   if( GetItemPossessedBy(oPC, "_h_mistletoe") == OBJECT_INVALID )
        {
             if( water != OBJECT_INVALID && sulfur != OBJECT_INVALID)
             {
               DestroyObject(water, 0.0);
                DestroyObject(sulfur, 0.1);
                CreateItemOnObject("item010", oPC, 1);
              }
              else
              {
                  CreateItemOnObject("_h_mistletoe", oPC, 1);
              }
        }
        else
        {
            AssignCommand(oPC, ActionSpeakString("I already have some of that.") );
        }
}
