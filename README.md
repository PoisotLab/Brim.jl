# BRIM modularity

Various ways to optimize the modularity of bipartite networks using BRIM in
`Julia`.

## Interface

There are two types of functions: those to determine the initial community
partition, who return a `Modular`, and those who do fine-scale optimization
of modularity, who return a `Dict`. This allows to combine different types
of initial label attribution and optimization methods.

The type `Modular` (soon to be replaced by `BinaryModular`, `FloatModular`,
and `IntegerModular`) stores `A` (the matrix) and `S`, the community partition.

``` julia
using Brim
eye(Int64, 100) |> random_partition |> recursive_brim
```

## Currently implemented

### Initial module assignment

- `partition_random`, attributes all nodes to a module at random
- `partition_lp`, *not yet*

### Modularity optimization

- `recursive_brim`, recursive BRIM, as in the **xxx** paper

## Graphics

Not yet.
