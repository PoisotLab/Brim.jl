"""
Every node is in its own module.
"""
function partition_single(A::Array{Int64, 2})
  # Every species is its own partition
  S = eye(Int64, sum(size(A)))
  M = Modular(A, S)
  return M
end
