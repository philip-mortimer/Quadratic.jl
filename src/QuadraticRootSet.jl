"""
    QuadraticRootSet

Abstract supertype for quadratic root types returned by the ```getroots```
function.
"""
abstract type QuadraticRootSet end


"""
    QuadraticRoots{T<:Number}(root1::T,root2::T) <: QuadraticRootSet

Create an object containing 2 quadratic roots. The ```getroots``` function
returns an object created by this constructor if the discriminant is not zero.
The roots will be 2 real numbers if the discriminant is > 0, or 2 complex
numbers if the discriminant is < 0.
"""
struct QuadraticRoots{T<:Number} <: QuadraticRootSet
    root1::T
    root2::T
end


"""
    QuadraticRoot{T<:Real}(root::T) <: QuadraticRootSet

Create an object containing 1 real quadratic root. The ```getroots``` function
returns an object created by this constructor if the discriminant is zero.
"""
struct QuadraticRoot{T<:Real} <: QuadraticRootSet
    root::T
end


"""
    isnear(rootset1::QuadraticRoots, rootset2::QuadraticRoots)

Return true if the roots in ```rootset1``` are equal, or are very close to
being equal, to the roots in ```rootset2```.
`"""
function isnear(rootset1::QuadraticRoots, rootset2::QuadraticRoots)
    if nearzero(rootset1.root1 - rootset2.root1)
        return nearzero(rootset1.root2 - rootset2.root2)
    elseif nearzero(rootset1.root1 - rootset2.root2)
        return nearzero(rootset1.root2 - rootset2.root1)
    else
        return false
    end
end

function isnear(rootset1::QuadraticRoot, rootset2::QuadraticRoot)
    nearzero(rootset1.root - rootset2.root)
end
