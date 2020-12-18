void main()
{
object oObject = OBJECT_SELF;
object oPC = GetLastUsedBy();
PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 1.0f, 1.0f);
DelayCommand(5.0f, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE, 1.0f, 1.0f));
}
