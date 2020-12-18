void main()
{
    object User = GetLastUsedBy();

    object ship = GetNearestObjectByTag("Lifeboat_On_Ship", OBJECT_SELF, 1);
    object shiponactivate = OBJECT_SELF;
    location NewShipLoc = Location(OBJECT_SELF, Vector(37.66, 42.48, -0.50), 22.6);

    if(GetTag(User) == "MermaidsTailSailor2")
    {
        DestroyObject(ship, 0.5);
        DestroyObject(OBJECT_SELF, 0.0);
        AssignCommand(User, SpeakString("**Lowers the ship into the water** ALL ASHORE WHOS GOEN ASHORE!"));
        object newship = CreateObject(OBJECT_TYPE_PLACEABLE, "boulder007", NewShipLoc, FALSE, "Lifeboat_In_Water");
    }
}
