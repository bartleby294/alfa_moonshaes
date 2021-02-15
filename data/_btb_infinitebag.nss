#include "nw_i0_plot"

void main()
{
    string bagTag = "050_container002";
    int bagNum = GetNumItems(OBJECT_SELF, bagTag);

    while (6 - bagNum > 0) {
        CreateItemOnObject(bagTag);
        bagNum = bagNum + 1;
    }

    return;
}
