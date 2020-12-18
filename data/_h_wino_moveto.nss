void main()
{
    object moveto = GetObjectByTag("_h_wino_moveto1");

    AssignCommand(OBJECT_SELF, ActionMoveToObject(moveto, FALSE, 1.0));
}
