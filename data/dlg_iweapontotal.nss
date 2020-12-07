void main()
{
int x = GetLocalInt(OBJECT_SELF, "iMagicWeaponBroke");
int xx = GetLocalInt(OBJECT_SELF, "iMagicWeaponValue");
int y = GetLocalInt(OBJECT_SELF, "iWeaponBroke");
int yy = GetLocalInt(OBJECT_SELF, "iWeaponValue");
int z = x + y;
int zz = xx + yy;
SpeakString("A total of " +(IntToString(z)) +" weapons worth " +(IntToString(zz)) +" have been broken.");
}
