void main()
{

    if(GetHitDice(GetLastUsedBy()) == 1 || GetIsDM(GetLastUsedBy()))
      OpenStore(GetNearestObject(OBJECT_TYPE_STORE), GetLastUsedBy());
}
