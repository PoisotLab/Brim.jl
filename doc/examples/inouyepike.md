In this example, we will work on another plant and pollination network. As in
the previous example, we will download it and turn it into an adjacency matrix.

Because there will be some randomizations involved, we will start Julia with
`julia -p n`, where `n` is the number of CPUs to run on. If you have a 4-core
machine, then `julia -p 3` is fine. This will not give excellent scaling because
there is some overhead when using a small number of cores, but it will still cut
the computing time.

Brim has to be loaded on all workers, so it should be imported with

```julia
@everywhere using Brim
```

Have a look at the [Parallel Computing][pc] page of Julia's documentation if you
need more information.

[pc]: http://julia.readthedocs.org/en/latest/manual/parallel-computing/

```julia
download(
  "https://www.nceas.ucsb.edu/interactionweb/data/plant_pollinator/text/ino_matr_f.txt",
  "ino.txt"
)
@everywhere A = map((x) -> x>0?1:0, int(readdlm("ino.txt")))
```

The first step is to optimize its modularity. Since this is a small network, we
will use a random starting partition:

```julia
@everywhere rndbrim = (A) -> A |> partition_random |> recursive_brim!
ino_partitions = pmap(rndbrim, [A for i in 1:1000])
```

For reference, on my machine (runing three workers), the `pmap` (parallel)
version runs 1000 replicates within 2 seconds, and the `map` (serial) does the
same thing in 4 seconds. The gain in time becomes greater when using more
replicates (or more cores...).

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

This can take a few seconds to run (around 8 sec. on my machine). We will need
to do this in parallel, which is not difficult:

```julia
random_matrices = pmap(null_preserve_marginals, [A for i in 1:50])
```

Note that I used 50 replicates for the sake of not spending minutes waiting for
the permutations to finish. It is of course unreasonably low.

Now, we can apply the same steps as above, to measure the distribution of
modularities in the shuffled matrices. Because we have not assigned
`random_matrices` everywhere, we will not use `pmap`:

```julia
expected_q = map(Q, map(rndbrim, random_matrices))
```

This array will have the expected distribution of Q, for this network, under the
null hypothesis that interactions are randomly distributed (this is a way to
test the impact of the degree distribution on the modularity). There are
different ways to get estimates of the *p-value*, but an easy one is to measure
the proportion of randomized matrices that are *less* modular than the original
one:

```julia
approx_pval = maximum([sum(expected_q .>= Q(ino_mod))/length(expected_q) 1/length(expected_q)])
```

Note that the p-value cannot be lower than *1/m*, where *m* is the number of
shuffled matrices tested. In this example, this should return a value *around*
0.02. This indicates that the modular structure of this network, although not
strong, is a significant deviation from the random expectation.
