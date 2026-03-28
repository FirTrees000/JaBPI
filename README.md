# JaBPI
An API for using Figura with JaB

# Installation
This works just like any other module, just copy the Lua file into the folder with your main script

In your main script, add the line
```
jabpi = require("JaBPI")
```

Now it's installed :)

# The Functions
# `setAnims()`
Arguably the most important function!

This function sets the animations that JaBPI uses for its default animation updates

Most likely, you'll want to put it in the `events.entity_init()` function


This function takes 4 arguments
`setAnims(a,b,c,d)`
```
a = fat animation
b = fullness animation (stuffing + inflation)
c = stuffing animation
d = inflation animation
```

generally you want to pick between using `b` alone or `c` and `d`

They do the same thing, `c` and `d` just separate it out

example:
```
event.entity_init()
	jabpi.setAnims(fatAnim,fillAnim,nil,nil)
end
```
or
```
event.entity_init()
	jabpi.setAnims(fatAnim,nil,stuffingAnim,inflationAnim)
end
```
