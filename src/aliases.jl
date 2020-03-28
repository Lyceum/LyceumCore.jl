const Maybe{T} = Union{T,Nothing}

const TupleN{T,N} = NTuple{N,T}

const AbsArr{T,N} = AbstractArray{T,N}
const AbsMat{T} = AbstractMatrix{T}
const AbsVec{T} = AbstractVector{T}

const AbsNestedArr{N} = AbstractArray{<:AbstractArray,N}
const AbsSimilarNestedArr{V,M,N} = AbstractArray{<:AbstractArray{V,M},N}

