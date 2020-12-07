void main() {
    object oMod = GetModule();

    /* doa_lootnotify - cache icon dimension for baseitems */
    int row,size;
    for (row=0; row<218; row++) {
        size = StringToInt(Get2DAString("baseitems","InvSlotWidth",row));
        if (size) {
            size *= StringToInt(Get2DAString("baseitems","InvSlotHeight",row));
            if (size > 1) SetLocalInt(oMod, "baseitem_size_" + IntToString(row), size);
        }
    }
}
