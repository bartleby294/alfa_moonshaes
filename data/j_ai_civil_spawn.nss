/************************ [Spawn Commoner] *************************************
    Filename: J_AI_Civil_spawn
************************* [Spawn Commoner] *************************************
    Spawn file for commoners, containing optional animations and waypoint code.

    Meant to speed up CPU cycles by cutting out all combat related things for
    commoners - as commoners are always meant to flee, and only wander around
    or walk waypoints normally.
************************* [History] ********************************************
    1.3 - Added
************************* [Workings] *******************************************
    This should go in:

    - On Spawn

    + For OnPhisicalAttacked, OnDamaged, OnSpellCastAt and OnDisturbed, use the
      file "J_AI_Civil_Host"
    + For the OnBlocked event, using the default should be fine.
    + The OnPerception, OnRested and OnCombatRoundEnd events scripts can be
      "J_AI_Civil_Empty". This is to stop any odd behaviour.
    + Conversation script is "J_AI_Civil_Speak"
    + Heartbeat script is "J_AI_Civil_HB"
************************* [Arguments] ******************************************
    Arguments: OBJECT_SELF, but thats about it.
************************* [Spawn Commoner] ************************************/

#include "J_INC_SPAWNIN"

void main()
{
    // * If the NPC has the Hide skill they will go into stealth mode
    // * while doing WalkWayPoints().
    // *
    // SetSpawnInCondition(NW_FLAG_STEALTH);

    // * Same, but for Search mode
    // *
    // SetSpawnInCondition(NW_FLAG_SEARCH);

    // * Separate the NPC's waypoints into day & night.
    // * See comment on WalkWayPoints() for use.
    // *
    // SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);

    // * This will cause an NPC to use common animations it possesses,
    // * and use social ones to any other nearby friendly NPCs.
    // *
    // SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    // * Same as above, except NPC will wander randomly around the
    // * area.
    // *
    // SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);

    // * Civilized creatures interact with placeables in
    // * their area that have the tag "NW_INTERACTIVE"
    // * and "talk" to each other.
    // *
    // * Humanoid races are civilized by default, so only
    // * set this flag for monster races that you want to
    // * behave the same way.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);

    // * Civilized creatures with this flag set will
    // * randomly use a few voicechats. It's a good
    // * idea to avoid putting this on multiple
    // * creatures using the same voiceset.
    // SetAnimationCondition(NW_ANIM_FLAG_CHATTER);

    // * Creatures with _immobile_ ambient animations
    // * can have this flag set to make them mobile in a
    // * close range. They will never leave their immediate
    // * area, but will move around in it, frequently
    // * returning to their starting point.
    // *
    // * Note that creatures spawned inside interior areas
    // * that contain a waypoint with one of the tags
    // * "NW_HOME", "NW_TAVERN", "NW_SHOP" will automatically
    // * have this condition set.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);

    DelayCommand(f2, SpawnWalkWayPoints());
        // Delayed walk waypoints, as to not upset instant combat spawning.
        // This will also check if to change to day/night posts during the walking, no heartbeats.
}
