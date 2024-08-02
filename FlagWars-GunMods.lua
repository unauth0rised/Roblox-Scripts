
--> Variables
local AmmoConfigs = { "CurrentAmmo" }
local RecoilSpreadAndOtherStuff = { "MinSpread", "MaxSpread", "RecoilMax", "RecoilMin", "ShotCooldown", "SwingCooldown", "HeadshotCooldown" }
local DamageConfigs = { "HitDamage", "HeadshotDamage", "BulletSpeed" }

local OldIndex; OldIndex = hookmetamethod(game, "__index", newcclosure(function(Object, Property)
    if table.find(AmmoConfigs, tostring(Object)) and Property == "Value" then 
        return 1
    end 
    if table.find(RecoilSpreadAndOtherStuff, tostring(Object)) and Property == "Value" then 
        return 0
    end 
    if tostring(Object) == "FireMode" and Property == "Value" then 
        return "Automatic"
    end 
    if table.find(DamageConfigs, tostring(Object)) and property == "Value" then 
        return 9999
    end 
    return OldIndex(Object, Property)
end))
