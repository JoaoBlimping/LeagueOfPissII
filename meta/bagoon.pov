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

object {walkway(<31, 5>) translate <0, 18, 1>}
union {
    box {<0, 0, 0> <31, 18, 1>}
    box {<0, 0, 5> <31, 18, 6>}
    #for (i, 0, 18, 0.25)
        box {<14, 0, 6 + i> <17, 18 - i, 6 + i + 0.25>}
    #end
    texture {concrete}
}

object {
    regularPrism(5, 2)
    texture {rusty}
    translate <20, 0, 20>
}




union {
    box {<2, 1, 2> <3, 2, 3>}
    sphere {<2.5, 2.5, 2.5> 0.5}
    texture {rusty}
}

sun(1.7)

niceCamera(<15, 3, 28>)
