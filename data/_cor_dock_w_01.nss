void main()
{
    object Worker = GetObjectByTag("DockWorker");
    object crate = GetNearestObjectByTag("_cor_worker_crate01", Worker, 2);

    if(GetLastUsedBy() != Worker)
    {
        return;
    }

    AssignCommand(Worker, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));

    if(GetLocalInt(Worker, "BoxState") != 1)
    {
        DelayCommand(2.0, AssignCommand(Worker, SpeakString("**Picks up Box**")));
        SetLocalInt(Worker, "BoxState", 1);
    }
    else
    {
        DelayCommand(2.0, AssignCommand(Worker, SpeakString("**Puts box Down**")));
        SetLocalInt(Worker, "BoxState", 0);
    }

    DelayCommand(5.0, AssignCommand(Worker, ActionInteractObject(crate)));
    SetLocalObject(Worker, "InteractionBox", crate);
}
