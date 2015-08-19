# BRIM modularity

[![Build Status](https://travis-ci.org/PoisotLab/Brim.jl.svg?branch=master)](https://travis-ci.org/PoisotLab/Brim.jl)
[![Coverage Status](https://coveralls.io/repos/PoisotLab/Brim.jl/badge.svg?branch=master)](https://coveralls.io/r/PoisotLab/Brim.jl?branch=master)
[![codecov.io](http://codecov.io/github/PoisotLab/Brim.jl/coverage.svg?branch=master)](http://codecov.io/github/PoisotLab/Brim.jl?branch=master)
[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.16579.svg)](http://dx.doi.org/10.5281/zenodo.16579)
[![Documentation Status](https://readthedocs.org/projects/brimjl/badge/?version=latest)](https://readthedocs.org/projects/brimjl/?badge=latest)

Various ways to optimize the modularity of bipartite networks using BRIM in
`Julia`.

## Log file

**TODO**

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
