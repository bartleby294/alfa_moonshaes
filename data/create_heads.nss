void main()
{
    object oPC = GetLastUsedBy();
    int iHead = GetCreatureBodyPart(CREATURE_PART_HEAD, oPC);
    if(GetTag(OBJECT_SELF) == "HEAD_UP") iHead++;
    if(GetTag(OBJECT_SELF) == "HEAD_DOWN") iHead--;
    if(iHead > 255) iHead = 1;
    if(iHead < 1) iHead = 255;
    SetCreatureBodyPart(CREATURE_PART_HEAD, iHead, oPC);
}
