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
[Brim/src/permutations.jl:129](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__null_preserve_marginals.1" class="lexicon_definition"></a>
#### null_preserve_marginals(A::Array{Int64, 2}) [¶](#method__null_preserve_marginals.1)

Performs 2x2 swaps of a matrix by preserving the marginal totals (degree of the
network). The product of the matrix size (rows x columns) divided by four, times
100, is used as a number of swaps. If this number is less than 30000, then the
model performs 30000 swaps.


*source:*
[Brim/src/permutations.jl:72](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__null_preserve_rows_marginals.1" class="lexicon_definition"></a>
#### null_preserve_rows_marginals(A::Array{Int64, 2}) [¶](#method__null_preserve_rows_marginals.1)

Performs 2x2 swaps of a matrix by preserving the marginal totals of ROWS only.
The product of the matrix size (rows x columns) divided by four, times 100, is
used as a number of swaps. If this number is less than 30000, then the model
performs 30000 swaps. The rows marginals are constant, and the returned matrix
cannot have empty rows or columns.


*source:*
[Brim/src/permutations.jl:100](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

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
[Brim/src/permutations.jl:47](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__constrained_swapable.1" class="lexicon_definition"></a>
#### constrained_swapable(A::Array{Int64, 2}) [¶](#method__constrained_swapable.1)

Checks that the matrix is swapable under constrained permutations, i.e. one of
the two conformations called c1 and c2.


*source:*
[Brim/src/permutations.jl:17](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

---

<a id="method__free_swap.1" class="lexicon_definition"></a>
#### free_swap(A::Array{Int64, 2}) [¶](#method__free_swap.1)

Perfoms a free swap: the matrix cells are shuffled. The marginals are not
(necessarily) conserved.


*source:*
[Brim/src/permutations.jl:62](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

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
[Brim/src/permutations.jl:38](file:///home/tpoisot/.julia/v0.3/Brim/src/permutations.jl)

