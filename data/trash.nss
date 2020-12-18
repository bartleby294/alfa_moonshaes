//::///////////////////////////////////////////////
//:: Deletes all Items placed in Trash Can
//:: pri_trashcan.nss
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

Place this script on the "OnDisturbed" Event of a container
and any item placed in the trash can will be deleted.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: June 28, 2002
//:://////////////////////////////////////////////

void main()
{
object oTrash = GetInventoryDisturbItem();
DestroyObject(oTrash);
ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_FNF_SMOKE_PUFF ), OBJECT_SELF );
}
