--> Services
local Players = game:GetService("Players")

--> Variables
local LocalPlayer = Players.LocalPlayer
local ClientReplicatedClassesFolder = LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses

local ClientItemModule = require(ClientReplicatedClassesFolder.ClientFighter.ClientItem)
local InputFunction = ClientItemModule.Input

local OldInputFunction; OldInputFunction = hookfunction(InputFunction, function(...)
    local Arguments = {...}

    if type(Arguments[1]) == "table" then
        Arguments[1].Info.ShootRecoil = 0
        Arguments[1].Info.ShootSpread = 0
        Arguments[1].Info.ProjectileSpeed = 99999999
        Arguments[1].Info.ShootCooldown = 0
        Arguments[1].Info.QuickShotCooldown = 0
    end
    
    return OldInputFunction(...)
end)
