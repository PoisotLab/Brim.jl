The `network_roles` function measures the within-module z-score and the
among-module c-score.

``` julia
using Brim
eye(Int64, 100) |> partition_random |> recursive_brim! |> Q
eye(Int64, 100) |> partition_random |> recursive_brim! |> Qr
eye(Int64, 100) |> partition_random |> recursive_brim! |> network_roles
# Best value out of 100 trials
maximum([eye(Int64, 100) |> partition_random |> recursive_brim! |> Q for i in 1:100])
```
