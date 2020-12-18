void main()
{
    object Worker = GetObjectByTag("DockWorker");
    object crate = GetLocalObject(Worker, "InteractionBox");

    DelayCommand(2.0, AssignCommand(Worker, ActionInteractObject(crate)));
}
