"""
Checks that the matrix is swapable under constrained permutations, i.e. one of
the two conformations called c1 and c2.
"""
function constrained_swapable(A::Array{Int64, 2})
  @assert size(A) == (2, 2)
  const c1 = [1 0; 0 1]
  const c2 = [0 1; 1 0]
  return (A == c1) | (A == c2)
end

"""
Checks that the matrix is swapable under free permutations, i.e. it has
at least one non-zero element, and at least one zero element.

This check is necessary because if not, the free swaps will collect all ones in
a few rows / columns, which results in very blocky (and therefore biased)
matrices. As a consequence, all sub-matrices that are "constrained swapable" are
"free swapable" too, but the reciprocal is not true.

Because more sub-matrices are free swapable, and because there are higher order
constraints on the acceptable swapped matrices.

Also, this is a serious lot of documentation in a function that is not exported.
"""
function free_swapable(A::Array{Int64, 2})
  @assert size(A) == (2, 2)
  return (sum(A) >= 1) & (sum(A) <= 3)
end


"""
Performs a constrained swap: the marginals are conserved.
"""
function constrained_swap(A::Array{Int64, 2})
  @assert size(A) == (2, 2)
  const c1 = [1 0; 0 1]
  const c2 = [0 1; 1 0]
  if A == c2
    return c1
  else A == c1
    return c2
  end
end

"""
Perfoms a free swap: the matrix cells are shuffled. The marginals are not
(necessarily) conserved.
"""
function free_swap(A::Array{Int64, 2})
  @assert size(A) == (2, 2)
  return reshape(A[shuffle([1, 2, 3, 4])], (2, 2))
end

"""
Performs 30000 2x2 swaps of a matrix by preserving the marginal totals (degree of the
network).
"""
function null_preserve_marginals(A::Array{Int64, 2})
  X = copy(A)
  nswaps = 30000
  dswaps = 0 # Done swaps
  tswaps = 0 # Attempted swaps
  START_TIME = time()
  while dswaps < nswaps
    tswaps += 1
    rows = StatsBase.sample(1:size(X,1), 2, replace=false)
    cols = StatsBase.sample(1:size(X,2), 2, replace=false)
    # Only if the submatrix is swapable do we actually swap it
    if constrained_swapable(X[rows,cols])
      dswaps += 1
      X[rows,cols] = constrained_swap(X[rows,cols])
    end

    if time() - START_TIME >= 120
      START_TIME = time()
    end
  end

  return X
end

"""
Performs 30000 2x2 swaps of a matrix by preserving the marginal totals of ROWS only.
"""
function null_preserve_rows_marginals(A::Array{Int64, 2})
  X = copy(A)
  nswaps = 30000
  dswaps = 0 # Done swaps
  tswaps = 0 # Attempted swaps
  START_TIME = time()
  while dswaps < nswaps
    tswaps += 1
    rows = StatsBase.sample(1:size(X,1), 2, replace=false)
    cols = StatsBase.sample(1:size(X,2), 2, replace=false)
    # Only if the submatrix is swapable do we actually swap it
    if free_swapable(X[rows,cols])
      subX = free_swap(X[rows,cols])
      Y = copy(X) # NOTE this may not be optimal because it moves potentially large objects in memory
      Y[rows,cols] = subX
      if no_empty_rows(Y) & no_empty_columns(Y) & same_row_marginals(X, Y)
        X[rows,cols] = subX
        dswaps += 1
      end
    end

    if time() - START_TIME >= 120
      START_TIME = time()
    end
  end

  return X
end

"""
Calls `null_preserve_rows_marginals` on `A'`.
"""
function null_preserve_columns_marginals(A::Array{Int64, 2})
  return null_preserve_rows_marginals(A')'
end

"""
Performs 30000 2x2 swaps of a matrix by preserving the fill only.
"""
function null_preserve_fill(A::Array{Int64, 2})
  X = copy(A)

  nswaps = 30000
  dswaps = 0 # Done swaps
  tswaps = 0 # Attempted swaps
  START_TIME = time()
  while dswaps < nswaps
    tswaps += 1
    rows = StatsBase.sample(1:size(X,1), 2, replace=false)
    cols = StatsBase.sample(1:size(X,2), 2, replace=false)
    # Only if the submatrix is swapable do we actually swap it
    if free_swapable(X[rows,cols])
      subX = free_swap(X[rows,cols])
      Y = copy(X) # NOTE this may not be optimal because it moves potentially large objects in memory
      Y[rows,cols] = subX
      if no_empty_rows(Y) & no_empty_columns(Y)
        X[rows,cols] = subX # NOTE this avoids copying B back into A
        dswaps += 1
      end
    end

    if time() - START_TIME >= 120
      START_TIME = time()
    end
  end

  return X
end
