#include "base.pov"
#include "boats.pov"


#macro tree()
    #local spot = <0, 0, 0>;
    #local rad = 1;
    union {
        #for (i, 1, 5, 1)
            #local bing = 5;
            sphere {spot rad}

        #end
    }
    texture {rusty}
#end



//niceCamera(<0, 2, 0>)
camera {
    location <3, 10, -15>
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

object {fancyHouse}
//object {skip}
