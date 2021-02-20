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

    if (!HasItem("dmbatsignal3")) {
        CreateItemOnObject("dmbatsignal3");
    }

    if (!HasItem("dmbatsignal4")) {
        CreateItemOnObject("dmbatsignal4");
    }

    if (!HasItem("dmbatsignal5")) {
        CreateItemOnObject("dmbatsignal5");
    }

    if (!HasItem("dmbatsounds1")) {
        CreateItemOnObject("dmbatsounds1");
    }

    return;
}
