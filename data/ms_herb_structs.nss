#include "ms_terrain_id"

struct Herb
{
    string itemResRef;
    string containerResRef;
    string terrain;
};

struct Herb GetRandomFreshWaterHerb() {

    struct Herb freshWaterHerb;

    switch(Random(2)){
        case 0:
            freshWaterHerb.itemResRef = "";
            freshWaterHerb.containerResRef = "";
            freshWaterHerb.terrain = TERRAIN_FRESH_WATER;

        case 1:
            freshWaterHerb.itemResRef = "";
            freshWaterHerb.containerResRef = "";
            freshWaterHerb.terrain = TERRAIN_FRESH_WATER;
    }

    return freshWaterHerb;
}

struct Herb GetRandomSaltWaterHerb() {

    struct Herb saltWaterHerb;

    switch(Random(2)){
        case 0:
            saltWaterHerb.itemResRef = "";
            saltWaterHerb.containerResRef = "";
            saltWaterHerb.terrain = TERRAIN_SALT_WATER;

        case 1:
            saltWaterHerb.itemResRef = "";
            saltWaterHerb.containerResRef = "";
            saltWaterHerb.terrain = TERRAIN_SALT_WATER;
    }

    return saltWaterHerb;
}

struct Herb GetRandomFieldHerb() {

    struct Herb fieldHerb;

    switch(Random(2)){
        case 0:
            fieldHerb.itemResRef = "aaronsrod";
            fieldHerb.containerResRef = "witcherplc182";
            fieldHerb.terrain = TERRAIN_FIELD;

        case 1:
            fieldHerb.itemResRef = "";
            fieldHerb.containerResRef = "";
            fieldHerb.terrain = TERRAIN_FIELD;
    }

    return fieldHerb;
}

struct Herb GetRandomForestHerb() {

    struct Herb forestHerb;

    switch(Random(2)){
        case 0:
            forestHerb.itemResRef = "";
            forestHerb.containerResRef = "";
            forestHerb.terrain = TERRAIN_FOREST;

        case 1:
            forestHerb.itemResRef = "";
            forestHerb.containerResRef = "";
            forestHerb.terrain = TERRAIN_FOREST;
    }

    return forestHerb;
}

struct Herb GetRandomMountainHerb() {

    struct Herb mountainHerb;

    switch(Random(2)){
        case 0:
            mountainHerb.itemResRef = "";
            mountainHerb.containerResRef = "";
            mountainHerb.terrain = TERRAIN_MOUNTAIN;

        case 1:
            mountainHerb.itemResRef = "";
            mountainHerb.containerResRef = "";
            mountainHerb.terrain = TERRAIN_MOUNTAIN;
    }

    return mountainHerb;
}
