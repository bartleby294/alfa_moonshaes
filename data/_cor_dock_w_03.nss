void main()
{
    object Worker = GetObjectByTag("DockWorker");
    object crate = GetNearestObjectByTag("_cor_worker_crate01", Worker, 1);

    effect Walk = EffectMovementSpeedDecrease(50);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, Worker);

    AssignCommand(Worker, ActionInteractObject(crate));
}
