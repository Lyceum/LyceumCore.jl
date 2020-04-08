include("preamble.jl")

@info "Running with $(Threads.nthreads()) threads"
@includetests "LyceumCore.jl"
