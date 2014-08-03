function partition_single(A::Array{Int64, 2})
   S = eye(Int64, sum(size(A)))
   M = Modular(A, S)
   return M
end
