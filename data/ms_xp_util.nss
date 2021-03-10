void GiveAndLogXP(object oPC, int xpAmount, string xpEventName,
                  string description) {

    WriteTimestampedLogEntry("XP LOGGING: " + xpEventName + " - Awarding "
                             + GetName(oPC) + " played by "
                             + GetPCPlayerName(oPC) + " "
                             + IntToString(xpAmount) + " for " + description);
    GiveXPToCreature(oPC, xpAmount);
}

