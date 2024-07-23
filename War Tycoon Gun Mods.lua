--execute this script and then shoot your gun if you die you'll have to shoot your gun again once you've equipped it.
--Services:
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

--Variables:
local LocalPlayer = Players.LocalPlayer 
local HasShotGun = false 

local UsedGuns = {}
local ReloadedGun

local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    if Self.Name == "FireBullet" then 
        HasShotGun = true 
    end

    return OldNamecall(Self, ...)
end)

if LocalPlayer.Character then 
    local Character = LocalPlayer.Character 

    if Character:FindFirstChildWhichIsA("Tool") then 
        local Tool = Character:FindFirstChildWhichIsA("Tool")
        local ToolName = Tool.Name 

        if not table.find(UsedGuns, Tool.Name) and not HasShotGun then 
            repeat task.wait() until HasShotGun

            table.insert(UsedGuns, Tool.Name)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)

            if Tool:FindFirstChild("Settings", true) then 
                local GunProperties = require(Tool:FindFirstChild("Settings", true))
                
                GunProperties.Mode = "Auto"
                GunProperties.FireModes = {Semi = false, Auto = true, Burst = false}
                GunProperties.Ammo = math.huge
                GunProperties.FireRate = 100000000000000
                GunProperties.BSpeed = 1000000
                GunProperties.DamageMultiplier = math.huge

                --No Recoil:
                GunProperties.MinRecoilPower = 0
                GunProperties.VRecoil = {0, 0}
                GunProperties.HRecoil = {0, 0}
                GunProperties.MaxRecoilPower = 0
                GunProperties.AimRecoilReduction = math.huge
                GunProperties.RecoilPowerStepAmount = 0
                GunProperties.RecoilPunch = 0
                GunProperties.DamageMultiplier = 1000


                --No Spread:
                GunProperties.MinSpread = 0
                GunProperties.MaxSpread = 0
            end 

            Tool.Parent = LocalPlayer.Backpack 
            LocalPlayer.Backpack[ToolName].Parent = Character
        end
    end 

    Character.ChildAdded:Connect(function(Child)
        if Child:IsA("Tool") and not table.find(UsedGuns, Child.Name) and not HasShotGun then 
            local Tool = Child
            local ToolName = Tool.Name

            repeat task.wait() until HasShotGun
            table.insert(UsedGuns, Tool.Name)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)

            if Tool:FindFirstChild("Settings", true) then 
                local GunProperties = require(Tool:FindFirstChild("Settings", true))
                
                GunProperties.Mode = "Auto"
                GunProperties.FireModes = {Semi = false, Auto = true, Burst = false}
                GunProperties.Ammo = math.huge
                GunProperties.FireRate = 100000000000000
                GunProperties.BSpeed = 1000000
                GunProperties.DamageMultiplier = math.huge

                --No Recoil:
                GunProperties.MinRecoilPower = 0
                GunProperties.VRecoil = {0, 0}
                GunProperties.HRecoil = {0, 0}
                GunProperties.MaxRecoilPower = 0
                GunProperties.AimRecoilReduction = math.huge
                GunProperties.RecoilPowerStepAmount = 0
                GunProperties.RecoilPunch = 0
                GunProperties.DamageMultiplier = 1000


                --No Spread:
                GunProperties.MinSpread = 0
                GunProperties.MaxSpread = 0
            end 

            Tool.Parent = LocalPlayer.Backpack 
            LocalPlayer.Backpack[ToolName].Parent = Character
        end 

        if Child:IsA("Tool") and not table.find(UsedGuns, Child.Name) and HasShotGun then 
            HasShotGun = false
            local Tool = Child
            local ToolName = Tool.Name
            
            repeat task.wait() until HasShotGun
            table.insert(UsedGuns, Tool.Name)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)

            if Tool:FindFirstChild("Settings", true) then 
                local GunProperties = require(Tool:FindFirstChild("Settings", true))
                
                GunProperties.Mode = "Auto"
                GunProperties.FireModes = {Semi = false, Auto = true, Burst = false}
                GunProperties.Ammo = math.huge
                GunProperties.FireRate = 100000000000000
                GunProperties.BSpeed = 1000000
                GunProperties.DamageMultiplier = math.huge

                --No Recoil:
                GunProperties.MinRecoilPower = 0
                GunProperties.VRecoil = {0, 0}
                GunProperties.HRecoil = {0, 0}
                GunProperties.MaxRecoilPower = 0
                GunProperties.AimRecoilReduction = math.huge
                GunProperties.RecoilPowerStepAmount = 0
                GunProperties.RecoilPunch = 0
                GunProperties.DamageMultiplier = 1000


                --No Spread:
                GunProperties.MinSpread = 0
                GunProperties.MaxSpread = 0
            end 

            Tool.Parent = LocalPlayer.Backpack 
            LocalPlayer.Backpack[ToolName].Parent = Character
        end 
    end)
