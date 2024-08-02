--> Game Link: https://www.roblox.com/games/621129760/KAT
--> Services
local Players = game:GetService("Players")

--> Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Camera = game.Workspace.CurrentCamera
local Wtvp = Camera.WorldToViewportPoint

local function FindNearestPlayerHead() 
    local Distance = math.huge
    local Target = nil

    for Index, Value in pairs(Players.GetPlayers(Players)) do 
        if Value ~= LocalPlayer and Value.Character then
            local EnemyCharacter = Value.Character

            if EnemyCharacter.FindFirstChild(EnemyCharacter, "Head") and EnemyCharacter.FindFirstChild(EnemyCharacter, "Humanoid") then
                local EnemyHead = EnemyCharacter.Head
                local EnemyHumanoid = EnemyCharacter.Humanoid 

                if EnemyHumanoid.Health > 0 then
                    local EnemyHeadPosition, OnScreen = Wtvp(Camera, EnemyHead.Position)

                    if OnScreen then
                        local EnemyHeadDistanceFromMouse = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(EnemyHeadPosition.X, EnemyHeadPosition.Y)).Magnitude

                        if EnemyHeadDistanceFromMouse < Distance then 
                            Distance = EnemyHeadDistanceFromMouse
                            Target = EnemyHead
                        end 
                    end 
                end 
            end 
        end 
    end 

    return Target
end 

local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local NamecallMethod = getnamecallmethod()
    local CallingScript = getcallingscript() 

    if NamecallMethod == "FindPartOnRayWithIgnoreList" and FindNearestPlayerHead() and (tostring(CallingScript) == "RevolverClient" or tostring(CallingScript) == "KnifeClient") then
        local NearestPlayerHead = FindNearestPlayerHead()
        return NearestPlayerHead, NearestPlayerHead.Position
    end 

    return OldNamecall(...)
end))
