#include "nw_o0_itemmaker"

void main()
{
int iSW = GetLocalInt(OBJECT_SELF, "iMagicWeaponBroke");
string sW = IntToString(iSW);
//string sW = GetLocalArrayString(OBJECT_SELF, sW, 1);
string sPCname = GetLocalArrayString(OBJECT_SELF, sW, 2);
string sMonsterName = GetLocalArrayString(OBJECT_SELF, sW, 3);
string sArea = GetLocalArrayString(OBJECT_SELF, sW, 4);
string sWeaponTag = GetLocalArrayString(OBJECT_SELF, sW, 5);
string sWeaponName = GetLocalArrayString(OBJECT_SELF, sW, 6);

SpeakString("It was bad day for "+sPCname
+" when his "+sWeaponName +"("+sWeaponTag+") shattered on "+sMonsterName +" in "+sArea);

}
