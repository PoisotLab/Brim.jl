"""
The `Modular` type is used by a lot of functions internally.

It has two fields:
- `A` is the adjacency matrix, of size *R* x *C*
- `S` is the community partition, of size (*R+C*) x *c*, where *c* is the number of modules
"""
type Modular
   A::Array{Int64, 2}
   S::Array{Int64, 2}
end
