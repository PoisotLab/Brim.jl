function no_empty_rows(A::Array{Int64, 2})
  return prod(sum(A, 2)) > 0
end

function no_empty_columns(A::Array{Int64, 2})
  return prod(sum(A, 1)) > 0
end

function same_row_marginals(A::Array{Int64, 2}, B::Array{Int64, 2})
  return sum(A, 2) == sum(B, 2)
end

"""
Checks that the matrix is swapable, i.e. one of the two conformations called c1
and c2.
"""
function swapable(A::Array{Int64, 2})
  @assert size(A) == (2, 2)
  const c1 = [1 0; 0 1]
  const c2 = [0 1; 1 0]
  return (A == c1) | (A == c2)
end

"""
Performs a constrained swap: the marginals are conserved.
"""
function constrained_swap(A::Array{Int64, 2})
  # TODO checks
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
  return reshape(A[shuffle([1, 2, 3, 4])], (2, 2))
end

"""
Performs 2x2 swaps of a matrix by preserving the marginal totals (degree of the
network). The product of the matrix size (rows x columns) divided by four, times
100, is used as a number of swaps. If this number is less than 30000, then the
model performs 30000 swaps.
"""
function null_preserve_marginals(A::Array{Int64, 2})
  nswaps = int(maximum([prod(size(A))/4 * 100, 30000.0]))
  dswaps = 0 # Done swaps
  tswaps = 0 # Attempted swaps
  while dswaps < nswaps
    tswaps += 1
    rows = StatsBase.sample(1:size(A,1), 2, replace=false)
    cols = StatsBase.sample(1:size(A,2), 2, replace=false)
    # Only if the submatrix is swapable do we actually swap it
    if swapable(A[rows,cols])
      dswaps += 1
      A[rows,cols] = constrained_swap(A[rows,cols])
    end
    # Logging every 1000 attempts
    if tswaps % 1000 == 0
      Logging.info("SWAP MARGINS A:", tswaps, " D:", dswaps)
    end
  end
  return A
end

"""
Performs 2x2 swaps of a matrix by preserving the marginal totals of ROWS only.
The product of the matrix size (rows x columns) divided by four, times 100, is
used as a number of swaps. If this number is less than 30000, then the model
performs 30000 swaps. The rows marginals are constant, and the returned matrix
cannot have empty rows or columns.
"""
function null_preserve_rows_marginals(A::Array{Int64, 2})
  nswaps = int(maximum([prod(size(A))/4 * 100, 30000.0]))
  dswaps = 0 # Done swaps
  tswaps = 0 # Attempted swaps
  while dswaps < nswaps
    tswaps += 1
    rows = StatsBase.sample(1:size(A,1), 2, replace=false)
    cols = StatsBase.sample(1:size(A,2), 2, replace=false)
    # Only if the submatrix is swapable do we actually swap it
    if swapable(A[rows,cols])
      subA = free_swap(A[rows,cols])
      B = copy(A) # NOTE this may not be optimal because it moves potentially large objects in memory
      B[rows,cols] = subA
      if no_empty_rows(B) & no_empty_columns(B) & same_row_marginals(A, B)
        A = copy(B)
        dswaps += 1
      end
    end
    # Logging every 1000 attempts
    if tswaps % 1000 == 0
      Logging.info("SWAP ROWS A:", tswaps, " D:", dswaps)
    end
  end
  return A
end

"""
Calls `null_preserve_rows_marginals` on `A'`.
"""
function null_preserve_columns_marginals(A::Array{Int64, 2})
  return null_preserve_rows_marginals(A')'
end
