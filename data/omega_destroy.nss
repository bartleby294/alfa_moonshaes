void main()
{
    object oTarget = GetLocalObject(GetPCSpeaker(), "OMWandTarget");
    DestroyObject(oTarget);
    ExecuteScript( "omega_prevobj", OBJECT_SELF );
}
