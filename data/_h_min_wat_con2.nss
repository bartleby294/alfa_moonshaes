void main()
{
   object oPC =GetLastUsedBy();

   object mistletoe = GetItemPossessedBy(oPC, "_h_mistletoe");
   object sulfur = GetItemPossessedBy(oPC, "_h_sulfur");


   if( GetItemPossessedBy(oPC, "_h_mineral_water") == OBJECT_INVALID )
        {
             if( mistletoe != OBJECT_INVALID && sulfur != OBJECT_INVALID)
             {
               DestroyObject(mistletoe, 0.0);
                DestroyObject(sulfur, 0.1);
                CreateItemOnObject("item010", oPC, 1);
              }
              else
              {
                  CreateItemOnObject("_h_mineral_water", oPC, 1);
              }
        }
        else
        {
            AssignCommand(oPC, ActionSpeakString("I already have a bottle of that.") );
        }
}
