#include "_moonwell01spawn"

// use this so sparingly!!!
void main()
{
    object oPC = GetPCChatSpeaker();
    if(!GetIsPC(oPC)){
        return;
    }

    string sCommand = GetStringLowerCase(GetPCChatMessage());
    while((sCommand != "") && (GetStringLeft(sCommand, 1) == " ")) {
        sCommand = GetStringRight(sCommand, GetStringLength(sCommand) -1);
    }
    SendMessageToPC(oPC, sCommand);
    if(GetStringLeft(sCommand, 10) == "high druid") {
        object obHbObj = GetObjectByTag("moonwell01onhbob");
        float druidDist = GetDistanceBetween(obHbObj, oPC);
        if(druidDist > 0.0 && druidDist < 15.0) {
            moonwellSpawn(oPC);
        }
    }

}
