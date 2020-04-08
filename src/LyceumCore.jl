module LyceumCore

using Base: @pure, @_inline_meta

using StaticNumbers

export @mustimplement, propertytype, argerror
include("util.jl")

export Maybe
export TupleN
export AbsArr, AbsMat, AbsVec
export AbsNestedArr, AbsSimilarNestedArr
export StaticOrVal
include("aliases.jl")

export front, tail, tuple_split, tuple_length, tuple_prod, tuple_minimum
include("tuple.jl")

end # module
