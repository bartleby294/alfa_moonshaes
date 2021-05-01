#include "ms_seed_treasure"
#include "ms_aat_utility"

const string MS_BTREASURE_AREA = "ms_btreasure_area";

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();
    object oPCArea = GetArea(oPC);
    object oMap = GetItemActivated();
    object oTreasureArea = OBJECT_INVALID;
    string oTreasureAreaTag = GetLocalString(oMap, MS_BTREASURE_AREA);

    // If we havent selected a treasure area yet do so now.
    if(oTreasureAreaTag == "") {
        int maxI = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oModule,
                                        "ms_module_areas");
        int maxTry = 0;
        while(oTreasureArea == OBJECT_INVALID && maxTry < 100) {
            string areaStr = NWNX_Data_Array_At_Str(oModule, "ms_module_areas",
                                                    Random(maxI));
            if(GetCampaignInt(MS_TREASURE_PER_AREA, areaStr) == TRUE) {
                oTreasureArea = GetObjectByTag(areaStr);
                oTreasureAreaTag = areaStr;
            }
            maxTry++;
        }

        if(oTreasureArea != OBJECT_INVALID) {
            SetLocalString(oMap, MS_BTREASURE_AREA, oTreasureAreaTag);
        }
    } else {
        oTreasureArea = GetObjectByTag(oTreasureAreaTag);
    }

    if(oTreasureArea == OBJECT_INVALID) {
        return;
    }

    // insert roll stuff here for now ignore.

    // inform PC of where the treasure is.
    int isNorth = GetIsNorth(oPCArea, oTreasureArea);
    int isSouth = GetIsSouth(oPCArea, oTreasureArea);
    int isEast = GetIsEast(oPCArea, oTreasureArea);
    int isWest = GetIsWest(oPCArea, oTreasureArea);

    // good ol a^2 + b^2 = c^2
    int a = GetNSDistance(oPCArea, oTreasureArea);
    int b = GetEWDistance(oPCArea, oTreasureArea);

    float aSqr = a * a * 1.0;
    float bSqr = b * b * 1.0;

    float distance = sqrt(aSqr * bSqr);

    // more than 5 is a "far to the".
    // 2-5 is is "to the"
    // 1-2 and under is "you think youre getting close"
    // 0 is it must be some where near by.

    string playerMsg = "The treasure seems to be some where ";

    if(distance >= 5.0) {
        playerMsg += "far to the ";
    } else if ( distance > 0.0 && distance <= 2.0) {
         playerMsg += "to the ";
    } else if (distance > 0.0 && distance <= 2.0) {
         playerMsg += "near by to the ";
    } else {
         playerMsg += "in this general area";
    }

    if(distance > 0.0) {
        if(isNorth == TRUE) {
             playerMsg += "N";
        }
        if(isSouth == TRUE) {
             playerMsg += "S";
        }

        if(isEast == TRUE) {
             playerMsg += "E";
        }

        if(isWest == TRUE) {
             playerMsg += "W";
        }
    }

    playerMsg += ".";

    SendMessageToPC(oPC, playerMsg);

}
