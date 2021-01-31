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

    if(GetStringLeft(sCommand, 10) == "high druid") {
        object obHbObj = GetObjectByTag("moonwell01onhbob");
        if(GetDistanceBetween(obHbObj, oPC) < 15.0) {
            moonwellSpawn(oPC);
        }
    }

}
