void main()
{
    object oDM = GetLastSpeaker();
    object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
    effect eff = GetFirstEffect(oMyTarget);
    while(GetIsEffectValid(eff)) {
        if(GetEffectCreator(eff) == oDM) {
            RemoveEffect(oMyTarget, eff);
        }
        eff = GetNextEffect(oMyTarget);
    }
}
