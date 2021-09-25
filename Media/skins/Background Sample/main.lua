require("global:Globals")

testmenu = 0

local backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\background.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(screenMeshId, 0)

local fontId = graphics.loadFont("assets:fonts\\bahnschrift-bold-37px.fnt")

function onRender(dt)
	local eye = vector3.new(0, 0, 2)
	local target = vector3.new(0, 0, 0)
	local up = vector3.new(0, 1, 0)
	local modelMatrix = matrix4.new()
	local viewMatrix = matrix4.lookAt(eye, target, up)
	local orthoMatrix = matrix4.orthoOffCenter(0, graphics.getWidth(), 0, graphics.getHeight(), 1, 100)

	graphics.clear(true, 1.0, true, 0, true, color4.new(0.227, 0.227, 0.227, 1.0))

	-- Background

	graphics.disableDepthTest()
	graphics.setModelMatrix(modelMatrix)
	graphics.setViewMatrix(viewMatrix)
	graphics.setProjectionMatrix(orthoMatrix)

	-- Background wallpaper example
	graphics.activateTexture(backgroundTextureId)
	graphics.activateMesh(screenMeshId, 0)
	graphics.drawMesh(0, 6)

	-- Message

	if (controller.isButtonDown(0, controller.Button["A"])) then
		if testmenu == 0 then
			testmenu = 1
		else
			testmenu = 0
		end
	end
	if testmenu == 1 then
		local textHPPosition = vector3.new(10, 50, 0).invertY(graphics.getHeight())
		graphics.setColorTint(color4.new(100 / 255, 140 / 255, 54 / 255, 1.0)) --Set text colour
		graphics.drawFont(fontId, textHPPosition, "This is how you would set a background with text.")
	end

	graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0)) -- Default colour back to white

	graphics.endScene()
	graphics.swapBuffers()
end

for i = 1, 10 do
	print(math.random())
end

print("done")
