# Brim

## Exported

---

<a id="method__draw_matrix.1" class="lexicon_definition"></a>
#### draw_matrix(M::Modular) [¶](#method__draw_matrix.1)

Takes a `Modular` object, and plot it using the *Cairo* driver.

**Keyword arguments:**

- `reorder::Function`, a function to change the order of species (by default, `reorder_by_module!`)
- `file`: the name of the file to draw in (has to end in `.png`)

Note that the modules are identified by color, using the
`distinguishable_colors` function from the `Colors` package.


*source:*
[Brim/src/draw_matrix.jl:44](file:///home/tpoisot/.julia/v0.3/Brim/src/draw_matrix.jl)

---

<a id="method__network_roles.1" class="lexicon_definition"></a>
#### network_roles(M::Modular) [¶](#method__network_roles.1)

Measure the roles of the species in a network (given as a `Modular` object),
according to two parameters. *z* is the z-score of the degree within a modules
(which species connect *within* their modules). *c* is the degree across
networks (which species connect different networks).

The result is given as a `data.frame` object.


*source:*
[Brim/src/network_roles.jl:9](file:///home/tpoisot/.julia/v0.3/Brim/src/network_roles.jl)

---

<a id="method__no_empty_modules.1" class="lexicon_definition"></a>
#### no_empty_modules!(M::Modular) [¶](#method__no_empty_modules.1)

Given a `Modular` object, returns the same object with no empty modules (this
essentially reduces the size of `M.S` if needed).


*source:*
[Brim/src/common.jl:5](file:///home/tpoisot/.julia/v0.3/Brim/src/common.jl)

---

<a id="method__null_preserve_columns_marginals.1" class="lexicon_definition"></a>
#### null_preserve_columns_marginals(A::Array{Int64, 2}) [¶](#method__null_preserve_columns_marginals.1)

Calls `null_preserve_rows_marginals` on `A'`.


*source:*
[Brim/src/permutations.jl:140](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__null_preserve_marginals.1" class="lexicon_definition"></a>
#### null_preserve_marginals(A::Array{Int64, 2}) [¶](#method__null_preserve_marginals.1)

Performs 30000 2x2 swaps of a matrix by preserving the marginal totals (degree of the
network).


*source:*
[Brim/src/permutations.jl:79](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__null_preserve_rows_marginals.1" class="lexicon_definition"></a>
#### null_preserve_rows_marginals(A::Array{Int64, 2}) [¶](#method__null_preserve_rows_marginals.1)

Performs 30000 2x2 swaps of a matrix by preserving the marginal totals of ROWS only.


*source:*
[Brim/src/permutations.jl:107](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__partition_lp.1" class="lexicon_definition"></a>
#### partition_lp(A::Array{Int64, 2}) [¶](#method__partition_lp.1)

Propagate labels to reach the starting partition. Takes an adjacency matrix
as input and returns a `Modular` object as output.

This approach works better for large graphs (it tends to underperform both the
"random" and "single" approaches for small graphs).

The optimization stops when any label propagation fails to increase the
modularity, measured with `Q`.


*source:*
[Brim/src/partition_lp.jl:11](file:///home/tpoisot/.julia/v0.3/Brim/src/partition_lp.jl)

---

<a id="method__partition_random.1" class="lexicon_definition"></a>
#### partition_random(A::Array{Int64, 2}) [¶](#method__partition_random.1)

Create a random partition for a matrix `A`. Each node is assigned to a module at
random. If the smallest dimension of the matrix is *m*, there will be between 1
and *m* modules.

This method tends to work well for small to medium networks (and is faster than
`partition_lp`).


*source:*
[Brim/src/partition_random.jl:9](file:///home/tpoisot/.julia/v0.3/Brim/src/partition_random.jl)

---

<a id="method__partition_single.1" class="lexicon_definition"></a>
#### partition_single(A::Array{Int64, 2}) [¶](#method__partition_single.1)

Every node is in its own module.


*source:*
[Brim/src/partition_single.jl:4](file:///home/tpoisot/.julia/v0.3/Brim/src/partition_single.jl)

---

<a id="method__reorder_by_module.1" class="lexicon_definition"></a>
#### reorder_by_module!(M::Modular) [¶](#method__reorder_by_module.1)

Takes a `Modular` object, and reorder it by module. The row / columns of `A` and
`S` are modified.


*source:*
[Brim/src/draw_matrix.jl:5](file:///home/tpoisot/.julia/v0.3/Brim/src/draw_matrix.jl)

## Internal

---

<a id="method__constrained_swap.1" class="lexicon_definition"></a>
#### constrained_swap(A::Array{Int64, 2}) [¶](#method__constrained_swap.1)

Performs a constrained swap: the marginals are conserved.


*source:*
[Brim/src/permutations.jl:56](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__constrained_swapable.1" class="lexicon_definition"></a>
#### constrained_swapable(A::Array{Int64, 2}) [¶](#method__constrained_swapable.1)

Checks that the matrix is swapable under constrained permutations, i.e. one of
the two conformations called c1 and c2.


*source:*
[Brim/src/permutations.jl:26](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__free_swap.1" class="lexicon_definition"></a>
#### free_swap(A::Array{Int64, 2}) [¶](#method__free_swap.1)

Perfoms a free swap: the matrix cells are shuffled. The marginals are not
(necessarily) conserved.


*source:*
[Brim/src/permutations.jl:71](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__free_swapable.1" class="lexicon_definition"></a>
#### free_swapable(A::Array{Int64, 2}) [¶](#method__free_swapable.1)

Checks that the matrix is swapable under free permutations, i.e. it has
at least one non-zero element, and at least one zero element.

This check is necessary because if not, the free swaps will collect all ones in
a few rows / columns, which results in very blocky (and therefore biased)
matrices. As a consequence, all sub-matrices that are "constrained swapable" are
"free swapable" too, but the reciprocal is not true.

Because more sub-matrices are free swapable, and because there are higher order
constraints on the acceptable swapped matrices.

Also, this is a serious lot of documentation in a function that is not exported.


*source:*
[Brim/src/permutations.jl:47](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__no_empty_columns.1" class="lexicon_definition"></a>
#### no_empty_columns(A::Array{Int64, 2}) [¶](#method__no_empty_columns.1)

Check that there are no empty columns in a matrix.


*source:*
[Brim/src/permutations.jl:11](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__no_empty_rows.1" class="lexicon_definition"></a>
#### no_empty_rows(A::Array{Int64, 2}) [¶](#method__no_empty_rows.1)

Check that there are no empty rows in a matrix.


*source:*
[Brim/src/permutations.jl:4](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__same_row_marginals.1" class="lexicon_definition"></a>
#### same_row_marginals(A::Array{Int64, 2}, B::Array{Int64, 2}) [¶](#method__same_row_marginals.1)

Check that two matrices have the same degree distributions.


*source:*
[Brim/src/permutations.jl:18](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

