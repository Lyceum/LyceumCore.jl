module TestUtil

include("preamble.jl")
using LyceumCore: genpath

@testset "mkgoodpath" begin
    with_tempdir() do dir
        mkpath("dir1/dir2")
        touch("f1.txt")
        touch(joinpath("dir1", "f2.txt"))
        touch(joinpath("dir1", "dir2", "f3.txt"))
        touch(joinpath("dir1", "dir2", "f3_1.txt"))

        @test genpath("dir1/dir2") == joinpath("dir1", "dir2_1")
        @test genpath("f1.txt", force=true) == "f1.txt"
        @test !isfile("f1.txt")
        @test genpath("dir1/dir2/f3.txt") == joinpath("dir1", "dir2", "f3_2.txt")
        @test genpath("dir1/dir2/f3.txt", sep="___") == joinpath("dir1", "dir2", "f3___1.txt")
    end
end

end # module