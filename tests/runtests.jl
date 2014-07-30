using Base.Test
using Brim

anyerrors = false

my_tests = ["recursive_brim.jl"]

for my_test in my_tests
   try
      include(my_test)
      println("\t\033[1m\033[32mPASSED\033[0m: $(my_test)")
   catch e
      anyerrors = true
      println("\t\033[1m\033[31mFAILED\033[0m: $(my_test)")
   end
end

if anyerrors
   throw("Tests failed")
end
