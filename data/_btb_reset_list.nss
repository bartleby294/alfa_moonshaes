#include "ms_rest_consts"

void main() {
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea)) {
        string areaResRef = GetResRef(oArea);
        if(GetStringLeft(areaResRef, 1) == "|") {
            string message =  GetResRef(oArea) + ": ";
            int restState = GetCampaignInt(REST_DATABASE, GetResRef(oArea));
            if( restState == TRUE) {
                message += "TRUE";
            } else {
                message += "FALSE";
            }
            SendMessageToPC(GetItemActivator(), message);
        }
        oArea = GetNextArea();
    }
}
