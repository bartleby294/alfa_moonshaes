#include "_btb_craft_util"

void main()
{
    if (!HasItem("dmcontrolstone")) {
        CreateItemOnObject("dmcontrolstone");
    }

    if (!HasItem("dmbatsignal1")) {
        CreateItemOnObject("dmbatsignal1");
    }

    if (!HasItem("dmbatsignal2")) {
        CreateItemOnObject("dmbatsignal2");
    }

    return;
}
