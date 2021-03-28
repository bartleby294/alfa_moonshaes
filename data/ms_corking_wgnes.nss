#include "ms_aat_utility"

void main()
{
    object enterObj = GetEnteringObject();
    if(GetTag(enterObj) != "tradewagon") {
        return;
    }

    object oArea = GetArea(enterObj);
    int x = GetAreaTransitionX(enterObj);
    int y = GetAreaTransitionY(enterObj);

    object newArea = GetAreaAtCoordinates(oArea, x, y);

    vector curPosition = GetPosition(enterObj);
    float newX = curPosition.y;
    float newY = curPosition.y;

    if(x > 0) {
        newX = 6.0;
    } else if (x < 0) {
        newX = 314.0;
    }

    if(y > 0) {
        newY = 314.0;
    } else if (y < 0) {
        newY = 6.0;
    }

    location newLoc = Location(oArea, Vector(newX, newY, 0.0), 0.0);

    AssignCommand(enterObj, ActionJumpToLocation(newLoc));
}
