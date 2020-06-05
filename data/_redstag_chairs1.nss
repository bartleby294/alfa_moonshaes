void main()
{
object oPC = GetLastUsedBy();
object oChair = OBJECT_SELF;

    if(!GetIsObjectValid(GetSittingCreature(oChair)))
    {
      AssignCommand(oPC,ActionSit(oChair));
      SetLocalInt(oPC, "IsSitting", 1);
     }
}
