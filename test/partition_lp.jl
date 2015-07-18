module TestPartitionLp
  using Base.Test
  using Brim

  A = [1 0; 0 1]
  S = [1 0; 0 1; 1 0; 0 1]

  M = partition_lp(A)

  # The modularity should be the diagonal matrix
  @test sum(abs(M.S .- S)) == 0

  # The original adjacency matrix should not change
  @test sum(abs(M.A .- A)) == 0

end
