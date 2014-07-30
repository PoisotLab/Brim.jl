module Brim

# Dependencies
using Cairo

# Exports
export Qr, recursive_brim

# Includes
# include(joinpath(...))
include(joinpath(".", "Q.jl"))
include(joinpath(".", "recursive_brim.jl"))

end
