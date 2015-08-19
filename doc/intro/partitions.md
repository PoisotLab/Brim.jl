Functions for initial module assignment accept a two-dimensional array as input,
and return a `Modular` object. Function for modularity optimization accept a
`Modular` object as input and return this object after the optimization was
applied.

- `partition_random`, attributes all nodes to a module at random (good default, especially for networks with less than 50/50 species)
- `partition_lp`, uses asynchronous label propagation to estimate the starting partition (good only for large networks)
- `partition_single`, each node is its own label (good default if you assume a lot of modules)
