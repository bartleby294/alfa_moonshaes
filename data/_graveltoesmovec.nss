void main()
{

    object gnomemove = GetObjectByTag("Gnomestand");
    object gnome = GetObjectByTag("Davendithas");
    object Bell =  GetObjectByTag("Gnomebell");
    object oChair = GetObjectByTag("alfa_chair");
    object oArea =GetArea(oChair);
    vector gnomegohere2 = Vector(19.52,27.44,0.0);

    location gnomelocation2 = Location(oArea, gnomegohere2, 90.0f);

    AssignCommand(gnome, PlaySoundByStrRef(76368) );
    AssignCommand(gnome, ActionSpeakString("*Hops down off platform*") );
    AssignCommand(gnome, ActionMoveToLocation(gnomelocation2, FALSE) );
    AssignCommand(gnome, ActionWait(0.2) );
    AssignCommand(gnome, ActionInteractObject(oChair) );
    AssignCommand(gnome, ActionSpeakString("*Goes back to books*") );











}
