//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oCaster;
oCaster = OBJECT_SELF;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_LESSER_RESTORATION, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));

AssignCommand(oPC, TakeGoldFromCreature(75, oPC, TRUE));

}
