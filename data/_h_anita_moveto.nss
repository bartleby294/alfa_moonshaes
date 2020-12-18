#include "x0_i0_position"

void main()
{
    object moveto = GetObjectByTag("_h_anita_moveto1");
    float facethisway = GetFacingFromLocation(GetLocation(moveto));


    AssignCommand(OBJECT_SELF, ActionMoveToObject(moveto, FALSE, 1.0));
    DelayCommand(12.0, AssignCommand(OBJECT_SELF, SetFacing(facethisway)));
}
