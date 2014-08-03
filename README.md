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
eye(Int64, 100) |> random_partition |> recursive_brim! |> Q
```

## Currently implemented

Functions for initial module assigment accept a two-dimensional array as input,
and return a `Modular` object. Function for modularity optimization accept
a `Modular` object as input and return this object after the optimization
was applied.

### Initial module assignment

- `partition_random`, attributes all nodes to a module at random
- `partition_lp`, uses asynchronous label propagation to estimate the starting partition
- `partition_single`, each node is its own label

### Modularity optimization

- `recursive_brim!`, recursive BRIM, as in the **xxx** paper

## Graphics

Using the `draw_matrix` function, which takes a `Mdular` object as
input. Currently very minimal, links from the same module are in black,
others in grey.

``` julia
A = map((x) -> x<0.2?1:0, rand(20, 10))
A |> partition_lp |> recursive_brim! |> draw_matrix
```
