# BRIM modularity

[![Build Status](https://travis-ci.org/PoisotLab/Brim.jl.svg?branch=master)](https://travis-ci.org/PoisotLab/Brim.jl)
[![Coverage Status](https://coveralls.io/repos/PoisotLab/Brim.jl/badge.svg?branch=master)](https://coveralls.io/r/PoisotLab/Brim.jl?branch=master)
[![codecov.io](http://codecov.io/github/PoisotLab/Brim.jl/coverage.svg?branch=master)](http://codecov.io/github/PoisotLab/Brim.jl?branch=master)
[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.16579.svg)](http://dx.doi.org/10.5281/zenodo.16579)

Various ways to optimize the modularity of bipartite networks using BRIM in
`Julia`.

## Interface

There are two types of functions: those to determine the initial community
partition, who return a `Modular`, and those who do fine-scale optimization
of modularity, who return a `Dict`. This allows to combine different types
of initial label attribution and optimization methods.

The type `Modular` (soon to be replaced by `BinaryModular`, `FloatModular`,
and `IntegerModular`) stores `A` (the matrix) and `S`, the community
partition. *Both* are two-dimensional arrays of `Int64`.

``` julia
using Brim
eye(Int64, 100) |> partition_random |> recursive_brim! |> Q
eye(Int64, 100) |> partition_random |> recursive_brim! |> Qr
eye(Int64, 100) |> partition_random |> recursive_brim! |> network_roles
# Best value out of 100 trials
maximum([eye(Int64, 100) |> partition_random |> recursive_brim! |> Q for i in 1:100])
```

As a lot of iterations may be needed to get the optimal value, it makes
sense to use the code in a parallel context:

~~~ julia
# Use julia -p n where n is the number of cores to use
@everywhere using Brim
@everywhere qoptim = (x) -> x |> partition_random |> recursive_brim! |> Q
Qs = pmap(qoptim, [eye(Int64, 100) for i=1:100])
~~~

## Currently implemented

Functions for initial module assignment accept a two-dimensional array as input,
and return a `Modular` object. Function for modularity optimization accept
a `Modular` object as input and return this object after the optimization
was applied.

### Initial module assignment

- `partition_random`, attributes all nodes to a module at random (good default, especially for networks with less than 50/50 species)
- `partition_lp`, uses asynchronous label propagation to estimate the starting partition (good only for large networks)
- `partition_single`, each node is its own label (good default if you assume a lot of modules)

### Modularity optimization

- `recursive_brim!`, recursive BRIM, as in the **xxx** paper

### Modularity value

- `Q`, bipartite modularity
- `Qr`, realized bipartite modularity, as in **xxx**

### Module roles

* `network_roles`, measures the within-module z-score and the among-module c-score

## Graphics

Using the `draw_matrix` function, which takes a `Modular` object as
input. Currently very minimal, links from the same module are in color, each
module has it own color, arcs between nodes from different modules are in grey.

The scale of the picture will change, each node occupies 10px + 2px on
each side.

``` julia
A = map((x) -> x<0.2?1:0, rand(50, 100))
A |> partition_lp |> recursive_brim! |> draw_matrix
```
