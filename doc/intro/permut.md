The `Brim` package offers a (currently limited) way to do significance testing
using permutations with null models. Events during the permutation process are
logged every two minutes.

For example, the following lines will first measure modularity on the original
data, then measure modularity on a permutation of `A` with the same number of
ones.

``` julia
A = map((x) -> x<0.2?1:0, rand(50, 100))
A |> partition_lp |> recursive_brim! |> Q
A |> null_preserve_marginals |> partition_lp |> recursive_brim! |> Q
```

Because swap algorithms need to look for swapable submatrices, they can take a
while to run.

The `null_preserve_rows_marginals` function does the same routine *but* only
enforces the equality of rows marginals (same thing for `s/row/column/`). It may
take longer to run because this routine introduces the possibility of emptying
rows or columns, in which case the swapping step is not valid.

A final null model (`null_preserve_fill`) only conserves the matrix *fill*: the
number of arcs are kept, but not the marginals.

**Example:**

``` julia
A = map((x) -> x<0.2?1:0, rand(80, 90))
n_samples = 50
empirical_q = A |> partition_lp |> recursive_brim! |> Q
# The next line would benefit from being run using pmap
shuffled_q = map((x) -> A |> null_preserve_marginals |> partition_lp |> recursive_brim! |> Q, 1:n_samples)
# (APPROXIMATION of the p-value for the hypothesis that empirical_Q > random_Q)
pvalue = sum(empirical_q .<= shuffled_q) / n_samples
```
