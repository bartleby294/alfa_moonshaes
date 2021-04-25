void main()
{
int spookspawn = GetLocalInt(OBJECT_SELF, "spookspawn");

if(spookspawn == FALSE)
{
CreateObject(OBJECT_TYPE_CREATURE, "skeleton_04", GetLocation(OBJECT_SELF));
}
  SetLocalInt(OBJECT_SELF, "spookspawn", TRUE);
  }
