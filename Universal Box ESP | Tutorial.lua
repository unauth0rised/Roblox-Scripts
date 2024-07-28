--//credits: blissful (i used his script for the actual math of the box esp because i fucking suck at math if anyone could teach me it please do!1!!)
--// made by: unauth0rised (on discord) you can ask me for questions if you need help or teach me something new because i'm still a learner aswell :)

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
Service = A service is an object which holds many different functions, properties, objects, events etc...
]]--

local players = game:GetService("Players") --// accessing the players service
local runservice = game:GetService("RunService") --// accessing the run service
local teams = game:GetService("Teams") --// accessing the teams service

--//Variables:

local localplayer = players.LocalPlayer --// accessing our local player
local drawnplayers = {} --// creating a table which will store players that have a table which has the quad drawing object attached to it (if that makes sense)
local camera = workspace.CurrentCamera --// accessing the workspace's camera

--// this function creates a box outline with the following properties
local function createboxoutline()
    local box = Drawing.new("Quad") --// accessing the drawing library and creating a new quad object (this is what i will be referring to "box" as)
    box.Visible = false --// setting the box's visibility to false so it cannot be seen
    --// since a quad is a square it has 4 point (A, B, C and D) point A and B connect/draw to eachother and point C and D connect/draw to eachother if that makes sense
    box.PointA = Vector2.new(0,0)
    box.PointB = Vector2.new(0,0)
    box.PointC = Vector2.new(0,0)
    box.PointD = Vector2.new(0,0) 
    box.Color = Color3.new(0, 0, 0) --// Setting the box colour to black
    box.Filled = false --// setting the filled property to false so the box isn't filled
    box.Thickness = 2 --// setting the box thickness to 2 so it appears behind the original box object (this line is quite confusing)
    box.Transparency = 1 --// setting the box transparency to 1 so that it isn't transparent, bro the drawing library doesn't really make sense how is transparency = 1 mean its visible lmao it should be 0 but whatever
    return box --// returning the box object meaning whenever we invoke this function we can get the box object with the following properties
end;

--// this function creates a box with the following properties
--// does the same thing as the function above basically cba to retype
local function createbox()
    local box = Drawing.new("Quad")
    box.Visible = false
    box.PointA = Vector2.new(0,0)
    box.PointB = Vector2.new(0,0)
    box.PointC = Vector2.new(0,0)
    box.PointD = Vector2.new(0,0)
    box.Color = Color3.new(1, 1, 1)
    box.Filled = false
    box.Thickness = 1
    box.Transparency = 1
    return box --// returning the box object meaning whenever we invoke this function we can get the box object with the following properties
end;

--// this function is called "addplayers" and what it does is that it indexes a player that will be passed to the "player" parameter and creates a table filled with the box objects
local function addplayer(player)
    drawnplayers[player] = {  --// indexing the player passed to "player" parameter and giving it a table which holds the box and boxoutline objects
        boxoutline = createboxoutline(),
        box = createbox() --invoking the "createbox" function to p
    }
end 

--// this function updates the boxes position and sets the box's visibility to true depending on whether the player is onscreen
local function updateboxes(box, boxoutline, distanceY, root2dpos)
    --// tysm blissful for your beautiful maths skills because i don't how the fuck to do shit like this

    box.PointA = Vector2.new(root2dpos.X + distanceY, root2dpos.Y - distanceY * 2)
    box.PointB = Vector2.new(root2dpos.X - distanceY, root2dpos.Y - distanceY * 2)
    box.PointC = Vector2.new(root2dpos.X - distanceY, root2dpos.Y + distanceY * 2)
    box.PointD = Vector2.new(root2dpos.X + distanceY, root2dpos.Y + distanceY * 2)

    boxoutline.PointA = Vector2.new(root2dpos.X + distanceY, root2dpos.Y - distanceY * 2)
    boxoutline.PointB = Vector2.new(root2dpos.X - distanceY, root2dpos.Y - distanceY * 2)
    boxoutline.PointC = Vector2.new(root2dpos.X - distanceY, root2dpos.Y + distanceY * 2)
    boxoutline.PointD = Vector2.new(root2dpos.X + distanceY, root2dpos.Y + distanceY * 2)

    box.Visible = true --// setting the box visibility to true so its visibile
    boxoutline.Visible = true --// setting the box outline's visibility to true so its visibile
