# Brim

## Exported

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
