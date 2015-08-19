using Base.Test
using Brim

anyerrors = false

my_tests = ["recursive_brim.jl",
  "no_empty_modules.jl",
  "reorder_by_module.jl",
  "network_roles.jl",
  "partition_single.jl",
  "partition_lp.jl",
  "permutations.jl",
  "Qr.jl"]

for my_test in my_tests
  try
    include(my_test)
    println("\033[1m\033[32mPASSED\033[0m\t$(my_test)")
  catch e
    anyerrors = true
    println("\033[1m\033[31mFAILED\033[0m\t$(my_test)")
    showerror(STDOUT, e, backtrace())
    println()
  end
end

if anyerrors
  throw("Tests failed")
end
