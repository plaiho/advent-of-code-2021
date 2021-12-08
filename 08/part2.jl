using DelimitedFiles: readdlm

function infer_segment_codes_and_return_output(a, i)

    function get_length_l_bitarray(arr, l)
        return BitArray([length(el) == l for el in arr])
    end

    set_1 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],2)][1]))
    set_7 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],3)][1]))
    set_4 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],4)][1]))
    set_8 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],7)][1]))

    d = Dict([(set_1, 1),
              (set_7, 7),
              (set_4, 4),
              (set_8, 8)])

    set_9 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],6)][BitArray([issubset(set_4, set) for set in a[i,1:10][get_length_l_bitarray(a[i,1:10],6)]])][1]))
    set_0 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],6)][BitArray([(!issubset(set_4, set) && issubset(set_1, set)) for set in a[i,1:10][get_length_l_bitarray(a[i,1:10],6)]])][1]))
    set_6 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],6)][BitArray([(!issubset(set_4, set) && !issubset(set_1, set)) for set in a[i,1:10][get_length_l_bitarray(a[i,1:10],6)]])][1]))
    set_3 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],5)][BitArray([issubset(set_1, set) for set in a[i,1:10][get_length_l_bitarray(a[i,1:10],5)]])][1]))
    set_5 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],5)][BitArray([(issubset(setdiff(set_4, set_1), set) && !issubset(set_1, set)) for set in a[i,1:10][get_length_l_bitarray(a[i,1:10],5)]])][1]))
    set_2 = Set(collect(a[i,1:10][get_length_l_bitarray(a[i,1:10],5)][BitArray([(!issubset(setdiff(set_4, set_1), set) && !issubset(set_1, set)) for set in a[i,1:10][get_length_l_bitarray(a[i,1:10],5)]])][1]))

    merge!(d,Dict([(set_9, 9),
                   (set_0, 0),
                   (set_6, 6),
                   (set_3, 3),
                   (set_5, 5),
                   (set_2, 2)]))
    output = [d[Set(collect(el))] for el in a[i,end-3:end]]
    return 1000*output[1]+100*output[2]+10*output[3]+output[4]
end

a = readdlm(ARGS[1],' ',String)
counter = 0

for i in 1:size(a,1) 
    global counter += infer_segment_codes_and_return_output(a,i)
end

println(counter)