//::///////////////////////////////////////////////
//:: Name Alfa Languages
//:: FileName alfa_lang_inc
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ariak
//:: Created On: 5 oct 2004
//:://////////////////////////////////////////////

//:://////////////////////////////////////////////


//:://////////////////////////////////////////////
//:: Constants
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

const string STORAGE_ITEM = "emoteitem";

const int ALFA_LANG_ABYSSAL              = 1;
const int ALFA_LANG_AGLARONDAN           = 2;
const int ALFA_LANG_ALZHEDO              = 3;
const int ALFA_LANG_ARAGRAKH             = 4;
const int ALFA_LANG_AURAN                = 5;
const int ALFA_LANG_CELESTIAL            = 6;
const int ALFA_LANG_CHESSENTAN           = 7;
const int ALFA_LANG_CHONDATHAN           = 8;
const int ALFA_LANG_CHULTAN              = 9;
const int ALFA_LANG_COMMON               = 10;
const int ALFA_LANG_DAMARAN              = 11;
const int ALFA_LANG_DRACONIC             = 12;
const int ALFA_LANG_DROW_SIGN_LANGUAGE   = 13;
const int ALFA_LANG_DRUIDIC              = 14;
const int ALFA_LANG_DWARVEN              = 15;
const int ALFA_LANG_ELVEN                = 16;
const int ALFA_LANG_GIANT                = 17;
const int ALFA_LANG_GNOLL                = 18;
const int ALFA_LANG_GNOME                = 19;
const int ALFA_LANG_GOBLIN               = 20;
const int ALFA_LANG_HALFLING             = 21;
const int ALFA_LANG_HALRUAAN             = 22;
const int ALFA_LANG_HULGORKYN            = 23;
const int ALFA_LANG_INFERNAL             = 24;
const int ALFA_LANG_ILLUSKAN             = 25;
const int ALFA_LANG_LANTANESE            = 26;
const int ALFA_LANG_LOROSS               = 27;
const int ALFA_LANG_MIDANI               = 28;
const int ALFA_LANG_MULHORANDI           = 29;
const int ALFA_LANG_NETHERESE            = 30;
const int ALFA_LANG_ORC                  = 31;
const int ALFA_LANG_RASHEMI              = 32;
const int ALFA_LANG_ROUSHOUM             = 33;
const int ALFA_LANG_SELDRUIN             = 34;
const int ALFA_LANG_SHAARAN              = 35;
const int ALFA_LANG_SYLVAN               = 36;
const int ALFA_LANG_TASHALAN             = 37;
const int ALFA_LANG_TERRAN               = 38;
const int ALFA_LANG_THORASS              = 39;
const int ALFA_LANG_TUIGAN               = 40;
const int ALFA_LANG_UNDERCOMMON          = 41;
const int ALFA_LANG_UNTHERIC             = 42;

const int ALFA_REGION_AGLAROND           =  1;
const int ALFA_REGION_AMN                =  2;
const int ALFA_REGION_ANOUROCH           =  3;
const int ALFA_REGION_CALIMSHAN          =  4;
const int ALFA_REGION_CHESSENTA          =  5;
const int ALFA_REGION_CHONDALWOOD        =  6;
const int ALFA_REGION_CHULT              =  7;
const int ALFA_REGION_CORMYR             =  8;
const int ALFA_REGION_DALELANDS          =  9;
const int ALFA_REGION_DAMARA             = 10;
const int ALFA_REGION_DRAGON_COAST       = 11;
const int ALFA_REGION_GREAT_DALE         = 12;
const int ALFA_REGION_HALRUAA            = 13;
const int ALFA_REGION_HIGH_FOREST        = 14;
const int ALFA_REGION_HORDELANDS         = 15;
const int ALFA_REGION_IMPILTUR           = 16;
const int ALFA_REGION_LAKE_OF_STREAMS    = 17;
const int ALFA_REGION_LANTAN             = 18;
const int ALFA_REGION_LUIREN             = 19;
const int ALFA_REGION_MOONSEA            = 20;
const int ALFA_REGION_MOONSHAE_ISLES     = 21;
const int ALFA_REGION_MULHORAND          = 22;
const int ALFA_REGION_NARFELL            = 23;
const int ALFA_REGION_NELANTHER_ISLES    = 24;
const int ALFA_REGION_RASHEMEN           = 25;
const int ALFA_REGION_SEMBIA             = 26;
const int ALFA_REGION_SILVERYMOON        = 27;
const int ALFA_REGION_TASHALAR           = 28;
const int ALFA_REGION_TETHYR             = 29;
const int ALFA_REGION_THAY               = 30;
const int ALFA_REGION_THESK              = 31;
const int ALFA_REGION_THE_NORTH          = 32;
const int ALFA_REGION_THE_SHAAR          = 33;
const int ALFA_REGION_THE_VAST           = 34;
const int ALFA_REGION_WATERDEEP          = 35;
const int ALFA_REGION_WESTERN_HEARTLANDS = 36;
const int ALFA_REGION_VAASA              = 37;
const int ALFA_REGION_UNTHER             = 38;

