# Brim

The function to perform the Brim optimization of modularity is
`recursive_brim!`. It takes a `Modular` object as input, and returns the same
`Modular` object with its modularity optimized.

``` julia
using Brim
eye(Int64, 100) |> partition_random |> recursive_brim!
```

# Modularity values

There are currently two modularity values implemented. `Q` is Barber's original
modularity, and `Qr` is Poisot's realized modularity (which compares the number
of within and between modules links).

``` julia
using Brim
eye(Int64, 100) |> partition_random |> recursive_brim! |> Q
eye(Int64, 100) |> partition_random |> recursive_brim! |> Qr
```
