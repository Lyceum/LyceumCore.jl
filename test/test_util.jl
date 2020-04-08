module TestUtil

include("preamble.jl")

@testset "mkgoodpath" begin
    mktempdir() do path
        mkpath(joinpath(path, "foo"))
        mkpath(joinpath(path, "foo", "bar.txt"))
        mkpath(joinpath(path, "foo", "baz.txt"))
        mkpath(joinpath(path, "foo", "baz_1.txt"))
        @info walkdir(path)
    end
    @test true
end

end # module