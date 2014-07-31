function random_partition(A::Array{Int64, 2})
   min_part = minimum(size(A))
   S = zeros(Int64, sum(size(A)), min_part)
   init_part = rand(1:1:min_part,sum(size(A)))
   for i = 1:length(init_part)
      S[i,init_part[i]] = 1
   end
   return Modular(A, S)
end
