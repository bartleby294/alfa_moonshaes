void main()
{
    object Worker = GetObjectByTag("laura");
    object clothes = GetNearestObjectByTag("laura_clothes", Worker, 1);
    object crate = GetNearestObjectByTag("laura_crate", Worker, 1);


    AssignCommand(Worker, ActionInteractObject(crate));
}
