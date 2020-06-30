"""
    quadratic(x, a, b, c)

Return the value of the quadratic function y=ax^2+bx+c.

# Example
```julia-repl
julia> quadratic(8.2,-2,7,0)
-77.08
```
"""
function quadratic(x, a, b, c)
    a*x^2 + b*x + c
end


"""
    quadraticfunction(a, b, c)

Return a function 'f(x)' which when called will return the value of the
quadratic function ax^2+bx+c.

# Example
```julia-repl
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
"""
function quadraticfunction(a, b, c)
    x -> quadratic(x, a, b, c)
end


"""
    getroots(a, b, c) -> QuadraticRootSet

Return the roots of the quadratic function ax^2+bx+c in a ```QuadraticRoots```
object if there are 2 roots (if the discriminant b^2-4ac is not zero), or in a
```QuadraticRoot``` object if there is only 1 root (```QuadraticRoots```
and ```QuadraticRoot``` are sub-types of ```QuadraticRootSet```).

If the discriminant is negative then the roots will be complex as they will
contain the square root of a negative number.

# Examples
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
"""
function getroots(a, b, c)::QuadraticRootSet
    @assert (! nearzero(a)) "a cannot be zero."

    denom = 2.0 * a
    discrim = b^2.0 - 4.0 * a * c
    if nearzero(discrim)
        # There is only 1 root.
        root = -b / denom
        return QuadraticRoot(root)
    end
    if discrim < zero(discrim)
        sq_root_of_discrim = sqrt(Complex(discrim))
    else
        sq_root_of_discrim = sqrt(discrim)
    end

    root1 = (-b + sq_root_of_discrim) / denom
    root2 = (-b - sq_root_of_discrim) / denom

    QuadraticRoots(root1, root2)
end


"""
    getvertex(a, b, c)

Return the vertex of the quadratic function ax^2+bx+c in a named tuple.
The vertex is the x,y point on the quadratic function curve where y is at a
minimum (or maximum if a < 0).

# Example
```julia-repl
julia> getvertex(-2,5,0)
(x = 1.25, y = 3.125)
```
"""
function getvertex(a, b, c)
    @assert (! nearzero(a)) "a cannot be zero."

    # Get x where y is at a minimum or maximum.
    x = -b / (2.0 * a)
    y = quadratic(x, a, b, c)

    (x=x, y=y)
end
