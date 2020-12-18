#include "omega_include"
void main()
{
object oTarget = GetObjectByTag ("omega_neutralfdrone");
object oOld = GetLocalObject(GetModule(),"cmk_todestroy");
object oDoppelganger = CopyObject(oMyTarget,GetLocation(oDM),OBJECT_INVALID,"Doppelganger");

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

