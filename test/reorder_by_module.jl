module TestReoderByModule
   using Base.Test
   using Brim
   #=testdir = dirname(@__FILE__)=#
   A = [[1 0 0], [0 0 1], [0 1 0]]
   S = [[0 1 0], [1 0 0], [0 0 1], [0 1 0], [0 0 1], [0 0 1]]
   C = [[1 0 0], [0 1 0], [0 0 1], [0 1 0], [0 0 1], [0 0 1]]
   M = no_empty_modules!(Modular(A, S))
   reorder_by_module!(M)
   @test sum(abs(M.S .- C)) == 0
end
