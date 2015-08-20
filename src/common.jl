"""
Given a `Modular` object, returns the same object with no empty modules (this
essentially reduces the size of `M.S` if needed).
"""
function no_empty_modules!(M::Modular)
  S = M.S
  S = S[:,[1:size(S)[2]]'[sum(S,1).>0]]
  M.S = S
  return M
end

"""
Check that there are no empty rows in a matrix.
"""
function no_empty_rows(A::Array{Int64, 2})
  return prod(sum(A, 2)) > 0
end

"""
Check that there are no empty columns in a matrix.
"""
function no_empty_columns(A::Array{Int64, 2})
  return prod(sum(A, 1)) > 0
end

"""
Check that two matrices have the same degree distributions.
"""
function same_row_marginals(A::Array{Int64, 2}, B::Array{Int64, 2})
  return sum(A, 2) == sum(B, 2)
end
