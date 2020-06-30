using Printf

const INDENT = "    "

function printvertex(out::IO, a, b, c)
    vertex = getvertex(a, b, c)
    minmax = a < 0 ? "maximum" : "minimum"
    str = formatpoint(vertex)
    print(out, INDENT)
    println(out, "Vertex (point where y is at a ", minmax, "): ", str)
end

function printrootset(out::IO, rootset::QuadraticRoots)
    str1 = formatnumber(rootset.root1)
    str2 = formatnumber(rootset.root2)
    if str1==str2
        str1 = formatnumber(rootset.root1; round=false)
        str2 = formatnumber(rootset.root2; round=false)
    end
    println(out, INDENT, "Roots are ", str1, " and ", str2)
end

function printrootset(out::IO, rootset::QuadraticRoot)
    str = formatnumber(rootset.root)
    println(out, INDENT, "Root is ", str)
end

function printroots(out::IO, a, b, c)
    rootset = getroots(a, b, c)
    printrootset(out, rootset)
end

function printintercept(out::IO, slope, constant)
    # The intercept is the x value such that y=0 in the
    # linear equation y = slope * x + constant.
    intercept = -constant/slope
    str = formatnumber(intercept)
    print(out, INDENT)
    println(out, "Function is linear with intercept (x where y=0) ", str)
end

function printconstant(out::IO, constant)
    str = formatnumber(constant)
    println(out, INDENT, "Function has constant value ", str)
end

function printcoeffs(out::IO, a, b, c)
    astr = formatnumber(a)
    bstr = formatnumber(b)
    cstr = formatnumber(c)
    println(out, "ax^2+bx+c where a=$astr, b=$bstr, c=$cstr:")
end


"""
    printquadratic([out::IO], a, b, c)

Print information relating to the quadratic function ax^2+bx+c to the output
stream ```out``` (defaults to ```stdout```) as follows:

if ```a``` is not zero print the roots, or root, of the quadratic function
and the vertex (x,y coordinates where the quadratic function curve is at a
minimum or maximum).

if ```a``` is zero, but ```b``` is not zero, print the linear intercept
(x value where y=0).

if ```a``` and ```b``` are both zero just print the value of the constant
```c```.

# Examples
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
"""
function printquadratic(out::IO, a, b, c)
    printcoeffs(out, a, b, c)
    if nearzero(a)
        if nearzero(b)
            printconstant(out, c)
        else
            printintercept(out, b, c)
        end
    else
        printroots(out, a, b, c)
        printvertex(out, a, b, c)
    end
end

printquadratic(a, b, c) = printquadratic(stdout, a, b, c)
