void main()
{
    object chair = GetObjectByTag("_h_chair04");

    AssignCommand(OBJECT_SELF, ActionInteractObject(chair));
}
