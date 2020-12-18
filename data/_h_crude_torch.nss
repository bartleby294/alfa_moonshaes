void main()
{
    object  oPC = OBJECT_SELF;

    object rag = GetItemPossessedBy(oPC, "Rag");
    object stick = GetItemPossessedBy(oPC, "_walking_stick");

    DestroyObject(rag, 0.0);
    DestroyObject(stick, 0.1);

    AssignCommand(oPC, ActionSpeakString("*Fashions a crude torch from a stick and some rags.*") );
    CreateItemOnObject("_h_crude_torch", oPC, 1);
    //SetPlotFlag(Torch, TRUE);
}
