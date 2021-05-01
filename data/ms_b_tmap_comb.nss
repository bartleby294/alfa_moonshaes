int GetCompleteQty(string type) {

    if(type == "q") {
        return 4;
    }

    if(type == "t") {
        return 3;
    }

    if(type == "h") {
        return 2;
    }

    return 0;
}

void main()
{
    object oPC = OBJECT_SELF;
    object oMapPeice = GetItemActivated();
    object oMapTarget = GetItemActivatedTarget();

    // Abort if stacked and msg player.
    if(GetItemStackSize(oMapPeice) > 1 || GetItemStackSize(oMapTarget) > 1) {
        SendMessageToPC(oPC, "Maybe I should unstack the map peices so I dont mix them up.");
        return;
    }

    string oMapPeiceTag = GetTag(oMapPeice);
    string oMapTargetTag = GetTag(oMapTarget);

    WriteTimestampedLogEntry("BANDIT TREASURE MAP: oMapPeiceTag: " + oMapPeiceTag);
    WriteTimestampedLogEntry("BANDIT TREASURE MAP: oMapTargetTag: " + oMapTargetTag);

    string MapStyleStr = GetStringRight(oMapPeiceTag, 1);
    int MapQty = StringToInt(GetSubString(oMapPeiceTag, 8, 1));
    string MapTypeStr = GetSubString(oMapPeiceTag, 9, 1);

    string TargetStyleStr = GetStringRight(oMapTargetTag, 1);
    int TargetQty = StringToInt(GetSubString(oMapTargetTag, 8, 1));
    string TargetTypeStr = GetSubString(oMapTargetTag, 9, 1);

    int completeQty = GetCompleteQty(MapTypeStr);
    int combinedQty = MapQty + TargetQty;

    // if not a valid combination return out.
    if(MapStyleStr != TargetStyleStr || MapTypeStr != TargetTypeStr
       || combinedQty > completeQty) {
        return;
    }

    // If the map is complete give full map!
    if(combinedQty == completeQty) {
        CreateItemOnObject("ms_btreasure_map", oPC);
        WriteTimestampedLogEntry("BANDIT TREASURE MAP: creating ms_btreasure_map");
    // Else combine them!
    } else {
        string assembledResRef = "ms_bmap_" + IntToString(combinedQty)
                                 + MapTypeStr + "_" + MapStyleStr;
        CreateItemOnObject(assembledResRef, oPC);
        WriteTimestampedLogEntry("BANDIT TREASURE MAP: creating " + assembledResRef);
    }

    DestroyObject(oMapPeice);
    DestroyObject(oMapTarget);
}
