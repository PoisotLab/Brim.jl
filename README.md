# BRIM modularity

Various ways to optimize the modularity of bipartite networks using BRIM in
`Julia`.

## Interface

All functions take an `Array{Int64, 2}` as input (will be changed when we
get to measures for quantitative network), as return a `Dict` with keys `"Q"`
(modularity) and `"S"` (community partition matrix).

## Currently implemented

- `recursive_brim` recursive BRIM, as in the **xxx** paper

## Usage

``` julia
using Brim
A = eye(Int64, 100)
recursive_brim(A)
```

## Graphics

Not yet.
