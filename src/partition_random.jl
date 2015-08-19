function partition_random(A::Array{Int64, 2})
  Logging.info("starting random partition")
  # Smaller margin of A determines the number of modules
  min_part = minimum(size(A))
  # Generates a matrix with int(0) for the module partition
  S = zeros(Int64, sum(size(A)), min_part)
  # Pick modules at random and put them in the partition
  init_part = rand(1:1:min_part,sum(size(A)))
  for i = 1:length(init_part)
    S[i,init_part[i]] = 1
  end
  # Only non-empty modules are allowed
  # And it returns a Modular object
  Logging.info("created random partition")
  return no_empty_modules!(Modular(A, S))
end
