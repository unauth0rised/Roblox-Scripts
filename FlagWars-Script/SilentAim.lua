--> Anticheat Bypass by Tupsu:
local BAC_
local Ran = false 

repeat task.wait() 
    for Index, Value in next, getnilinstances() do
        if game.IsA(Value, "LocalScript") and Value.Name == "BAC_" then
            BAC_ = Value
        end
    end

    for Index, Value in next, debug.getregistry() do
        if typeof(Value) == "thread" and gettenv(Value).script == BAC_ then
            task.cancel(Value)
            Ran = true
        end
    end
until Ran 

--> Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--> Variables
local LocalPlayer = Players.LocalPlayer 
local Camera = workspace.CurrentCamera 

local Wtvp = Camera.WorldToViewportPoint
local Mouse = LocalPlayer:GetMouse() 

local function FindNearestEnemyHead()
    local Distance = math.huge
    local Target

    for Index, Value in next, Players.GetPlayers(Players) do 
        if Value ~= LocalPlayer and Value.Team ~= LocalPlayer.Team and Value.Character then 
            local Character = Value.Character 

            if Character.FindFirstChild(Character, "Head") and Character.FindFirstChild(Character, "Humanoid").Health > 0 then 
                local Head = Character.Head 
                local HeadPos, OnScreen = Wtvp(Camera, Head.Position)
        
                if OnScreen then 
                    local MouseDistanceFromHead = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(HeadPos.X, HeadPos.Y)).Magnitude 

                    if MouseDistanceFromHead < Distance then 
                        Distance = MouseDistanceFromHead
                        Target = Head
                    end 
                end 
            end 
        end 
    end 

    return Target
end 

local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local Method = getnamecallmethod() 
    local Arguments = {...}

    if Self.Name == "WeaponHit" and FindNearestEnemyHead() then 
        local Head = FindNearestEnemyHead() 

        Arguments[2].part = Head
        Arguments[2].h = Head
        Arguments[2].p = Head.Position
    end 

    return OldNamecall(Self, unpack(Arguments))
end))

