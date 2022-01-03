HELP_COMMANDS = HELP_COMMANDS or {}

HELP_COMMANDS.Commands = HELP_COMMANDS.Commands or {
    ["!forums"] = "Check out out forums at ridge.gg",
}

HELP_COMMANDS.AccessGroups = {
    ["superadmin"] = true,
}

concommand.Add("help_addcommand", function(ply, cmd, args)
    if (not HELP_COMMANDS.AccessGroups[ply:GetUserGroup()]) then return end

    local newCommand = args[1]
    local output = args[2]

    HELP_COMMANDS.Commands[newCommand] = output

    HELP_COMMANDS.Save()

    ply:ChatPrint("Successfully added in new command " .. newCommand)
end)

concommand.Add("help_removecommand", function(ply, cmd, args)
    if (not HELP_COMMANDS.AccessGroups[ply:GetUserGroup()]) then return end

    local removeCommand = args[1]
    HELP_COMMANDS.Commands[removeCommand] = nil

    HELP_COMMANDS.Save()

    ply:ChatPrint("Successfully removed command " .. removeCommand)
end)

concommand.Add("help_listcommands", function(ply) 
    if (not HELP_COMMANDS.AccessGroups[ply:GetUserGroup()]) then return end

    for k, v in pairs(HELP_COMMANDS.Commands) do
        ply:ChatPrint("Command: " .. k .. " Output: " .. v)
    end
end)

hook.Add("PlayerSay", "CheckHelpCommands", function(ply, text)
    local helpCommand = HELP_COMMANDS.Commands[string.lower(text)]

    if (helpCommand) then
        ply:ChatPrint(helpCommand)

        return ""
    end
end)

local saveDir = "helpcommands"

function HELP_COMMANDS.Save()
    if (not file.Exists(saveDir, "DATA")) then
        file.CreateDir(saveDir)
    end

    file.Write(saveDir .. "/commands.txt", util.TableToJSON(HELP_COMMANDS.Commands, true))
    print("SUCCESSFULLY SAVED!")
end   

function HELP_COMMANDS.Load()
    local data = file.Read(saveDir .. "/commands.txt", "DATA")

    if (not data) then 
        MsgC(Color(255, 0, 0), "No save data found for help commands!") 
        return 
    end

    HELP_COMMANDS.Commands = util.JSONToTable(data)

    MsgC(Color(0, 255, 0), " Loaded help commands saved data!")
end

hook.Add("InitPostEntity", "LoadHelpCommandsData", function()
    HELP_COMMANDS.Load()
end)


print("sv_chatcommands.lua loaded")