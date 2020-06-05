void main()
{
    object WP1 = GetObjectByTag("Ship_wp1");
    object WP2 = GetObjectByTag("Ship_wp2");

    object AIToggle = GetNearestObjectByTag("AIToggle", OBJECT_SELF, 1);

    location ShipSPLoc = GetLocation(WP1);

    object Ship = CreateObject(OBJECT_TYPE_CREATURE, "ship", ShipSPLoc, FALSE, "smugship1");

    AssignCommand(Ship, ActionMoveToObject(WP2, TRUE, 300000.0));

    SetLocalInt(AIToggle, "AIState", 1);
}
