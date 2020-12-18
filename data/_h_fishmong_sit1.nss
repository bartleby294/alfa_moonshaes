void main()
{
    object oChair = GetObjectByTag("_h_fishmonger_chair01");
    object fishmonger = GetObjectByTag("");

    AssignCommand(fishmonger, ActionInteractObject(oChair));
}
