///////////////////////////////////////////////////////
// Place the Lever and set it State to "Deactivated"
// Use in the OnUsed of a Lever or switch
///////////////////////////////////////////////////////
int FlipSwitch(object oLever = OBJECT_SELF)
{
    //lever animation
    if (GetLocalInt(OBJECT_SELF,"nToggle") == 0)
        {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
        SetLocalInt(OBJECT_SELF,"nToggle",1);//set "ON"
        return TRUE;
        }
    else
        {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0);
        SetLocalInt(OBJECT_SELF,"nToggle",0);//set "OFF"
        return FALSE;
        }
    //end level anaimation
}
void main()
{
    if(FlipSwitch())
        {
            object waypoint = GetObjectByTag("trade_wagon_start");
            CreateObject(OBJECT_TYPE_CREATURE, "mstradewagon1",
                GetLocation(waypoint));
        }
    else
        {

        }
}
