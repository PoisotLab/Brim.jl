JEXEC=julia

test: src/*jl tests/*jl
	$(JEXEC) -e 'Pkg.clone(pwd(), "src")'
	$(JEXEC) --code-coverage ./tests/runtests.jl
