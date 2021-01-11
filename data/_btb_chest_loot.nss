#include "_btb_random_loot"

void main()
{
    object chest = OBJECT_SELF;
    if(GetLocalInt(chest, "loot_generated") == 0) {
        SetLocalInt(chest, "loot_generated", 1);
        generateLoot(3000, chest, 1);
    }
}
