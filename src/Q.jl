function Q(A::Array{Int64, 2}, S::Array{Int64, 2}; axis=1)
   #=

   Returns Barber's bipartite modularity for either the first or second axis.

   =#

   n_rows, n_cols = size(A)
   R = S[[1:n_cols],:]
   T = S[[(n_cols+1):end],:]
   m = sum(int(A))
   P = kron(sum(A, 1), sum(A, 2)) ./ m
   B = A - P
   if axis == 1
      inner_sum = sum((B'*T) .* R)
   else
      inner_sum = sum((B*R) .* T)
   end
   return (1/m)*inner_sum
end
