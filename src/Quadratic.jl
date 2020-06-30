module Quadratic
    export QuadraticRootSet,QuadraticRoots,QuadraticRoot,isnear
    export quadratic,quadraticfunction,getroots,getvertex,printquadratic

    include("nearzero.jl")
    include("formatnumber.jl")
    include("QuadraticRootSet.jl")
    include("quadraticlib.jl")
    include("printquadratic.jl")
end # module
