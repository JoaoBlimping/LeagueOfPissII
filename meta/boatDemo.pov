#include "base.pov"
#include "boats.pov"
#include "tree.pov"




//niceCamera(<0, 2, 0>)
camera {
    location <3, 10, -20>
    look_at <0, 0, 0>
}
sun(2.0)

object {ocean}

#declare stream = seed(1);
#for (i, 1, 90, 1)
    object {
        canoe rotate <0, rand(stream) * 360, 0>
        translate <3 + rand(stream) * 100, 0, 0>
        rotate <0, rand(stream) * 360, 0>
    }
#end

//object {tree(2, 3, 0.7) scale 0.2 translate <-4, 0, 4>}
object {tree(3, 4, 0.7) scale 0.2 translate <4, 0, -4>}
//object {skip}
