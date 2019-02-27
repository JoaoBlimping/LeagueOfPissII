#include "base.pov"
#include "materials.pov"

merge {
    room(<8, 15>)
    cylinder {<4, 2, 0> <4, 2, 17> 2.5}
    pigment {Pink}
}

object {
    sign("Bongo City", texture {grate}, texture {Gold_Nugget})
    rotate y * 30 translate <2, 2, 10>
}


plane {y, 0 texture {grate}}
rafters(<8, 6, 15>, Yellow_Pine, grate, 0.3, 0.2, 2)

niceCamera(<4, 2, 0> <4, 4, 15>)

light_source {
    <6, 4, 4>
    color White
}
