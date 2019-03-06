#include "base.pov"
#include "danyMaterial.pov"


niceCamera(<0, 2.8, 0>)
sun(1.0)
object {ocean}


cylinder {
    <0, 0, 0> <0, 1, 0> 0.5
    texture {concrete}
}

#declare stream = seed(2);
#for (i, 1, 666, 1)
    difference {
        #local tall = 0.3 + rand(stream) * 3;
        #local thick = 0.1 + rand(stream) * 0.2;
        cylinder {<0, 0, 0> <0, tall, 0> thick}
        cylinder {<0, -1, 0> <0, tall + 1, 0> thick - 0.07}
        sphere {
            <0, 0, 0> thick * 2
            scale <1, 0.1 + rand(stream) * 2, 1>
            translate <thick, tall, 0>
            rotate <0, rand(stream) * 360, 0>
        }
        translate <1 + pow(rand(stream), 2) * 100, 0, 0>
        rotate <0, rand(stream) * 360, 0>
        texture {rusty}
    }
#end

#for (i, 1, 100, 1)
    sphere {
        <1 + rand(stream) * 100, 0, 0> rand(stream)
        rotate <0, rand(stream) * 360, 0>
        texture {rusty}
    }
#end
