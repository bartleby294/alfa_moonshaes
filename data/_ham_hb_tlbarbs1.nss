#include "x0_i0_position"

void main()
{
    int x = 1;
    object talkNPC = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF,1);

    while(x != 0)
    {
        if(GetIsPC(talkNPC))
        {
           talkNPC = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, x);
        }
        else
        {
            x = 0;
        }
    }

    TurnToFaceObject(talkNPC,OBJECT_SELF);

    int q = d4(1);

    if(q==1)
    {
        AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
    }
    if(q==2)
    {
      AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 6.0));
    }
    if(q==3)
    {
      AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0));
    }
    if(q==4)
    {
        return;
    }
    if(q==5)
    {
      AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0));
    }
    if(q==6)
    {
      AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0));
    }
}
