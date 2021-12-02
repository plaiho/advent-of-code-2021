using DelimitedFiles: readdlm

function parse_command(x)
    dirs = split(x, " ")
    command = dirs[1] == "forward" ? [parse(Int64,dirs[2]), 0] :
              dirs[1] == "down" ? [0, parse(Int64,dirs[2])] :
              dirs[1] == "up" ? [0, -1*parse(Int64,dirs[2])] :
              [0, 0, 0]
    return command
    end

function calculate_depth(m)
    (depth, aim) = (0, 0)
    for i in zip(m[:,1], m[:,2])
        i[1] == 0 ? (depth, aim) = (depth, aim+i[2]) :
        i[1] != 0 ? (depth, aim) = (depth+i[1]*aim, aim) :
        (depth, aim) = (depth, aim)
    end
    return depth
    end

println(string("Reading data from file ", ARGS[1]))
readings = readdlm(ARGS[1], '\t')
commands = [parse_command(reading) for reading in readings]
m = transpose(reduce(hcat, commands))

position = sum(m[:,1])
depth = calculate_depth(m)

println(string(position))
println(string(depth))

println(string(position*depth))