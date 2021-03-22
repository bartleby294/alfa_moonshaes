#include "x0_i0_stringlib"

float GetRandomXFrom(string xyStr) {
     int baseX = StringToInt(GetTokenByPosition(xyStr, "|", 0)) * 10;
     return baseX + IntToFloat(Random(100))/10;
}

float GetRandomYFrom(string xyStr) {
     int baseY = StringToInt(GetTokenByPosition(xyStr, "|", 1)) * 10;
     return baseY + IntToFloat(Random(100))/10;
}

int getRandomDimensionOffBorder(int dimension, int buffer) {
    int doubleBuffer = 2 * buffer;
    // if you ask for a buffer larger than your dimension its meaningless so
    // we will just give you a random loction sorry.
    if(dimension <= doubleBuffer) {
        return Random(dimension);
    }
    return Random(dimension - doubleBuffer) + buffer;
}

location GetLocationInAreaWithBuffer(object oArea, int buffer)
{
   // each area size if 10m so multiply by 10
    int areaHeight = GetAreaSize(AREA_HEIGHT, oArea) * 10;
    int areaWidth = GetAreaSize(AREA_WIDTH, oArea) * 10;

    float randX = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
    float randY = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
    float randZ = GetGroundHeight(Location(oArea,
                                           Vector(randX, randY, 0.0), 0.0));

    return Location(oArea, Vector(randX, randY, randZ), 0.0);
}
