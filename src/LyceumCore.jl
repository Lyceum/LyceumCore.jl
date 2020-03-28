module LyceumCore

using Base: @pure, @_inline_meta

using StaticNumbers


export Maybe
export TupleN
export AbsArr, AbsMat, AbsVec
export RealArr, RealMat, RealVec
export AbsNestedArr, AbsSimilarNestedArr
include("aliases.jl")

export StaticOrVal, SBool, STrue, SFalse
export wrapval, wrapstatic, unwrap
export static_not, static_and, static_or
export static_filter, static_merge, static_in, static_sum
include("static.jl")

export front, tail, tuple_split, tuple_length, tuple_prod, tuple_minimum
include("util.jl")

end # module