end

--// this for loop iterates over the players in the games and adds them to the "drawnplayers" table
for i, v in pairs(players:GetChildren()) do 
    --// if value inside of the list of players is equal to local player then we're going to iterate over that item in the list therefore skipping over it
    if v == localplayer then continue end  
    addplayer(v) --// invoking the "addplayer" function
end

--// this event is fired whenever a player joins the game, and when a player does the function "addplayer" is invoked which adds that player to the "drawnplayers" table
players.PlayerAdded:Connect(function(player)
    --// the playeradded event also has a function which passes in the "player" who joined as a parameter
    addplayer(player) --// the player who joined is what we're passing to the "addplayer" function so it creates a table filled with the box objects for that specific player
end)

--// this event is fired whenever a player leaves the game, and when a player does the function "addplayer" the 
players.PlayerRemoving:Connect(function(player)
    --// the playerremoving event also has a function which passes in the "player" who left as a parameter
    drawnplayers[player].box:Remove() --// removing the box object from the player
    drawnplayers[player].boxoutline:Remove() --// removing the box outline object from the player
    drawnplayers[player] = nil --//setting the player to nil as they don't exist anymore in the game since they left
end)

runservice.RenderStepped:Connect(function() --// renderstepped is an event inside of the run service which allows us to create a loop that will run every frame per second
    for player, table in pairs(drawnplayers) do --// this for loop iterates over the "drawnplayers" table
        if player.Team == localplayer.Team and #teams:GetChildren() > 0 then continue end 
        --// ^^^ if the player's team is equal to our localplayer's team and there is more than 0 teams then iterate over the players with the same teams as us ^^^

        if player.Character then --// if the player has a character then this condition is true else if they don't this condition will evaluate as false and the script will not advance onto the next lines
            local character = player.Character --// accessing the player's character

            if character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") and character:FindFirstChild("Humanoid") then 
                --// ^^^ checking IF the player's character has a humanoidrootpart and a head ^^^
                local root = character.HumanoidRootPart --// accesing the character's humanoidrootpart 
                local head = character.Head --// accessing the character's head
                local root2dpos, onscreen = camera:WorldToViewportPoint(root.Position)
                local humanoid = character.Humanoid
                --[[ 
                    WorldToViewportPoint (WTV) is a built in function that returns 2 values the first value is
                    a Vector2 value of an object in a 2D space (think of it as a function that converts a 3D value into a 2D value) 
                    it also returns a boolean value that allows us to check if that said object is on our screen, thats its 2nd return value.
                ]]--

                local head2dpos = camera:WorldToViewportPoint(head.Position) --// converting the character's 3d head position into a 2d position basically
                local distanceY = math.clamp((Vector2.new(head2dpos.X, head2dpos.Y) - Vector2.new(root2dpos.X, root2dpos.Y)).Magnitude, 2, math.huge) --// again idk how this maths works so ty blissful...
                
                if onscreen and humanoid.Health > 0 then --// checking if the character's humanoid root part is onscreen
                    updateboxes(table.box, table.boxoutline, distanceY, root2dpos) --// invoking the update boxes function which takes 4 parameters the box object and the box outline object, the distanceY variable and the rood2dpos variable aswell
                end 

                if humanoid.Health < 0 or not onscreen then 
                    table.box.Visible = false 
                    table.boxoutline.Visible = false 
                end
            end 
            
        else 
            table.box.Visible = false 
            table.boxoutline.Visible = false 
        end 
    end 
end)
