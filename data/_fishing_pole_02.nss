#include "x0_i0_position"
#include "nw_i0_2q4luskan"
#include "nw_i0_plot"

void main()
{
    object oPC = OBJECT_SELF;
    int randomnum = d100(1);
    location FishSpawnLoc = GetLocation(oPC);

    string uuid = GetPCPublicCDKey(oPC)+GetName(oPC);
    int fishCaught = GetCampaignInt("fish_caught", uuid);
    SetCampaignInt("fish_caught", uuid, fishCaught + 1);

    if(randomnum > 94)
    {
       object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item04", FishSpawnLoc, FALSE);
    }

    if(randomnum > 89 && randomnum < 95 )
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item14", FishSpawnLoc, FALSE);
    }

    if(randomnum > 84 && randomnum < 90)
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item07", FishSpawnLoc, FALSE);
    }

    if(randomnum > 74 && randomnum < 85)
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item06", FishSpawnLoc, FALSE);
    }

    if(randomnum > 64 && randomnum < 75)
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item03", FishSpawnLoc, FALSE);
    }

    if(randomnum > 54 && randomnum < 65)
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item12", FishSpawnLoc, FALSE);
    }

    if(randomnum > 39 && randomnum < 55)
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item05 ", FishSpawnLoc, FALSE);
    }
    if(randomnum > 24 && randomnum < 40)
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item04 ", FishSpawnLoc, FALSE);
    }
    if(randomnum > 14 && randomnum < 25)
    {
     object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item13", FishSpawnLoc, FALSE);
    }
    if(randomnum > 0 && randomnum < 15)
    {
      object fishthing1 = CreateObject(OBJECT_TYPE_ITEM, "_fishing_item01", FishSpawnLoc, FALSE);
    }

   AssignCommand(oPC, ActionSpeakString("*Pulls line out of water.*"));

}
