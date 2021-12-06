using DelimitedFiles: readdlm

fish = readdlm(ARGS[1], ',', Int32, '\t')
rot = [[0 1 0 0 0 0 0 0 0]; [0 0 1 0 0 0 0 0 0]; [0 0 0 1 0 0 0 0 0]; [0 0 0 0 1 0 0 0 0]; [0 0 0 0 0 1 0 0 0]; [0 0 0 0 0 0 1 0 0]; [1 0 0 0 0 0 0 1 0]; [0 0 0 0 0 0 0 0 1]; [1 0 0 0 0 0 0 0 0]]
counts = [count(==(i), fish) for i in [0, 1, 2, 3, 4, 5, 6, 7, 8]]
println(sum(rot^80*counts))