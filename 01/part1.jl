using DelimitedFiles

println(string("Reading data from file ", ARGS[1]))
readings = readdlm(ARGS[1], '\t', Int, '\n')
println(sum(diff(readings, dims=1) .> 0))
