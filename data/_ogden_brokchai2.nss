void main()
{
object Shopkeep = GetObjectByTag("Ventin");
object oPC = GetLastUsedBy();
object oChair = OBJECT_SELF;
object sitter = GetSittingCreature(oChair);

effect oDeath = EffectDeath();
int Q = d20(1); // rand num for facing of broken chair

//set up for location
vector ChairVec = GetPosition(oChair);
object oArea = GetArea(oChair);
float Chairface = GetFacing(oChair);
float Chairface2 = Chairface + Q + 90.0f;


location ChairLoc = Location(oArea, ChairVec, Chairface2);


if(GetIsObjectValid(sitter))
{
// PC is knocked down chair is destroyed
AssignCommand(oPC, ClearAllActions(FALSE) );
AssignCommand(oPC , ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 0.0f) );

ApplyEffectToObject(DURATION_TYPE_INSTANT, oDeath, oChair, 0.0f);
CreateObject(OBJECT_TYPE_PLACEABLE, "x0_brokenchair4", ChairLoc, FALSE);
ExecuteScript("_ogden_brokchai3", oChair);
}
}
