#include "omega_include"
void main()
{
    object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
    if(GetPlotFlag(oMyTarget))
        SetPlotFlag(oMyTarget, 0);
        else SetPlotFlag(oMyTarget, 1);
}
