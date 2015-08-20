This package provides a series of functions to optimize the modularity of
bipartite networks, test its significance, and plot the results. The approach to
using this package is as follows:

1. Prepare the data as an adjacency matrix (type `Array{Int64,2}`) containing 0 and 1
2. Assign an initial community partition using one of the different methods
3. Refine this structure using the recursive Brim approach
4. (Optional) Measure the roles of all nodes
5. (Optional) Test the significance of the modular structure using swaps
6. (Optional) Visualize the results

Functions that create an initial partition (`partition_*`) work on an adjancency
matrix. All (almost all) other function work on a `Modular` object, which is
returned by the starting partition functions. The `Modular` types stores both
the adjacency matrix, and the module matrix.
