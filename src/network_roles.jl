function network_roles(M::Modular)
   roles = zeros(Float64, (sum(size(M.A)), 2))
   ## Step 1 -- measure of z
   for m in 1:size(M.S)[2]
      blues = M.S[[1:size(M.A)[2]],m]
      reds = M.S[[size(M.A)[2]+[1:size(M.A)[1]]],m]
      mod_only = M.A[vec(reds.==1),vec(blues.==1)]
      degree_seq = append!(vec(sum(mod_only, 1)), vec(sum(mod_only, 2)))
      if std(degree_seq) == 0
         # If all species have equal degree within a module
         # the z-score is 0
         z = (degree_seq .- mean(degree_seq))
      else
         z = (degree_seq .- mean(degree_seq))./std(degree_seq)
      end
      idx = [1:size(M.S)[1]][append!(vec(blues.==1),vec(reds.==1))]
      roles[idx,1] = z
   end
   ## Step 2 -- measure of c
   nr, nc = size(M.A)
   for col = 1:nc
      k = sum(M.A, 1)[col]
      km = zeros(Int64, size(M.S)[2])
      for row = 1:nr
         if M.A[row,col] == 1
            km[[1:(size(M.S)[2])][vec(M.S[(nc+row),:] .== 1)]] += 1
         end
      end
      c = 1-sum((km./k).^2)
      roles[col,2] = c
   end
   for row = 1:nr
      k = sum(M.A, 2)[row]
      km = zeros(Int64, size(M.S)[2])
      for col = 1:nc
         if M.A[row,col] == 1
            km[[1:(size(M.S)[2])][vec(M.S[col,:] .== 1)]] += 1
         end
      end
      c = 1-sum((km./k).^2)
      roles[(nc+row),2] = c
   end
   return roles
end
