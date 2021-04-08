void main()
{
    object enterObj = GetEnteringObject();
    if(GetTag(enterObj) != "mstradewagon1") {
        return;
    }

    object gate = GetObjectByTag("CorwellTownEastGate2");
    if(GetIsOpen(gate) == FALSE) {
         AssignCommand(gate, ActionOpenDoor(gate));
    }
}
