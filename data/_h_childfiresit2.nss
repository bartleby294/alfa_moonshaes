void main()
{
    object log1 = GetObjectByTag("_h_log2");

    AssignCommand(OBJECT_SELF, ActionInteractObject(log1));
}
