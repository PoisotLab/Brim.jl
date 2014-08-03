function draw_matrix(M::Modular)
   number_modules = sum(sum(M.S, 1) .> 0)

end
