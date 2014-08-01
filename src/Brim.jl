module Brim

# Dependencies
using Cairo

# Exports
export Modular,
       Q,
       recursive_brim, 
       random_partition,
       label_propagation

# Includes
# include(joinpath(...))
include(joinpath(".", "Modular.jl"))
include(joinpath(".", "Q.jl"))
include(joinpath(".", "recursive_brim.jl"))
include(joinpath(".", "random_partition.jl"))
include(joinpath(".", "label_propagation.jl"))

end
