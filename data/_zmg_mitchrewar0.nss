#include "nw_i0_plot"

int StartingConditional()
{

    // Inspect local variables
    if((GetNumItems(GetObjectByTag("rewardCorn"), "corn") == 0))
        return TRUE;

    return FALSE;
}
