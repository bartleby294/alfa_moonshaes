// Equip the weapon appropriate to enemy and position
// You can use nState to use shields or whatever. Need to make a section to cover that.
void EquipAppropriateWeapons(object oTarget);

//::///////////////////////////////////////////////
//:: Equip Appropriate Weapons
//:://////////////////////////////////////////////
/*
    This will use the set weapons, especially good
    for deul wielding and ranged weapon choosing, and shields!
*/
//:://////////////////////////////////////////////

void EquipAppropriateWeapons(object oTarget)
{
    object oRanged = GetLocalObject(OBJECT_SELF, "DW_RANGED");
        int iRanged = GetIsObjectValid(oRanged);
        if(iRanged && GetItemPossessor(oRanged) != OBJECT_SELF)
        {
            DeleteLocalObject(OBJECT_SELF, "DW_RANGED");
            iRanged = FALSE;
        }
    object oRight = (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
    if(GetDistanceToObject(oTarget) > 3.0 && iRanged && (oRight != oRanged))
    {
        ActionEquipItem(oRanged, INVENTORY_SLOT_RIGHTHAND);
    }
    else if(GetDistanceToObject(oTarget) <= 3.0 || !iRanged)
    {
        object oPrimary = GetLocalObject(OBJECT_SELF, "DW_PRIMARY");
            int iPrimary = GetIsObjectValid(oPrimary);
            if(iPrimary && GetItemPossessor(oPrimary) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_PRIMARY");
                iPrimary = FALSE;
            }
        object oSecondary = GetLocalObject(OBJECT_SELF, "DW_SECONDARY");
            int iSecondary = GetIsObjectValid(oSecondary);
            if(iPrimary && GetItemPossessor(oSecondary) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_SECONDARY");
                iSecondary = FALSE;
            }
        object oShield = GetLocalObject(OBJECT_SELF, "DW_SHIELD");
            int iShield = GetIsObjectValid(oShield);
            if(iPrimary && GetItemPossessor(oShield) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_SHIELD");
                iShield = FALSE;
            }
        object oTwoHanded = GetLocalObject(OBJECT_SELF, "DW_TWO_HANDED");
            int iTwoHanded = GetIsObjectValid(oTwoHanded);
            if(iTwoHanded && GetItemPossessor(oTwoHanded) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_TWO_HANDED");
                iTwoHanded = FALSE;
            }

        object oLeft = (GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
        // Complete change - it will check the slots, if not eqip, then do so.
        if(iPrimary && (oRight != oPrimary))
        {
            ActionEquipItem(oPrimary, INVENTORY_SLOT_RIGHTHAND);
        }
        if(iSecondary && (oLeft != oSecondary))
        {
            ActionEquipItem(oSecondary, INVENTORY_SLOT_LEFTHAND);
        }
        else if(!iSecondary && iShield && (oLeft != oShield))
        {
            ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND);
        }
        if(!iPrimary && iTwoHanded && (oRight != oTwoHanded))
        {
            ActionEquipItem(oTwoHanded, INVENTORY_SLOT_RIGHTHAND);
        }
        // If all else fails...TRY most damaging melee weapon.
        if(!iPrimary && !iTwoHanded)
            ActionEquipMostDamagingMelee(oTarget, TRUE);
    }
}
