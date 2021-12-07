using DelimitedFiles, Statistics

pos = readdlm(ARGS[1], ',', Int64)
println(Int(sum(abs.(pos.-median(pos)))))