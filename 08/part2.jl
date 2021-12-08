using DelimitedFiles: readdlm

function infer_segment_codes_and_return_output(a, i)

    set_1 = Set(collect(a[i,1:10][BitArray([length(el) == 2 for el in a[i,1:10]])][1]))
    set_7 = Set(collect(a[i,1:10][BitArray([length(el) == 3 for el in a[i,1:10]])][1]))
    set_4 = Set(collect(a[i,1:10][BitArray([length(el) == 4 for el in a[i,1:10]])][1]))
    set_8 = Set(collect(a[i,1:10][BitArray([length(el) == 7 for el in a[i,1:10]])][1]))

    d = Dict([(set_1, 1),
              (set_7, 7),
              (set_4, 4),
              (set_8, 8)])

    set_9 = Set(collect(a[i,1:10][BitArray([length(el) == 6 for el in a[i,1:10]])][BitArray([issubset(set_4, set) for set in a[i,1:10][BitArray([length(el) == 6 for el in a[i,1:10]])]])][1]))
    merge!(d,Dict([(set_9, 9)]))

    set_0 = Set(collect(a[i,1:10][BitArray([length(el) == 6 for el in a[i,1:10]])][BitArray([(!issubset(set_4, set) && issubset(set_1, set)) for set in a[i,1:10][BitArray([length(el) == 6 for el in a[i,1:10]])]])][1]))
    merge!(d,Dict([(set_0, 0)]))

    set_6 = Set(collect(a[i,1:10][BitArray([length(el) == 6 for el in a[i,1:10]])][BitArray([(!issubset(set_4, set) && !issubset(set_1, set)) for set in a[i,1:10][BitArray([length(el) == 6 for el in a[i,1:10]])]])][1]))
    merge!(d,Dict([(set_6, 6)]))

    set_3 = Set(collect(a[i,1:10][BitArray([length(el) == 5 for el in a[i,1:10]])][BitArray([issubset(set_1, set) for set in a[i,1:10][BitArray([length(el) == 5 for el in a[i,1:10]])]])][1]))
    merge!(d,Dict([(set_3, 3)]))

    set_5 = Set(collect(a[i,1:10][BitArray([length(el) == 5 for el in a[i,1:10]])][BitArray([(issubset(setdiff(set_4, set_1), set) && !issubset(set_1, set)) for set in a[i,1:10][BitArray([length(el) == 5 for el in a[i,1:10]])]])][1]))
    merge!(d,Dict([(set_5, 5)]))

    set_2 = Set(collect(a[i,1:10][BitArray([length(el) == 5 for el in a[i,1:10]])][BitArray([(!issubset(setdiff(set_4, set_1), set) && !issubset(set_1, set)) for set in a[i,1:10][BitArray([length(el) == 5 for el in a[i,1:10]])]])][1]))
    merge!(d,Dict([(set_2, 2)]))

    output = [d[Set(collect(el))] for el in a[i,end-3:end]]
    return 1000*output[1]+100*output[2]+10*output[3]+output[4]
end

a = readdlm(ARGS[1],' ',String)
counter = 0

for i in 1:200 
    global counter += infer_segment_codes_and_return_output(a,i)
end

println(counter)