#include "ms_seed_bancamp"
#include "ms_bandit_ambcon"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    string race = pickRace();
    string class = pickClass();
    string resref = race + class + "m_bandit_1";

    object bandit = spawnBandit(resref, race, class, GetLocation(oPC), 1,
                                "banditcamper");

    SetEventScript(bandit, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                   "ja_ai_onheartbea");
    SetEventScript(bandit, EVENT_SCRIPT_CREATURE_ON_DEATH,
                   "ja_ai_ondeath");
    SetEventScript(bandit, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,
                   "ja_ai_onphiattac");

    //int banditCampCnt = GetCampaignInt(MS_BANDIT_CAMP_NUM, GetResRef(oArea));
    //SeedRandomBanditCampAtLocation(oArea, banditCampCnt, GetLocation(oPC));
}

