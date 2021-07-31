require("global:Globals")

local designedWidth = 1920	
local designedHeight = 1441 

local bahnschriftFontId = graphics.loadFont("assets:fonts\\bahnschrift-bold-16px.fnt")

local fileManagerTextureId = graphics.loadTexture("assets:images\\fileManager.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, designedWidth, designedHeight, 1, 1)
graphics.bindMesh(screenMeshId, 0)

function onRender(dt)

	local windowWidth = graphics.getWidth()
	local windowHeight = graphics.getHeight()

	local ratioX = windowWidth / designedWidth
	local ratioY = windowHeight / designedHeight
	local ratio = 0
	if (ratioX < ratioY) then
		ratio = ratioX
	else
		ratio = ratioY
	end

	local newWidth = designedWidth * ratio
	local newHeight = designedHeight * ratio
	local xOffset = (windowWidth - newWidth) / 2
	local yOffset = (windowHeight - newHeight) / 2

	--print("new width " .. newWidth .. " height " .. newHeight .. " " .. xOffset)

--and offset by xOffset + yOffset
--so drawing a sprite would be something like drawsprite(spritex + xoffsofet, spritey + yoffset, spritewidth * ratio, spriteheight * raitio)


	local modelMatrix = matrix4.scale(ratio, ratio, ratio) 
	local translateMatrix = matrix4.translate(xOffset, 0, 0)
	modelMatrix = translateMatrix * modelMatrix

	local eye = vector3.new(0, 0, 2)
	local target = vector3.new(0, 0, 0)
	local up = vector3.new(0, 1, 0)
	local viewMatrix = matrix4.lookAt(eye, target, up)
	local orthoMatrix = matrix4.orthoOffCenter(0, graphics.getWidth(), 0, graphics.getHeight(), 1, 100)

	graphics.clear(true, 1.0, true, 0, true, color4.new(1.0, 0, 0, 1.0))
 	graphics.setColorTint(color4.new(1.0, 1.0, 1.0, 1.0)) 

	if graphics.beginScene() then

		graphics.setModelMatrix(modelMatrix)
		graphics.setViewMatrix(viewMatrix)
		graphics.setProjectionMatrix(orthoMatrix)

		graphics.activateTexture(fileManagerTextureId);
		graphics.activateMesh(screenMeshId, 0);
		graphics.drawMesh(0, 6)

		graphics.endScene()
		graphics.swapBuffers()

	end

end

function onResize()
	print("OnResize width = " .. graphics.getWidth() .. " height = " .. graphics.getHeight())
end

print("done")