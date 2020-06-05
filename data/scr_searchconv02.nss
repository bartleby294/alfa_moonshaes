void main()
{
object oPC = GetLastUsedBy();
object oSecretButton = GetObjectByTag("SBOOKSHELF_01");
if (GetIsSkillSuccessful(oPC, SKILL_SEARCH, 18))
   {
   AssignCommand(oSecretButton, ActionStartConversation(oPC, "c_sbookshelf_01", TRUE, FALSE));
   }

}
