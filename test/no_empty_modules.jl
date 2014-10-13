module TestNoEmptyModules
   using Base.Test
   using Brim
   #=testdir = dirname(@__FILE__)=#
   A = [[1 0 0], [0 1 0], [0 0 1]]
   S = [[1 0 0], [0 1 0], [0 1 0]]
   M = no_empty_modules!(Modular(A, S))
   @test size(M.S)[1] == 3
   @test size(M.S)[2] == 2
end
