#include "base.pov"
#include "danyMaterial.pov"






// setting up camera and shit
niceCamera(<0, 7, 0>)
sun(1.0)
object {ocean}


#declare txtTree = texture{rusty}


#local bing1 = union {
    #local Leaf = #include "trees/leaf1.inc";
    #include "trees/1.inc"
    #include "trees/foliage1.inc"
}

#local bing2 = union {
    #local Leaf = #include "trees/leaf2.inc";
    #include "trees/2.inc"
    #include "trees/foliage2.inc"
}

#local bing3 = union {
    #local Leaf = #include "trees/leaf3.inc";
    #include "trees/3.inc"
    #include "trees/foliage3.inc"
}

#local trees = array[3];
#local trees[0] = bing1
#local trees[1] = bing2
#local trees[2] = bing3


#declare stream = seed(2);
#for (i, 1, 50, 1)
    object {
        trees[floor(rand(stream) * 3)]
        rotate <0, rand(stream) * 360, 0>
        translate <6 + rand(stream) * 150, 0, 0>
        rotate <0, rand(stream) * 360, 0>
    }

#end
