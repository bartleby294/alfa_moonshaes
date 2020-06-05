void main()
{

if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
if (GetCurrentAction() != ACTION_SIT)
{
ClearAllActions();
int i = 1;
object oChair = GetNearestObjectByTag("cd_ch15", OBJECT_SELF,i);
int bFoundChair = FALSE;
while (bFoundChair == FALSE && GetIsObjectValid(oChair) == TRUE)
{
if (GetIsObjectValid(GetSittingCreature(oChair)) == FALSE)
{
bFoundChair = TRUE;
ActionSit(oChair);
}
else
{
i++;
oChair = GetNearestObjectByTag("cd_ch15", OBJECT_SELF,i);
}
}
if (bFoundChair == FALSE)
{
ClearAllActions();
ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
}
}
}
