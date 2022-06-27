local getters = require("getters")
local utils = require("utils")

if #arg == 0 then
    utils.missing_parameters()
end

if arg[1] == "-h" or arg[1] == "--help" then
    print([[
Usage:
  lua ffufify.lua [OPTIONS] [FILE WORDLIST]

ARGUMENTS:
  FILE              path to burp file request
  WORDLIST          path to wordlist

OPTIONS:
  -h, --help         show list of command-line options
    ]])
    os.exit()
end

local function read_file_to_table(filename)
    local file = io.open(filename, "r")
        or (function()
            print("File " .. filename .. " not found, exiting")
            os.exit()
        end)()

    local content = {}

    for line in file:lines() do
        table.insert(content, line)
    end

    file:close()

    return content
end

if #arg ~= 2 then
    utils.missing_parameters()
end

local filename = arg[1]
local wordlist = arg[2]

-- Read file content and store into a table
local content = read_file_to_table(filename)

-- Getters
local method = getters.get_method(content)
local url = getters.get_url(content)
local headers = getters.get_headers(content)

print("FFUFIFIED:\n")
print("ffuf -u " .. url .. ' -X "' .. method .. '" -w ' .. wordlist .. (#headers ~= 0 and ' \\' or ""))
for i, header in pairs(headers) do
    print("-H '" .. header[1] .. ":" .. header[2] .. "'" .. (i ~= #headers and " \\" or ""))
end
