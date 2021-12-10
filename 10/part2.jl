using DelimitedFiles, Statistics

function return_stack(a)
    m = Char[]
    d = Dict([(')', '('), (']', '['), ('}', '{'), ('>', '<')])
    for c in collect(a)
           if c in Set(['(', '[', '{', '<'])
               push!(m,c)
           elseif !isempty(m)
               if m[end] != d[c]
                   return Any[]
               elseif m[end] == d[c] 
                   pop!(m)
               end
           end
    end
    return m
end

function score_stack(s)
    score_rule = Dict([('(', 1), ('[', 2), ('{', 3), ('<', 4)])
    score = 0
    for c in reverse(s)
        score *= 5
        score += score_rule[c]
    end
    if score == 0
        score = NaN
    end
    return score
end

as = readdlm(ARGS[1],String)

scores = [score_stack(return_stack(a)) for a in as]
println(Int(median(scores[[!isnan(score) for score in scores]])))