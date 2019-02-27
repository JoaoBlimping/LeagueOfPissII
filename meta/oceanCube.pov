#include "base.pov"

object {ocean}

#declare stream = seed(0);

#declare pillar = union {
    cylinder {<0, -1, 0> <0, 5, 0>, 0.4}
    sphere {<0, 5, 0>, 0.4}
    sphere {<0, 5.7, 0>, 0.3}
    sphere {<0, 6.1, 0>, 0.1}
    sphere {<0, 6.3, 0>, 0.1}
    texture{Jade}
}


#for(i, -6, 600, 6)
    object{pillar translate <-2 - rand(stream), 0, i>}
    object{pillar translate <2 + rand(stream), 0, i>}
#end

niceCamera(<0, 2, 300>)

light_source {
    <2, 2, -5>
    color <1.0, 0.4, 0.4>
    area_light <5, 0, 0>, <0, 0, 5>, 5, 5
    adaptive 1
    jitter
}
