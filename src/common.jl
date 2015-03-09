function no_empty_modules!(M::Modular)
  S = M.S
  S = S[:,[1:size(S)[2]]'[sum(S,1).>0]]
  M.S = S
  return M
end
