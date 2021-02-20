#include "nwnx_object"
#include "x0_i0_corpses"

void main()
{
    if (GetLocalInt(OBJECT_SELF, "iFirstOpen") == 0)
    {
        string dbSerStr = GetCampaignString("PChest", "poctest");
        object phantomChest = NWNX_Object_Deserialize(dbSerStr);
        LootInventory(phantomChest, OBJECT_SELF);
        DestroyObject(phantomChest);
        SetLocalInt(OBJECT_SELF, "iFirstOpen", 1);
    }

}
