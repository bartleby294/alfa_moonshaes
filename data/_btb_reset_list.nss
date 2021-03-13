#include "ms_rest_consts"

void main() {
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea)) {
        string areaResRef = GetResRef(oArea);
        string areaName = GetName(oArea);
        if(GetStringLeft(areaName, 1) == "|") {
            string message =  areaResRef + ": ";
            int restState = GetCampaignInt(REST_DATABASE, areaResRef);
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
