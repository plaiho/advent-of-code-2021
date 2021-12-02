using DelimitedFiles: readdlm

function parse_command(x)
    dirs = split(x, " ")
    command = dirs[1] == "forward" ? [parse(Int64,dirs[2]), 0] :
              dirs[1] == "down" ? [0, parse(Int64,dirs[2])] :
              dirs[1] == "up" ? [0, -1*parse(Int64,dirs[2])] :
              [0, 0]
    return command
    end

println(string("Reading data from file ", ARGS[1]))
readings = readdlm(ARGS[1], '\t')

commands = transpose(reduce(hcat, [parse_command(reading) for reading in readings]))
position = sum(commands[:,1])
depth = sum(commands[:,1] .* cumsum(commands[:,2]))

println(string(position))
println(string(depth))

println(string(position*depth))