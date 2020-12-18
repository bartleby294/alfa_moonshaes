#include "omega_include"
void main()
{
location lTarget = GetLocation(GetWaypointByTag("omega_doppelganger"));
object oTarget = GetObjectByTag ("omega_neutralfdrone");
object oOld = GetLocalObject(GetModule(),"cmk_todestroy");
object oDoppelganger = CopyObject(oMyTarget,lTarget,OBJECT_INVALID,"Doppelganger");
FloatingTextStringOnCreature("A duplicate has been created and sent to your DM room", oDM);
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_POLYMORPH),oDoppelganger));
DelayCommand(1.2,ChangeFaction(oDoppelganger,oTarget));
object oDopItem = GetFirstItemInInventory(oDoppelganger);
while(oDopItem != OBJECT_INVALID)

            {
DestroyObject(oDopItem);
oDopItem = GetNextItemInInventory(oDoppelganger);
            }
TakeGoldFromCreature(GetGold(oDoppelganger),oDoppelganger,TRUE);

}