end 

LocalPlayer.CharacterAdded:Connect(function(Character)
    HasShotGun = false 
    UsedGuns = {}

    Character.ChildAdded:Connect(function(Child)
        if Child:IsA("Tool") and not table.find(UsedGuns, Child.Name) and not HasShotGun then 
            local Tool = Child
            local ToolName = Tool.Name

            repeat task.wait() until HasShotGun
            table.insert(UsedGuns, Tool.Name)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)

            if Tool:FindFirstChild("Settings", true) then 
                local GunProperties = require(Tool:FindFirstChild("Settings", true))
                
                GunProperties.Mode = "Auto"
                GunProperties.FireModes = {Semi = false, Auto = true, Burst = false}
                GunProperties.Ammo = math.huge
                GunProperties.FireRate = 100000000000000
                GunProperties.BSpeed = 1000000
                GunProperties.DamageMultiplier = math.huge

                --No Recoil:
                GunProperties.MinRecoilPower = 0
                GunProperties.VRecoil = {0, 0}
                GunProperties.HRecoil = {0, 0}
                GunProperties.MaxRecoilPower = 0
                GunProperties.AimRecoilReduction = math.huge
                GunProperties.RecoilPowerStepAmount = 0
                GunProperties.RecoilPunch = 0
                GunProperties.DamageMultiplier = 1000


                --No Spread:
                GunProperties.MinSpread = 0
                GunProperties.MaxSpread = 0
            end 

            Tool.Parent = LocalPlayer.Backpack 
            LocalPlayer.Backpack[ToolName].Parent = Character
        end 

        if Child:IsA("Tool") and not table.find(UsedGuns, Child.Name) and HasShotGun then 
            HasShotGun = false
            local Tool = Child
            local ToolName = Tool.Name
            
            repeat task.wait() until HasShotGun
            table.insert(UsedGuns, Tool.Name)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)

            if Tool:FindFirstChild("Settings", true) then 
                local GunProperties = require(Tool:FindFirstChild("Settings", true))
                
                GunProperties.Mode = "Auto"
                GunProperties.FireModes = {Semi = false, Auto = true, Burst = false}
                GunProperties.Ammo = math.huge
                GunProperties.FireRate = 100000000000000
                GunProperties.BSpeed = 1000000
                GunProperties.DamageMultiplier = math.huge

                --No Recoil:
                GunProperties.MinRecoilPower = 0
                GunProperties.VRecoil = {0, 0}
                GunProperties.HRecoil = {0, 0}
                GunProperties.MaxRecoilPower = 0
                GunProperties.AimRecoilReduction = math.huge
                GunProperties.RecoilPowerStepAmount = 0
                GunProperties.RecoilPunch = 0
                GunProperties.DamageMultiplier = 1000


                --No Spread:
                GunProperties.MinSpread = 0
                GunProperties.MaxSpread = 0
            end 

            Tool.Parent = LocalPlayer.Backpack 
            LocalPlayer.Backpack[ToolName].Parent = Character
        end 
    end)
end)    
