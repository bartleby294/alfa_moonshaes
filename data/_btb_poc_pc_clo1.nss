#include "nwnx_object"

void main()
{
    string serStr = NWNX_Object_Serialize(OBJECT_SELF);
    SpeakString("Serialized String Length: " + IntToString(GetStringLength(serStr)));

    SetCampaignString("PChest", "poctest", serStr);
    string dbSerStr = GetCampaignString("PChest", "poctest");
    SendMessageToPC(GetLastClosedBy(), "DB Serialized String Length: " + IntToString(GetStringLength(dbSerStr)));
}
