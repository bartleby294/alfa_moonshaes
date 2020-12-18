void main()
{
    object bat = OBJECT_SELF;
    object moveto = GetObjectByTag("");

    AssignCommand(bat, ActionMoveToObject(moveto, FALSE));
}
