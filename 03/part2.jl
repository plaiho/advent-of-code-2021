using DelimitedFiles: readdlm

function get_rating(m, majority_criterion)
    
    function discard_row_by_bit_criterion(m, bit, n)
        return view(m, vec(mapslices(row -> row[n] != bit, m, dims = 2)), :)
    end

    for i in 1:size(m,2)
        majority_criterion ? criteria = sum(m, dims=1) .>= size(m)[1]/2 : criteria = sum(m, dims=1) .< size(m)[1]/2
        (size(m)[1] > 1) ? m = discard_row_by_bit_criterion(m, criteria[i], i) : m
    end

    return parse(Int, filter(x -> !isspace(x), bitstring(m.== 1)), base=2)
end

readings = readdlm(ARGS[1], String)

m = map(row -> collect(row), readings)
m = transpose(UInt32.(reduce(hcat, m)).-48)

O2rating = get_rating(m, true)
CO2rating = get_rating(m, false)
 
println(O2rating*CO2rating)
