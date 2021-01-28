int RandomLvlZeroSpell() {

    int randSpell = Random(11);
    switch(randSpell)
    {
        case 0:
            return IP_CONST_CASTSPELL_ACID_SPLASH_1;
        case 1:
            return IP_CONST_CASTSPELL_CURE_MINOR_WOUNDS_1;
        case 2:
            return IP_CONST_CASTSPELL_INFLICT_MINOR_WOUNDS_1;
        case 3:
            return IP_CONST_CASTSPELL_LIGHT_1;
        case 4:
            return IP_CONST_CASTSPELL_LIGHT_5;
        case 5:
            return IP_CONST_CASTSPELL_RESISTANCE_2;
        case 6:
            return IP_CONST_CASTSPELL_VIRTUE_1;
        case 7:
            return IP_CONST_CASTSPELL_DAZE_1;
        case 8:
            return IP_CONST_CASTSPELL_ELECTRIC_JOLT_1;
        case 9:
            return IP_CONST_CASTSPELL_FLARE_1;
        case 10:
            return IP_CONST_CASTSPELL_RAY_OF_FROST_1;
    }

    return IP_CONST_CASTSPELL_LIGHT_1;
}

int RandomLvlOneSpell() {

    int randSpell = Random(32);
    switch(randSpell)
    {
        case 0:
            return IP_CONST_CASTSPELL_AMPLIFY_5;
        case 1:
            return IP_CONST_CASTSPELL_BALAGARNSIRONHORN_7;
        case 2:
            return IP_CONST_CASTSPELL_BANE_5;
        case 3:
            return IP_CONST_CASTSPELL_BLESS_2;
        case 4:
            return IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_2;
        case 5:
            return IP_CONST_CASTSPELL_DIVINE_FAVOR_5;
        case 6:
            return IP_CONST_CASTSPELL_DOOM_2;
        case 7:
            return IP_CONST_CASTSPELL_ENDURE_ELEMENTS_2;
        case 8:
            return IP_CONST_CASTSPELL_ENTROPIC_SHIELD_5;
        case 9:
            return IP_CONST_CASTSPELL_INFLICT_LIGHT_WOUNDS_5;
        case 10:
            return IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_2;
        case 11:
            return IP_CONST_CASTSPELL_REMOVE_FEAR_2;
        case 12:
            return IP_CONST_CASTSPELL_SANCTUARY_2;
        case 13:
            return IP_CONST_CASTSPELL_SCARE_2;
        case 14:
            return IP_CONST_CASTSPELL_SHIELD_OF_FAITH_5;
        case 15:
            return IP_CONST_CASTSPELL_SUMMON_CREATURE_I_2;
        case 16:
            return IP_CONST_CASTSPELL_CAMOFLAGE_5;
        case 17:
            return IP_CONST_CASTSPELL_ENTANGLE_2;
        case 18:
            return IP_CONST_CASTSPELL_MAGIC_FANG_5;
        case 19:
            return IP_CONST_CASTSPELL_GREASE_2;
        case 20:
            return IP_CONST_CASTSPELL_SLEEP_2;
        case 21:
            return IP_CONST_CASTSPELL_BURNING_HANDS_2;
        case 22:
            return IP_CONST_CASTSPELL_CHARM_PERSON_2;
        case 23:
            return IP_CONST_CASTSPELL_COLOR_SPRAY_2;
        case 24:
            return IP_CONST_CASTSPELL_EXPEDITIOUS_RETREAT_5;
        case 25:
            return IP_CONST_CASTSPELL_IDENTIFY_3;
        case 26:
            return IP_CONST_CASTSPELL_MAGE_ARMOR_2;
        case 27:
            return IP_CONST_CASTSPELL_MAGIC_MISSILE_3;
        case 28:
            return IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_1;
        case 29:
            return IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_3;
        case 30:
            return IP_CONST_CASTSPELL_RAY_OF_ENFEEBLEMENT_2;
        case 31:
            return IP_CONST_CASTSPELL_TRUE_STRIKE_5;
    }

    return IP_CONST_CASTSPELL_IDENTIFY_3;
}

int RandomLvlTwoSpell() {

    int randSpell = Random(36);
    switch(randSpell)
    {
        case 0:
            return IP_CONST_CASTSPELL_AID_3;
        case 1:
            return IP_CONST_CASTSPELL_AURAOFGLORY_7;
        case 2:
            return IP_CONST_CASTSPELL_BARKSKIN_3;
        case 3:
            return IP_CONST_CASTSPELL_BULLS_STRENGTH_3;
        case 4:
            return IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_3;
        case 5:
            return IP_CONST_CASTSPELL_DARKNESS_3;
        case 6:
            return IP_CONST_CASTSPELL_EAGLE_SPLEDOR_3;
        case 7:
            return IP_CONST_CASTSPELL_ENDURANCE_3;
        case 8:
            return IP_CONST_CASTSPELL_FIND_TRAPS_3;
        case 9:
            return IP_CONST_CASTSPELL_FOXS_CUNNING_3;
        case 10:
            return IP_CONST_CASTSPELL_HOLD_PERSON_3;
        case 11:
            return IP_CONST_CASTSPELL_INFLICT_MODERATE_WOUNDS_7;
        case 12:
            return IP_CONST_CASTSPELL_LESSER_DISPEL_3;
        case 13:
            return IP_CONST_CASTSPELL_LESSER_RESTORATION_3;
        case 15:
            return IP_CONST_CASTSPELL_OWLS_WISDOM_3;
        case 16:
            return IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        case 17:
            return IP_CONST_CASTSPELL_RESIST_ELEMENTS_3;
        case 18:
            return IP_CONST_CASTSPELL_SILENCE_3;
        case 19:
            return IP_CONST_CASTSPELL_SOUND_BURST_3;
        case 20:
            return IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        case 21:
            return IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_3;
        case 22:
            return IP_CONST_CASTSPELL_FLAME_LASH_3;
        case 23:
            return IP_CONST_CASTSPELL_HOLD_ANIMAL_3;
        case 24:
            return IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7;
        case 25:
            return IP_CONST_CASTSPELL_BLINDNESS_DEAFNESS_3;
        case 26:
            return IP_CONST_CASTSPELL_CATS_GRACE_3;
        case 27:
            return IP_CONST_CASTSPELL_GHOSTLY_VISAGE_3;
        case 28:
            return IP_CONST_CASTSPELL_GHOUL_TOUCH_3;
        case 29:
            return IP_CONST_CASTSPELL_INVISIBILITY_3;
        case 30:
            return IP_CONST_CASTSPELL_KNOCK_3;
        case 31:
            return IP_CONST_CASTSPELL_MELFS_ACID_ARROW_3;
        case 32:
            return IP_CONST_CASTSPELL_SEE_INVISIBILITY_3;
        case 33:
            return IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3;
        case 34:
            return IP_CONST_CASTSPELL_TASHAS_HIDEOUS_LAUGHTER_7;
        case 35:
            return IP_CONST_CASTSPELL_WEB_3;
    }

    return IP_CONST_CASTSPELL_KNOCK_3;
}
