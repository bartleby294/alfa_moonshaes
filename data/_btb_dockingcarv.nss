void main()
{
   object oCityShip = GetNearestObjectByTag("dockingcaravel", OBJECT_SELF, 1);
   AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
}
