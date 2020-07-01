# Quadratic.jl

This example Julia package contains functions and types relating to the quadratic
function ax<sup>2</sup>+bx+c.

## Installing the package

Run the following Julia command to install the package:

```julia
using Pkg

Pkg.add(PackageSpec(url="https://github.com/philip-mortimer/Quadratic.jl"))
```

## Using the package

The following example illustrates how to use the package:

```julia
using Quadratic

const a = 7.6
const b = 0
const c = 2.5

printquadratic(a,b,c)
```

## Package contents

The package contains the following functions and types:

**quadratic(x, a, b, c)**

Return the value of the quadratic function.

*Example*
```juliarepl
julia> quadratic(8.2,-2,7,0)
-77.08
```

**quadraticfunction(a, b, c)**

Return a function 'f(x)' which when called will return the value of the
quadratic function ax<sup>2</sup>+bx+c.

*Examples*
```juliarepl
julia> f = quadraticfunction(-2,7,0)
#4 (generic function with 1 method)

julia> f(8.2)
-77.08

julia> f.([1.0,2.0,3.0])
3-element Array{Float64,1}:
 5.0
 6.0
 3.0
```

**getroots(a, b, c) -> QuadraticRootSet**
<a name="getroots"></a>

Return the roots of the quadratic function ax<sup>2</sup>+bx+c in a [`QuadraticRoots`](#quadraticroots)
object if there are 2 roots (if the discriminant b<sup>2</sup>-4ac is not zero), or in a
[`QuadraticRoot`](#quadraticroot) object if there is only 1 root (```QuadraticRoots```
and ```QuadraticRoot``` are sub-types of [`QuadraticRootSet`](#quadraticrootset)).

If the discriminant is negative then the roots will be complex as they will
contain the square root of a negative number.

*Examples*
```julia-repl
julia> r=getroots(-2, 5, 0) # 2 real roots.
QuadraticRoots{Float64}(-0.0, 2.5)

julia> r.root1
-0.0

julia> r.root2
2.5

julia> r=getroots(3, 0, 1.4) # 2 complex roots.
QuadraticRoots{Complex{Float64}}(0.0 + 0.6831300510639732im, 0.0 - 0.6831300510639732im)

julia> r.root1
0.0 + 0.6831300510639732im

julia> r.root2
0.0 - 0.6831300510639732im

julia> r=getroots(2, 5, 3.125) # 1 real root.
QuadraticRoot{Float64}(-1.25)

julia> r.root
-1.25
```

**getvertex(a, b, c)**

Return the vertex of the quadratic function ax<sup>2</sup>+bx+c in a named tuple.
The vertex is the x,y point on the quadratic function curve where y is at a
minimum (or maximum if a < 0).

*Example*
```julia-repl
julia> getvertex(-2,5,0)
(x = 1.25, y = 3.125)
```

**printquadratic([out::IO], a, b, c)**

Print information relating to the quadratic function ax<sup>2</sup>+bx+c to the output
stream ```out``` (defaults to ```stdout```) as follows:

if ```a``` is not zero print the roots, or root, of the quadratic function,
and the vertex (x,y coordinates where quadratic curve is at a minimum or
maximum).

if ```a``` is zero, but ```b``` is not zero, print the linear intercept (x value
where y=0).

if ```a``` and ```b``` are both zero just print the value of the constant ```c```.

*Examples*
```julia-repl
julia> printquadratic(-2, 5, 0)
ax^2+bx+c where a=-2, b=5, c=0:
    Roots are 0 and 2.5
    Vertex (point where y is at a maximum): (x=1.25,y=3.125)

julia> printquadratic(3.01, 0, 1.4)
ax^2+bx+c where a=3.01, b=0, c=1.4:
    Roots are (0 + 0.68199434i) and (0 - 0.68199434i)
    Vertex (point where y is at a minimum): (x=0,y=1.4)

julia> printquadratic(0, 9.1, 3)
ax^2+bx+c where a=0, b=9.1, c=3:
    Function is linear with intercept (x where y=0) -0.32967033

julia> printquadratic(0, 0, -3)
ax^2+bx+c where a=0, b=0, c=-3:
    Function has constant value -3

julia> out = IOBuffer()

julia> printquadratic(out, 2, 5, 3.125)

julia> str = String(take!(out))

julia> println(str)
ax^2+bx+c where a=2, b=5, c=3.125:
    Root is -1.25
    Vertex (point where y is at a minimum): (x=-1.25,y=0)
```

**QuadraticRootSet**
<a name="quadraticrootset"></a>

Abstract supertype for quadratic root types returned by the 
[`getroots`](#getroots) function.

**QuadraticRoots{T<:Number}(root1::T,root2::T) <: QuadraticRootSet**
<a name="quadraticroots"></a>

Create an object containing 2 quadratic roots. The [`getroots`](#getroots) 
function returns an object created by this constructor if the discriminant is 
not zero. The roots will be 2 real numbers if the discriminant is > 0, or 2 
complex numbers if the discriminant is < 0.

**QuadraticRoot{T<:Real}(root::T) <: QuadraticRootSet**
<a name="quadraticroot"></a>

Create an object containing 1 real quadratic root. The [`getroots`](#getroots)
function returns an object created by this constructor if the discriminant is
zero.

**isnear(rootset1::QuadraticRoots, rootset2::QuadraticRoots)**

Return ```true``` if the roots in ```rootset1``` are equal, or are very close
to being equal, to the roots in ```rootset2```.










