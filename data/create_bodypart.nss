void main()
{
    object oPC = GetLastUsedBy();
    string sTag = GetTag(OBJECT_SELF);
    int iBodyPart;
    if(sTag == "RIGHT_SHIN")    iBodyPart = CREATURE_PART_RIGHT_SHIN;
    if(sTag == "LEFT_SHIN")     iBodyPart = CREATURE_PART_LEFT_SHIN;
    if(sTag == "RIGHT_THIGH")   iBodyPart = CREATURE_PART_RIGHT_THIGH;
    if(sTag == "LEFT_THIGH")    iBodyPart = CREATURE_PART_LEFT_THIGH;
    if(sTag == "TORSO")         iBodyPart = CREATURE_PART_TORSO;
    if(sTag == "RIGHT_FOREARM") iBodyPart = CREATURE_PART_RIGHT_FOREARM;
    if(sTag == "LEFT_FOREARM")  iBodyPart = CREATURE_PART_LEFT_FOREARM;
    if(sTag == "RIGHT_BICEP")   iBodyPart = CREATURE_PART_RIGHT_BICEP;
    if(sTag == "LEFT_BICEP")    iBodyPart = CREATURE_PART_LEFT_BICEP;
    if(sTag == "RIGHT_FOOT")    iBodyPart = CREATURE_PART_RIGHT_FOOT;
    if(sTag == "LEFT_FOOT")     iBodyPart = CREATURE_PART_LEFT_FOOT;
    if(sTag == "RIGHT_HAND")    iBodyPart = CREATURE_PART_RIGHT_HAND;
    if(sTag == "LEFT_HAND")     iBodyPart = CREATURE_PART_LEFT_HAND;

    SendMessageToPC(oPC, "iBodyPart: " + IntToString(iBodyPart) + " set to "
                         + IntToString(GetCreatureBodyPart(iBodyPart, oPC)));

    if(iBodyPart != CREATURE_PART_TORSO)
    {
        if(GetCreatureBodyPart(iBodyPart, oPC) == CREATURE_MODEL_TYPE_NONE)
            SetCreatureBodyPart(iBodyPart, CREATURE_MODEL_TYPE_SKIN, oPC);
        else if(GetCreatureBodyPart(iBodyPart, oPC) == CREATURE_MODEL_TYPE_SKIN)
            SetCreatureBodyPart(iBodyPart, CREATURE_MODEL_TYPE_TATTOO, oPC);
        else if(GetCreatureBodyPart(iBodyPart, oPC) == CREATURE_MODEL_TYPE_TATTOO)
            SetCreatureBodyPart(iBodyPart, CREATURE_MODEL_TYPE_NONE, oPC);
    }
    else
    {
        if(GetCreatureBodyPart(iBodyPart, oPC) == 159)
            SetCreatureBodyPart(iBodyPart, CREATURE_MODEL_TYPE_SKIN, oPC);
        else if(GetCreatureBodyPart(iBodyPart, oPC) == CREATURE_MODEL_TYPE_SKIN)
            SetCreatureBodyPart(iBodyPart, CREATURE_MODEL_TYPE_TATTOO, oPC);
        else if(GetCreatureBodyPart(iBodyPart, oPC) == CREATURE_MODEL_TYPE_TATTOO)
            SetCreatureBodyPart(iBodyPart, 159, oPC);
    }
    if(iBodyPart == CREATURE_PART_RIGHT_HAND
        || iBodyPart == CREATURE_PART_LEFT_HAND
        || iBodyPart == CREATURE_PART_RIGHT_FOOT
        || iBodyPart == CREATURE_PART_LEFT_FOOT)
    {
        if(GetCreatureBodyPart(iBodyPart, oPC) == CREATURE_MODEL_TYPE_TATTOO)
            SetCreatureBodyPart(iBodyPart, CREATURE_MODEL_TYPE_NONE, oPC);
    }
}
