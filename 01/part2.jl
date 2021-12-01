using DelimitedFiles, RollingFunctions

println(string("Reading data from file ", ARGS[1]))
readings = readdlm(ARGS[1], '\t', Int, '\n')
println(sum(diff(rolling(sum,vec(readings),3), dims=1) .> 0))
