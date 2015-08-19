In this example, we will work on the modularity of the Kato et al. (1990)
dataset of plant and pollinator interactions, available from [IWDB][IWDB].

[IWDB]: https://www.nceas.ucsb.edu/interactionweb/html/kato_1990.html

We first save the raw text matrix locally:

```julia
download(
  "https://www.nceas.ucsb.edu/interactionweb/data/plant_pollinator/text/kato_matr_f.txt",
  "kato.txt"
)
```

If this fails, just download the file manually and save it as `kato.txt`.

This dataset has 91 plants and about 600 pollinators, and is therefore part of
the "big" ecological networks. It is additionally sparse, with about 1200
interactions (for a density of 0.019).

We can read it into a binary adjacency matrix with:

```julia
A = map((x) -> x>0?1:0, int(readdlm("kato.txt")))
```

Once this is done, we will apply the `partition_lp` to this matrix:

```julia
kato_lp = partition_lp(A)
```

We can measure the modularity of this initial partition using `Q`:

```julia
Q(kato_lp)
```

This should give a value *close to* 0.54 (keep in mind that this is a stochastic
process).

The next step is to optimize the modularity further, using Brim:

```julia
kato_lp |> recursive_brim! |> Q
```

This should give a value around 0.57.

Usually, the LP step is repeated several times, to make sure that a suitably
(yet arbitrarily...) large part of the parameter space has been explored. We can
do so using a simple wrapper function:

```julia
lpbrim = (A) -> A |> partition_lp |> recursive_brim!
```

Note that this function does not measure modularity. We will first apply it 50
times (on my machine, each run takes on average 3 seconds); of course, for real
applications, it would be better to repeat this step 1000 times or more (and to
do so in a parallel way).

```julia
kato_partitions = map(lpbrim, [A for i in 1:50])
```

We can now get the modularity values:

```julia
kato_partitions_Q = map(Q, kato_partitions)
```

Most of the times, this will give an array of 50 identical (or very close)
values. This is because the modular structure of this network is rather easy to
optimize.
