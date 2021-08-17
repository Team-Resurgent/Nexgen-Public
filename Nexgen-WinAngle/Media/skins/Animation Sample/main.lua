--###############################################################################################

-- Basic Animation Sample (Waves).
-- Using individual images and tables to animate the effect of waves around the ship.
-- Use the Dpad to move the ship on screen.

-- Author: Team Resurgent.
-- 17/08/2021.

-- The following are shortcut paths to the root folder of current skin. 
-- media: skin: scripts: audio: assets:

--###############################################################################################

--###############################################################################################
-- All code below is called exactly once at the beginning of the script
--###############################################################################################

require("global:Globals")

-- Load ship texture and store ships width & height into variables.
Ship = graphics.loadTexture("assets:images\\boat\\ship_large_body.png")
ShipWidth, ShipHeight = graphics.getTextureSize(Ship)

-- Create a table and store  X & Y positions along with movement speed.
ShipTable = {x = renderGetWidth() / 2, y = renderGetHeight() - ShipHeight, Speed = 100}

-- Create a table that holds all the wave sprites.
Waves = {}
table.insert(Waves, graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_000.png"))
table.insert(Waves, graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_001.png"))
table.insert(Waves, graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_002.png"))
table.insert(Waves, graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_003.png"))
table.insert(Waves, graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_004.png"))

-- Set current wave frame to 1 since tables start at 1.
WaveCurrentFrame = 1

-- Load background texture / wallpaper.
local backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\Water.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(screenMeshId, 0)

--###############################################################################################
-- Create a function that controls boat movement.
--###############################################################################################

-- Function that controls movement of ship X & Y cords, Initial values are read from ShipTable we created earlier.
function Move(dt)
      if direction == "Left" and ShipTable.x > 0 then -- ensure ship is always in window
            ShipTable.x = ShipTable.x - (ShipTable.Speed * dt)
      end

      if direction == "Right" and ShipTable.x < (renderGetWidth() - ShipWidth) then -- ensure ship is always in window
            ShipTable.x = ShipTable.x + (ShipTable.Speed * dt)
      end

      if direction == "Down" and ShipTable.y > 0 then -- ensure ship is always in window
            ShipTable.y = ShipTable.y - (ShipTable.Speed * dt)
      end

      if direction == "Up" and ShipTable.y < (renderGetHeight() - ShipHeight) then -- ensure ship is always in window
            ShipTable.y = ShipTable.y + (ShipTable.Speed * dt)
      end
end

--###############################################################################################

--###############################################################################################
-- All code located in the onRender callback function is used to update the state of the game
-- every frame (dt).

-- Do not use loadTexture, loadFont, loadMeshCollection, sound.load or any other load commands
-- here as this will cause the file to continuously load a new instance in memory,(leak).
--###############################################################################################

function onRender(dt)
      -- Control the speed of the wave animation and also loop through all the waves
      WaveCurrentFrame = WaveCurrentFrame + 10 * dt

      if math.floor(WaveCurrentFrame) > #Waves then
            WaveCurrentFrame = 1
      end

      -- Ship Controls using Dpad
      if (controller.isButtonHeld(0, controller.Button["DpadLeft"])) then
            if ShipTable.x > 0 then -- ensure ship is always in window
                  direction = "Left"
            end
      elseif (controller.isButtonHeld(0, controller.Button["DpadRight"])) then
            if ShipTable.x < (renderGetWidth() - ShipWidth) then -- ensure ship is always in window
                  direction = "Right"
            end
      elseif (controller.isButtonHeld(0, controller.Button["DpadDown"])) then
            if ShipTable.y > 0 then -- ensure ship is always in window
                  direction = "Down"
            end
      elseif (controller.isButtonHeld(0, controller.Button["DpadUp"])) then
            if ShipTable.y < (renderGetHeight() - ShipHeight) then -- ensure ship is always in window
                  direction = "Up"
            end
      end

      -- Calls function Move(dt) 
      Move(dt)

      --###############################################################################################
      -- All code located in graphics.beginScene() is for redering / displaying text & images on
      -- the screen every frame.
      --###############################################################################################

      if graphics.beginScene() then
            local eye = vector3.new(0, 0, 2)
            local target = vector3.new(0, 0, 0)
            local up = vector3.new(0, 1, 0)
            local modelMatrix = matrix4.new()
            local viewMatrix = matrix4.lookAt(eye, target, up)
            local orthoMatrix = matrix4.orthoOffCenter(0, graphics.getWidth(), 0, graphics.getHeight(), 1, 100)

            graphics.clear(true, 1.0, true, 0, true, color4.new(0.227, 0.227, 0.227, 1.0))
            graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0)) -- Default color to white atleast once to render screen

            -- Reender Background onto screen
            graphics.disableDepth()
            graphics.setModelMatrix(modelMatrix)
            graphics.setViewMatrix(viewMatrix)
            graphics.setProjectionMatrix(orthoMatrix)
            graphics.activateTexture(backgroundTextureId)
            graphics.activateMesh(screenMeshId, 0)
            graphics.drawMesh(0, 6)

            -- Render ship & waves onto screen
            graphics.drawNinePatch(
                  Waves[math.floor(WaveCurrentFrame)],
                  vector3.new(ShipTable.x, ShipTable.y, 0.0),
                  ShipWidth,
                  ShipHeight,
                  0.0,
                  0.0
            )
            graphics.drawNinePatch(
                  Ship,
                  vector3.new(ShipTable.x + 15, ShipTable.y + 15, 0.0),
                  ShipWidth - 30,
                  ShipHeight - 30,
                  0.0,
                  0.0
            )

            graphics.endScene()
            graphics.swapBuffers()
      end
end
