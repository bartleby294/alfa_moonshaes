void main()
{
    object gnome = GetObjectByTag("Davendithas");
    object oArea = GetArea(gnome);
    object oChair = GetObjectByTag("Gravel_chair");

    vector gnomegohere = Vector(22.45,25.28,1.0);
    vector gnomegohere2 = Vector(19.52,27.44,0.0);

    location gnomelocation = Location(oArea, gnomegohere, 90.0f);
    location gnomelocation2 = Location(oArea, gnomegohere2, 90.0f);

    AssignCommand(gnome, ClearAllActions(FALSE) );
    AssignCommand(gnome, ActionMoveToLocation(gnomelocation, FALSE) );

    AssignCommand(gnome, ActionSpeakString("*Looks over to you*") );
    AssignCommand(gnome, ActionWait(1.5) );
    AssignCommand(gnome, ActionSpeakString("You break it, you buy it.") );

    AssignCommand(gnome, ActionMoveToLocation(gnomelocation2, FALSE) );
    AssignCommand(gnome, ActionWait(0.5) );
    AssignCommand(gnome, ActionInteractObject(oChair) );
    AssignCommand(gnome, ActionSpeakString("*Goes back to books*") );
}
