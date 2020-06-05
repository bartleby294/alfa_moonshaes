void main()
{
    object oPC = GetLastUsedBy();
    object gnomemove = GetObjectByTag("Gnomestand");
    object gnome = GetObjectByTag("Davendithas");
    object oArea = GetArea(OBJECT_SELF);
    object Bell =  GetObjectByTag("Gnomebell");
    vector gnomegohere = Vector(16.63,24.56,1.0);

    location gnomelocation = Location(oArea, gnomegohere, 90.0f);

    //stops any action gnome might be undertaking tells him to walk to obj
    SoundObjectPlay(Bell);
    AssignCommand(gnome, ClearAllActions(FALSE) );
    AssignCommand(gnome, ActionMoveToLocation(gnomelocation, FALSE) );
    AssignCommand(gnome, ActionSpeakString("*Hops up on platform*") );
    AssignCommand(gnome, ActionWait(0.5) );

    AssignCommand(gnome, PlaySoundByStrRef(76365) );
    AssignCommand(gnome, ActionStartConversation(oPC,"graveltoesconvo",FALSE,TRUE) );










}
