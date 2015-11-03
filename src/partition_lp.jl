"""
Propagate labels to reach the starting partition. Takes an adjacency matrix
as input and returns a `Modular` object as output.

This approach works better for large graphs (it tends to underperform both the
"random" and "single" approaches for small graphs).

The optimization stops when any label propagation fails to increase the
modularity, measured with `Q`.
"""
function partition_lp(A::Array{Int64, 2})
  nr, nc = size(A)
  min_part = minimum(size(A))
  S = eye(Int64, sum(size(A)))
  M = Modular(A, S)
  old_Q = 0.0
  new_Q = 0.000001
  while new_Q > old_Q
    update_order_top = shuffle([1:nc;])
    update_order_bot = shuffle([1:nr;])
    # Top level
    @inbounds for node_top in update_order_top
       neighbors = [1:nr;][M.A[:,node_top] .> 0] .+ nc
       lab_count = sum(M.S[neighbors,:],1)
       for i = 1:length(lab_count)
          if lab_count[i] == maximum(lab_count)
             M.S[node_top,:] = zeros(Int64, size(M.S)[2])
             M.S[node_top,i] = 1
             break
          end
       end
    end
    # Bottom level
    @inbounds for node_bot in update_order_bot
       neighbors = [1:nc;]'[M.A[node_bot,:] .> 0]
       lab_count = sum(M.S[neighbors,:],1)
       for i = 1:length(lab_count)
          if lab_count[i] == maximum(lab_count)
             M.S[node_bot+nc,:] = zeros(Int64, size(M.S)[2])
             M.S[node_bot+nc,i] = 1
             break
          end
       end
    end
    old_Q = new_Q
    new_Q = Q(M)
  end
  no_empty_modules!(M)
  return M
end
