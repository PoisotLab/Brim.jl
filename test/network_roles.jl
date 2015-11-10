module TestNetworkRoles
   using Base.Test
   using Brim
   #=testdir = dirname(@__FILE__)=#
   A = [1 0 0; 1 1 0; 0 1 1; 0 1 1]
   S = [1 0; 0 1; 0 1; 1 0; 1 0; 0 1; 0 1]
   M = Modular(A, S)
   roles = network_roles(M)
   ## Approximate values, calculated by hand
   @test abs(roles[:z][1] - 1.1547) <= 0.01
   @test abs(roles[:c][2] - 0.4444) <= 0.01
   @test roles[:c][5] == 0.5
end
