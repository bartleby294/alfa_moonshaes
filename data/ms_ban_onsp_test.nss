void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPAWN");
    // Custom Bandit Scripts
    if(toggle == FALSE) {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR,
                       "ja_ai_onblocked");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND,
                       "ba_ai_oncombatro");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DIALOGUE,
                       "ja_ai_onconversa");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DAMAGED,
                       "band_ai_ondamage");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DEATH,
                       "band_ai_ondeath");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DISTURBED,
                       "ja_ai_ondisturbe");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                       "ba_ai_onheartbe2");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_NOTICE,
                       "ba_ai_onpercieve");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,
                       "ba_ai_onphiattac");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_RESTED,
                       "ja_ai_onrest");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT,
                       "ja_ai_onspellcas");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT,
                       "ja_ai_onuserdef");
        ExecuteScript("band_ai_onspawn2");
    // Generic Kobold scripts
    } else {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR,
                       "ja_ai_onblocked");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND,
                       "ja_ai_oncombatro");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DIALOGUE,
                       "ja_ai_onconversa");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DAMAGED,
                       "ja_ai_ondamage");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DEATH,
                       "ja_ai_ondeath");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DISTURBED,
                       "ja_ai_ondisturbe");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                       "ja_ai_onheartbea");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_NOTICE,
                       "ja_ai_onpercieve");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,
                       "ja_ai_onphiattac");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_RESTED,
                       "ja_ai_onrest");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT,
                       "ja_ai_onspellcas");
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT,
                       "ja_ai_onuserdef");
        ExecuteScript("jai_kob_mel_onsp");
    }
}
