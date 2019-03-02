#include "danyMaterial.pov"
#include "colors.inc"
#include "textures.inc"
#include "skies.inc"

#declare thin = 0.01;


sky_sphere {S_Cloud2}

#macro room(dimension)
    box {
        <0, -999, 0>
        <dimension.x, 999, dimension.y>
    }
#end

#macro rafters(dimension, ceilingTexture, rafterTexture, deep, thick, regular)
    union {
        plane {-y, -dimension.y texture {ceilingTexture}}
        #for(i, regular, dimension.z, regular)
            box {
                <0, dimension.y - deep, 0>
                <dimension.x, dimension.y, thick>
                texture{rafterTexture}
                translate z*i
            }
        #end
    }
#end

#macro buildStand(top, height, base)
    union {
        object {top}
        cylinder {<0, 0, 0> <0, -height, 0>, 0.1 texture {lemony}}
        cone {<0, -(height - 0.5), 0>, 0 <0, -height, 0> base texture {lemony}}
    }
#end

#macro sign(content, backColour, textColour)
    difference {
        box {<0, 0, -0.2> <5, 1, 0> texture {backColour}}
        text {ttf "timrom.ttf" content 0.15, 0 translate <0.2, 0.2, -0.3> texture {textColour}}
    }
#end

#macro niceCamera(at)
    camera {
        spherical
        angle 360 180
        location at
        look_at at + <0, 0, 1>
    }
#end

#declare ground = box {
    <-0.5, 0, -0.5> <0.5, 1, 0.5>
    texture {Jade}
}

#declare ocean = plane {
    y, 0
    texture {
        pigment{rgb <.2,.2,.2>}
        finish {
            ambient 0.15
            diffuse 0.55
            brilliance 6.0
            phong 0.8
            phong_size 120
            reflection 0.6
        }
        normal {
            bumps 0.04
            scale <1, 0.25, 0.25> * 1
            turbulence 0.6
        }
    }
}

#declare bolt = prism {
    linear_spline
    0, 0.1, 6,
    <0, -0.01>, <-0.008, 0.01>, <0.006, 0.004>, <-0.004, 0.01>, <-0.01, 0>, <0, -0.01>
}

// A metal bracket like used in bagoon.
#declare bracket = union {
    #local wide = 0.05;
    #local thick = 0.01;
    #local tilt = degrees(atan(0.16 / 0.26));
    #local brace = sqrt(pow(0.17, 2) + pow(0.27, 2));
    box {<-wide / 2, -thick, 0> <wide / 2, -0.002, 0.2>}
    box {<-wide / 2, -0.3, 0> <wide / 2, -0.002, thick>}
    box {
        <-wide / 2, -brace, 0> <wide / 2, 0, thick>
        rotate <tilt, 0, 0>
        translate <0, 0, 0.17>
    }
    object {bolt translate <0, 0.19, 0>}

    texture {rusty}
}
