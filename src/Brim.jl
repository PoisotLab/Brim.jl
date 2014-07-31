module Brim

# Dependencies
using Cairo

# Exports
export Modular,
       recursive_brim, 
       random_partition

# Includes
# include(joinpath(...))
include(joinpath(".", "Modular.jl"))
include(joinpath(".", "recursive_brim.jl"))
include(joinpath(".", "random_partition.jl"))

end
