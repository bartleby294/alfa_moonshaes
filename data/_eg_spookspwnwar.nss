void main()
{
int spookspawn = GetLocalInt(OBJECT_SELF, "spookspawn");

if(spookspawn == FALSE)
{
CreateObject(OBJECT_TYPE_CREATURE, "undeadpirate1", GetLocation(OBJECT_SELF));
}
  SetLocalInt(OBJECT_SELF, "spookspawn", TRUE);
  }
