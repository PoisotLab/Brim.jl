function null_preserve_fill(A::Array{Int64, 2})
  n_ones = sum(A)
  n_zeroes = prod(size(A)) - n_ones
  keep_on = true
  candidate = zeros(A)
  while keep_on
    flat = shuffle([zeros(Int64, n_zeroes), ones(Int64, n_ones)])
    candidate = reshape(flat, size(A))
    if prod(sum(candidate, 1)) * prod(sum(candidate, 2)) > 0
      keep_on = false
    end
  end
  return candidate
end

function null_preserve_fill(M::Modular)
  return Modular(null_preserve_fill(M.A), M.S)
end
