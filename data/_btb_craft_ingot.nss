#include "_btb_craft_const"
#include "_btb_craft_util"

void main()
{
    if (!HasItem(IRON_INGOT_TAG)) {
        CreateItemOnObject(IRON_INGOT_TAG);
    }
    if (!HasItem(SILVER_INGOT_TAG)) {
        CreateItemOnObject(SILVER_INGOT_TAG);
    }
    if (!HasItem(COLD_INGOT_TAG)) {
        CreateItemOnObject(COLD_INGOT_TAG);
    }
    if (!HasItem(DARK_STEEL_INGOT_TAG)) {
        CreateItemOnObject(DARK_STEEL_INGOT_TAG);
    }
    if (!HasItem(ADAMANTIUM_INGOT_TAG)) {
        CreateItemOnObject(ADAMANTIUM_INGOT_TAG);
    }
    if (!HasItem(MITHRAL_INGOT_TAG)) {
        CreateItemOnObject(MITHRAL_INGOT_TAG);
    }
    if (!HasItem(OBSIDIAN_INGOT_TAG)) {
        CreateItemOnObject(OBSIDIAN_INGOT_TAG);
    }

    return;
}
