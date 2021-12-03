using DelimitedFiles: readdlm

function discard_row_by_bit_criterion(m, bit, n)
    return view(m, vec(mapslices(row -> row[n] != bit, m, dims = 2)), :)
end

readings = readdlm(ARGS[1], String)

m = map(row -> collect(row), readings)
m = transpose(UInt32.(reduce(hcat, m)).-48)

mO2 = m
mCO2 = m

for i in 1:size(m,2)
    majoritiesO2 = sum(mO2, dims=1) .>= size(mO2)[1]/2
    majoritiesCO2 = sum(mCO2, dims=1) .>= size(mCO2)[1]/2
    if (size(mO2)[1] > 1) global mO2 = view(mO2, vec(mapslices(row -> row[i] == majoritiesO2[i], mO2, dims = 2)), :) end
    if (size(mCO2)[1] > 1) global mCO2 = view(mCO2, vec(mapslices(row -> row[i] != majoritiesCO2[i], mCO2, dims = 2)), :) end
end

O2rating = parse(Int, filter(x -> !isspace(x), bitstring(mO2.== 1)), base=2)
CO2rating = parse(Int, filter(x -> !isspace(x), bitstring(mCO2.== 1)), base=2)

println(O2rating*CO2rating)