//::///////////////////////////////////////////////
//::Generic magic shop NPC Script
//::
//:://////////////////////////////////////////////
/*
        Generic magic shop NPC Script:

        Used to add some life to a merchant in a magic shop.
        When placed in the UDE of a NPC they will appear to be practicing
        some magic on an object with the tag of "castingTarget" and move to a spellbook
        ("spellBook") from time to time to check on spells.

        If a PC get within 3 meters of the NPC, it will stop and wait for the PC to
        start a conversation.

        To Use:
        Place this script in the User Defined section of the NPC.
        You will need two placeables. The target object that will be fired upon and a spellbook placeables.
        Change the target object's tag to "castingTarget" and the spellbook to "spellBook".
        ****REMEMBER, these tags ARE case sensitive***
*/
//:://////////////////////////////////////////////
//:: Created By: Michael Herberger
//:: Created On: 06/30/2004
//:://////////////////////////////////////////////

//Declarations
void castASpell(object o_Target);       //Determines if spell works or not and handles effects, responses and spells

//Helper functions for castASpell()
int responseSpell();                    //Returns a random spell
string responseBook();                  //Returns a random speech
string responseNeg();                   //Returns a random negitive response
string responsePos();                   //Returns a random positive response
int responseEffect();                   //Returns a random effect

//Variables
int isBusy = 0;

//**Changing these below will change the frequency of time the NPC will perform either spells or readings
int i_delayTimeMin = 6; //The minimum delay between castings/readings in seconds. Will be random.
int i_delayTimeMax = 12; //The maximum delay between castings/readings in seconds. Will be random.

/////////////////////////////////////////////////////////
//Main
/////////////////////////////////////////////////////////
void main()
{
    int i_User = GetUserDefinedEventNumber();
    if(i_User == 1001) // HEARTHBEAT
    {
//Find the nearest PC, get the distance away. If greater that 3 meters, do spells, else face the PC
    object o_PC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    object o_Target = GetObjectByTag("castingTarget");
    float f_Range = GetDistanceToObject(o_PC);
    vector v_Target = GetPosition(o_PC);
        if (f_Range > 3.0 && isBusy == 0)
        {
                if (d100() < 40)
                {
                        isBusy = 1;
                        castASpell(o_Target);
                }
                else
                {
                        isBusy = 1;
                        ActionMoveToObject(GetObjectByTag("spellBook"));
                        ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 1.0);
                        ActionSpeakString(responseBook());
                        isBusy = 0;
                }
        }
        else
        {
                ClearAllActions();
                SetFacingPoint(v_Target);
        }
    }
    else if(i_User == 1002) // PERCEIVE
    {}
    else if(i_User == 1003) // END OF COMBAT
    {}
    else if(i_User == 1004) // ON DIALOGUE
    {}
    else if(i_User == 1005) // ATTACKED
    {}
    else if(i_User == 1006) // DAMAGED
    {}
    else if(i_User == 1007) // DEATH
    {}
    else if(i_User == 1008) // DISTURBED
    {}
}

/////////////////////////////////////////////////////////
//castASpell
/////////////////////////////////////////////////////////

void castASpell(object o_Target)
{
        int i_attempt = Random(100);
        int i_Spell;
        int i_Effect;
        int i_Animation;
        string s_Response;
            if (i_attempt <= 70)
            {
//Negitive spell result
                i_Spell = responseSpell();
                i_Effect = responseEffect();
                s_Response = responseNeg();
                i_Animation = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;
            }
            else if (i_attempt > 70)
//Positive spell result
            {
                i_Spell = responseSpell();
                i_Effect = responseEffect();
                s_Response = responsePos();
                i_Animation = ANIMATION_FIREFORGET_VICTORY1;
            }
        ActionCastFakeSpellAtLocation(i_Spell, GetLocation(o_Target), PROJECTILE_PATH_TYPE_DEFAULT);
        ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(i_Effect), GetLocation(o_Target)));
        ActionSpeakString(s_Response);
        ActionPlayAnimation(i_Animation, 1.0, 1.0);
        ActionWait(IntToFloat(Random(i_delayTimeMax) + i_delayTimeMin));
        isBusy == 0;
}

/////////////////////////////////////////////////////////
//SPELLS
/////////////////////////////////////////////////////////

int responseSpell()
{
        int i_Roll = Random(18) + 1;
        int i_Spell;

        switch(i_Roll)
        {
                case 1:
                        i_Spell =  SPELL_CHAIN_LIGHTNING;
                        break;
                case 2:
                        i_Spell =  SPELL_CIRCLE_OF_DEATH;
                        break;
                case 3:
                        i_Spell =  SPELL_FLAME_STRIKE;
                        break;
                case 4:
                        i_Spell =  SPELL_GREATER_SPELL_MANTLE;
                        break;
                case 5:
                        i_Spell =  SPELL_ACID_FOG;
                        break;
                case 6:
                        i_Spell =  SPELL_BOMBARDMENT;
                        break;
                case 7:
                        i_Spell =  SPELL_CONE_OF_COLD;
                        break;
                case 8:
                        i_Spell =  SPELL_IMPLOSION;
                        break;
                case 9:
                        i_Spell =  SPELL_ELECTRIC_JOLT;
                        break;
                case 10:
                        i_Spell =  SPELL_ENERVATION;
                        break;
                case 11:
                        i_Spell =  SPELL_HORIZIKAULS_BOOM;
                        break;
                case 12:
                        i_Spell =  SPELL_INFERNO;
                        break;
                case 13:
                        i_Spell =  SPELL_RAY_OF_ENFEEBLEMENT;
                        break;
                case 14:
                        i_Spell =  SPELL_SPHERE_OF_CHAOS;
                        break;
                case 15:
                        i_Spell =  SPELL_SUNBURST;
                        break;
                case 16:
                        i_Spell =  SPELL_WEIRD;
                        break;
                case 17:
                        i_Spell =  SPELL_WOUNDING_WHISPERS;
                        break;
                case 18:
                        i_Spell =  SPELL_DESTRUCTION;
                        break;
        }
        return i_Spell;
}

