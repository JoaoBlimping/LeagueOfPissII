#include "colors.inc"
#include "textures.inc"

// a metal grate with a lotta holes like a walkway or something.
#declare grate = texture {
    pigment {
        image_map {
            png "assets/grate.png"
        } rotate x * 90
    }
}

// normal concrete.
#declare concrete = texture {
    pigment {
        granite
        color_map {
            [0 rgb <0.71, 0.71, 0.72>]
            [1 rgb <0.6, 0.6, 0.6>]
        }
    }
    finish {ambient 0.2 diffuse 0.3 crand 0.03 reflection 0}
    normal {bumps 0.2 scale 0.005}
}

#declare greenPaint = texture {
    pigment {rgb <0.002, 0.05, 0.004>}
    normal {granite}
    finish {Shiny}
}

#declare whitePaint = texture {
    pigment {rgb <0.6, 0.6, 0.6>}
    finish {Shiny}
}

#declare rust = texture {
    pigment {rgb <0.3, 0.1, 0>}
    normal {bumps 0.5 scale 0.01}
}

#declare rusty =
    texture {rust}
    texture {
        pigment {
            granite
            color_map {
                [0.45 rgb <1, 0.03, 0>]
                [0.8 rgbt <0, 0, 0, 1>]
            }
        }
        normal {
            granite
            slope_map {
                [0.45 1]
                [0.8 0.5]
            }
        }
        finish {Shiny}
    }

/* #macro rusty(paint)
    texture {rust}
    texture {
        pigment {paint}
        finish {Shiny}
    }
#end */

// wall colour used in happy lemon retreat and NO.
#declare alainWall = texture {
    Cork
    normal {bumps 0.3 scale 0.1}
    finish {Shiny}
}


#declare coconut = texture {
    pigment {rgb <0.3, 0.1, 0>}
    normal {bumps 0.5 scale 0.01}
}
