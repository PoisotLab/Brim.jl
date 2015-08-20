Using the `draw_matrix` function, which takes a `Modular` object as
input. Currently very minimal, links from the same module are in color, each
module has it own color, arcs between nodes from different modules are in grey.

The scale of the picture will change, each node occupies 10px + 2px on
each side.

``` julia
A = map((x) -> x<0.2?1:0, rand(50, 100))
A |> partition_lp |> recursive_brim! |> draw_matrix
```
