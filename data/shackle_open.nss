
void main()
{
object oPC = GetPCSpeaker();
object oShackle=GetNearestObjectByTag("Shackle", oPC);
object oPrisoner=GetLocalObject(oShackle, "Prisoner");
location lShackle = GetLocation(oShackle);
object oSpot=GetNearestObjectByTag("ShaftofLightBlue", oShackle);

int x= GetLocalInt(oShackle, "InUse");

  ActionPauseConversation();

  if (x>0)
    {
    PlaySound("as_na_branchsnp3");
    RemoveEffect(oPrisoner, EffectKnockdown());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPrisoner, 0.5f);
    AssignCommand(oPrisoner, ClearAllActions());
    DestroyObject(oSpot, 0.0f);
    }

  SetCommandable(TRUE, oPrisoner);
  SetLocalInt(oShackle, "InUse", 0);
  SetLocalInt(oShackle, "knockdown", 0);
  //SetLocalInt(oPrisoner, "shackled6", 0);
  DeleteLocalObject(oShackle, "Prisoner");

  ActionResumeConversation();

}