//:://////////////////////////////////////////////
//:: Function Prototypes
//:://////////////////////////////////////////////

//Get the storage item from the chosen PC.
object getStorageItem(object oOwner);

//Get the number of bonus languages the PC has chosen.
int getChosenBonusLangCount(object oPC);

//Check if a PC has the chosen language.
int hasLanguage(object oPC, int nLanguage);

//Check if the PC has chosen a region language
int getIsRegionLangSet(object oPC);

//Get the number of unused ranks in speak language
int getUnusedRanks(object oPC);

//Add a bonuslanguage for a PC
void setBonusLanguage(object oPC, int nLanguage);

//Check if the PC has set all his bonuslanguages
int getIsBonusLangSet(object oPC);

//Add a language for a PC
void setLanguage(object oPC, int nLanguage);

//Set the regional language for a PC
void setRegionAndLanguage(object oPC, int nRegion, int nLanguage);

//Show languages
void showLanguages(object oPC);

//Find language name
string getLanguageName(int nLanguage);

//Get all the bonus languages the PC has as a string
string getBonusLanguageList(object oPC);

//Get all the race languages the PC has as a string
string getRaceLanguageList(object oPC);

//Get all the class languages the PC has as a string
string getClassLanguageList(object oPC);

//Get the regionlanguage the PC has as a string
string getRegionLanguageName(object oPC);

//Get the languages the PC has as a string
string getLanguageList(object oPC);

//Get the languages the PC has as a string
string getHomeRegionName(object oPC);

//Get unmodified intelligence modifier from PC
int getUnmodifiedIntMod(object oPC);

//Check if a PC is litterate
int isLitterate(object oPC);

//:://////////////////////////////////////////////
//:: Functions
//:://////////////////////////////////////////////

object getStorageItem(object oOwner)
{
    return GetItemPossessedBy(oOwner, STORAGE_ITEM);
}

