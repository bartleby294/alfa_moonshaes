void main()
{
object Shopkeep = GetObjectByTag("Ventin");
object oPC = GetLastUsedBy();

object oChair1 = GetObjectByTag("Ogden_chair01");
object oChair2 = GetObjectByTag("Ogden_chair02");
object oChair3 = GetObjectByTag("Ogden_chair03");
object oChair4 = GetObjectByTag("Ogden_chair04");

object oChair = OBJECT_SELF;

object sitter = GetSittingCreature(oChair);
float delay = d6(1) + 5.0;
AssignCommand(Shopkeep, ClearAllActions(FALSE) );
//takes care of sitting

    if(!GetIsObjectValid(GetSittingCreature(oChair)))
      AssignCommand(oPC,ActionSit(oChair));

//end of taking care of sitting


AssignCommand(Shopkeep, ActionWait(3.00) );
AssignCommand(Shopkeep, ActionSpeakString("Carefull those chairs are a wee bit wobbly.") );
AssignCommand(Shopkeep, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.00, 0.0f) );
DelayCommand(delay, ExecuteScript("_ogden_brokchai2", oChair));
}
