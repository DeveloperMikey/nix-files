function(buf)
    if buf.name == "default.nix" then
        local function split(str, sep)
            local result = {}
            for part in string.gmatch(str, "([^" .. sep .. "]+)") do
                table.insert(result, part)
            end
            return result
        end

        local paths = split(buf.path, "/")
        if #paths > 1 then
            local parent_dir = paths[#paths - 1]
            return parent_dir .. "(d)"
        end
    end
end
