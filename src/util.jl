@inline ncolons(n::Integer) = ntuple(_ -> Colon(), n)

@inline front(t::Tuple, m::Integer) = ntuple(i -> t[i], m)
@inline front(t::Tuple, ::StaticOrVal{M}) where {M} = ntuple(i -> t[i], Val(M))
@inline front(t::NTuple{L,Any}) where {L} = front(t, Val(L - 1))

@inline function tail(t::Tuple, n::Integer)
    m = length(t) - n
    ntuple(i -> t[i+m], n)
end
@inline function tail(t::NTuple{L,Any}, ::StaticOrVal{N}) where {L,N}
    M = L - N
    ntuple(i -> t[i+M], Val(N))
end
@inline tail(t::NTuple{L,Any}) where {L} = tail(t, Val(L - 1))

@inline function tuple_split(t::NTuple{L,Any}, ::StaticOrVal{M}) where {L,M}
    front(t, Val(M)), tail(t, Val(L - M))
end
@inline function tuple_split(t::NTuple{L,Any}, m::Integer) where {L}
    front(t, Val(m)), tail(t, L - m)
end

@pure tuple_length(T::Type{<:Tuple}) = length(T.parameters)
@pure tuple_length(t::Tuple) = length(t)

@pure tuple_prod(T::Type{<:Tuple}) = length(T.parameters) == 0 ? 1 : *(T.parameters...)
@pure tuple_prod(t::Tuple) = prod(t)

@pure function tuple_minimum(T::Type{<:Tuple})
    length(T.parameters) == 0 ? 0 : minimum(tuple(T.parameters...))
end
@pure tuple_minimum(t::Tuple) = minimum(t)
