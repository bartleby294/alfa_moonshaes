void main()
{
    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 2) {
        DestroyObject(OBJECT_SELF);
    } else {
        SetLocalInt(OBJECT_SELF, "hbCount", hbCount + 1);
    }
}
