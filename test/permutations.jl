module TestPermutation
  using Base.Test
  using Brim

  A = map((x) -> x<0.2?1:0, rand(10, 10))

  # null_preserve_fill
  @test sum(A) == sum(null_preserve_fill(A))
  @test sum(A) == sum(null_preserve_fill(A))
  @test sum(A) == sum(null_preserve_fill(A))


end
