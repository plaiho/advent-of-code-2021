using DelimitedFiles, Images

function collect_groups(labels)
    groups = [Int[] for i = 1:maximum(labels)]
    for (i,l) in enumerate(labels)
        if l != 0
            push!(groups[l], i)
        end
    end
    groups
end

a = readdlm(ARGS[1],String)
am = convert(Matrix{Float32},reduce(hcat,[collect(row) for row in a])).-48
mat = .! (am .== 9.0)
labels = label_components(mat)
groups = collect_groups(labels)
println(prod(sort([length(group) for group in groups])[end-2:end]))