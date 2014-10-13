JEXEC=julia

.PHONY: clean

test: src/*jl tests/*jl
	$(JEXEC) -e 'Pkg.rm("Brim")'
	$(JEXEC) -e 'Pkg.clone(pwd())'
	$(JEXEC) --code-coverage ./tests/runtests.jl

clean:
	- rm src/*.cov
