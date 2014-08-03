function recursive_brim!(M::Modular)
   #=
   Recursive BRIM as in Barber
   =#

   # -2- R and T sub-matrices
   n_rows, n_cols = size(M.A)
   m = sum(M.A)
   R = M.S[[1:n_cols],:]
   T = M.S[[(n_cols+1):end],:]
   B = M.A - kron(sum(M.A, 1), sum(M.A, 2)) ./ m

   # -3- Recursive BRIM
   old_Q = 0.0
   new_Q = 0.000001
   while new_Q > old_Q
      t_tilde = B'*T
      bestPart!(R, t_tilde)
      r_tilde = B*R
      bestPart!(T, r_tilde)
      old_Q = new_Q
      new_Q = maximum(map((x) -> x/m, [sum((B'*T) .* R), sum((B*R) .* T)]))
   end
   M.S[[1:n_cols],:] = R
   M.S[[(n_cols+1):end],:] = T
   no_empty_modules!(M)
   return M
end

function bestPart!(Target::Array{Int64, 2}, Scores::Array{Float64, 2})
   best_scores = maximum(Scores, 2)
   @inbounds for i = 1:size(Target)[1]
      for c = 1:size(Scores)[2]
         if Scores[i,c] == best_scores[i]
            Target[i,:] = zeros([1:size(Target)[2]])
            Target[i,c] = 1
            break
         else
            Target[i,c] = 0
         end
      end
   end
end
