string RandomBatSound() {

    switch(Random(9) + 1) {
        case 1:
            return "as_an_bat1";
        case 2:
            return "as_an_bat2";
        case 3:
            return "as_an_bat3";
        case 4:
            return "as_an_batflap1";
        case 5:
            return "as_an_batflap2";
        case 6:
            return "as_an_bats1";
        case 7:
            return "as_an_bat2";
        case 8:
            return "as_an_batsflap1";
        case 9:
            return "as_an_batsflap2";
    }
    return "";
}

void main()
{
    object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    AssignCommand ( oDM, PlaySound(RandomBatSound()));
}
