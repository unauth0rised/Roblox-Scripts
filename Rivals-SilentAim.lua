--> Services
local Players = game:GetService("Players")

--> Variables
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera 
local Mouse = LocalPlayer:GetMouse() 
local Wtvp = Camera.WorldToViewportPoint
             
local function GetClosestPlayerToHead()
    local Target
    local Distance = math.huge 
  
    for Index, Value in ipairs(Players.GetPlayers(Players)) do
         if Value == LocalPlayer or not Value.Character then continue end 
         local Character = Value.Character 
    
         if Character.FindFirstChild(Character, "Head") then
            local Head = Character.Head 
            local HeadPos, OnScreen = Wtvp(Camera, Head.Position)
            
            if OnScreen then 
                local MouseDistance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(HeadPos.X, HeadPos.Y)).Magnitude
        
                if MouseDistance < Distance then 
                    Distance = MouseDistance 
                    Target = Head
                end 
            end 
        end 
    end
  
    return Target 
end 

--> Namecall Hook for Silent Aim!
local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local CallingScript = getcallingscript()
    
    if (Method == "Raycast") and (tostring(CallingScript) == "Equipment" or tostring(CallingScript) == "FighterController" or tostring(CallingScript) == "PlayerDataController" or tostring(CallingScript) == "ControlsController") then 
        Arguments[2] = Camera.CFrame.Position
        Arguments[3] = (GetClosestPlayerToHead().Position - Arguments[2]).Unit * 1000
    end
    return OldNamecall(unpack(Arguments))
end)
