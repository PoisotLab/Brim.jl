module TestReorderByModule
  using Base.Test
  using Brim

  # Test 1 - simple case

  A = [1 0 0; 0 0 1; 0 1 0]
  S = [0 1 0; 1 0 0; 0 0 1; 0 1 0; 0 0 1; 0 0 1]
  C = [1 0 0; 0 1 0; 0 0 1; 0 1 0; 0 0 1; 0 0 1]

  M = no_empty_modules!(Modular(A, S))

  reorder_by_module!(M)
  @test sum(abs(M.S .- C)) == 0

  # Test 2 - more complex case

  A = [0 0 0 1 1 1; 1 1 1 0 0 0; 0 0 0 1 1 1; 1 1 1 0 0 0; 0 0 0 1 1 1; 1 1 1 0 0 0]
  M = recursive_brim!(partition_random(A))
  reorder_by_module!(M)

  target = [1 0; 1 0; 1 0; 0 1; 0 1; 0 1; 1 0; 1 0; 1 0; 0 1; 0 1; 0 1]

  @test hash(M.S) == hash(target)

end
