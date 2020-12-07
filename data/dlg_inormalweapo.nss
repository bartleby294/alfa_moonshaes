void main()
{
int y = GetLocalInt(OBJECT_SELF, "iWeaponBroke");
int yy = GetLocalInt(OBJECT_SELF, "iWeaponValue");
SpeakString((IntToString(y)) +" normal weapons worth " +(IntToString(yy)) +" have been broken.");
}
