#include "base.pov"

#declare railRad = 0.06;


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

#macro frame(dim)
    union {
        box {<-railRad, -railRad, -railRad> <dim.x + railRad, railRad, railRad>}
        box {<-railRad, -railRad, -railRad> <railRad, railRad, dim.y + railRad>}
        box {<-railRad, -railRad, dim.y - railRad> <dim.x + railRad, railRad, dim.y + railRad>}
        box {<dim.x - railRad, -railRad, -railRad> <dim.x + railRad, railRad, dim.y + railRad>}
        texture {rusty}
    }
#end

#macro walkway(dim)
    union {
        frame(dim)
        box {
            <0, -thin, 0> <dim.x, thin, dim.y>
            texture {grate}
        }
    }
#end


object {ocean}

object {walkway(<35, 5>) translate <0, 18, 1>}

union {
    difference {
        union {
            object {walkway(<35, 7>) translate <0, 18, -7>}
            object {walkway(<35, 7>) translate <0, 12, -7>}
            object {walkway(<35, 7>) translate <0, 6, -7>}
        }
        box {<12, 1, 0> <13, 19, -1>}
    }
    object {frame(<1, 1>) translate <12, 6, -1>}
    object {frame(<1, 1>) translate <12, 12, -1>}
    object {frame(<1, 1>) translate <12, 18, -1>}
    cylinder {<12.5, 1, -0.5> <12.5, 20, -0.5> 0.2 texture {rusty}}
}


union {
    box {<0, 1, -7> <railRad * 2, 18, -7 + railRad * 2>}
    box {<17.5 - railRad, 1, -7> <17.5 + railRad, 18, -7 + railRad * 2>}
    box {<35, 1, -7> <35 - railRad * 2, 18, -7 + railRad * 2>}
    texture {rusty}
}

union {
    box {<0, 0, 0> <35, 1, -7>}
    box {<0, 0, 0> <35, 18, 1>}
    box {<0, 0, 5> <35, 18, 6>}
    box {<0, 0, 6> <35, 1, 25>}
    #for (i, 1, 18, 0.25)
        box {<16, 0, 6 + i> <19, 19 - i, 6 + i + 0.25>}
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

//niceCamera(<15, 3, 28>)
//niceCamera(<15, 19, 10>)
niceCamera(<3, 3, -4>)
