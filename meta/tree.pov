#declare random = seed(69);

#macro branch(n, level, length, fall)
    #local rat = 0.6;
    #local bonusRat = 0.9;
    #local bonusChance = 0.8;
    union {
        sphere {<0, 0, 0> 1 texture {coconut}}
        #local chance = rand(random);
        #if (chance > bonusChance)
            cone {<0, 0, 0> 1 <0, length, 0> rat texture {coconut}}
            #if (level > 0)
                #for (i, 1, n, 1)
                    object {
                        branch(n, level - 1, (length / rat) * fall, fall)
                        rotate <rand(random) * 90, rand(random) * 360, 0>
                        scale rat
                        translate <0, length, 0>
                    }
                #end
            #else
            #end
        #else
            cone {<0, 0, 0> 1 <0, length * bonusRat, 0> 1 texture {coconut}}
            object {
                branch(n, level, length, fall)
                rotate <rand(random) * 30, rand(random) * 360, 0>
                translate <0, length * bonusRat, 0>
            }
        #end
    }
#end

#macro tree(n, length, fall)
    branch(n, 3, length, fall)
#end
