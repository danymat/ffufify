if #arg == 0 then
    print("No arg specified")
    os.exit()
end

local function read_file_to_table(filename)
    local file = io.open(filename, "r") or os.exit()

    local content = {}

    for line in file:lines() do
        table.insert(content, line)
    end

    file:close()

    return content
end

local getters = {}

getters.get_method = function(content)
    local line = content[1]
    return string.match(line, "[^%s]+")
end

getters.get_url = function(content)
    local host
    local subdir

    for _, line in ipairs(content) do
        host = string.match(line, "^Host: (.*)")
        if host then
            break
        end
    end

    if not host then
        print("No host found")
        os.exit()
    end

    local count = 0
    for i in string.gmatch(content[1], "[^%s]+") do
        if count == 1 then
            subdir = i
            break
        end
        count = count + 1
    end

    if not subdir then
        print("No subdir found")
        os.exit()
    end

    return host .. subdir
end

getters.get_headers = function(content)
    -- TODO: un header comence par XXX: (filtrer de cette manière)
    local headers = {}
    for _, line in ipairs(content) do
        for header_name, header_value in string.gmatch(line, "([%w-_]*): (.*)") do
            if header_name ~= "Host" then
                table.insert(headers, { header_name, header_value })
            end
        end
    end

    return headers
end

local content = read_file_to_table(arg[1])

local method = getters.get_method(content)
local url = getters.get_url(content)
local headers = getters.get_headers(content)

print("FFUFIFIED:\n")
print("ffuf -u " .. url .. ' -X "' .. method .. (#headers ~= 0 and '" \\' or ""))
for i, header in pairs(headers) do
    print("-H '" .. header[1] .. ":" .. header[2] .. "'" .. (i ~= #headers and " \\" or ""))
end
