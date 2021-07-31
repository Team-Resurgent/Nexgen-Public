require("global:Globals")

system.refreshDrives()
local drives = system.getDrives();
print("dive count = " .. #drives)
for driveNum = 1, #drives do
  print("drive = " .. drives[driveNum])
end

local soundIndex = sound.load("audio:music\\comic.wav")
sound.play(soundIndex)

local backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\background.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(screenMeshId, 0)

local fontId = graphics.loadFont("assets:fonts\\bahnschrift-bold-37px.fnt")

local index = 0
local message = "hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world"
local message_x = 0;
local message_length = string.len(message)
local offset = 0

function onRender(dt)

	local eye = vector3.new(0, 0, 2)
	local target = vector3.new(0, 0, 0)
	local up = vector3.new(0, 1, 0)
	local modelMatrix = matrix4.new()
	local viewMatrix = matrix4.lookAt(eye, target, up)
	local orthoMatrix = matrix4.orthoOffCenter(0, graphics.getWidth(), 0, graphics.getHeight(), 1, 100)

	graphics.clear(true, 1.0, true, 0, true, color4.new(0.227, 0.227, 0.227, 1.0))

	--message_x = message_x + (dt * 120);
	if (message_x > message_length) then		
		message_x = 0;
	end

	offset = offset + (dt * 120)
	if (offset >= 360) then
		offset = 0;
	end

	if graphics.beginScene() then

		-- Setup Lights
		graphics.disableLights()		

		-- Background

		graphics.disableDepth()
		graphics.setModelMatrix(modelMatrix)
		graphics.setViewMatrix(viewMatrix)
		graphics.setProjectionMatrix(orthoMatrix)

		-- Background wallpaper example
		graphics.activateTexture(backgroundTextureId);
		graphics.activateMesh(screenMeshId, 0);
		graphics.drawMesh(0, 6)
		
		-- Message

		graphics.setColorTint(color4.new(0.0, 1.0, 0.0, 1.0)) -- tint green

		local pos_x = message_x
 	    for i = 1, 52 do
 	    	local pos_y = math.sin((offset + i) / 57.296) * 400.0
		    local textPosition = vector3.new(pos_x, 450 + pos_y, 0)
		    graphics.drawFont(fontId, textPosition, string.sub(message, index + i, index + i))		    
		    pos_x = pos_x + 20
	    end

	    graphics.setColorTint(color4.new(1.0, 1.0, 1.0, 1.0)) -- restore to default 
	
		graphics.endScene()
		graphics.swapBuffers()
	end

end

print("done")