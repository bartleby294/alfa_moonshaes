void main()
{
    object Fiscal = GetObjectByTag("Mines02FiscalAdvisor");
    object throneright = GetObjectByTag("DwarfMines02ThrownRight");

    AssignCommand(Fiscal, ActionInteractObject(throneright));
}
