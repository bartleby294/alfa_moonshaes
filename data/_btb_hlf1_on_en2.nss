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
//#include "alfa_include"

int isObjectInArea(string objTag) {
    int objectFound = 0;
    object obj = GetFirstObjectInArea();
    while(GetIsObjectValid(obj) && objectFound == 0){
        if(GetTag(obj) == objTag){
            objectFound = 1;
        }
        obj = GetNextObjectInArea();
    }
    return objectFound;
}

void plantCorn() {
    string BASE_WP_TAG = "hlf_f1_corn_";
    string BASE_OBJ_TAG = "hlf_f1_corn_obj_";
    string CORN_RESREF = "alfa_produce014";

    int i;
    for(i=1; i<49; ++i) {
        string waypointTag = BASE_WP_TAG + IntToString(i);
        string objTag = BASE_OBJ_TAG + IntToString(i);
        object wp = GetWaypointByTag(waypointTag);

        int objectFound = isObjectInArea(objTag);
        if(objectFound == 0) {
            CreateObject(OBJECT_TYPE_PLACEABLE, CORN_RESREF, GetLocation(wp), FALSE, objTag);
            WriteTimestampedLogEntry("2 Created Corn: " + objTag);
        }
    }
}

void main()
{
  //ALFA_OnAreaEnter();


  /**************** Add Custom Code Here ***************/
  object xvartBell = GetObjectByTag("hlf_farm1_raid_bell");
  if(GetLocalInt(xvartBell, "planting_corn") == 0) {
        SetLocalInt(xvartBell, "planting_corn", 1);
        if(GetLocalInt(xvartBell, "xvart_raids_in_progress") == 0) {
            plantCorn();
        }
        SetLocalInt(xvartBell, "planting_corn", 0);
    }
  /*****************************************************/
}

