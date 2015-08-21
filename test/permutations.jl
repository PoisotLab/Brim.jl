module TestPermutation
  using Base.Test
  using Brim

  # Test utility functions

  c1 = [1 0; 0 1]
  c2 = [0 1; 1 0]
  c3 = [0 0; 1 1]
  c4 = [1 1; 1 1]
  c5 = [0 0; 0 0]

  @test Brim.free_swapable(c1) == true
  @test Brim.free_swapable(c2) == true
  @test Brim.free_swapable(c3) == true
  @test Brim.free_swapable(c4) == false
  @test Brim.free_swapable(c5) == false

  @test Brim.constrained_swapable(c1) == true
  @test Brim.constrained_swapable(c2) == true
  @test Brim.constrained_swapable(c3) == false
  @test Brim.constrained_swapable(c4) == false
  @test Brim.constrained_swapable(c5) == false

  @test Brim.constrained_swap(c1) == c2
  @test Brim.constrained_swap(c2) == c1

  @test Brim.no_empty_rows(c3) == false
  @test Brim.no_empty_rows(c1) == true
  @test Brim.no_empty_columns(c3') == false
  @test Brim.no_empty_columns(c1') == true

  @test Brim.same_row_marginals(c1, c2) == true
  @test Brim.same_row_marginals(c1, c1) == true
  @test Brim.same_row_marginals(c1, c3) == false

  A = [1 1 1 0 0 0; 1 1 1 0 0 0; 1 1 1 0 0 0; 0 0 0 1 1 1; 0 0 0 1 1 1; 0 0 0 1 1 1]

  # null_preserve_marginals
  @test sum(A) == sum(null_preserve_marginals(A))
  @test sum(A) == sum(null_preserve_marginals(A))
  @test sum(A) == sum(null_preserve_marginals(A))

  # null_preserve_rows_marginals
  @test sum(A, 2) == sum(null_preserve_rows_marginals(A), 2)
  @test sum(A, 2) == sum(null_preserve_rows_marginals(A), 2)
  @test sum(A, 2) == sum(null_preserve_rows_marginals(A), 2)

  # null_preserve_columns_marginals
  @test sum(A, 1) == sum(null_preserve_columns_marginals(A), 1)
  @test sum(A, 1) == sum(null_preserve_columns_marginals(A), 1)
  @test sum(A, 1) == sum(null_preserve_columns_marginals(A), 1)

  # null_preserve_fill
  X = null_preserve_fill(A)
  @test sum(A) == sum(X)
  @test Brim.no_empty_rows(X)
  @test Brim.no_empty_columns(X)

end
