--Basic Animation Sample (Waves) 
-- Using Tables to animate the waves. Dpad to move the boat
-- Author: Team Resurgent

require("global:Globals")


ShipWidth = 160
ShipHeight = 415

Speed = 0.1

ShipTable = {x = renderGetWidth()/ 2, y = renderGetHeight() - ShipHeight, Speed = 100, img = nil}


Ship = graphics.loadTexture("assets:images\\boat\\ship_large_body.png")

-- Create a table that holds all the wave sprites.
Waves = {}
table.insert(Waves,graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_000.png"))
table.insert(Waves,graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_001.png"))
table.insert(Waves,graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_002.png"))
table.insert(Waves,graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_003.png"))
table.insert(Waves,graphics.loadTexture("assets:\\images\\sprites\\waves\\water_ripple_big_004.png"))

-- Set current wave frame to 1 since tables start at 1
WaveCurrentFrame = 1


local backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\Water.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(screenMeshId, 0)

local fontId = graphics.loadFont("assets:fonts\\bahnschrift-bold-16px.fnt")

-- Function that controls movement of Ship X & Y cords
function Move(dt)
if direction == "Left" and ShipTable.x > 0 then -- ensure plane is always in window
      ShipTable.x = ShipTable.x - (ShipTable.Speed*dt)
end	  

if direction == "Right" and ShipTable.x < (renderGetWidth() - ShipWidth) then  -- ensure plane is always in window
      ShipTable.x = ShipTable.x + (ShipTable.Speed*dt)
end
	  
if direction == "Down" and ShipTable.y > 0 then  -- ensure plane is always in window
      ShipTable.y = ShipTable.y - (ShipTable.Speed*dt)	  
end

if direction == "Up" and ShipTable.y < (renderGetHeight() - ShipHeight ) then  -- ensure plane is always in window
      ShipTable.y = ShipTable.y + (ShipTable.Speed*dt)
end
end





function onRender(dt)

    local eye = vector3.new(0, 0, 2)
    local target = vector3.new(0, 0, 0)
    local up = vector3.new(0, 1, 0)
    local modelMatrix = matrix4.new()
    local viewMatrix = matrix4.lookAt(eye, target, up)
    local orthoMatrix = matrix4.orthoOffCenter(0, graphics.getWidth(), 0, graphics.getHeight(), 1, 100)

    graphics.clear(true, 1.0, true, 0, true, color4.new(0.227, 0.227, 0.227, 1.0))


        -- Background
        graphics.disableDepth()
        graphics.setModelMatrix(modelMatrix)
        graphics.setViewMatrix(viewMatrix)
        graphics.setProjectionMatrix(orthoMatrix)
        graphics.activateTexture(backgroundTextureId);
        graphics.activateMesh(screenMeshId, 0);
        graphics.drawMesh(0, 6)


-- Control the speed of the wave animation and also loop through all the waves
WaveCurrentFrame = WaveCurrentFrame + 10 *dt
if WaveCurrentFrame > #Waves then
WaveCurrentFrame = 1
end   


-- Render ship & waves onto screen

graphics.drawNinePatch(Waves[math.floor(WaveCurrentFrame)], vector3.new(ShipTable.x, ShipTable.y, 0.0), ShipWidth,ShipHeight, 0.0, 0.0)
graphics.drawNinePatch(Ship, vector3.new(ShipTable.x + 15, ShipTable.y + 15, 0.0), ShipWidth -30 , ShipHeight -30, 0.0, 0.0)

	




 -- Ship Controls using Dpad
Move(dt)	     	
	if (controller.isButtonHeld(0, controller.Button['DpadLeft'])) then
    if ShipTable.x > 0 then -- ensure ship is always in window
	  direction = "Left"
	  
    end
  elseif (controller.isButtonHeld(0, controller.Button['DpadRight'])) then
	 if ShipTable.x < (renderGetWidth() - ShipWidth) then  -- ensure ship is always in window
	  direction = "Right"
    end

elseif (controller.isButtonHeld(0, controller.Button['DpadDown'])) then
    if ShipTable.y > 0 then  -- ensure ship is always in window
	  direction = "Down"
    end
  elseif (controller.isButtonHeld(0, controller.Button['DpadUp'])) then
    if ShipTable.y < (renderGetHeight() - ShipHeight ) then  -- ensure ship is always in window
	  direction = "Up"
    end
	
		
 end					



    graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0)) -- Default color back to white
    graphics.endScene()
    graphics.swapBuffers()

end