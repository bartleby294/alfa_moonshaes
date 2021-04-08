#include "_btb_spider_sp1"

void main() {
    if(d2() == 1) {
        spawnSpiders(Random(2) + 1, OBJECT_SELF);
    }
}
