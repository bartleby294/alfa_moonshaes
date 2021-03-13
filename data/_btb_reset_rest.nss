#include "ms_onrest"
#include "ms_rest_consts"

void main() {
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea)) {
        string areaResRef = GetResRef(oArea);
        string areaName = GetName(oArea);
        SendMessageToPC(GetItemActivator(), areaName);
        if(GetStringLeft(areaName, 1) == "|") {
            SetDefaultRestState(oArea);
        }
        oArea = GetNextArea();
    }
}
