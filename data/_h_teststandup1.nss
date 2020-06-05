void main()
{
    object boy1 = GetObjectByTag("_boy1");
    object boy2 = GetObjectByTag("_boy2");
    object boy3 = GetObjectByTag("_boy3");

    AssignCommand(boy1, ClearAllActions());
    AssignCommand(boy2, ClearAllActions());
    AssignCommand(boy3, ClearAllActions());
}
