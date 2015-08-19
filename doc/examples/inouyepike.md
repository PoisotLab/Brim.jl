In this example, we will work on another plant and pollination network. As in
the previous example, we will download it and turn it into an adjacency matrix.

Because there will be some randomizations involved, we will start Julia with
`julia -p n`, where `n` is the number of CPUs to run on. If you have a 4-core
machine, then `julia -p 3` is fine. This will not give excellent scaling because
there is some overhead when using a small number of cores, but it will still cut
the computing time.

Have a look at the [Parallel Computing][pc] page of Julia's documentation if you
need more information.

[pc]: http://julia.readthedocs.org/en/latest/manual/parallel-computing/

```julia
download(
  "https://www.nceas.ucsb.edu/interactionweb/data/plant_pollinator/text/ino_matr_f.txt",
  "ino.txt"
)
A = map((x) -> x>0?1:0, int(readdlm("ino.txt")))
```

The first step is to optimize its modularity. Since this is a small network, we
will use a random starting partition:

```julia
rndbrim = (A) -> A |> partition_random |> recursive_brim!
ino_partitions = map(rndbrim, [A for i in 1:100])
```

We can then filter only the partitions giving the best modularity:

```julia
ino_q = map(Q, ino_partitions)
best_partition_id = filter((x) -> ino_q[x] == maximum(ino_q), 1:length(ino_q))[1]
ino_mod = ino_partitions[best_partition_id]
```

The modularity of this partition (`Q(ino_mod)`) should be around 0.39 -- which
is low, and may not be significant.

We will test this using permutations of the original matrix.

To generate a single randomization keeping the rows and columns marginals, we
can use:

```julia
A_rnd = null_preserve_marginals(A)
```

This can take a few seconds to run (around 8 sec. on my machine). This is going to be long.
