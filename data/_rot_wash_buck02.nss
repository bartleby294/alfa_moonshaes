void main()
{
    object Worker = GetObjectByTag("Laura");
    object wash = GetLocalObject(Worker, "InteractionWash");

    if(GetLastUsedBy() != Worker)
    {
        return;
    }



    if(GetTag(OBJECT_SELF) == "laura_shirt")
    {
        object wash2 = GetNearestObjectByTag("laura_bucket");
        SetLocalObject(Worker, "InteractionWash", wash2);
    }
    if(GetTag(OBJECT_SELF) == "laura_bucket")
    {
      object wash2 = GetNearestObjectByTag("laura_shirt");
      SetLocalObject(Worker, "InteractionWash", wash2);
    }

    AssignCommand(Worker, SpeakString("**Washes Clothes**"));
    DelayCommand(2.0, AssignCommand(Worker, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0)));
    DelayCommand(7.0, AssignCommand(Worker, ActionInteractObject(wash)));

}
