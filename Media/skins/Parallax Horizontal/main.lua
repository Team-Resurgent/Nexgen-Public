--************************************************************************************************
--
--************************************************************************************************
require("global:Globals")
local sysinfo = require("scripts:sysinfo")

--************************************************************************************************
--
--************************************************************************************************

backgroundTextureId1 = {Layer = graphics.loadTexture("assets:images\\backgrounds\\far-buildings.png"), x = 0, y = 0}
backgroundTextureId2 = {Layer = graphics.loadTexture("assets:images\\backgrounds\\back-buildings.png"), x = 0, y = 0}
backgroundTextureId3 = {Layer = graphics.loadTexture("assets:images\\backgrounds\\foreground.png"), x = 0, y = 0}

backgroundTextureId1.Width, backgroundTextureId1.Height = graphics.getTextureSize(backgroundTextureId1.Layer)
backgroundTextureId2.Width, backgroundTextureId2.Height = graphics.getTextureSize(backgroundTextureId2.Layer)
backgroundTextureId3.Width, backgroundTextureId3.Height = graphics.getTextureSize(backgroundTextureId3.Layer)

backgroundTextureId1.Scale = math.floor(renderGetHeight() / backgroundTextureId1.Height)
backgroundTextureId2.Scale = math.floor(renderGetHeight() / backgroundTextureId2.Height)
backgroundTextureId3.Scale = math.floor(renderGetHeight() / backgroundTextureId3.Height)

backgroundTextureId1.y = renderGetHeight() - (backgroundTextureId1.Height * backgroundTextureId1.Scale)

--Set Variabled for Parallax Background Scrolling
VerticalUp, VerticalDown, HorizontalLeft, HorizontalRight = 0, 1, 2, 3

fontId1 = graphics.loadFont("assets:fonts\\Mobile_39px.fnt")

function ParallaxScrolling(background, parallaxDirection, parallaxSpeed, dt)
  if parallaxDirection == VerticalUp then
    -- Parallax background scrolling Vertical Up
    background.y = background.y + parallaxSpeed * dt
    if background.y > 0 then
      background.y = background.y - renderGetHeight()
    end
    direction = vector3.new(background.x, background.y + renderGetHeight(), 0.0)
  elseif parallaxDirection == VerticalDown then
    -- Parallax background scrolling Vertical Down
    background.y = background.y - parallaxSpeed * dt
    if background.y < 0 then
      background.y = background.y + renderGetHeight()
    end
    direction = vector3.new(background.x, background.y - renderGetHeight(), 0.0)
  
  elseif parallaxDirection == HorizontalLeft then
    -- Parallax background scrolling Horizontal Left
    background.x = background.x - parallaxSpeed * dt
    if background.x < 0 then
      background.x = background.x + (background.Width * background.Scale)
	  --print("looped")
    end
    direction = vector3.new(background.x - (background.Width * background.Scale) , background.y, 0.0)
	--print("Started")
	
	-- if background.x > (background.Width * background.Scale) then
      -- direction = vector3.new(background.x - (background.Width * background.Scale) , background.y, 0.0)
	  -- print("looped")
    -- end
  
	elseif parallaxDirection == HorizontalRight then
    -- Parallax background scrolling Horizontal Right
    background.x = background.x + parallaxSpeed * dt
    if background.x > 0 then
      background.x = background.x - renderGetWidth()
    end
    direction = vector3.new(background.x + renderGetWidth(), background.y, 0.0) 
  end

--print(renderGetWidth() - (background.Width * background.Scale))

  graphics.activateTexture(background.Layer, graphics.Filter['Nearest'])
  graphics.drawQuad(vector3.new(background.x, background.y, 0.0), background.Width * background.Scale, background.Height * background.Scale)

  graphics.activateTexture(background.Layer, graphics.Filter['Nearest'])
  graphics.drawQuad(direction, background.Width * background.Scale, background.Height * background.Scale)
  
end

graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0)) -- Default colour back to white

function onRender(dt)
  local eye = vector3.new(0, 0, 2)
  local target = vector3.new(0, 0, 0)
  local up = vector3.new(0, 1, 0)
  local modelMatrix = matrix4.new()
  local viewMatrix = matrix4.lookAt(eye, target, up)
  local orthoMatrix = matrix4.orthoOffCenter(0, graphics.getWidth(), 0, graphics.getHeight(), 1, 100)
  
  graphics.setModelMatrix(modelMatrix)
  graphics.setViewMatrix(viewMatrix)
  graphics.setProjectionMatrix(orthoMatrix)
  
  graphics.disableDepthTest()
  graphics.clear(true, 1.0, true, 0, true, color4.new(0.227, 0.227, 0.227, 1.0))

  -- Parallax Background
  -- Set Scroll Direction (VerticalUp, VerticalDown,  HorizontalLeft, HorizontalRight)
  -- Speed

  ParallaxScrolling(backgroundTextureId1, HorizontalLeft, 20, dt)
  ParallaxScrolling(backgroundTextureId2, HorizontalLeft, 40, dt)
  ParallaxScrolling(backgroundTextureId3, HorizontalLeft, 60, dt)
  
  sysinfo.getFps(fontId1, 165, 20, 15, dt)
  --sysinfo.getMemory(fontId1, 20, 20, 10, dt)
  graphics.endScene()
  graphics.swapBuffers()
end

print("done")
