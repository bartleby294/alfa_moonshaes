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
#include "nwnx_time"
#include "alfa_ms_config"

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

void spawnFarmers() {
    // only spawn the farmers during the day and if they arent already there.
    if(GetIsDay()) {
        object wp = GetWaypointByTag("corn_farmer_spawn");
        if(GetObjectByTag("clav") == OBJECT_INVALID) {
            CreateObject(OBJECT_TYPE_CREATURE, "clav",
                GetLocation(wp), FALSE, "clav");
        }
        if(GetObjectByTag("jart") == OBJECT_INVALID) {
            CreateObject(OBJECT_TYPE_CREATURE, "jart",
                GetLocation(wp), FALSE, "jart");
        }
        if(GetObjectByTag("rolling") == OBJECT_INVALID) {
            CreateObject(OBJECT_TYPE_CREATURE, "rolling",
                GetLocation(wp), FALSE, "rolling");
        }
    }
    object wpMitch = GetWaypointByTag("mitchan_spawn");
    if(GetObjectByTag("mitchan") == OBJECT_INVALID) {
       CreateObject(OBJECT_TYPE_CREATURE, "mitchan",
        GetLocation(wpMitch), FALSE, "mitchan");
    }
}

void main()
{
  //ALFA_OnAreaEnter();


  /**************** Add Custom Code Here ***************/
    object oArea = GetArea(OBJECT_SELF);
    object xvartBell = GetObjectByTag("hlf_farm1_raid_bell");
    int lastRaid = GetCampaignInt("XVART_RAIDS", "XVART_RAID_" + GetTag(oArea));
    // if no raid is going on plant the corn and spawn the farmers
    if(NWNX_Time_GetTimeStamp() - lastRaid > FARM_DELAY_SECONDS) {
        if(GetLocalInt(xvartBell, "reseting_area") == 0) {
            SetLocalInt(xvartBell, "reseting_area", 1);
            plantCorn();
            spawnFarmers();
        }
        SetLocalInt(xvartBell, "reseting_area", 0);
    }
  /*****************************************************/
}

