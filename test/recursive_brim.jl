module TestRecursiveBrim
   using Base.Test
   using Brim
   #=testdir = dirname(@__FILE__)=#
   @test eye(Int64, 50) |> partition_random |> recursive_brim! |> Q >= 0.90
   @test ones(Int64, (50, 50)) |> partition_random |> recursive_brim! |> Q <= 0.1
end
