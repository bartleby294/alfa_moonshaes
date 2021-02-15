#include "_btb_craft_util"

void main()
{
    if (!HasItem("dmcontrolstone")) {
        CreateItemOnObject("dmcontrolstone");
    }

    return;
}
