function recursive_brim(A::Array{Int64, 2})
   #=
   Recursive BRIM as in Barber
   =#

   # -1- Partitions at random
   min_part = minimum(size(A))
   S = zeros(Int64, sum(size(A)), min_part)
   init_part = rand(1:1:min_part,sum(size(A)))
   for i = 1:length(init_part)
      S[i,init_part[i]] = 1
   end

   # -2- R and T sub-matrices
   n_rows, n_cols = size(A)
   m = sum(A)
   R = S[[1:n_cols],:]
   T = S[[(n_cols+1):end],:]
   B = A - kron(sum(A, 1), sum(A, 2)) ./ m

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
   return {"Q"=>new_Q}
end

function bestPart!(Target::Array, Scores::Array)
   best_scores = maximum(Scores, 2)
   @inbounds for i = 1:size(Target)[1]
      for c = 1:size(Scores)[2]
         if Scores[i,c] == best_scores[i]
            Target[i,c] = 1
         else
            Target[i,c] = 0
         end
      end
   end
end
