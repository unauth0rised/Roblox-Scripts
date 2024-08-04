--> Made by: unauth0rised (on discord)
--> Services:
local RunService = game:GetService("RunService") --> Accessing the run service
local Players = game:GetService("Players") --> Accessing the players service
local ReplicatedStorage = game:GetService("ReplicatedStorage") --> Accessing the ReplicatedStorage service

--> Variables:
local LocalPlayer = Players.LocalPlayer --> Indexing our local player from the player service

--> getsenv() is a table that takes in a local script as a paraneter
--> It returns a table that contains a list of global functions, tables and variables in that script
--> We're essentially just accessing contents of the "WeaponryFramework" local script (if that makes sense)
local WeaponryFramework = getsenv(LocalPlayer.PlayerScripts.WeaponryFramework)
local WeaponHandler = ReplicatedStorage.Remotes.WeaponHandler --> Accessing the weapon handler remote

--> Initializing our local variables we're basically just creating them, but not giving it any value at the moment
local WeaponPropertiesTable1
local WeaponPropertiesTable2

RunService.RenderStepped:Connect(function()
    for I, V in pairs(WeaponryFramework) do --> Iterating through the weaponry framework's script enviroment

        if I == "InventoryManager" then
            local InventoryManagerFunc = V --> A function that manages your inventory

            for I, V in pairs(debug.getupvalues(InventoryManagerFunc)) do
                if type(V) == "table" then --> If one of the upvalues is a table then this condition evaluates to true so it proceeds to the next line
                    for I, V in pairs(V) do --> Iterating through that table

                        if type(V) == "table" then --> If a value in the table is a table then proceed to the next line
                            --> The first index holds a table that contains properties for your 1st gun so we check if I is == 1
                            --> If I == 1 then we're going to accessing the properties of our 1st gun (This part is confusing ik)
                            if I == 1 then
                                --> Setting our "WeaponPropertiesTable1" to the value of the 1st index which is a table full of our 1st gun's properties
                                WeaponPropertiesTable1 = V

                                --> THIS PART IS VERY IMPORTANT IT HOLDS THE LOGIC OF THE INF AMMO PLEASE READ!!!!!
                                --> We're essentially just checking if our gun's ammo value is less than its max ammo value
                                --> If it is then we're going to set the gun's reload property to true and fire the remote that reloads our gun
                                --> Once the gun has reloaded we're going to set it's reload property to "false", so that the game doesn't thinks we're reloading anymore
                                --> And then we're going to set its "CurrentAmmo" property value to the gun's max ammo value
                                --> This part BASICALLYLYY just allows us to mimic how a LEGIT player reloads their gun, so we don't trigger the AC
                                if WeaponPropertiesTable1.CurrentAmmo < WeaponPropertiesTable1.WeaponStats.MaxAmmo then
                                    WeaponPropertiesTable1.Reloading = true
                                    WeaponHandler:FireServer(3, WeaponPropertiesTable1)
                                    WeaponPropertiesTable1.CurrentAmmo = WeaponPropertiesTable1.WeaponStats.MaxAmmo
                                    WeaponPropertiesTable1.Reloading = false
                                end
                            end
                            --> The second index holds a table that contains properties for your 1st gun so we check if I is == 2
                            --> If I == 2 then we're going to accessing the properties of our 2nd gun (This part is confusing ik)
                            if I == 2 then
                                --> Setting our "WeaponPropertiesTable1" to the value of the 1st index which is a table full of our 1st gun's properties
                                WeaponPropertiesTable2 = V

                                --> I just Crtl + C, Crtl + V this part lmao
                                --> THIS PART IS VERY IMPORTANT IT HOLDS THE LOGIC OF THE INF AMMO PLEASE READ!!!!!
                                --> We're essentially just checking if our gun's ammo value is less than its max ammo value
                                --> If it is then we're going to set the gun's reload property to true and fire the remote that reloads our gun
                                --> Once the gun has reloaded we're going to set it's reload property to "false", so that the game doesn't thinks we're reloading anymore
                                --> And then we're going to set its "CurrentAmmo" property value to the gun's max ammo value
                                --> This part BASICALLYLYY just allows us to mimic how a LEGIT player reloads their gun, so we don't trigger the AC
                                if WeaponPropertiesTable2.CurrentAmmo < WeaponPropertiesTable2.WeaponStats.MaxAmmo then
                                    WeaponPropertiesTable2.Reloading = true
                                    WeaponHandler:FireServer(3, WeaponPropertiesTable2)
                                    WeaponPropertiesTable2.CurrentAmmo = WeaponPropertiesTable2.WeaponStats.MaxAmmo
                                    WeaponPropertiesTable2.Reloading = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
