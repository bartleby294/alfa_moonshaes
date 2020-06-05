//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oCaster;
oCaster = OBJECT_SELF;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));

AssignCommand(oPC, TakeGoldFromCreature(45, oPC, TRUE));

}
