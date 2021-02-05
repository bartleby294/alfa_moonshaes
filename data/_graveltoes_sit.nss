void main()
{
    object gnome = GetObjectByTag("Davendithas");
    object oChair = GetObjectByTag("Gravel_chair");
    object oArea =GetArea(oChair);
    vector gnomegohere2 = Vector(19.52,27.44,0.0);

    location gnomelocation2 = Location(oArea, gnomegohere2, 90.0f);

    AssignCommand(gnome, ActionMoveToLocation(gnomelocation2, FALSE) );
    AssignCommand(gnome, ActionWait(0.5) );
    AssignCommand(gnome, ActionInteractObject(oChair) );
    AssignCommand(gnome, ActionSpeakString("*Goes back to books*") );

    ExecuteScript("ms_on_area_enter");

}
