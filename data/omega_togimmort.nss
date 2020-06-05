#include "omega_include"
void main()
{
    object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
    if(GetImmortal(oMyTarget))
        SetImmortal(oMyTarget, 0);
        else SetImmortal(oMyTarget, 1);
}
