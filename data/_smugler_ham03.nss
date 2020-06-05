void main()
{
    object Smuggler = GetObjectByTag("SmugglerSittingByBoat01");
    AssignCommand(Smuggler, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999999.0));
}
