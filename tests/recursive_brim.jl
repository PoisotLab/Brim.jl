module TestRecursiveBrim
   using Base.Test
   using Brim
   #=testdir = dirname(@__FILE__)=#
   A = eye(50)
   @test recursive_brim(A)['Q'] > 0.95
end
