module TestPartitionSingle
  using Base.Test
  using Brim

  A = [1 0; 0 1]
  S = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]

  M = partition_single(A)

  # The modularity should be the diagonal matrix
  @test sum(abs(M.S .- S)) == 0

end
