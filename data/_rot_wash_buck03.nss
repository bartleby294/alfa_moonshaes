void main()
{
    object Worker = GetObjectByTag("laurabennemen");
    object wash = GetLocalObject(Worker, "InteractionWash");

    DelayCommand(2.0, AssignCommand(Worker, ActionInteractObject(wash)));
}
