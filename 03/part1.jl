using DelimitedFiles: readdlm

readings = readdlm(ARGS[1], String)

m = map(row -> collect(row), readings)
m = transpose(UInt32.(reduce(hcat, m)).-48)

occs = sum(m, dims=1) .> size(m)[1]/2
γ = parse(Int, filter(x -> !isspace(x), bitstring(occs)), base=2)
ε = parse(Int, filter(x -> !isspace(x), bitstring(.!occs)), base=2)

println(γ*ε)
