void main()
{
int x = GetLocalInt(OBJECT_SELF, "iMagicWeaponBroke");
int xx = GetLocalInt(OBJECT_SELF, "iMagicWeaponValue");
SpeakString((IntToString(x)) +" magic weapons worth " +(IntToString(xx)) +" have been broken.");
}
