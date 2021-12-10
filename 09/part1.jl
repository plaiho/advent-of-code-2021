using DelimitedFiles, ShiftedArrays

a = readdlm(ARGS[1],String)
am = convert(Matrix{Float32},reduce(hcat,[collect(row) for row in a])).-48
c = zeros(size(am,1),size(am,2))

for i in 1:size(am,1)
    for j in 1:size(am,2)
        c[i,j] = (all(skipmissing(am[i,j] .< [ShiftedArray(am,(1,0))[i,j], ShiftedArray(am,(-1,0))[i,j], ShiftedArray(am,(0,1))[i,j], ShiftedArray(am,(0,-1))[i,j]])))
    end
end

c = BitArray(c)
println(Int(sum(c .* (am.+1))))