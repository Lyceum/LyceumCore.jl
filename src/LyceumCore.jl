module LyceumCore

using Base: @pure, @_inline_meta

using StaticNumbers


export Maybe
export TupleN
export AbsArr, AbsMat, AbsVec
export AbsNestedArr, AbsSimilarNestedArr
include("aliases.jl")

export front, tail, tuple_split, tuple_length, tuple_prod, tuple_minimum
include("util.jl")

end # module
