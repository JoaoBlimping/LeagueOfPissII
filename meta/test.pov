#include "base.pov"


camera {
    location <1, 0.4, -0.4>
    look_at <0, 0, 0>
}

light_source {
    <100, 100, 100>
    rgb 1
    area_light <5, 0, 0>, <0, 0, 5>, 5, 5
    adaptive 1
    jitter
}


object {bracket}
