#include "base.pov"

#declare lemony = texture {pigment {color Yellow} normal {bumps 0.3 scale 0.03} finish {phong 1}}
#declare crystal = texture {pigment {color Red}}


#declare lemon = union {
    intersection {
       sphere {<-1, 0, 0>, 2}
       sphere {<1, 0, 0>, 2}
       texture {lemony}
    }
    torus {1.7 0.1 rotate z * 90 texture {lemony}}
    torus {0.25 0.1 rotate z * 90 translate <0, 2, 0> texture {lemony}}
    sphere {<0, 2, 0>, 0.25 texture {crystal}}
}

object {ocean translate z-10}

object {buildStand(lemon, 8, 1.5) rotate y * 45 translate <2, -2, -2>}
object {buildStand(lemon, 8, 1.5) rotate y * -45 translate <-2, -2, -2>}
object {buildStand(lemon, 10, 1.5) translate <-3, 0, 0>}
object {buildStand(lemon, 10, 1.5) translate <3, 0, 0>}
object {buildStand(lemon, 10, 1.5) translate <3, 0, 0>}
object {buildStand(lemon, 11, 1.5) rotate y * -45 translate <2, 1, 2>}
object {buildStand(lemon, 11, 1.5) rotate y * 45 translate <-2, 1, 2>}
buildStand(
    union {
        difference {
            sphere {<0, 0, 0>, 2}
            union {
                cylinder {<0, 0, -2> <0, 0, 0.5>, 1}
                sphere {<0, 0, 0.5>, 1}
            }
            texture {lemony}
        }
        sphere {<0, 0, 0>, 0.5 texture {crystal}}
    },
    10,
    2
)


niceCamera(<0, -1, -20>)

light_source {
    <2, 2, -5>
    color <1.0, 0.4, 0.4>
    area_light <5, 0, 0>, <0, 0, 5>, 5, 5
    adaptive 1
    jitter
}
