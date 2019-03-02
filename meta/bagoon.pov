#include "base.pov"


#declare holder = union {
    box {<0.1, 0, 0.4> <0.9, 0.9, 0.6>}
    box {<0, 0.9, 0> <1, 1, 1>}
    texture {rusty}
}

#declare bracket = union {
    #local wide = 0.05;
    #local thick = 0.01;
    box {<-wide / 2, -thick, 0> <wide / 2, -0.002, 0.3>}
    box {<-wide / 2, -thick, 0> <wide / 2, 0, 0.3>}
}

#macro walkway(dim)
    #local rad = 0.06;
    union {
        union {
            box {<-rad, -rad, -rad> <dim.x + rad, rad, rad>}
            box {<-rad, -rad, -rad> <rad, rad, dim.y + rad>}
            box {<-rad, -rad, dim.y - rad> <dim.x + rad, rad, dim.y + rad>}
            box {<dim.x - rad, -rad, -rad> <dim.x + rad, rad, dim.y + rad>}




            texture {rusty}
        }
        box {
            <0, -thin, 0> <dim.x, thin, dim.y>
            texture {grate}
        }
    }
#end


object {ocean}

box {
    <0, 0, 0> <5, 1, 5>
    texture {concrete}
}

#for(i, 1, 5)
    box {
        <0 + i / 2, i - 1, 15 + i / 2> <5 - i /2, i, 20 - i / 2>
        texture {concrete}
    }
#end

union {
    box {<2, 1, 2> <3, 2, 3>}
    sphere {<2.5, 2.5, 2.5> 0.5}
    texture {rusty}
}


object {holder translate <4, 1, 0>}
object {holder translate <4, 2, 0>}
object {holder translate <4, 3, 0>}
object {holder translate <4, 4, 0>}
object {holder translate <4, 5, 0>}

object {walkway(<3, 10>) translate <1, 0.6, 5>}

light_source {
    <100, 100, 100>
    rgb 1
    area_light <5, 0, 0>, <0, 0, 5>, 5, 5
    adaptive 1
    jitter
}

niceCamera(<2, 2.6, 8>)
