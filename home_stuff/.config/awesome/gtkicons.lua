--[[
GTK theme coding thoughts...
By reading the index.theme file of a few themes I realized that
it defines context for each type/size of icons...
for example it specifies from which folder to pick an icon for applications,
panel, folder, e.t.c So that's one thing to keep in mind.
--]]
require("dumper")

local THEME_TAG_REGEXP = "gtk%-icon%-theme%-name *=(.-)\n"

function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'" 2>/dev/null')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

function string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end


function open_file(file, mode)
    local f = io.open(file, mode)
    if f then return f end

    --print ("open_file function: " .. file .. " - failed.")
    return nil
end


function read_file(file, mode)
    f = open_file(file, mode)

    if f  == nil then
        return nil
    end

    local content = f:read("*all")

    f:close()

    return content
end


function get_theme_sections()
    local sections = nil
    local theme_name = nil

    local settings = read_file(os.getenv("HOME") .. "/.config/gtk-3.0/settings.ini", "r")
                     or
                     read_file("/usr/share/gtk-3.0/settings.ini")


    if settings ~= nil then
        theme_name = string.match(settings, THEME_TAG_REGEXP)
    else
        --print ("get_gtk_theme_name: couldn't parse the name.")
        return nil
    end

    local theme_location = os.getenv("HOME") .. "/.icons/" .. theme_name
    local index_file = read_file(theme_location .. "/index.theme", "r")

    if index_file == nil then
        theme_location = "/usr/share/icons/" .. theme_name
        index_file = read_file(theme_location .. "/index.theme", "r")

        if index_file == nil then
            --print("Couldn't locate the theme's index file. Theme Name: " .. theme_name)
            return nil
        end
    end

    local sections = {}
    sections["theme_location"] = theme_location

    local section = nil

    for line in index_file:gmatch("([^\n]*)\n?") do

        if string.find(line, '#') ~= 0 then

            section = string.match(line, "^%[(.-)%]$") or section

            if section ~= nil then
                if sections[section] == nil then
                    sections[section] = {}
                end
            end

            local index = line:find("=")

            if index ~= nil then
                local property = line:split("=")
                local property_name = property[1]
                local property_data = property[2]
                sections[section][property_name] = property_data
            end
        end
    end

    return sections
end

function build_icon_tree()
    local sections = get_theme_sections()
    local directories = sections['Icon Theme']['Directories']:split(",")

    if directories[#directories] == nil or directories[#directories] == "" then
        table.remove(directories, #directories)
    end

    local theme_location = sections["theme_location"]

    local icon_tree = {}

    for _, v in pairs(directories) do
        local icon_folder = theme_location .. "/" .. v

        if exists(icon_folder) == true then
            local dir_files = scandir(icon_folder)

            for _, x in pairs(dir_files) do
                if x ~= "." and x ~= ".." then
                    local name = string.match(x, "(.+)%..+")
                    if name ~= nil then
                        icon_tree[name] = theme_location .. "/" .. v .. "/" .. x
                    end
                end
            end
        end
    end

    --print(DataDumper(icon_tree))
    return icon_tree
end

--build_icon_tree()
