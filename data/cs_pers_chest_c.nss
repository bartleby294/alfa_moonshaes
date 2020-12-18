// Working implementation of persistent chests for ALFA. Anonymous author.
// Remember to keep the tag short! Variablenames can be a maximum of 32 characters!

void main()
{
string sDatabase = "alfa_persistentchest";
string sTag = GetTag(OBJECT_SELF);
string sVarName;
int i = 0;

object obj = GetFirstItemInInventory();;
object bag;

while( obj != OBJECT_INVALID )
{
if( GetHasInventory( obj ) )
{
bag = obj;
obj = GetFirstItemInInventory(bag);
while( obj != OBJECT_INVALID )
{
SetLocalInt(obj, "bagged", TRUE);
obj = GetNextItemInInventory(bag);
}
}
obj = GetNextItemInInventory();
}

int iMax = 0;
object oItem = GetFirstItemInInventory();

while (oItem != OBJECT_INVALID)
{
sVarName = sTag + "_" + IntToString(i);
if ((GetLocalObject(OBJECT_SELF, sVarName) != oItem) && (!GetLocalInt(oItem, "bagged")))
{
StoreCampaignObject(sDatabase, sVarName, oItem);
SetLocalObject(OBJECT_SELF, sVarName, oItem);
}
if (!GetLocalInt(oItem, "bagged"))
{
iMax++;
i++;
}
else
{
DeleteLocalInt(oItem, "bagged");
}
oItem = GetNextItemInInventory();
}
SetCampaignInt(sDatabase, sTag + "_n", iMax);
}
