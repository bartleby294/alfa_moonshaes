//  The global Area OnUserDefined script
//  This script should be in every areas OnUserDefined Handler
//  All area templates have this script installed

// This script will clean areas of items and corpses as a player exits

void main()
 {
    int nUser=GetUserDefinedEventNumber();
    switch(nUser)
        {
        case 3000:
            {
            object oArea = GetArea(OBJECT_SELF);
            object oChk = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oChk))
                {
                if(GetIsPC(oChk) || GetLocalInt(oArea,"InPlay"))
                    {return;}
                else if (GetObjectType(oChk) == OBJECT_TYPE_ITEM)
                        {DestroyObject(oChk);}
                else if(GetStringLowerCase(GetName(oChk)) == "remains")
                    {
                    object oItem = GetFirstItemInInventory(oChk);
                    while(GetIsObjectValid(oItem))
                        {
                        DestroyObject(oItem);
                        oItem = GetNextItemInInventory(oChk);
                        }
                    AssignCommand(oChk,SetIsDestroyable(TRUE));
                    DestroyObject(oChk);
                    }
                     else if(GetStringLowerCase(GetName(oChk)) == "corpse")
                    {
                    object oItem = GetFirstItemInInventory(oChk);
                    while(GetIsObjectValid(oItem))
                        {
                        DestroyObject(oItem);
                        oItem = GetNextItemInInventory(oChk);
                        }
                    AssignCommand(oChk,SetIsDestroyable(TRUE));
                    DestroyObject(oChk);
                    }
                else if( GetTag( oChk) == "bodybag")
                    { object oItem = GetFirstItemInInventory( oChk);
                      while( GetIsObjectValid( oItem))
                      { DestroyObject( oItem);
                        oItem = GetNextItemInInventory( oChk);
                      }
                      AssignCommand(oChk,SetIsDestroyable(TRUE));
                      DestroyObject(oChk);
                    }
                oChk = GetNextObjectInArea(oArea);
                }
            break;}
        }
}
