// OnSpawnIn
/*
  Lots of toggleable options, and plenty to read. Most things are fully working, while
  some have not been tested too much. I think all work fine though.

  Note: I have removed:
    - Teleporting (this seemed bugged anyway, or useless)
    - Spawn in animation. This is bugged, and looks wierd. Also does not work with the weapon setting.
    - Day/night posting. This is uneeded, with a changed walk waypoints that does it automatically.
*/
#include "alfa_include"

#include "j_inc_setweapons"
// This line needs umcommenting, and the line at the bottom, for *urg* default
// treasure. I don't like it, so I uncommented it.
//#include "nw_o2_coninclude"
#include "j_inc_spawnin"

void main()
{
//@@@@@@@@@@@@@@@@@@@@ UN-OPTIONAL BEHAVIORS (Should have a value) @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    //SetSpawnInValue("AI_INTELLIGENCE", 10);
        // This is the intelligence of the creature 1-10. Default to 10
        // Read the file in "Explainations" about this intelligence for more info.
    //SetSpawnInValue("AI_MORALE", 10);
        // This is a value, which is added to the morale check. Morale checks are at
        // HD difference, + 20 (10 averages this out to HD+10). They never flee at similar
        // levels.
        // SETTING THIS TO A MINUS VALUE MAKES THEM ALWAYS FLEE!
//@@@@@@@@@@@@@@@@@@@@ OPTIONAL BEHAVIORS (Comment In or Out to Activate ) @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
        // Use the file "nw_d2_gen_check" in a converation (first string) and they will say it when they see an enemy
    //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
        // Similar to above BUT use "nw_d2_gen_combat" in the tree though.
                // This causes the creature to say a special greeting in their conversation file
                // upon Perceiving the player. Attach the [nw_d2_gen_check.nss] script to the desired
                // greeting in order to designate it. As the creature is actually saying this to
                // himself, don't attach any player responses to the greeting.

    //*************************** COMBAT ORIENTATED THINGS ***************************
    //SetSpawnInCondition(NW_FLAG_STEALTH);
        // If the NPC has stealth, they will go into stealth mode
    //SetSpawnInCondition(NW_FLAG_SEARCH);
        // If the NPC has Search, they will go into Search Mode

    //SetSpawnInValue("IGNORE_EMOTES");
        // This will cause the creature to not react to spoken text enclosed in asterisks.
    //SetSpawnInCondition(TRACK_DAY_NIGHT);
        // This will check the day/night status (on heartbeat), and set the int "IS_DAY" to
        // TRUE if it is day or dawn, else deletes it, or sets it to FALSE
        // Not needed for day/night posting, or anything else by default.
        // Good for tracking stuff for Undead or whatever in user defined events. Not requied by default.
    //SetSpawnInCondition(NO_CLEAR_ACTIONS_BEFORE_CONVERSATION);
        // Basically, this will not clear all actions before a conversation. It *should*
        // keep the person sitting down, but needs proper testing. Also, if moving they
        // may still be moving (which may cancel the conversation) so be careful.
    //SetSpawnInCondition(NO_POLYMORPHING);
        // This will stop all polymorphing spells, and all feats that do polymorphing from being used.
    //SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);
        // When an enemy comes in 40M, they will use some of thier spells to buff before combat.
    //SetSpawnInValue("AI_SPELL_TRIGGERS", 2);
        // This will let loose some spells, depending on wizard/Sorceror levels, free of casting them.
        // The value is the amount of triggers they have. They will be released again on
        // low HP, with no spell effects, and a cirtain amount of passes when they can do actions.
    //SetSpawnInCondition(GROUP_LEADER);
        // This will make the creature a "leader" to command the help, and genrally command others.
        // Also, any creature that can see the leader will have a morale bonus.
        // These have prioritory for healing, may say "attack X" and send runners to get help.
    //SetSpawnInCondition(NEVER_FIGHT_IMPOSSIBLE_ODDS);
        // This will make the creature never fight against impossible odds.
        // A massive (8) difference in HD/CR will make them run off, if there are valid near allies.
    //SetSpawnInCondition(ARCHER_ATTACKING);
        // This will make the creature defined as an Archer only. They will either:
        //  a. Use a missile weapon with pointblankshot.
        //  b. Move back, best they can, if allies are there to help, then carry on shooting.
        // This also never will polymorph until no ammo or missile weapons.
    //SetSpawnInCondition(ATTACK_FROM_AFAR_FIRST);
        // This will make the creature use ranged spells, before moving in bit by bit.
        // Ranges of spells are 40, then 20, 8, and then 2.5. Warning: This will make
        // them cast all spells, before even considering attacking with anything else.
    //SetSpawnInCondition(FEARLESS);
        // This will make the creature never flee at all.
    //SetSpawnInCondition(SUMMON_FAMILIAR);
        // This will make the creature summon thier respective familiars/animal companions.
        // It will be a nameless bat for the familiar, and badger for the druid, and without
        // a hakpack, this cannot be changed.
    //SetSpawnInValue("AI_DOOR_INTELLIGENCE", 1);
        // This will determine what to do with blocking doors. Default is 0 or not set, which
        // means intelligence will take the key, and they may unlock, untrap, knock or bash it.
        // 1 = Always bashes the door (does not check for plot flag, or if it can be opened).
        // 2 = Never open any doors (none! Just stops there)
        // 3 = Never attempts to open (bash or anything) plot doors
    //SetSpawnInValue("AI_HEALING_ALLIES_PERCENT", 60);
        // This is the % of HP that allies have to be down to to heal. It will default to 60.
        // It will still choose appropriate healing, and wait until they are that damaged.
    //SetSpawnInCondition(WILL_RAISE_ALLIES_IN_BATTLE);
       // This will let the cleric use the raising spells in battle.

    //SetSpawnInValue("AI_FAVOURED_ENEMY_RACE", RACIAL_TYPE_HUMAN, TRUE);
        // This means they will try to attack this race over others. Use the RACIAL_ constants.
    //SetSpawnInValue("AI_CORPSE_DESTROY_TIME", 30);
        // This is the amount of time, in seconds, that it will take for a corpse to dissapear.
        // High means a cleric may raise it in time, lower for faster loot. Default = 30.
    //SetSpawnInCondition(BOSS_MONSTER_SHOUT);
        // This will bring all allies in 60M to help, using a shout on percieve. One use.
    //SetSpawnInCondition(CHEAT_MORE_POTIONS);
        // If they are damaged a lot, they may spawn a critical wounds potion and use it.
    //SetSpawnInValue("AI_POLYMORPH_INTO", POLYMORPH_TYPE_WEREWOLF, TRUE);
        // This will poly morph the creture (using the effect) when they are damaged
        // (nw_c2_default6). Remeber the luskan wererats? Similar technique.
        // Leave the "TRUE", as otherwise the values will not be set properly.
    //SetSpawnInStringValue("AI_WE_WILL_CREATE_ON_DEATH", "Resref Here");
        // Add in a resref, and OnDeath, when they are dealt a final blow, will create
        // creatre X. Resrefs only, else badgers will be popping up!
        // Idea: Use the spawn in setting "AI_DEATH_VISUAL_EFFECT", to make it fancy
    //SetSpawnInValue("AI_DEATH_VISUAL_EFFECT", VFX_FNF_SCREEN_SHAKE);
        // This will set the visual effect, X, to be used instantly (so only Fire and Forget ones
        // or instant ones!). It is fired ONCE every time the death script is fired.
        // You cannot use value 0 for this, but that would not work anyway (it is VFX_DUR_BLUR)
    //SetSpawnInValue("AI_ABILITY_TO_TELEPORT", 3);
        // This makes the person able to teleport. The number is the times they can do it.
        // If you put down waypoints ("TELEPORT_" + TAG + "_1 (and up)"), at least 2-3 really, that the mage
        // can teleport to, they will IF there are no enemies near that waypoint. Else, they will
        // choose the nearest ally with no enemies nearby.
        // Also, note, that waypoints can be in other areas!
    //SetSpawnInCondition(IMPROVED_INSTANT_DEATH_SPELLS);
        // This will make the creature cheat by using some instant death spells on low save enemies
        // Its not that powerful at all, really, but might as well be toggelable.
    //CreateRandomStats(-3, 3, 6);
        // This will affect 3 (by default random stats. They will rise or go down by the amount, randomly
        // You can make the numbers anything. The first is the LOWEST and the second the HIGHEST
        // WARNING: They are magical effects. Force resting by a DM removes them.
        // Dispelling should not affect them, and I have added a ERF for modified resorations
    //CreateRandomOther(-2, 2, -2, 2, -2, 2, -2, 2);
        // This will radomise all the creatures saves, HP (will damage if a negative!) and
        // AC changes. It goes MinValue then Max Value, double click on the name for more info
    //SetSpawnInCondition(RETURN_TO_SPAWN_LOCATION);
        // This will store thier starting location, and then move back there after combat
        // Will turn off if there are waypoints. This NEEDS the location set below...
    //SetLocalLocation(OBJECT_SELF, "AI_RETURN_TO_POINT", GetLocation(OBJECT_SELF));
        // This NEEDS setting with the above.

    /**************************** SPEAKSTRINGS *********************************
        If you wish, there are strings that can be said on cirtain events. There is
        the ability to use a conversation item (special combat conversation, at the top)
        but these may allow randomness, and ones for more special events.

        This is good for making creatures of different types speak things they would say
        like a goblin saying "Groala!" instead of "Attack!".

        Replace SetSpawnInStringValue with SetSpawnInStringRandomValue for randomness.
    ***************************** SPEAKSTRINGS ********************************/
    //SetSpawnInStringValue("AI_TALK_ON_MORALE_BREAK", "No more!");
        // This will be spoken when the creatures morale breaks and they move to
        // another group of allies.
    //SetSpawnInStringValue("AI_TALK_ON_CANNOT_RUN", "Grrr!");
        // This will be spoken when the creatures morale breaks, BUT they cannot
        // find a better place to be AND thier intelligence (above) is over 5.
    //SetSpawnInStringValue("AI_TALK_ON_STUPID_RUN", "Run! RUUNNN!!");
        // This will be spoken when the creatures morale breaks, BUT they cannot
        // find a better place to be AND thier intelligence (above) is BELOW 5,
        // when they just run (badly) away from the enemy.
        // NOTE: This is also used when morale is "0", IE animal or similar, this is spoken.
    //SetSpawnInStringRandomValue("AI_TALK_ON_PERCIEVE_ENEMY", 6, "Stand and fight, lawbreaker!", "Don't run from the law!", "I have my orders!", "I am ready for violence!", "CHARGE!", "Time you died!");
        // Set at random at the moment. This will be RANDOMLY spoken, unless set otherwise
        // just below.
    //SetSpawnInValue("AI_PERCENT_TO_SHOUT_ON_PERCIEVE", 70);
        // This is the percent the speakstring above will be spoken, when they see an enemy
        // and is not in combat.
    //SetSpawnInStringRandomValue("AI_TALK_ON_DAMAGED", 2, "Ouch, damn you!", "Haha! Nothing will stop me!");
        // A random value is set to speak when damaged, set percent below.
    //SetSpawnInValue("AI_PERCENT_TO_SHOUT_ON_DAMAGED", 20);
        // This is the percent the speakstring above will be spoken, when they are damaged
        // by a spell or a weapon.
    //SetSpawnInStringRandomValue("AI_TALK_ON_PHISICALLY_ATTACKED", 2, "Hah! Mear weapons won't defeat me!", "Pah! You cannot defeat me with such rubbish!");
        // This is the string used for the phyiscally atttacked string.
    //SetSpawnInValue("AI_PERCENT_TO_SHOUT_ON_PHISICALLY_ATTACKED", 20);
        // This is the percent the speakstring above will be spoken, when they see an enemy
        // and is not in combat.
    //SetSpawnInStringRandomValue("AI_TALK_ON_HOSTILE_SPELL_CAST_AT", 2, "No one spell will stop me!", "Is that all you have!?!");
        // Set at random at the moment. This will be RANDOMLY spoken, unless set otherwise
        // just below.
    //SetSpawnInValue("AI_PERCENT_TO_SHOUT_ON_HOSTILE_SPELL_CAST_AT", 20);
        // This is the percent the speakstring above will be spoken, when they see an enemy
        // and is not in combat.

    //SetSpawnInStringValue("AI_TALK_ON_DEATH", "Agggggg!");
        // This will ALWAYS be said, when the creature dies.
    //SetSpawnInStringValue("AI_TALK_ON_LEADER_SEND_RUNNER", "Quickly! We need help!");
        // This will be said when the leader, if this creature, sends a runner.
    //SetSpawnInStringValue("AI_TALK_ON_LEADER_ATTACK_TARGET", "Help attack this target!");
        // When the leader thinks target X should be attacked, it will say this.
    //SetSpawnInStringRandomValue("AI_TALK_ON_TAUNT", 3, "You're going down!", "No need to think, let my blade do it for you!", "Time to meet your death!");
        // If the creature uses thier skill, taunt, this will be said.

    /**************************** ANIMATIONS ************************************
        You can only put one of these on at once (as they override each other)
        They will not be used with waypoints, and are performed in heartbeat, if there
        is another PC in the area.
    ***************************** ANIMATIONS ***********************************/
    //SetSpawnInValue("AI_ANIMATIONS", IMMOBILE_AMBIENT_ANIMATIONS);
        // This will make the creature talk with nearby allies, as to not look dead.
    //SetSpawnInValue("AI_ANIMATIONS", IMMOBILE_ANIMATIONS_AND_SOLO);
        // This will make the creature talk with nearby allies, as to not look dead.
        // Also, if alone, it will take drinks, and things like that, maybe sit, etc.
    //SetSpawnInValue("AI_ANIMATIONS", AMBIENT_ANIMATIONS);
        // These animations normally make them randomwalk around, or move to allies.
        // WARNING: This can make a creature walk out of doorways to other areas!
    //SetSpawnInValue("AI_ANIMATIONS", AMBIENT_ANIMATIONS_AVIAN);
        // These animations are for birds, that you want to fly away.
    //SetSpawnInValue("AI_ANIMATIONS", AMBIENT_GROUP_ANIMATIONS);
        // These will make creatures group, sit, talk and not wander too much.
    //SetSpawnInValue("AI_ANIMATIONS", AMBIENT_ANIMAL_WALKING);
        // This is a consitution for just random walking, nothing else.

    //SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007
    //SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);    //OPTIONAL BEHAVIOR - Fire User Defined Event 1011
    //SetSpawnInCondition(NW_FLAG_RESTED_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1009

// This line needs umcommenting, and the line at the bottom, for *urg* default
// treasure. I don't like it, so I uncommented it.
//    GenerateNPCTreasure();
        //Use this to create a small amount of treasure on the creature

    //***** ALFA MOD: Danmar's PuppetMaster functionality
    //**
    if ( gALFA_USE_PUPPET_MASTER )
    {
      ALFA_InitPuppetMaster();
      // This is the Jasperre's AI version of SetListeningPatterns, modified
      // by Kensai to take an argument that lets us indicate that
      // SetListening() has already been called (by InitPuppetMaster());
      // set FALSE because we already SetListening - and the renamed with
      // the JAI prefix by Cereborn...
      //SetListeningPatterns( FALSE );
    }

    else
    {
      //SetListeningPatterns( TRUE );
    }
    //**
    //****** end ALFA MOD

        // Goes through and sets up which shouts the NPC will listen to.
    SetWeapons();
        // This sets what weapons the creature will use. They will use the best, according to a "value"
        // Giving a creature the feat Two-weapon-fighting makes them deul wield if appropriate weapons.
    AI_AdvancedAuras();
        // This activates the creatures top aura.
    DelayCommand(2.0, SpawnWalkWayPoints());
        // Delayed walk waypoints, as to not upset instant combat spawning.
        // This will also check if to change to day/night posts during the walking, no heartbeats.
}
