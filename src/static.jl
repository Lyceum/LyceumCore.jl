const SBool = StaticBool
const STrue = typeof(static(true))
const SFalse = typeof(static(false))

const StaticOrVal{X} = Union{StaticInteger{X}, StaticReal{X}, StaticNumber{X}, Val{X}}


wrapval(::StaticOrVal{X}) where {X} = Val(X)
wrapval(::Type{<:StaticOrVal{X}}) where {X} = Val(X)
@pure wrapval(x) = Val(x)

wrapstatic(::StaticOrVal{X}) where {X} = static(X)
wrapstatic(::Type{<:StaticOrVal{X}}) where {X} = static(X)
@pure wrapstatic(x) = static(x)

unwrap(::StaticOrVal{X}) where {X} = X
unwrap(::Type{<:StaticOrVal{X}}) where {X} = X
unwrap(x) = x


static_not(::SFalse) = static(true)
static_not(::STrue) = static(false)

static_and(::STrue, ::STrue) = static(true)
static_and(::SBool, ::SBool) = static(false)

static_or(::SBool, ::STrue) = static(true)
static_or(::STrue, ::SBool) = static(true)
static_or(::SBool, ::SBool) = static(false)

static_in(x::StaticOrInt, itr::TupleN{StaticOrInt}) = _static_in(x, itr)
@pure function _static_in(x::StaticOrInt, itr::TupleN{StaticOrInt})
    for y in itr
        unwrap(y) === unwrap(x) && return static(true)
    end
    return static(false)
end

@pure function static_filter(which::SBool, by::NTuple{N,SBool}, xs::NTuple{N,Any}) where {N}
    _static_filter(which, by, xs)
end
@inline function _static_filter(which::SBool, by::NTuple{N,SBool}, xs::NTuple{N,Any}) where {N}
    (_filter1(which, first(by), first(xs))..., _static_filter(which, tail(by), tail(xs))...)
end
_static_filter(::SBool, ::Tuple{}, ::Tuple{}) = ()
@inline _filter1(::T, ::T, x) where {T} = (x, )
@inline _filter1(::T, ::V, x) where {T,V} = ()

@generated function static_merge(::Bys, x::X, y::Y) where {Bys<:TupleN{SBool}, X<:Tuple, Y<:Tuple}
    i = j = 0
    xy = []
    for By in Bys.parameters
        if By === STrue
            push!(xy, :(x[$(i+=1)]))
            i > tuple_length(X) && return :(throw(BoundsError(x, $i)))
        else
            push!(xy, :(y[$(j+=1)]))
            j > tuple_length(Y) && return :(throw(BoundsError(y, $j)))
        end
    end
    return :(@_inline_meta; $(Expr(:tuple, xy...)))
end
