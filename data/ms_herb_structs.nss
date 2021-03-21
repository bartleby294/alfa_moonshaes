#include "ms_terrain_id"

struct Herb
{
    string itemResRef;
    string containerName;
    string containerNewTag;
    string containerResRef;
    string terrain;
};

struct Herb GetLesserRandomFreshWaterHerb() {

    struct Herb freshWaterHerb;

    switch(0){
        case 0:
            freshWaterHerb.itemResRef = "comfrey";
            freshWaterHerb.containerName = "Comfrey";
            freshWaterHerb.containerResRef = "vegetationdiv076";
            freshWaterHerb.terrain = TERRAIN_FRESH_WATER;
    }

    return freshWaterHerb;
}

struct Herb GetLesserRandomSaltWaterHerb() {

    struct Herb saltWaterHerb;

    switch(0){
        case 0:
            saltWaterHerb.itemResRef = "";
            saltWaterHerb.containerName = "";
            saltWaterHerb.containerResRef = "";
            saltWaterHerb.terrain = TERRAIN_SALT_WATER;
    }

    return saltWaterHerb;
}

struct Herb GetLesserRandomFieldHerb() {

    struct Herb fieldHerb;

    switch(0){
        case 0:
            fieldHerb.itemResRef = "aaronsrod";
            fieldHerb.containerName = "Aaron's Rod";
            fieldHerb.containerResRef = "witcherplc182";
            fieldHerb.terrain = TERRAIN_FIELD;
    }

    return fieldHerb;
}

struct Herb GetLesserRandomForestHerb() {

    struct Herb forestHerb;

    switch(0){
        case 0:
            forestHerb.itemResRef = "bugsbane";
            forestHerb.containerName = "Bugsbane";
            forestHerb.containerResRef = "vegetationdiv052";
            forestHerb.terrain = TERRAIN_FOREST;
    }

    return forestHerb;
}

struct Herb GetLesserRandomRockyHerb() {

    struct Herb rockyHerb;

    switch(0){
        case 0:
            rockyHerb.itemResRef = "aloe";
            rockyHerb.containerName = "Aloe";
            rockyHerb.containerResRef = "vegetationdiv069";
            rockyHerb.terrain = TERRAIN_ROCKY;
    }

    return rockyHerb;
}

struct Herb GetLesserRandomMountainHerb() {

    struct Herb mountainHerb;

    switch(0){
        case 0:
            mountainHerb.itemResRef = "";
            mountainHerb.containerName = "";
            mountainHerb.containerResRef = "";
            mountainHerb.terrain = TERRAIN_MOUNTAIN;
    }

    return mountainHerb;
}
