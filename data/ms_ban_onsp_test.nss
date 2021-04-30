void main()
{
    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONBLOCK") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR,
                       "ja_ai_onblocked");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR,
                       "ja_ai_onblocked");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCOMEND") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND,
                       "ba_ai_oncombatro");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND,
                       "ja_ai_oncombatro");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCONV") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DIALOGUE,
                       "ja_ai_onconversa");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DIALOGUE,
                       "ja_ai_onconversa");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDMG") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DAMAGED,
                       "band_ai_ondamage");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DAMAGED,
                       "ja_ai_ondamage");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDEATH") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DEATH,
                       "band_ai_ondeath");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DEATH,
                       "ja_ai_ondeath");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDIST") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DISTURBED,
                       "ja_ai_ondisturbe");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DISTURBED,
                       "ja_ai_ondisturbe");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONHB") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                       "ba_ai_onheartbe2");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                       "ja_ai_onheartbea");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPERCEP") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_NOTICE,
                       "ba_ai_onpercieve");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_NOTICE,
                       "ja_ai_onpercieve");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPATTACK") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,
                       "ba_ai_onphiattac");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,
                       "ja_ai_onphiattac");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONREST") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_RESTED,
                       "ja_ai_onrest");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_RESTED,
                       "ja_ai_onrest");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPELLCAST") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT,
                       "ja_ai_onspellcas");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT,
                       "ja_ai_onspellcas");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONUSRDEF") == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT,
                       "ja_ai_onuserdef");
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT,
                       "ja_ai_onuserdef");
    }

    if(GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPAWN") == FALSE) {
        ExecuteScript("band_ai_onspawn2");
    } else {
        ExecuteScript("jai_kob_mel_onsp");
    }


}
