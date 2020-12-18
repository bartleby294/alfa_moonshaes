void main()
{
    object sitter = GetObjectByTag("_test_sitter");
    object chair = GetObjectByTag("_test_chair2");

    AssignCommand(sitter, ClearAllActions());

}
