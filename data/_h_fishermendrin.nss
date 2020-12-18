void main()
{
     object chair1 = GetObjectByTag("_hchair1");
      object chair2 = GetObjectByTag("_hchair2");
       object chair3 = GetObjectByTag("_hchair3");


     if(GetTag(OBJECT_SELF) == "hammerstaadsitter1")
     {
        ActionInteractObject(chair1);
        return;
     }

     if(GetTag(OBJECT_SELF) == "hammerstaadsitter3")
     {
        ActionInteractObject(chair3);
        return;
     }

     if(GetTag(OBJECT_SELF) == "hammerstaadsitter2")
     {
        ActionInteractObject(chair2);
        return;
     }


}
