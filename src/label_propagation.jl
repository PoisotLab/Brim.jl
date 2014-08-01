function label_propagation(A::Array{Int64, 2})
   min_part = minimum(size(A))
   nr, nc = size(A)
   S = eye(Int64, sum(size(A)))
   M = Modular(A, S)
   old_Q = 0.0
   new_Q = 0.000001
   while new_Q > old_Q
      update_order_top = shuffle([1:nc])
      update_order_bot = shuffle([1:nr]) .+ nc
      @inbounds for node_top in update_order_top
         neighbors = [1:nr]'[M.A[node_top,:] .> 0] .+ nc
         println(neighbors)
      end
      old_Q = new_Q
      new_Q = Q(M)
   end
   return M
end
