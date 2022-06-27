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

return getters
