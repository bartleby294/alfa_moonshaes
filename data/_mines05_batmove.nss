void main()
{
    object bat = GetEnteringObject();
    object moveto = GetObjectByTag("");

    AssignCommand(bat, ActionMoveToObject(moveto, FALSE));
}
