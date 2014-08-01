function Q(M::Modular)
   m = sum(M.A)
   B = M.A - kron(sum(M.A, 1), sum(M.A, 2)) ./ m
   println(B)
   inner_sum = 0.0
   nr, nc = size(M.A)
   for col = 1:nc
      for row = 1:nr
         if M.S[col,:] == M.S[nc+row,:]
            inner_sum += B[row,col]
         end
      end
   end
   return inner_sum / m
end
