using DelimitedFiles: readdlm

a = readdlm(ARGS[1],' ',String)
println(sum([length(el) in [2,3,4,7] for el in a[:,end-3:end]]))
