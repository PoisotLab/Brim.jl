module TestQrValue
   using Base.Test
   using Brim
   #=testdir = dirname(@__FILE__)=#
   A = [[1 0 0], [0 1 0], [0 0 1]]
   S = [[1 0 0], [0 1 0], [0 0 1], [1 0 0], [0 1 0], [0 0 1]]
   M = Modular(A, S)
   # Approximate values, calculated by hand
   @test M |> Qr == 1.0
end
