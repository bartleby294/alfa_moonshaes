#include"x0_i0_position"

void main()
{
    object Shopkeep = GetObjectByTag("Ventin");
    object oPC = GetLastUsedBy();
    object oChair = OBJECT_SELF;
    object oArea = GetArea(oChair);

    object oChair1 = GetObjectByTag("Ogden_chair01");
    object oChair2 = GetObjectByTag("Ogden_chair02");
    object oChair3 = GetObjectByTag("Ogden_chair03");
    object oChair4 = GetObjectByTag("Ogden_chair04");

    object oBar = GetObjectByTag("Ogden_bar");

    int ChairNum = 0;
    int Gen = GetGender(oPC);
    float Th = 90.0f;

    vector v1 = Vector(49.74f, 37.46f);
    location keepLocIni = GetLocation(Shopkeep);
    location keepLoc2 = Location(oArea, v1, 47.7);

    vector ShopVec = GetPosition(oChair);

    AssignCommand(Shopkeep, ClearAllActions(FALSE) );

    if(GetIsObjectValid(oChair1))
    {
        ChairNum = ChairNum +1;
    }

    if(GetIsObjectValid(oChair2))
    {
        ChairNum = ChairNum +1;
    }

    if(GetIsObjectValid(oChair3))
    {
        ChairNum = ChairNum +1;
    }

    if(GetIsObjectValid(oChair4))
    {
        ChairNum = ChairNum +1;
    }

        if(ChairNum == 1) /////////////////////////////////////////////////
    {
         AssignCommand(Shopkeep, ActionMoveToLocation(keepLoc2, FALSE));
         AssignCommand(Shopkeep, ActionJumpToLocation(keepLoc2));
         AssignCommand(Shopkeep, ActionSpeakString("Well whats one more.") );
         AssignCommand(Shopkeep, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.00, 0.0f) );
         AssignCommand(Shopkeep, ActionWait(1.00) );
         AssignCommand(Shopkeep, ActionSpeakString("*Sighs*") );
         AssignCommand(Shopkeep, ActionWait(3.0) );
         AssignCommand(Shopkeep, ActionMoveToLocation(keepLocIni, FALSE));
         AssignCommand(Shopkeep, ActionJumpToLocation(keepLocIni));

    }
        if(ChairNum == 2)///////////////////////////////////////////////////
    {
        AssignCommand(Shopkeep, ActionMoveToLocation(keepLoc2, TRUE));
        AssignCommand(Shopkeep, ActionJumpToLocation(keepLoc2));
        AssignCommand(Shopkeep, ActionSpeakString("Ye gotta be kidding me") );
        AssignCommand(Shopkeep, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.00, 0.0f) );
        AssignCommand(Shopkeep, ActionWait(1.00) );
        if(Gen == GENDER_FEMALE)
        {
            AssignCommand(Shopkeep, ActionSpeakString("You alright lass?") );
        }

        if(Gen == GENDER_MALE)
        {
            AssignCommand(Shopkeep, ActionSpeakString("You alright lad?") );
        }
        AssignCommand(Shopkeep, ActionWait(2.50) );
        AssignCommand(Shopkeep, ActionSpeakString("*Shakes head*") );
        AssignCommand(Shopkeep, ActionWait(3.0) );
        AssignCommand(Shopkeep, ActionMoveToLocation(keepLocIni, FALSE));
        AssignCommand(Shopkeep, ActionJumpToLocation(keepLocIni));

    }
        if(ChairNum == 3)  ///////////////////////////////////////////
    {
        AssignCommand(Shopkeep, ActionMoveToLocation(keepLoc2, TRUE));
        AssignCommand(Shopkeep, ActionJumpToLocation(keepLoc2));
        AssignCommand(Shopkeep, ActionSpeakString("Bah thats the second one this week!") );
        AssignCommand(Shopkeep, ActionWait(1.00) );
        AssignCommand(Shopkeep, ActionSpeakString("You alright?") );
        AssignCommand(Shopkeep, ActionWait(3.0) );
        AssignCommand(Shopkeep, ActionSpeakString("*Shakes head*") );
        AssignCommand(Shopkeep, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.00, 0.0f) );
        AssignCommand(Shopkeep, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.00, 0.0f) );
        AssignCommand(Shopkeep, ActionWait(1.5) );
        AssignCommand(Shopkeep, ActionMoveToLocation(keepLocIni, FALSE));
        AssignCommand(Shopkeep, ActionJumpToLocation(keepLocIni));

    }
        if(ChairNum == 4)//////////////////////////////////////////////////////
    {
        AssignCommand(Shopkeep, ActionMoveToLocation(keepLoc2, TRUE));
        AssignCommand(Shopkeep, ActionJumpToLocation(keepLoc2));
        AssignCommand(Shopkeep, ActionSpeakString("You alright there?"));
        AssignCommand(Shopkeep, ActionWait(1.00) );
        AssignCommand(Shopkeep, ActionSpeakString("*Looks the scene over.*"));
        AssignCommand(Shopkeep, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.00, 0.0f) );
        AssignCommand(Shopkeep, ActionWait(5.0) );
        AssignCommand(Shopkeep, ActionSpeakString("Dont be worrin about the chair it was a needen to be fixed anyhow."));
        AssignCommand(Shopkeep, ActionWait(4.0) );
        AssignCommand(Shopkeep, ActionMoveToLocation(keepLocIni, FALSE));
        AssignCommand(Shopkeep, ActionJumpToLocation(keepLocIni));

    }

}
