void main()
{
   string shipStr = "corwell_anim_sm_ship_1";
   object oCityShip = GetNearestObjectByTag(shipStr, OBJECT_SELF, 1);
   int animationState = GetLocalInt(oCityShip, "animationState");

    if(animationState == TRUE) {
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCityShip, "animationState", FALSE);
    } else {
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocalInt(oCityShip, "animationState", TRUE);
    }
}
