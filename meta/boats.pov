#include "base.pov"
#include "danyMaterial.pov"



#declare canoe = union {
    difference {
        union {
            sphere {<0, 0, 0>, 0.5 scale <1, 2, 5>}
            sphere {<0, 0, -2>, 0.5}
        }
        sphere {<0, 0, 0>, 0.5 scale <1, 1.5, 4.5>}
        box {<-0.5, 0, -2.5> <0.5, 1, 2.5>}
    }
    sphere {<0, 0.1, 2.5>, 0.2}
    sphere {<0, 1.3, 0>, 0.2}
    cylinder{<0, -0.5, 0> <0, 1.3, 0> 0.1}
    translate <0, 0.8, 0>
    texture {coconut}
}



#declare fancyHouse = union {
    #local rad = 3;
    #local biteRad = 3.3;
    #local cabinRad = 1.8;
    #local cabinInner = 1.6;
    #local dangler = union {
        difference {
            torus {rad 0.05 rotate <90, 0, 0>}
            plane {y, 0}
        }
        sphere {<-rad, 0, 0> 0.1}
        sphere {<rad, 0, 0> 0.1}
        texture {whitePaint}
    }
    // shell
    difference {
        sphere {<0, 0, 0>, 3 texture {greenPaint}}
        sphere {<0, 0, 0>, 3.3 scale <1, 0.5, 1> texture {coconut}}
    }
    torus {rad 0.05 rotate <90, 0, 0> texture {whitePaint}}
    torus {rad 0.05 rotate <90, 45, 0> texture {whitePaint}}
    torus {rad 0.05 rotate <90, 90, 0> texture {whitePaint}}
    torus {rad 0.05 rotate <90, 135, 0> texture {whitePaint}}
    object {dangler rotate y*22.5}
    object {dangler rotate y*67.5}
    object {dangler rotate y*112.5}
    object {dangler rotate y*157.5}
    sphere {<0, 3.15, 0> 0.1 texture {whitePaint}}
    // cabin
    difference {
        cylinder {<0, -2, 0> <0, 2, 0> cabinRad}
        cylinder {<-cabinRad, 0, 0> <cabinRad, 0, 0> 1}
        cylinder {<0, 0, -cabinRad> <0, 0, cabinRad> 1}
        cylinder {<0, -2, 0> <0, 2, 0> cabinInner}
        box {<-1, -2, -2> <1, 0, 0>}
        texture {concrete}
    }
    // moving
    translate <0, 1.8, 0>
}


#declare skip = union {
    box {<0, 0, 0> <2, 0.5, 2>}
    text {ttf "timrom.ttf" "League of Piss II" 1, 0 translate <-5, 0, 0> scale 2}
    texture {rusty}
}

#declare pissmobile = union {
    box {<-0.5, -0.5, -0.5> <0.5, 0.5, 0.5>}
    texture {rusty}
}
