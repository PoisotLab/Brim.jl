module Brim

# Dependencies
using Cairo

# Exports
export Modular,
       Q,
       recursive_brim!, 
       partition_lp,
       partition_random,
       partition_single

# Includes
# include(joinpath(...))
include(joinpath(".", "Modular.jl"))
include(joinpath(".", "Q.jl"))
include(joinpath(".", "recursive_brim.jl"))
include(joinpath(".", "partition_lp.jl"))
include(joinpath(".", "partition_random.jl"))
include(joinpath(".", "partition_single.jl"))

end
