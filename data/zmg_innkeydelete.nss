// part of the door scripts

   void main()
{
// Declare who is moving, and the target.
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget(OBJECT_SELF);
location lLoc = GetLocation(oTarget);

    object oItem = GetFirstItemInInventory(oClicker);
    while(oItem != OBJECT_INVALID)
    {
        if(GetTag(oItem) == "InnKey")
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oClicker);
    }


// Float the name of the target's area above the PC's head
FloatingTextStringOnCreature(GetName(GetArea(oTarget)), oClicker, FALSE);

// Delay moving them to the target
DelayCommand(1.0, AssignCommand(oClicker, JumpToObject(oTarget)));
}