int getChosenBonusLangCount(object oPC)
{
    object oStorageItem = getStorageItem(oPC);

    if(GetIsObjectValid(oStorageItem))
    {
        string sBonusLanguages = GetLocalString(oStorageItem, "bonuslanguages");

        if(sBonusLanguages != "")
        {
            return GetStringLength(sBonusLanguages)/2;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

int getIsBonusLangSet(object oPC)
{
    object oStorageItem = getStorageItem(oPC);

    if(GetIsObjectValid(oStorageItem))
    {
        int nBonusLangSet = GetLocalInt(oStorageItem, "bonuslangset");
        if(nBonusLangSet)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    return FALSE;
}

void setBonusLanguage(object oPC, int nLanguage)
{
    int nIntMod = getUnmodifiedIntMod(oPC);
    object oStorageItem = getStorageItem(oPC);

    if(GetIsObjectValid(oStorageItem) && nIntMod > 0)
    {
        string sBonusLang = GetLocalString(oStorageItem, "bonuslanguages");

        if(sBonusLang != "")
        {
            if(nLanguage > 9)
            {
                sBonusLang += IntToString(nLanguage);
            }
            else
            {
                sBonusLang = sBonusLang + "0" + IntToString(nLanguage);
            }
        }
        else
        {
            if(nLanguage > 9)
            {
                sBonusLang = IntToString(nLanguage);
            }
            else
            {
                sBonusLang = "0" + IntToString(nLanguage);
            }
        }
        SetLocalString(oStorageItem, "bonuslanguages", sBonusLang);

        if(nIntMod == GetStringLength(sBonusLang)/2)
        {
            SetLocalInt(oStorageItem, "bonuslangset", 1);
        }
    }
}

void setLanguage(object oPC, int nLanguage)
{
    object oStorageItem = getStorageItem(oPC);

    if(GetIsObjectValid(oStorageItem))
    {
        string sLang = GetLocalString(oStorageItem, "languages");

        if(sLang != "")
        {
            if(nLanguage > 9)
            {
                sLang += IntToString(nLanguage);
            }
            else
            {
                sLang = sLang + "0" + IntToString(nLanguage);
            }
        }
        else
        {
            if(nLanguage > 9)
            {
                sLang = IntToString(nLanguage);
            }
            else
            {
                sLang = "0" + IntToString(nLanguage);
            }
        }

        SetLocalString(oStorageItem, "languages", sLang);
    }
}

void setRegionAndLanguage(object oPC, int nRegion, int nLanguage)
{
    object oStorageItem = getStorageItem(oPC);

    if(GetIsObjectValid(oStorageItem))
    {
        string sRegion;
        string sRegionLang;
        string sRegionAndLang;

        if(nRegion > 9)
        {
           sRegion = IntToString(nRegion);
        }
        else
        {
            sRegion = "0" + IntToString(nRegion);
        }


        if(nLanguage > 9)
        {
           sRegionLang = IntToString(nLanguage);
        }
        else
        {
            sRegionLang = "0" + IntToString(nLanguage);
        }
        sRegionAndLang = sRegion + sRegionLang;
        SetLocalString(oStorageItem, "regionlanguage", sRegionAndLang);
    }
}

int hasLanguage(object oPC, int nLanguage)
{
    int bResult = FALSE;
    object oStorageItem = getStorageItem(oPC);
    string sTemp;

    int nSubrace = GetLocalInt(oPC, "SUBRACE_CHARACTER");

    if(nSubrace != 0)
    {
        switch(nSubrace)
        {
            case  2: //SUBRACE_DWARF_GOLD

                if(nLanguage == 10 || nLanguage == 15)
                {
                    return TRUE;
                }
                break;

            case  3: //SUBRACE_DWARF_GRAY

                if(nLanguage == 15 || nLanguage == 41)
                {
                    return TRUE;
                }
                break;

            case  4: //SUBRACE_DWARF_SHIELD

                if(nLanguage == 10 || nLanguage == 15)
                {
                    return TRUE;
                }
                break;

            case  5: //SUBRACE_ELF_DARK

                if(nLanguage == 10 || nLanguage == 16 || nLanguage == 41)
                {
                    return TRUE;
                }
                break;

            case  6: //SUBRACE_ELF_MOON

                if(nLanguage == 10 || nLanguage == 16)
                {
                    return TRUE;
                }
                break;

            case  7: //SUBRACE_ELF_SUN

                if(nLanguage == 10 || nLanguage == 16)
                {
                    return TRUE;
                }
                break;

            case  8: //SUBRACE_ELF_WILD

                if(nLanguage == 10 || nLanguage == 16)
                {
                    return TRUE;
                }
                break;

            case  9: //SUBRACE_ELF_WOOD

                if(nLanguage == 10 || nLanguage == 16)
                {
                    return TRUE;
                }
                break;

            case 10: //SUBRACE_GNOME_DEEP

                if(nLanguage == 19 || nLanguage == 41)
                {
                    return TRUE;
                }
                break;

            case 11: //SUBRACE_GNOME_ROCK

                if(nLanguage == 10 || nLanguage == 19)
                {
                    return TRUE;
                }
                break;

            case 12: //SUBRACE_HALFELF

                if(nLanguage == 10 || nLanguage == 16)
                {
                    return TRUE;
                }
                break;

            case 13: //SUBRACE_HALFORC

                if(nLanguage == 10 || nLanguage == 31)
                {
                    return TRUE;
                }
                break;

            case 14: //SUBRACE_HALFLING_GHOSTWISE

                if(nLanguage == 10 || nLanguage == 21)
                {
                    return TRUE;
                }
                break;

            case 15: //SUBRACE_HALFLING_LIGHTFOOT

                if(nLanguage == 10 || nLanguage == 21)
                {
                    return TRUE;
                }
                break;

            case 16: //SUBRACE_HALFLING_STRONGHEART

                if(nLanguage == 10 || nLanguage == 11)
                {
                    return TRUE;
                }
                break;

            case 17: //SUBRACE_HUMAN

                if(nLanguage == 10)
                {
                    return TRUE;
                }
                break;

            case 18: //SUBRACE_HALFDROW

                if(nLanguage == 10 || nLanguage == 16)
                {
                    return TRUE;
                }
                break;
        }
    }

    //Check if language is a classlanguage

    if(GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 && nLanguage == 14)
    {
        return TRUE;
    }

    if(GetIsObjectValid(oStorageItem))
    {
        string sBonusLang = GetLocalString(oStorageItem, "bonuslanguages");
        string sLanguages = GetLocalString(oStorageItem, "languages");
        string sRegionLanguage = GetLocalString(oStorageItem, "regionlanguage");

        if(sRegionLanguage != "")
        {
            sTemp = GetSubString(sRegionLanguage, 2, 2);
            if(StringToInt(sTemp) == nLanguage)
            {
                return TRUE;
            }
        }

        if(sBonusLang != "")
        {
            int nLanguages = GetStringLength(sBonusLang);

            int i;
            for( i=0; i < nLanguages; i++)
            {
                i++;
                sTemp = GetSubString(sBonusLang, i, 2);
                if(StringToInt(sTemp) == nLanguage)
                {
                  return TRUE;
                }
            }
        }
        else if(sLanguages != "")
        {
            int nLanguages = GetStringLength(sLanguages);

            int i;
            for(i=0; i < nLanguages; i++)
            {
                i++;
                sTemp = GetSubString(sLanguages, i, 2);
                if(StringToInt(sTemp) == nLanguage)
                {
                  return TRUE;
                }
            }
        }
    }
    return bResult;
}

int getIsRegionLangSet(object oPC)
{
    object oStorageItem = getStorageItem(oPC);

    if(GetIsObjectValid(oStorageItem))
    {
        string sRegionLang = GetLocalString(oStorageItem, "regionlanguage");
        if(sRegionLang != "")
        {
            return TRUE;
        }
    }
    return FALSE;
}

string getLanguageName(int nLanguage)
{
    switch(nLanguage)
    {
        case  1: return "Abyssal";
        case  2: return "Aglarondan";
        case  3: return "Alzhedo";
        case  4: return "Aragrakh";
        case  5: return "Auran";
        case  6: return "Celestial";
        case  7: return "Chessentan";
        case  8: return "Chondathan";
        case  9: return "Chultan";
        case 10: return "Common";
        case 11: return "Damaran";
        case 12: return "Draconic";
        case 13: return "Drow Sign Language";
        case 14: return "Druidic";
        case 15: return "Dwarven";
        case 16: return "Elven";
        case 17: return "Giant";
        case 18: return "Gnoll";
        case 19: return "Gnome";
        case 20: return "Goblin";
        case 21: return "Halfling";
        case 22: return "Halruaan";
        case 23: return "Hulgorkyn";
        case 24: return "Infernal";
        case 25: return "Illuskan";
        case 26: return "Lantanese";
        case 27: return "Loross";
        case 28: return "Midani";
        case 29: return "Mulhorandi";
        case 30: return "Netherese";
        case 31: return "Orc";
        case 32: return "Rashemi";
        case 33: return "Roushoum";
        case 34: return "Seldruin";
        case 35: return "Shaaran";
        case 36: return "Sylvan";
        case 37: return "Tashalan";
        case 38: return "Terran";
        case 39: return "Thoras";
        case 40: return "Tuigan";
        case 41: return "Undercommon";
        case 42: return "Untheric";

    }
    return "UNKNOWN";
}

string getRegionName(int nRegion)
{
    switch(nRegion)
    {
        case  1: return "Aglarond";
        case  2: return "Amn";
        case  3: return "Anouroch";
        case  4: return "Calimshan";
        case  5: return "Chessenta";
        case  6: return "Chondalwood";
        case  7: return "Chult";
        case  8: return "Cormyr";
        case  9: return "Dalelands";
        case 10: return "Damara";
        case 11: return "Dragon coast";
        case 12: return "Great Dale";
        case 13: return "Halruaa";
        case 14: return "High Forest";
        case 15: return "Hordelands";
        case 16: return "Impiltur";
        case 17: return "Lake of Streams";
        case 18: return "Lantan";
        case 19: return "Luiren";
        case 20: return "Moonsea";
        case 21: return "Moonshae Isles";
        case 22: return "Mulhorand";
        case 23: return "Narfell";
        case 24: return "Nelanther Isles";
        case 25: return "Rashemen";
        case 26: return "Sembia";
        case 27: return "Silverymoon";
        case 28: return "Tashalar";
        case 29: return "Tethyr";
        case 30: return "Thay";
        case 31: return "Thesk";
        case 32: return "The North";
        case 33: return "The Shaar";
        case 34: return "The Vast";
        case 35: return "Waterdeep";
        case 36: return "Western heartlands";
        case 37: return "Vaasa";
        case 38: return "Unther";
    }
    return "UNKNOWN";
}

string getBonusLanguageList(object oPC)
{
    object oStorageItem = getStorageItem(oPC);
    string sLanguages = "";

    if(GetIsObjectValid(oStorageItem))
    {
        string sBonusLang = GetLocalString(oStorageItem, "bonuslanguages");

        if(sBonusLang != "")
        {
            int nLanguages = GetStringLength(sBonusLang);
            int nLanguage;
            int i;
            string sTemp;

            for(i=0; i < nLanguages; i++)
            {
                sTemp = GetSubString(sBonusLang, i, 2);
                nLanguage = StringToInt(sTemp);
                sLanguages += getLanguageName(nLanguage);
                if((nLanguages > 2) && ( i < nLanguages-4))
                {
                    sLanguages += ", ";
                }
                else if((nLanguages > 2) && (i == nLanguages-4))
                {
                    sLanguages += " and ";
                }
                i++;
            }
        }
        else
        {
            sLanguages = "none";
        }
    }
    return sLanguages;
}

string getRegionLanguageName(object oPC)
{
    int nLanguage;
    object oStorageItem = getStorageItem(oPC);
    string sRegionLang;

    if(GetIsObjectValid(oStorageItem))
    {
        sRegionLang = GetLocalString(oStorageItem, "regionlanguage");
        if(sRegionLang != "")
        {
            string sTemp = GetStringRight(sRegionLang, 2);
            nLanguage = StringToInt(sTemp);
            sRegionLang = getLanguageName(nLanguage);
        }
        else
        {
            sRegionLang = "none";
        }
    }
    return sRegionLang;
}

string getHomeRegionName(object oPC)
{
    int nLanguage;
    object oStorageItem = getStorageItem(oPC);
    string sRegionLang;

    if(GetIsObjectValid(oStorageItem))
    {
        sRegionLang = GetLocalString(oStorageItem, "regionlanguage");
        if(sRegionLang != "")
        {
            string sTemp = GetStringLeft(sRegionLang, 2);
            nLanguage = StringToInt(sTemp);
            sRegionLang = getRegionName(nLanguage);
        }
        else
        {
            sRegionLang = "none";
        }
    }
    return sRegionLang;
}

string getLanguageList(object oPC)
{
    object oStorageItem = getStorageItem(oPC);
    string sLanguages = "";

    if(GetIsObjectValid(oStorageItem))
    {
        string sLang = GetLocalString(oStorageItem, "languages");

        if(sLang != "")
        {
            int nLanguages = GetStringLength(sLang);
            int nLanguage;
            int i;
            string sTemp;

            for(i=0; i < nLanguages; i++)
            {
                sTemp = GetSubString(sLang, i, 2);
                nLanguage = StringToInt(sTemp);
                sLanguages += getLanguageName(nLanguage);
                if((nLanguages > 2) && ( i < nLanguages-4))
                {
                    sLanguages += ", ";
                }
                else if((nLanguages > 2) && (i == nLanguages-4))
                {
                    sLanguages += " and ";
                }
                i++;
            }
        }
        else
        {
            sLanguages = "none";
        }
    }
    return sLanguages;
}

string getRaceLanguageList(object oPC)
{
    int nSubrace = GetLocalInt(oPC, "SUBRACE_CHARACTER");

    if(nSubrace != 0)
    {
        switch(nSubrace)
        {
            case  2: //SUBRACE_DWARF_GOLD
                return "Dwarven and Common";
            case  3: //SUBRACE_DWARF_GRAY
                return "Dwarven and Undercommon";
            case  4: //SUBRACE_DWARF_SHIELD
                return "Dwarven and Common";
            case  5: //SUBRACE_ELF_DARK
                return "Common, Elven and Undercommon";
            case  6: //SUBRACE_ELF_MOON
                return "Elven and Common";
            case  7: //SUBRACE_ELF_SUN
                return "Elven and Common";
            case  8: //SUBRACE_ELF_WILD
                return "Elven and Common";
            case  9: //SUBRACE_ELF_WOOD
                return "Elven and Common";
            case 10: //SUBRACE_GNOME_DEEP
                return "Gnome and Undercommon";
            case 11: //SUBRACE_GNOME_ROCK
                return "Gnome and Common";
            case 12: //SUBRACE_HALFELF
                return "Elven and Common";
            case 13: //SUBRACE_HALFORC
                return "Orc and Common";
            case 14: //SUBRACE_HALFLING_GHOSTWISE
                return "Halfling and Common";
            case 15: //SUBRACE_HALFLING_LIGHTFOOT
                return "Halfling and Common";
            case 16: //SUBRACE_HALFLING_STRONGHEART
                return "Halfling and Common";
            case 17: //SUBRACE_HUMAN
                return "Common";
            case 18: //SUBRACE_HALFDROW
                return "Elven and Common";
        }
    }
    return "Subrace could not be found!";
}

string getClassLanguageList(object oPC)
{
    string languagelist = "none";

    if(GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0)
    {
        languagelist = "Druidic";
    }
    return languagelist;
}

int getUnusedRanks(object oPC)
{
    object oStorageItem = getStorageItem(oPC);
    int nClass = GetClassByPosition(1, oPC);
    int nIntMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
    int nRanks = GetSkillRank(SKILL_SPEAK_LANGUAGE, oPC)- nIntMod;
    int nUnusedRanks = 0;

    //Check if the PC's first class is Barbarian and reduce ranks by 1.
    if(nClass == CLASS_TYPE_BARBARIAN)
    {
        nRanks -= 1;
    }

    //Check for languages already learned and subtract from number of ranks
    if(GetIsObjectValid(oStorageItem) && nRanks > 0)
    {
        string sLanguages = GetLocalString(oStorageItem, "languages");

        if(sLanguages != "")
        {
            int nLangCount = GetStringLength(sLanguages)/2;

            if(nLangCount < nRanks)
            {
                nUnusedRanks = nRanks - nLangCount;
            }
        }

    }
    return nUnusedRanks;
}

int getUnmodifiedIntMod(object oPC)
{
    int nIntMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
    int nItemIntMod = 0;
    int nModifier;
    int i;
    int nType = ITEM_PROPERTY_ABILITY_BONUS;
    int nSubType = ABILITY_INTELLIGENCE;
    itemproperty ip;
    object oItem;


    if(GetHasEffect(EFFECT_TYPE_ABILITY_INCREASE, oPC))
    {
        effect eFind = GetFirstEffect(oPC);

        while(GetIsEffectValid(eFind))
        {
            if(GetEffectSpellId(eFind) == SPELL_FOXS_CUNNING)
            {
                RemoveEffect(oPC, eFind);
            }
            eFind = GetNextEffect(oPC);
        }
    }

    for (i = 0; i < 18; ++i)
    {
        oItem = GetItemInSlot(i, oPC);
        ip = GetFirstItemProperty(oItem);
        if (GetIsObjectValid(oItem))
        {
            ip = GetFirstItemProperty(oItem);

            while (GetIsItemPropertyValid(ip))
            {
                if ((GetItemPropertyType(ip) == nType))
                {
                    if (GetItemPropertySubType(ip) == nSubType)
                    {
                        if (GetItemPropertyDurationType(ip) == DURATION_TYPE_PERMANENT)
                        {
                            nModifier = GetItemPropertyCostTableValue(ip);
                            if(nModifier > nItemIntMod)
                            {
                                nItemIntMod = nModifier;
                            }
                        }
                    }
                }
                ip = GetNextItemProperty(oItem);
            }
        }
    }

    if(nItemIntMod > 0)
    {
        nIntMod = nIntMod - nItemIntMod/2;
    }
    //string msg = "your INT modifier is " + IntToString(nIntMod);
    //SendMessageToPC(oPC, msg);
    return nIntMod;
}

int isLitterate(object oPC)
{
    int nClass = GetClassByPosition(1, oPC);
    int nIntMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
    int nRanks = GetSkillRank(SKILL_SPEAK_LANGUAGE, oPC)- nIntMod;

    //Check if the PC's first class is Barbarian
    if(nClass == CLASS_TYPE_BARBARIAN)
    {
        //Check if the Barbarian has taken ranks in Speak Language
        if(nRanks > 0)
        {
            return TRUE;  //Barbarian PC is litterate
        }
        else
        {
            return FALSE; //Barbarian PC is not litterate
        }
    }
    else
    {
        return TRUE; //All classes except Barbarians are litterat by default
    }
}

