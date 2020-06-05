void main()
{
    object Fiscal = GetObjectByTag("Mines02FiscalAdvisor");
    object throneright = GetObjectByTag("DwarfMines02ThrownRight");

    AssignCommand(Fiscal, ActionInteractObject(throneright) );
    ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
