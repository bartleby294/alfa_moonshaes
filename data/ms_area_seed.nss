#include "ms_herb_seed"
#include "ms_seed_treasure"
#include "ms_seed_bandits"
#include "nwnx_time"

void RandomAreaSeed(object oArea) {

    int numberOfPlayers = NWNX_Area_GetNumberOfPlayersInArea(oArea);
    int curTime = NWNX_Time_GetTimeStamp();

    // Seed Herbs
    int maxHerbs = GetCampaignInt(MAX_HERBS_PER_AREA, GetResRef(oArea));
    if(maxHerbs > 0) {
        if(numberOfPlayers > 1) {
            WriteTimestampedLogEntry("MS HERBS: ON ENTER EXIT 1");
        } else {
            int lastHerbCreate = GetLocalInt(oArea, LAST_HERB_CREATE);
            WriteTimestampedLogEntry("MS HERBS: curTime - lastHerbCreate > HERB_CREATE_DELAY_SECONDS "
                                     + IntToString(curTime) + " - "
                                     + IntToString(lastHerbCreate) + " > "
                                     + IntToString(HERB_CREATE_DELAY_SECONDS));
            if(curTime - lastHerbCreate > HERB_CREATE_DELAY_SECONDS) {
                SetLocalInt(oArea, LAST_HERB_CREATE, curTime);
                HerbTearDown(oArea);
                DelayCommand(0.5, SeedRandomHerbs(oArea, maxHerbs));
            }
        }
    }

    // Seed Treasure
    int treasure = GetCampaignInt(MS_TREASURE_PER_AREA, GetResRef(oArea));
    if(treasure > 0) {
        if(numberOfPlayers > 1) {
            WriteTimestampedLogEntry("MS TREASURE: ON ENTER EXIT 1");
        } else {
            int lastTreasureCreate = GetLocalInt(oArea, LAST_TREASURE_CREATE);
            WriteTimestampedLogEntry("curTime - lastTreasureCreate > TREASURE_CREATE_DELAY_SECONDS "
                                     + IntToString(curTime) + " - "
                                     + IntToString(lastTreasureCreate) + " > "
                                     + IntToString(TREASURE_CREATE_DELAY_SECONDS));
            if(curTime - lastTreasureCreate > TREASURE_CREATE_DELAY_SECONDS) {
                //if(Random(100) > 80) {
                if(Random(100) >= 0) { // Testing Mode
                    SetLocalInt(oArea, LAST_TREASURE_CREATE, curTime);
                    TearTreasureDown(oArea);
                    DelayCommand(0.5, SeedRandomTreasure(oArea, 1));
                }
            }
        }
    }

    // Seed Bandits
    int bandits = GetCampaignInt(MS_BANDITS_PER_AREA, GetResRef(oArea));
    if(bandits > 0) {
        if(numberOfPlayers > 1) {
            WriteTimestampedLogEntry("MS TREASURE: ON ENTER EXIT 1");
        } else {
            int lastBanditCreate = GetLocalInt(oArea, LAST_BANDIT_AMBUSH_CREATE);
            WriteTimestampedLogEntry("curTime - lastBanditAmbushCreate > BANDIT_AMBUSH_CREATE_DELAY_SECONDS "
                                     + IntToString(curTime) + " - "
                                     + IntToString(lastBanditCreate) + " > "
                                     + IntToString(BANDIT_AMBUSH_CREATE_DELAY_SECONDS));
            if(curTime - lastBanditCreate > BANDIT_AMBUSH_CREATE_DELAY_SECONDS) {
                //if(Random(100) > 80) {
                if(Random(100) >= 0) { // Testing Mode
                    SetLocalInt(oArea, LAST_BANDIT_AMBUSH_CREATE, curTime);
                    TearBanditAmbushDown(oArea);
                    DelayCommand(0.5, SeedRandomBanditAmbush(oArea, bandits));
                }
            }
        }
    }
}
