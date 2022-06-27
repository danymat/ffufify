local utils = {}

utils.err = function (err_msg)
    print(err_msg)
    os.exit()
end

utils.missing_parameters = function ()
    utils.err("Missing parameters: type --help for more details")
end

return utils
