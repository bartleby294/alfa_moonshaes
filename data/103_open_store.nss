void main()
{
    // open the nearest store or let the user know that no store exists.
   object oStore = GetNearestObject(OBJECT_TYPE_STORE);
   if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
       OpenStore(oStore, GetPCSpeaker());
   else
      ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}

