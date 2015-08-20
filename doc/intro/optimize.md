The function to perform the Brim optimization of modularity is
`recursive_brim!`. It takes a `Modular` object as input, and returns the same
`Modular` object with its modularity optimized.

``` julia
using Brim
eye(Int64, 100) |> partition_random |> recursive_brim!
```

There are currently two modularity values implemented. `Q` is Barber's original
modularity, and `Qr` is Poisot's realized modularity (which compares the number
of within and between modules links).

``` julia
using Brim
eye(Int64, 100) |> partition_random |> recursive_brim! |> Q
eye(Int64, 100) |> partition_random |> recursive_brim! |> Qr
```

**References:**

Barber M.J. Modularity and community detection in bipartite networks. *arXiv* [pdf](http://arxiv.org/pdf/0707.1616.pdf).

Newman M.E. & Girvan M. Finding and evaluating community structure in networks. *Phys Rev E* 2004, 69:2 (doi: 10.1103/PhysRevE.69.026113).

Poisot T. An a posteriori measure of network modularity *F1000Research* 2013, 2:130 (doi: 10.12688/f1000research.2-130.v3).
