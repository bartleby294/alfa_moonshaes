#include "ms_aat_constants"
#include "x0_i0_stringlib"

int GetLetterPosition(string curEWPos) {
    return FindSubString(EW_GRID, curEWPos);
}

/*
 *  curEWPos - Your east west grid cooridinate could be "a" or "ff".
 *  offset   - The number of grid jumps you would like the new position of.
 */

string GetLetterUsingOffset(string curEWPos, int offset) {

    int curEWPosNum = 0;
    string curLocationStr = GetTokenByPosition(EW_GRID_DELIM, "|", curEWPosNum);

    while(curLocationStr != "") {
        if(curLocationStr == curEWPos) {
            break;
        }
        curEWPosNum++;
        curLocationStr = GetTokenByPosition(EW_GRID_DELIM, "|", curEWPosNum);
    }

    return GetTokenByPosition(EW_GRID_DELIM, "|", curEWPosNum + offset);
}

/*
 *  This will work for any module that uses a letter number grid like
 *  The following example q_50_e.
 */
object GetAreaAtCoordinates(object curArea, int xDirection, int yDirection) {
    string curAreaStr = GetTag(curArea);
    string curEWPos = GetTokenByPosition(curAreaStr, "_", 0);
    int curNSPos = StringToInt(GetTokenByPosition(curAreaStr, "_", 1));

    string newEWPos = GetLetterUsingOffset(curEWPos, xDirection);
    string newNSPos = IntToString(curNSPos + yDirection);
    string tag = newEWPos + "_" + newNSPos + "_e";
    //WriteTimestampedLogEntry("Area Tag: " + tag);
    object newArea = GetObjectByTag(tag);

    // Lets make sure what we have is really an area.
    int iWidthInTiles = GetAreaSize(AREA_WIDTH,  newArea);
    if(iWidthInTiles <= 0) {
        return OBJECT_INVALID;
    }

    return newArea;
}

/**
 * Returns an integer representing where on the map you are NS where
 * 01 = maximal north
 * 58 = maximal south
 */
int GetNSAreaPosition(object oArea) {
    string curAreaStr = GetTag(oArea);
    return StringToInt(GetTokenByPosition(curAreaStr, "_", 1));
}

/**
 * Returns an integer representing where on the map you are EW where
 * 01 = maximal west
 * 40 = maximal east
 */
int GetEWAreaPosition(object oArea) {
    string curAreaStr = GetTag(oArea);
    string curEWPos = GetTokenByPosition(curAreaStr, "_", 0);

    int curEWPosNum = 0;
    string curLocationStr = GetTokenByPosition(EW_GRID_DELIM, "|", curEWPosNum);

    while(curLocationStr != "") {
        if(curLocationStr == curEWPos) {
            return curEWPosNum + 1;
        }
        curEWPosNum++;
        curLocationStr = GetTokenByPosition(EW_GRID_DELIM, "|", curEWPosNum);
    }

    return 0;
}

/**
 *  Returns true if area 1 is north of area 2.
 */
int GetIsNorth(object oArea1, object oArea2) {

    int absoluteNSArea1 = GetNSAreaPosition(oArea1);
    int absoluteNSArea2 = GetNSAreaPosition(oArea2);

    if(absoluteNSArea1 > absoluteNSArea2) {
        return TRUE;
    }

    return FALSE;
}

/**
 *  Returns true if area 1 is south of area 2.
 */
int GetIsSouth(object oArea1, object oArea2) {

    int absoluteNSArea1 = GetNSAreaPosition(oArea1);
    int absoluteNSArea2 = GetNSAreaPosition(oArea2);

    if(absoluteNSArea2 > absoluteNSArea1) {
        return TRUE;
    }

    return FALSE;
}

/**
 *  Returns true if area 1 is east of area 2.
 */
int GetIsEast(object oArea1, object oArea2) {

    int absoluteEWArea1 = GetEWAreaPosition(oArea1);
    int absoluteEWArea2 = GetEWAreaPosition(oArea2);

    if(absoluteEWArea2 > absoluteEWArea1) {
        return TRUE;
    }

    return FALSE;
}

/**
 *  Returns true if area 2 is west of area 1.
 */
int GetIsWest(object oArea1, object oArea2) {

    int absoluteEWArea1 = GetEWAreaPosition(oArea1);
    int absoluteEWArea2 = GetEWAreaPosition(oArea2);

    if(absoluteEWArea1 > absoluteEWArea2) {
        return TRUE;
    }

    return FALSE;
}

/**
 *  Returns the ns difference magniude in how many areas away.
 */
int GetNSDistance(object oArea1, object oArea2) {

    int absoluteNSArea1 = GetNSAreaPosition(oArea1);
    int absoluteNSArea2 = GetNSAreaPosition(oArea2);

    if(absoluteNSArea2 > absoluteNSArea1) {
        return absoluteNSArea2 - absoluteNSArea1;
    } else {
        return absoluteNSArea1 - absoluteNSArea2;
    }

    return 0;
}

/**
 *  Returns the ew difference magniude in how many areas away.
 */
int GetEWDistance(object oArea1, object oArea2) {

    int absoluteEWArea1 = GetEWAreaPosition(oArea1);
    int absoluteEWArea2 = GetEWAreaPosition(oArea2);

    if(absoluteEWArea2 > absoluteEWArea1) {
        return absoluteEWArea2 - absoluteEWArea1;
    } else {
        return absoluteEWArea1 - absoluteEWArea2;
    }

    return 0;
}

int GetAreaTransitionX(object oPC) {
    object oArea = GetArea(oPC);
    vector oPCLocVec = GetPosition(oPC);

    //int iWidthInTiles  = GetAreaSize(AREA_WIDTH,  oArea);
    float height = GetAreaSize(AREA_HEIGHT, oArea) * 10.0;


    // move east
    if(oPCLocVec.x > height - 10.0){
        //WriteTimestampedLogEntry("Move East");
        return 1;
    }
    // move west
    if(oPCLocVec.x < 10.0) {
        //WriteTimestampedLogEntry("Move West");
        return -1;
    }
    // dont go anywhere
    return 0;
}

int GetAreaTransitionY(object oPC) {
    object oArea = GetArea(oPC);
    vector oPCLocVec = GetPosition(oPC);

    float width  = GetAreaSize(AREA_WIDTH,  oArea) * 10.0;

    // move north
    if(oPCLocVec.y > width - 10.0) {
        //WriteTimestampedLogEntry("Move North");
        return -1;
    }
    // move south
    if(oPCLocVec.y < 10.0) {
        //WriteTimestampedLogEntry("Move South");
        return 1;
    }
    // dont go anywhere
    return 0;
}
