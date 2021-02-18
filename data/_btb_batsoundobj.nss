void main()
{
    //as_an_bat1
    //as_an_bat2
    //as_an_bat3
    //as_an_batflap1
    //as_an_batflap2
    //as_an_bats1
    //as_an_bat2
    //as_an_batsflap1
    //as_an_batsflap2
    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 2) {
        DestroyObject(OBJECT_SELF);
    } else {
        PlaySound("al_pl_x2bongolp1");
        DelayCommand(0.5, PlaySound("as_an_bat1"));
        DelayCommand(1.0, PlaySound("as_an_bat2"));
        DelayCommand(1.5, PlaySound("as_an_batsflap1"));
        SetLocalInt(OBJECT_SELF, "hbCount", hbCount + 1);
    }
}
