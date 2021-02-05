#include "_btb_craft_const"

/*
 *  Check if item is a craft weapon item.
 */
int IsCraftWeaponItem(string tag) {
    if (tag == IRON_INGOT_TAG
        || tag == SILVER_INGOT_TAG
        || tag == COLD_INGOT_TAG
        || tag == DARK_STEEL_INGOT_TAG
        || tag == ADAMANTIUM_INGOT_TAG
        || tag == MITHRAL_INGOT_TAG
        || tag == OBSIDIAN_INGOT_TAG
        || tag == POTION_OF_FIRE_BREATH_TAG
        || tag == POTION_OF_ACID_BREATH_TAG
        || tag == POTION_OF_COLD_BREATH_TAG
        || tag == POTION_OF_ELEC_BREATH_TAG
        || tag == GEM_RUBY
        || tag == GEM_EMERALD
        || tag == GEM_SAPHIRE
        || tag == GEM_DIAMOND
        || tag == FIRE_ELEMENTAL_ESSENCE
        || tag == ACID_ELEMENTAL_ESSENCE
        || tag == COLD_ELEMENTAL_ESSENCE
        || tag == ELEC_ELEMENTAL_ESSENCE) {
        return TRUE;
    }
    return FALSE;
}


/*
 * Check if an item is in inventory.
 */
int HasItem(string sItem, object oObject=OBJECT_SELF) {
    object oInventory = GetFirstItemInInventory(oObject);
    while (GetIsObjectValid(oInventory) == TRUE) {
        if (GetTag(oInventory) == sItem) {
            return TRUE;
        }
        oInventory = GetNextItemInInventory(oObject);
    }
    return FALSE;
}

/*
 * Check if its higher than the existing max on a tie coin flip.
 */
int CheckIfHigher(object oPC, int iScore, int iAbility) {
    int curAbility = GetAbilityScore(oPC, iAbility, FALSE);
    if (iScore < curAbility || (iScore == curAbility && d2() == 1)) {
        return TRUE;
    }
    return FALSE;
}

/*
 * Check if its lower than the existing min on a tie coin flip.
 */
int CheckIfLower(object oPC, int iScore, int iAbility) {
    int curAbility = GetAbilityScore(oPC, iAbility, FALSE);
    if (iScore > curAbility || (iScore == curAbility && d2() == 1)) {
        return TRUE;
    }
    return FALSE;
}

/*
 * Get the highest attribute
 */
int GetHighAbility(object oPC) {
    int iAbility = ABILITY_STRENGTH;
    int iScore = GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE);

    if (CheckIfHigher(oPC, iScore, ABILITY_DEXTERITY)) {
        iScore = GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE);
        iAbility = ABILITY_DEXTERITY;
    }
    if (CheckIfHigher(oPC, iScore, ABILITY_CONSTITUTION)) {
        iScore = GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE);
        iAbility = ABILITY_CONSTITUTION;
    }
    if (CheckIfHigher(oPC, iScore, ABILITY_INTELLIGENCE)) {
        iScore = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE);
        iAbility = ABILITY_INTELLIGENCE;
    }
    if (CheckIfHigher(oPC, iScore, ABILITY_WISDOM)) {
        iScore = GetAbilityScore(oPC, ABILITY_WISDOM, FALSE);
        iAbility = ABILITY_WISDOM;
    }
    if (CheckIfHigher(oPC, iScore, ABILITY_CHARISMA)) {
        iScore = GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE);
        iAbility = ABILITY_CHARISMA;
    }

    return iAbility;
}

//Get the lowest attribute
int GetLowAbility(object oPC) {
    int iAbility = ABILITY_STRENGTH;
    int iScore = GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE);

    if (CheckIfLower(oPC, iScore, ABILITY_DEXTERITY)) {
        iScore = GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE);
        iAbility = ABILITY_DEXTERITY;
    }
    if (CheckIfLower(oPC, iScore, ABILITY_CONSTITUTION)) {
        iScore = GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE);
        iAbility = ABILITY_CONSTITUTION;
    }
    if (CheckIfLower(oPC, iScore, ABILITY_INTELLIGENCE)) {
        iScore = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE);
        iAbility = ABILITY_INTELLIGENCE;
    }
    if (CheckIfLower(oPC, iScore, ABILITY_WISDOM)) {
        iScore = GetAbilityScore(oPC, ABILITY_WISDOM, FALSE);
        iAbility = ABILITY_WISDOM;
    }
    if (CheckIfLower(oPC, iScore, ABILITY_CHARISMA)) {
        iScore = GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE);
        iAbility = ABILITY_CHARISMA;
    }

    return iAbility;
}

