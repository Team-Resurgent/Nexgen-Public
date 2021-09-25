if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
	require("lldebugger").start()
	print("debug started")
end

require("global:Globals")

local sheetTextureId = graphics.loadTexture("assets:images\\sprite-sheet.png")
local sheetMeshId = graphics.createSheetMeshCollection(0, 0, 0, 64, 64, 16, 16)
graphics.bindMesh(sheetMeshId, 0)

local sheetCount = 0

--error("FUBAR")

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
local message = "hello world hello world hello world hello world hello world hello world"
local message_x = 0;
local message_length = string.len(message)
local offset = 0
local spriteRotate = 0

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

	offset = (offset + (dt * 120)) % 360
	spriteRotate = (spriteRotate + (dt * 20)) % 360

	sheetCount = sheetCount + (dt * 20)

	local sheetFrame = math.floor(sheetCount) % 255

	if graphics.beginScene() then

		-- Setup Lights
		graphics.disableLights()		

		-- Background

		graphics.disableDepthTest()
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
 	    for i = 1, message_length do
 	    	local pos_y = math.sin((offset + i) / 57.296) * 400.0
		    local textPosition = vector3.new(pos_x, 450 + pos_y, 0)
		    graphics.drawFont(fontId, textPosition, string.sub(message, index + i, index + i))		    
		    pos_x = pos_x + 20
	    end

	  graphics.setColorTint(color4.new(1.0, 1.0, 1.0, 1.0)) -- restore to default 
	
		graphics.activateTexture(sheetTextureId, graphics.Filter['Nearest'])
		graphics.activateMesh(sheetMeshId, 0)

		-- above we asked for a sprite 64 x 64, so move it so its center is 0,0 
		-- as this is where we want to rotate form
		local translateTransform1 = matrix4.translate(-32,-32, 0, 0)
		-- rotate by spriteRotate which is 0 to 359 degrees
		local rotateTransform = matrix4.rotateZ(spriteRotate)
		-- move back to 0,0
		local translateTransform2 = matrix4.translate(32,32, 0, 0)
		-- scale by siz times
		local scaleTransform = matrix4.scale(6,6,1)

		-- multiply the transforms in order
		local spriteTransform = translateTransform1 * rotateTransform * translateTransform2 * scaleTransform
		-- tell shader we want to use this transform
		graphics.setModelMatrix(spriteTransform)
		graphics.drawMesh(sheetFrame * 6, 6)

		graphics.endScene()
		graphics.swapBuffers()
	end

end

print("done")