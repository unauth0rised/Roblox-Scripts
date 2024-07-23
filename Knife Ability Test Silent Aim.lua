--Changed my style of coding to make it easier for people to understand!

--[[
Glossary:
Iterate = Repeat over something a numerous amount of times.
Index [For Tables Definition] = Refers to the position of a value in a table
Index [Coding In General Definition] = Index is just another word for "referencing" e.g "Indexing our local player" basically means referencing our local player
Invoked = When a function is called/executed
Function = A piece of code that can be executed on command, a function can return values when invoked/executed
Method = Another word for "function" e.g "GetPlayers" is a method which returns a table of players in the game
Return = idk how to explain it, but just view it as "getting" a value
Parameter = Values passed through a function, can be seen as another word for "arguments"
Service = tbfh idrk what a service is i just see it as an object which holds many different functions, properties, events etc...
]]--

--Services:
local Players = game:GetService("Players") -- Get Service: In built function that returns a service if it exists, if it doesn't exists it creates and returns the said service. basically just ascessing the player's service

--Variables:
local LocalPlayer = Players.LocalPlayer -- Referencing our local player
local Mouse = LocalPlayer:GetMouse() -- Returns our mouse which holds many different events, functions and properties 

local Camera = game.Workspace.CurrentCamera  -- Accessing the game's camera
local Wtvp = Camera.WorldToViewportPoint -- A function that returns 2 values an object's position in a 2D space (Vector2) and a boolean value which determines if the object is on our screen.

local function FindNearestPlayerHead() -- Function basically returns the nearest enemy player's head
    local Distance = math.huge -- Setting the distance to math.huge
    local Target = nil -- Setting our target to nothing (nil)

    for Index, Value in pairs(Players.GetPlayers(Players)) do -- For Index, Value loops iterate over a table to grab the values of the table and the index of those values. What this piece of code does is it iterates over a table which contains a list of players in the game
        if Value ~= LocalPlayer and Value.Character then -- Checking if the values inside the table isn't our local player and checking if the values has a character "the value in this context basically refers to our player"
            local EnemyCharacter = Value.Character -- Referencing the enemy's character

            if EnemyCharacter.FindFirstChild(EnemyCharacter, "Head") and EnemyCharacter.FindFirstChild(EnemyCharacter, "Humanoid") then -- Checking if the enemy's character has a head and humanoid 
                local EnemyHead = EnemyCharacter.Head -- Referencing the enemy's head
                local EnemyHumanoid = EnemyCharacter.Humanoid -- Referencing the enemy's humanoid

                if EnemyHumanoid.Health > 0 then -- Checking if the enemy's humanoid health is more than 0 
                    local EnemyHeadPosition, OnScreen = Wtvp(Camera, EnemyHead.Position) -- Takes 1 Parameter which is a Vector3 Value 

                    if OnScreen then -- Checking if the enemy's head is on our screen
                        local EnemyHeadDistanceFromMouse = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(EnemyHeadPosition.X, EnemyHeadPosition.Y)).Magnitude -- Returns the distance between our mouse's position and our enemy's head's position in a 2D space, hence why "Vector2" is used

                        if EnemyHeadDistanceFromMouse < Distance then 
                            Distance = EnemyHeadDistanceFromMouse -- Setting our distance lower and lower so our function only finds the closest player
                            Target = EnemyHead -- Setting our target to the enemy's head
                        end 
                    end 
                end 
            end 
        end 
    end 

    return Target -- Returns our target which is the enemy's character's head
end 

local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...) -- If i were to explain this whole function it would take a while, so just see it as a function that allows you to detect when methods are invoked
    local NamecallMethod = getnamecallmethod() -- A function that returns a method 

    local CallingScript = getcallingscript() -- A function that returns the script that has a method 

    if NamecallMethod == "FindPartOnRayWithIgnoreList" and FindNearestPlayerHead() and (tostring(CallingScript) == "RevolverClient" or tostring(CallingScript) == "KnifeClient") then -- Checking if the method is equal to the "FindPartOnRayWithIgnoreList" and checking if the script that has the method "FindPartOnRayWithIgnoreList" is called "RevolverClient" or "KnifeClient" and checking if the nearest enemy exists
        local NearestPlayerHead = FindNearestPlayerHead() -- Our function that returns the nearest enemy 
        return NearestPlayerHead, NearestPlayerHead.Position --[[
        This part is very important for the silent aim to work what it basically does it replaces the values that the function "FindPartOnRayWithIgnoreList" normally returns and
        replaces it with the nearest enemy's head and the head's position thus resulting in whenever we fire our gun/knife the projectile hits the nearest enemy's head
        ]]--
    end 

    return OldNamecall(...) -- Return the old namecall function which holds the games necessities in order for it to function, if we don't return the oldnamecall function then our game will crash because we're overwriting it 
end))
