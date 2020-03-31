const StaticOrVal{X} = Union{StaticInteger{X},StaticReal{X},StaticNumber{X},Val{X}}

const SBool = StaticBool
const STrue = typeof(static(true))
const SFalse = typeof(static(false))


wrapval(::StaticOrVal{X}) where {X} = Val(X)
wrapval(::Type{<:StaticOrVal{X}}) where {X} = Val(X)
@pure wrapval(x) = Val(x)

wrapstatic(::StaticOrVal{X}) where {X} = static(X)
wrapstatic(::Type{<:StaticOrVal{X}}) where {X} = static(X)
@pure wrapstatic(x) = static(x)

unwrap(::StaticOrVal{X}) where {X} = X
unwrap(::Type{<:StaticOrVal{X}}) where {X} = X
unwrap(x) = x