int GetBonus() {
    if (HasItem(IRON_INGOT_TAG)) {
        return IRON_INGOT;
    } else if (HasItem(SILVER_INGOT_TAG)) {
        return SILVER_INGOT;
    } else if (HasItem(COLD_INGOT_TAG)) {
        return COLD_INGOT;
    } else if (HasItem(DARK_STEEL_INGOT_TAG)) {
        return DARK_STEEL_INGOT;
    } else if (HasItem(ADAMANTIUM_INGOT_TAG)) {
        return ADAMANTIUM_INGOT;
    } else if (HasItem(MITHRAL_INGOT_TAG)) {
        return MITHRAL_INGOT;
    }

    return 0;
}

int RandomStrSkill() {
    switch (Random(4)) {
        case 0:
            return SKILL_DISCIPLINE;
        case 1:
            return SKILL_CLIMB; //28
        case 2:
            return SKILL_JUMP; //32
        case 3:
            return SKILL_SWIM; //33
    }

    return SKILL_DISCIPLINE;
}

int RandomDexSkill() {
    switch (Random(7)) {
        case 0:
            return SKILL_HIDE;
        case 1:
            return SKILL_MOVE_SILENTLY;
        case 2:
            return SKILL_OPEN_LOCK;
        case 3:
            return SKILL_PARRY;
        case 4:
            return SKILL_PICK_POCKET;
        case 5:
            return SKILL_SET_TRAP;
        case 6:
            return SKILL_TUMBLE;
    }

    return SKILL_HIDE;
}

int RandomConSkill() {
    switch (Random(4)) {
        case 0:
            return SKILL_DISCIPLINE;
        case 1:
            return SKILL_CONCENTRATION;
        case 2:
            return SKILL_JUMP;
        case 3:
            return SKILL_SWIM;
    }

    return SKILL_DISCIPLINE;
}

int RandomIntSkill() {
    switch (Random(7)) {
        case 0:
            return SKILL_APPRAISE;
        case 1:
            return SKILL_CRAFT_ARMOR;
        case 2:
            return SKILL_CRAFT_TRAP;
        case 3:
            return SKILL_DISABLE_TRAP;
        case 4:
            return SKILL_LORE;
        case 5:
            return SKILL_SEARCH;
        case 6:
            return SKILL_SPELLCRAFT;
    }

    return SKILL_APPRAISE;
}

int RandomWisSkill() {
    switch (Random(4)) {
        case 0:
            return SKILL_HEAL;
        case 1:
            return SKILL_LISTEN;
        case 2:
            return SKILL_SPOT;
        case 3:
            return SKILL_SENSE; //29
    }

    return SKILL_HEAL;
}

int RandomCharSkill() {
    switch (Random(7)) {
        case 0:
            return SKILL_ANIMAL_EMPATHY;
        case 1:
            return SKILL_BLUFF;
        case 2:
            return SKILL_INTIMIDATE;
        case 3:
            return SKILL_PERFORM;
        case 4:
            return SKILL_PERSUADE;
        case 5:
            return SKILL_TAUNT;
        case 6:
            return SKILL_USE_MAGIC_DEVICE;
    }

    return SKILL_ANIMAL_EMPATHY;
}

int GetRandDmgType() {
    switch (d3()) {
        case 1:
            return IP_CONST_DAMAGETYPE_SLASHING;
        case 2:
            return IP_CONST_DAMAGETYPE_PIERCING;
        case 3:
            return IP_CONST_DAMAGETYPE_BLUDGEONING;
    }

    return IP_CONST_DAMAGETYPE_SLASHING;
}

void AddRandomAlignmentBonus(int nAlignGroup, int nBonus, object oWeapon,
                             int nDamageType) {
    switch (d3()) {
        case 1:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyAttackBonusVsAlign(nAlignGroup, nBonus + 1),
                    oWeapon);
            break;
        case 2:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyACBonusVsAlign(nAlignGroup, Random(nBonus) + 1),
                    oWeapon);
            break;
        case 3:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamageBonusVsAlign(nAlignGroup, nDamageType,
                    nBonus + 1), oWeapon);
            break;
    }
}

void addRandomLageWeaponBonus(int nBonus, object oWeapon) {
    switch (d6()) {
        case 1:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyMassiveCritical(Random(nBonus) + 1), oWeapon);
            break;
        case 2:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyACBonus(Random(nBonus) + 1), oWeapon);
            break;
        case 3:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,
                    nBonus + 1), oWeapon);
            break;
        case 4:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,
                    nBonus + 1), oWeapon);
            break;
        case 5:
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,
                    nBonus + 1), oWeapon);
            break;
    }
}
