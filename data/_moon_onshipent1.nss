/******************************************************************
 * Name: alfa_onareaenter
 * Type: OnAreaEnter
 * ---
 * Author: Cereborn
 * Date: 10/24/03
 * ---
 * This handles the module OnAreaEnter event.
 * You can add custom code in the appropriate section
 ******************************************************************/

/* Includes */
#include "alfa_include"

void main()
{
    //ALFA_OnAreaEnter();
    ExecuteScript("ms_on_area_enter");

    /**************** Add Custom Code Here ***************/
    object oPC = GetEnteringObject();
    object ship = GetNearestObjectByTag("Lifeboat_On_Ship", oPC, 1);
    object watership = GetNearestObjectByTag("Lifeboat_In_Water", oPC, 1);
    location shipLoc = Location(OBJECT_SELF, Vector(41.27, 39.96, 4.4), 90.0);
    location shipLoc2 = Location(OBJECT_SELF, Vector(42.71,43.33, 4.3), 0.0);

    int done = GetLocalInt(GetObjectByTag("CaptainJaric"), "HBEndFireOnce");

    // if theres no one one the ship or the ship isnt there yet done will == 0
    if(done != 1)
    {
        if(ship == OBJECT_INVALID)
        {
            object NewShip = CreateObject(OBJECT_TYPE_PLACEABLE, "boulder007", shipLoc, FALSE, "Lifeboat_On_Ship");
            object ShipUse = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_invisibl001", shipLoc2, FALSE, "Lifeboat_On_Ship_Activate");
        }

        if(watership != OBJECT_INVALID)
        {
            DestroyObject(watership, 0.0);
        }
    }
  /*****************************************************/
}
