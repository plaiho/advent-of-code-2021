using DelimitedFiles

function find_bad_char(a)
    m = Char[]
    d = Dict([(')', '('), (']', '['), ('}', '{'), ('>', '<')])
    for c in collect(a)
           if c in Set(['(', '[', '{', '<'])
               push!(m,c)
           elseif !isempty(m)
               if m[end] != d[c]
                   return c
               elseif m[end] == d[c] 
                   pop!(m)
               end
           end
    end
    return 'a'
end

as = readdlm(ARGS[1],String)
score_rule = Dict([(')', 3), (']', 57), ('}', 1197), ('>', 25137), ('a', 0)])
println(sum([score_rule[c] for c in [find_bad_char(a) for a in as]]))