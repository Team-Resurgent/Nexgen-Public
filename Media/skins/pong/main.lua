--############################################################################################### 
-- Nexgen Root.Lua 
-- media: skin: scripts: audio: assets: are the current path shortcuts
-- 07/04/2021
--############################################################################################### 


--************************************************************************************************
-- Load Includes / Requires.
-- These includes Controller Mapping, SysInfo, Music Control 
--************************************************************************************************

--local sysinfo = require ("scripts:sysinfo")
--local musiccontrol = require ("scripts:musiccontrol")

require("global:Globals")

--************************************************************************************************
-- Configurable Options to turn stuff On & Off
--************************************************************************************************

-- local BackgroundOverlay = "Off"
local Background2DWallpapper = "On"
-- local FogType = "Static"
local InGameMusic= "On"
-- local DNA = "On"

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Define & Load Audio.
--************************************************************************************************ 

if InGameMusic == "On" then
IGMusic = sound.load("audio:music\\music.wav")
end

 paddlehit = sound.load("audio:sounds\\paddle_hit.wav")
 wallhit = sound.load("audio:sounds\\wall_hit.wav")
 scores = sound.load("audio:sounds\\score.wav")

--************************************************************************************************ 
-- Define & Load Fonts.
--************************************************************************************************ 

fontId = graphics.loadFont("assets:fonts\\Arial_Black_20px.fnt")

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Define & Load 2D Background.
--************************************************************************************************ 

if Background2DWallpapper == "On" then
backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\PongBackground.jpg")
backgroundMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(backgroundMeshId, 0)
end

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Define & Load 9Patch Images.
--************************************************************************************************

local buttonTextureId = graphics.loadTexture("assets:images\\buttons\\button.png")
local paddleTextureId = graphics.loadTexture("assets:images\\paddles\\paddle.png")

-------------------------------------------------------------------------------------------------- 
local backgroundColor = color4.new(0.227, 0.227, 0.227, 1.0)
TextColour1 = color4.new(255/255, 204/255, 0/255, 1.0)
TextColour1Default = color4.new(1.0, 1.0, 1.0, 1.0)

ball = {}
ball.x = 300
ball.y = 200
ball.vel = {}
ball.vel.x = 5
ball.vel.y = 1
ball.height = 30
ball.width = 30

map = {}
map.offset = 20
map.width = 880
map.height = 400

a = {}
a.width = 10
a.height = 150
a.y = 200
a.x = 880

b = {}
b.width = 10
b.height = 150
b.y = 200
b.x = 40

a.score = 0
b.score = 0

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Play sound on startup
--************************************************************************************************

if InGameMusic == "On" then
	sound.setRepeat(IGMusic, -1)
	sound.play(IGMusic)
	print("Music repeat on")
end

-------------------------------------------------------------------------------------------------- 


--************************************************************************************************
-- Render Code Code from this point Loops.
--************************************************************************************************

function onRender(dt)

local aspectRatio = renderGetWidth() / renderGetHeight()

-------------------------------------------------------------------------------------------------- 	

local orthoModelMatrix = matrix4.new()
local eye = vector3.new(0, 0, 2)
local target = vector3.new(0, 0, 0)
local up = vector3.new(0, 1, 0)
local viewMatrix = matrix4.lookAt(eye, target, up)
local projMatrix = matrix4.perspective(maths.degreesToRadians(45.0), aspectRatio, 1, 100)
local orthoMatrix = matrix4.orthoOffCenter(0, renderGetWidth(), 0, renderGetHeight(), 1, 100)

graphics.disableScissor()
graphics.cullingMode(graphics.CullingMode['None'])
graphics.clear(true, 1.0, true, 0, true, backgroundColor)


-------------------------------------------------------------------------------------------------- 	

	ball.x = ball.x + ball.vel.x
	ball.y = ball.y + ball.vel.y

	--map boundaries
	if ball.x >= (map.width + map.offset) - ball.width then
		b.score = b.score + 1
		sound.play(scores)
		ball:reset()
	end
	if ball.x <= map.offset then
		a.score = a.score + 1
		sound.play(scores)
		ball:reset()
	end

	--walls bounce
	if ball.y <= map.offset then
		ball:bounce(1, -1)
		sound.play(wallhit)
	end
	if ball.y >= (map.height + map.offset) - ball.height then
		ball:bounce(1, -1)
		sound.play(wallhit)
	end

	--paddles bounces
	if ball.x > a.x - ball.width and ball.y <= a.y + a.height and ball.y >= a.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x - 10
		sound.play(paddlehit)
	end 
	if ball.x < b.x + 5 and ball.y <= b.y + b.height and ball.y >= b.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x + 10
		sound.play(paddlehit)
	end

	-- --keys testing
     if (controller.isButtonHeld(0, controller.Button['LeftTrigger']))and a.y > map.offset then
		 a.y = a.y - 2
     end
     if (controller.isButtonHeld(0, controller.Button['RightTrigger'])) and a.y + a.height < map.height + map.offset then
		 a.y = a.y + 2
     end
     if (controller.isButtonHeld(0, controller.Button['DpadDown'])) and b.y > map.offset then
		 b.y = b.y - 2
     end
     if (controller.isButtonHeld(0, controller.Button['DpadUp'])) and b.y + b.height < map.height + map.offset then
		 b.y = b.y + 2
     end