/////////////////////////////////////////////////////////
//EFFECTS
/////////////////////////////////////////////////////////
int responseEffect()
{
        int i_Roll = Random(18) + 1;
        int i_Effect;
        //
        switch(i_Roll)
        {
                case 1:
                        i_Effect = VFX_IMP_LIGHTNING_M;
                        break;
                case 2:
                        i_Effect = VFX_IMP_DEATH_WARD;
                        break;
                case 3:
                        i_Effect = VFX_IMP_DIVINE_STRIKE_FIRE;
                        break;
                case 4:
                        i_Effect = VFX_IMP_SPELL_MANTLE_USE;
                        break;
                case 5:
                        i_Effect = VFX_IMP_CHARM;
                        break;
                case 6:
                        i_Effect = VFX_IMP_DOOM;
                        break;
                case 7:
                        i_Effect = VFX_IMP_FROST_L;
                        break;
                case 8:
                        i_Effect = VFX_IMP_MAGBLUE;
                        break;
                case 9:
                        i_Effect = VFX_IMP_ELEMENTAL_PROTECTION;
                        break;
                case 10:
                        i_Effect = VFX_IMP_HARM;
                        break;
                case 11:
                        i_Effect = VFX_IMP_HOLY_AID;
                        break;
                case 12:
                        i_Effect = VFX_IMP_KNOCK;
                        break;
                case 13:
                        i_Effect = VFX_IMP_LIGHTNING_S;
                        break;
                case 14:
                        i_Effect = VFX_IMP_POLYMORPH;
                        break;
                case 15:
                        i_Effect = VFX_IMP_PULSE_FIRE;
                        break;
                case 16:
                        i_Effect = VFX_IMP_REDUCE_ABILITY_SCORE;
                        break;
                case 17:
                        i_Effect = VFX_IMP_SUNSTRIKE;
                        break;
                case 18:
                        i_Effect = VFX_IMP_TORNADO;
                        break;
        }
        return i_Effect;
}

/////////////////////////////////////////////////////////
//RESPONSE STRINGS
/////////////////////////////////////////////////////////

string responseNeg()
{
        int i_Roll = Random(12) + 1;
        string s_Response;
        switch(i_Roll)
        {
                case 1:
                        s_Response = "Huh. Thats odd";
                        break;
                case 2:
                        s_Response = "Weird.";
                        break;
                case 3:
                        s_Response = "That was unexpected.";
                        break;
                case 4:
                        s_Response = "WOW! I'll have to remember that one!";
                        break;
                case 5:
                        s_Response = "Impressive. But not correct.";
                        break;
                case 6:
                        s_Response = "That's gonna leave a mark!";
                        break;
                case 7:
                        s_Response = "No. That's not right. Too much arm movement.";
                        break;
                case 8:
                        s_Response = "No. No. No!";
                        break;
                case 9:
                        s_Response = "Interesting.";
                        break;
                case 10:
                        s_Response = "Opps!";
                        break;
                case 11:
                        s_Response = "Ouch!";
                        break;
                case 12:
                        s_Response = "What?";
                        break;
        }

        return s_Response;
}

string responsePos()
{
        int i_Roll = d8();
        string s_Response;
        switch(i_Roll)
        {
                case 1:
                        s_Response = "Ok. That's better.";
                        break;
                case 2:
                        s_Response = "Perfect.";
                        break;
                case 3:
                        s_Response = "Interesting";
                        break;
                case 4:
                        s_Response = "WOW! I'll have to remember that one!";
                        break;
                case 5:
                        s_Response = "I must master this spell.";
                        break;
                case 6:
                        s_Response = "Good. Good.";
                        break;
                case 7:
                        s_Response = "I am getting good at this.";
                        break;
                case 8:
                        s_Response = "Yes";
                        break;
        }
        return s_Response;
}

string responseBook()
{
        int i_Roll = d8();
        string s_Response;
        switch(i_Roll)
        {
                case 1:
                        s_Response = "Let's see...where was I...";
                        break;
                case 2:
                        s_Response = "Ah. Yes! Here it is.";
                        break;
                case 3:
                        s_Response = "First, I must double check the incantation.";
                        break;
                case 4:
                        s_Response = "Now where did I see that spell...Ah there it is.";
                        break;
                case 5:
                        s_Response = "Oh. That's why it didn't work.";
                        break;
                case 6:
                        s_Response = "Opps. I should be more careful.";
                        break;
                case 7:
                        s_Response = "What page was that on?";
                        break;
                case 8:
                        s_Response = "Yes. Now I understand.";
                        break;
        }
        return s_Response;
}

/////////////////////////////////////////////////////////


