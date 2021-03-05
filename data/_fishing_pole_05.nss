#include "nwnx_creature"
void main()
{
    int i = 1;
    object oNearest = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                         PLAYER_CHAR_NOT_PC, OBJECT_SELF, i);
    // If a hostile is within 10 ft destroy object
    while(oNearest != OBJECT_INVALID
        && GetDistanceBetween(oNearest, OBJECT_SELF) < 10.0) {
        // if we have a hostile within 10 feet destory the object.
        if(NWNX_Creature_GetFaction(oNearest) == STANDARD_FACTION_HOSTILE) {
            DestroyObject(OBJECT_SELF, 2.0);
        }
        i++;
        oNearest = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                      PLAYER_CHAR_NOT_PC, OBJECT_SELF, i);
    }
}
