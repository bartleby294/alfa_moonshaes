// hc_summon_inc - include file for Summon Creature I-IX spells
// Archaegeo, June 28, 2002
// Hardcore Ruleset


// To use, you must download and import HardCoreERFSU.zip from the
// HCR WWW page for the actual creature files.  Then COMMENT OUT
// Line 23

//void main(){}

// SUMMONTIME - If 0, will use normal summoning duration, if 1 will cause creature
// to last 1 round (6 sec) per HitDice (level) of the summoner.  You can set it to
// higher numbers to multiple rounds, ie 3 would be 18 seconds per level of summoner.
// By the book though its 1 round.
int SUMMONTIME=1;

// pick_creature allows you to set up your summon creature tables how you wish.
string pick_creature(int nLevel)
{
    int nRoll;
    string sCreature="";
    // Comment the next line to use the summoned creatures tables
    return "";
    switch(nLevel) // Level of the Summon Creature spell
    {
    // This is all skipped right now due to the return "" above.  remove that line
    // when all of the creatures exist.
        // Summon Creature I
        case 1:
            nRoll=d4();
            switch(nRoll)
            {
                case 1:   sCreature="celestialdog"; break;
                case 2:   sCreature="celestialbadger"; break;
                case 3:   sCreature="fiendishdirerat"; break;
                case 4:   sCreature="fiendishhawk"; break;
            }
        break;

        // Summon Creature II
        case 2:
            nRoll=d4();
            switch(nRoll)
            {
                case 1:   sCreature="celestialeagle"; break;
                case 2:   sCreature="lemure"; break;
                case 3:   sCreature="fiendishwolf"; break;
                case 4:   sCreature="celestialwolf"; break;
             }

        break;
        // Summon Creature III
        case 3:
            nRoll=d8();
            switch(nRoll)
            {
                case 1:   sCreature="celestialblackbe"; break;
                case 2:   sCreature="celestialdirebad"; break;
                case 3:   sCreature="fiendishboar"; break;
                case 4:   sCreature="fiendishleopard"; break;
                case 5:   sCreature="s_earthelemental"; break;
                case 6:   sCreature="s_airelemental"; break;
                case 7:   sCreature="s_fireelemental"; break;
                case 8:   sCreature="s_waterelemental"; break;
            }
        break;

        // Summon Creature IV
        case 4:
            nRoll=d4();
            switch(nRoll)
            {
                case 1:   sCreature="lanternarchon"; break;
                case 2:   sCreature="celestiallion"; break;
                case 3:   sCreature="imp"; break;
                case 4:   sCreature="hellhound"; break;
            }
        break;

        // Summon Creature V
        case 5:
            nRoll=Random(18);
            switch(nRoll)
            {
                case 1:   sCreature="celestialblackbe"; break;
                case 2:   sCreature="houndarchon"; break;
                case 3:   sCreature="fiendishdireboar"; break;
                case 4:   sCreature="fiendishpanther"; break;
                case 5:   sCreature="m_airelemental"; break;
                case 6:   sCreature="m_earthelemental"; break;
                case 7:   sCreature="m_fireelemental"; break;
                case 8:   sCreature="m_waterelemental"; break;
                case 9:   sCreature="airmephit"; break;
                case 10:  sCreature="dustmephit"; break;
                case 11:  sCreature="earthmephit"; break;
                case 12:  sCreature="firemephit"; break;
                case 13:  sCreature="icemephit"; break;
                case 14:  sCreature="magmamephit"; break;
                case 15:  sCreature="oozemephit"; break;
                case 16:  sCreature="saltmephit"; break;
                case 17:  sCreature="steammephit"; break;
                case 18:  sCreature="watermephit"; break;
            }
            break;

        // Summon Creature VI
        case 6:
            nRoll=d6();
            switch(nRoll)
            {
                case 1:   sCreature="celestialdirebea"; break;
                case 2:   sCreature="redslaad"; break;
                case 3:   sCreature="l_airelemental"; break;
                case 4:   sCreature="l_earthelemental"; break;
                case 5:   sCreature="l_fireelemental"; break;
                case 6:   sCreature="l_waterelemental"; break;
            }
            break;

        // Summon Creature VII
        case 7:
            nRoll=Random(7);
            switch(nRoll)
            {
                case 1:   sCreature="h_airelemental"; break;
                case 2:   sCreature="h_earthelemental"; break;
                case 3:   sCreature="h_fireelemental"; break;
                case 4:   sCreature="h_waterelemental"; break;
                case 5:   sCreature="invis_stalker"; break;
                case 6:   sCreature="blueslaad"; break;
                case 7:   sCreature="fiendishdiretig"; break;
            }
            break;

        // Summon Creature VIII
        case 8:
            nRoll=Random(5);
            switch(nRoll)
            {
                case 1:   sCreature="g_airelemental"; break;
                case 2:   sCreature="g_earthelemental"; break;
                case 3:   sCreature="g_fireelemental"; break;
                case 4:   sCreature="g_waterelemental"; break;
                case 5:   sCreature="succubus"; break;
            }
            break;

        // Summon Creature IX
        case 9:
            nRoll=d6();
            switch(nRoll)
            {
                case 1:   sCreature="e_airelemental"; break;
                case 2:   sCreature="e_earthelemental"; break;
                case 3:   sCreature="e_fireelemental"; break;
                case 4:   sCreature="e_waterelemental"; break;
                case 5:   sCreature="rakshasa"; break;
                case 6:   sCreature="vrock"; break;
            }
            break;
    }
    // Return the chosen critter
    return sCreature;
}

