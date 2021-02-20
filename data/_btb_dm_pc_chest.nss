#include "_btb_craft_util"
#include "nwnx_item"

void main()
{
    if (!HasItem("vialofmoonwellwa")) {
        object obj = CreateItemOnObject("vialofmoonwellwa");
        NWNX_Item_SetBaseGoldPieceValue(obj, 1);
        NWNX_Item_SetAddGoldPieceValue(obj, 1);
    }
    if (!HasItem("moonwellwater")) {
        object obj = CreateItemOnObject("moonwellwater");
        NWNX_Item_SetBaseGoldPieceValue(obj, 1);
        NWNX_Item_SetAddGoldPieceValue(obj, 1);
    }

    return;
}
