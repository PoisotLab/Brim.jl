function is_filled(X::Array{Int64, 2})
  return prod(sum(X, 1)) * prod(sum(X, 2)) > 0
end

function have_same(X::Array{Int64, 2}, Y::Array{Int64, 2}, what::ASCIIString)
  same = false
  if what == "fill"
    same = sum(X) == sum(Y)
  end
  if what == "rowdegree"
    same = sum(X, 2) == sum(Y, 2)
  end
  if what == "coldegree"
    same = sum(X, 1) == sum(Y, 1)
  end
  if what == "degree"
    same = (sum(X, 1) == sum(Y, 1)) & (sum(X, 2) == sum(Y, 2))
  end
  return same
end

function null_common_interface(A::Array{Int64, 2}, what::ASCIIString)
  n_ones = sum(A)
  n_zeroes = prod(size(A)) - n_ones
  keep_on = true
  candidate = zeros(A)
  while keep_on
    flat = shuffle([zeros(Int64, n_zeroes), ones(Int64, n_ones)])
    candidate = reshape(flat, size(A))
    if is_filled(candidate) & have_same(A, candidate, what)
      keep_on = false
    end
  end
  return candidate
end

function null_preserve_fill(A::Array{Int64, 2})
  return null_common_interface(A, "fill")
end

function null_preserve_rowdegree(A::Array{Int64, 2})
  return null_common_interface(A, "rowdegree")
end

function null_preserve_coldegree(A::Array{Int64, 2})
  return null_common_interface(A, "coldegree")
end

function null_preserve_degree(A::Array{Int64, 2})
  return null_common_interface(A, "degree")
end
