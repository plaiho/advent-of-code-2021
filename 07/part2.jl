using DelimitedFiles, Optim

pos = readdlm(ARGS[1], ',', Int64)

f(x) = (x^2 + abs(x))/2
g(x) = sum(f.(abs.(pos.-x[1])))

res = optimize(g, [0.0], BFGS())
println(Int(sum(f.(pos.-round.(Optim.minimizer(res))))))