function ball:bounce(x, y)
		self.vel.x = x * self.vel.x
		self.vel.y = y * self.vel.y
end

function ball:reset()
	ball.x = 300
	ball.y = 200
	ball.vel = {}
	ball.vel.x = 5
	ball.vel.y = 1
	ball.height = 30
	ball.width = 30
end



--************************************************************************************************
-- Begin RenderScene Code.
--************************************************************************************************

if graphics.beginScene() then

-- Setup Lights
local lightPosition = vector4.new(0.0, 0.0, 2.0, 0.0);
local lightDiffuseColor = color4.new(1.0, 1.0, 1.0, 0.0)

graphics.setAmbientLight(color3.new(0.3, 0.3, 0.3))
--graphics.setAmbientLight(color3.new(0.02, 0.02, 0.02))
--graphics.setAmbientLight(color3.new(0.6, 0.6, 0.6))		
graphics.enableLight(1, lightPosition, 4.0, lightDiffuseColor)
graphics.disableLight(2);
graphics.disableLight(3);
graphics.disableLight(4);
graphics.disableLights();		
		
-------------------------------------------------------------------------------------------------- 

-- Background 2D Wallpaper
if Background2DWallpapper =="On" then
graphics.setModelMatrix(orthoModelMatrix)
graphics.setViewMatrix(viewMatrix)
graphics.setProjectionMatrix(orthoMatrix)
graphics.activateTexture(backgroundTextureId);
graphics.activateMesh(backgroundMeshId, 0);
graphics.drawMesh(0, 6)
end
-------------------------------------------------------------------------------------------------- 
		
-- Background Overlays example		

if BackgroundOverlay == "On" then
graphics.setModelMatrix(orthoModelMatrix)
graphics.setViewMatrix(viewMatrix)
graphics.setProjectionMatrix(orthoMatrix)
graphics.activateTexture(overlayTextureId);
graphics.activateMesh(screenMeshId, 1);
graphics.drawMesh(0, 6)
end
		
-------------------------------------------------------------------------------------------------- 
				
-- Overlay
graphics.setModelMatrix(orthoModelMatrix)
graphics.setViewMatrix(viewMatrix)
graphics.setProjectionMatrix(orthoMatrix)
		
-------------------------------------------------------------------------------------------------- 

-- Memory + FPS		
-- sysinfo.getMemory()
-- sysinfo.getFps(dt)
-- sysinfo.getDriveInfo()
-- sysinfo.getSysInfo()
		
-------------------------------------------------------------------------------------------------- 

graphics.setColorTint(TextColour1Default)

graphics.drawNinePatch(buttonTextureId, vector3.new(ball.x, ball.y, 0.0), ball.width, ball.height, 0.25, 0.25)
	--love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
	--love.graphics.rectangle("line", map.offset, map.offset, map.width, map.height)

	--draw paddles
graphics.drawNinePatch(buttonTextureId, vector3.new(a.x, a.y, 0.0), a.width, a.height, 0.25, 0.25)
	--love.graphics.rectangle("fill", a.x, a.y, a.width, a.height)
graphics.drawNinePatch(buttonTextureId, vector3.new(b.x, b.y, 0.0), b.width, b.height, 0.25, 0.25)
	--love.graphics.rectangle("fill", b.x, b.y, b.width, b.height)

	--love.graphics.setFont(scoreFont)
	--draw score
	
local textPosition1 = vector3.new(65, 300, 0).invertY(graphics.getHeight())
graphics.setColorTint(color4.new(255/255, 125/255, 180/255, 1.0))
graphics.drawFont(fontId, textPosition1, b.score .. " - " .. a.score )
graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0))
	
	--love.graphics.print(b.score .. " - " .. a.score, 280, 40)


graphics.endScene()
graphics.swapBuffers()
end

-------------------------------------------------------------------------------------------------- 
	
--************************************************************************************************ 
-- Music Control
--************************************************************************************************ 
	
--musiccontrol.controls()
	
-------------------------------------------------------------------------------------------------- 
end

print("done")
