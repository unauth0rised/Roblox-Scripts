--> Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--> Variables
local LocalPlayer = Players.LocalPlayer 
local DigRemote = ReplicatedStorage.Events.Dig

local function FindNearestDirt()
    local Distance = math.huge 
    local Target
  
    for Index, Value in next, workspace.Core.CurrentDirt:GetDescendants() do 
        if Value.Name == "dirt" then 
            local DistanceFromDirt = LocalPlayer:DistanceFromCharacter(Value.Position)

            if DistanceFromDirt < Distance then 
                Distance = distanceFromDirt
                Target = Value
            end 
        end 
    end 
    return Target 
end 

RunService.RenderStepped:Connect(function()
    DigRemote:FireServer("Shovel", FindNearestDirt())
end)
