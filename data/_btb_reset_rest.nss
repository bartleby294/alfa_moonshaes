#include "ms_onrest"
#include "ms_rest_consts"

void main() {
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea)) {
        string areaResRef = GetResRef(oArea);
        if(GetStringLeft(areaResRef, 1) == "|") {
            SetDefaultRestState(oArea);
        }
        oArea = GetNextArea();
    }
}
