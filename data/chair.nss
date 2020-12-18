void main()
{
object oChair = OBJECT_SELF;
float fMeg = GetFacing(OBJECT_SELF);
if(!GetIsObjectValid(GetSittingCreature(oChair)))
     {
     AssignCommand(GetLastUsedBy(), ActionSit(oChair));
     AssignCommand(GetLastUsedBy(), SetFacing(fMeg));
     }
 }
