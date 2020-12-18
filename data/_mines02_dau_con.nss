void main()
{
    object Daughter = GetObjectByTag("Mines02EldersDaughter");
    object throneleft = GetObjectByTag("DwarfMines02ThrownLeft");

    AssignCommand(Daughter, ActionInteractObject(throneleft) );
    AssignCommand(Daughter, ActionSpeakString("*Remains seated, queitly observes you.*") );
    //ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
