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

    int curLetterPos = GetLetterPosition(curEWPos);
    int subStrSize = GetStringLength(curEWPos);
    int subStrStart = subStrSize * offset;

    // if our start position is out of bounds return nothing.
    if(subStrStart < 0 || subStrStart > GetStringLength(EW_GRID)){
        return "";
    }

    return GetSubString(EW_GRID, curLetterPos + subStrStart, subStrSize);
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
    object newArea = GetObjectByTag(newEWPos + newNSPos + "_e");

    // Lets make sure what we have is really an area.
    int iWidthInTiles = GetAreaSize(AREA_WIDTH,  newArea);
    if(iWidthInTiles <= 0) {
        return OBJECT_INVALID;
    }

    return newArea;
}

int GetAreaTransitionX(object oPC) {
    object oArea = GetArea(oPC);
    vector oPCLocVec = GetPosition(oPC);

    //int iWidthInTiles  = GetAreaSize(AREA_WIDTH,  oArea);
    float height = GetAreaSize(AREA_HEIGHT, oArea) * 10.0;

    // move north
    if(oPCLocVec.x > height - 10.0) {
        return -1;
    }
    // move south
    if(oPCLocVec.x < 10.0) {
        return 1;
    }
    // dont go anywhere
    return 0;
}

int GetAreaTransitionY(object oPC) {
    object oArea = GetArea(oPC);
    vector oPCLocVec = GetPosition(oPC);

    float width  = GetAreaSize(AREA_WIDTH,  oArea) * 10.0;

    // move east
    if(oPCLocVec.x > width - 10.0) {
        return 1;
    }
    // move west
    if(oPCLocVec.x < 10.0) {
        return -1;
    }
    // dont go anywhere
    return 0;
}
