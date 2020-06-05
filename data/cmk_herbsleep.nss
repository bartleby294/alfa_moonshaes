#include "sos_include"

void main()
{
    if(GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED)
    {
        if(SOS_GetPersistentInt(OBJECT_SELF,"cmk_sleepbonus") > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(SOS_GetPersistentInt(OBJECT_SELF,"cmk_sleepbonus")),OBJECT_SELF);
            FloatingTextStringOnCreature("The herbs aid your healing.",OBJECT_SELF,FALSE);
            SOS_SetPersistentInt(OBJECT_SELF,"cmk_sleepbonus",0);
        }
    }
}
