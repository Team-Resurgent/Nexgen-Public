require("global:Globals")
local sysinfo = require ("scripts:sysinfo")

local backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\background720.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(screenMeshId, 0)




--fontId = graphics.loadFont("assets:fonts\\Mobile_39px.fnt")
--fontId = graphics.loadFont("assets:fonts\\Mobile_59px.fnt")
fontId = graphics.loadFont("assets:fonts\\Mobile_79px.fnt")


local PlayerLeftImg, PlayerLeftImgWidth, PlayerLeftImgHeight = graphics.loadTexture("assets:images\\game\\planeleft.png"), 118, 84
local PlayerMiddleImg, PlayerMiddleImgWidth, PlayerMiddleImgHeight = graphics.loadTexture("assets:images\\game\\planemiddle.png"), 118, 84
local PlayerRightImg, PlayerRightImgWidth, PlayerRightImgHeight = graphics.loadTexture("assets:images\\game\\planeright.png"), 118, 84

local PlayerBulletImg, PlayerBulletImgWidth, PlayerBulletImgHeight = graphics.loadTexture("assets:images\\game\\playerbullet.png"), 10, 26


local PlaneLMRTrack = 2
PressStartArray = {}
local PressStartArrayLength = 5


PressStartTrack = 1
LetterP = 1

Player = {x = renderGetWidth() / 2, y = 20, speed = 400, img = nil}

PlayerBulletsL, PlayerBulletsR = {}, {}
CanShoot = true
CanShootTimerMax = 0.2
CanShootTimer = CanShootTimerMax

DisplayTextStart = 0
DisplayTextCheck = " "


function DisplayText(DisplayTextHigh, DisplayTextLow, DisplayTextSpeed, DisplayTextPhrase, dt)
  if DisplayTextCheck ~= DisplayTextPhrase then
    DisplayTextStart = 0
  end

  if DisplayTextStart == 0 then
    DisplayTextColourCount = 1
	DisplayTextColourSpeed = 0
    DisplayTextStart = 1
	DisplayTextCheck = DisplayTextPhrase
    DisplayTextLength = string.len(DisplayTextPhrase)
    DisplayTextWidth = graphics.measureFont(fontId, DisplayTextPhrase) - DisplayTextLength    
    DisplayTextPositionX, DisplayTextPositionY = (renderGetWidth() / 2) - (DisplayTextWidth / 2), renderGetHeight() / 2
	DisplayTextLetterA, DisplayTextLetterB, DisplayTextLetterC, DisplayTextLetterD = {}, {}, {}, {}
	for DisplayTextStartPosition = 1, DisplayTextLength do
      DisplayTextLetterA[DisplayTextStartPosition] = string.sub(DisplayTextPhrase, DisplayTextStartPosition, DisplayTextStartPosition)
	  DisplayTextLetterB[DisplayTextStartPosition], DisplayTextLetterC[DisplayTextStartPosition] = DisplayTextHigh, math.random(DisplayTextLow, DisplayTextHigh)
    end
  end

  DisplayTextPostion = 0 
   
  for DisplayTextAnimation = 1, DisplayTextLength do
    if DisplayTextLetterB[DisplayTextAnimation] == DisplayTextHigh and DisplayTextLetterC[DisplayTextAnimation] < DisplayTextHigh then
	  DisplayTextLetterC[DisplayTextAnimation] = DisplayTextLetterC[DisplayTextAnimation] + math.random(1, DisplayTextSpeed) * dt
    elseif DisplayTextLetterB[DisplayTextAnimation] == DisplayTextHigh then
      DisplayTextLetterB[DisplayTextAnimation] = DisplayTextLow
    elseif DisplayTextLetterB[DisplayTextAnimation] == DisplayTextLow and DisplayTextLetterC[DisplayTextAnimation] > DisplayTextLow then
	  DisplayTextLetterC[DisplayTextAnimation] = DisplayTextLetterC[DisplayTextAnimation] - math.random(1, DisplayTextSpeed) * dt
    elseif DisplayTextLetterB[DisplayTextAnimation] == DisplayTextLow then
      DisplayTextLetterB[DisplayTextAnimation] = DisplayTextHigh	
    end
  end
  
  DisplayTextColour = {}
  DisplayTextColour[0] = color4.new(0/255, 0/255, 0/255, 1.0) -- Black
  DisplayTextColour[1] = color4.new(228/255, 3/255, 3/255, 1.0) -- Red
  DisplayTextColour[2] = color4.new(255/255, 140/255, 0/255, 1.0) -- Orange
  DisplayTextColour[3] = color4.new(255/255, 237/255, 0/255, 1.0) -- Yellow
  DisplayTextColour[4] = color4.new(0/255, 128/255, 38/255, 1.0) -- Green
  DisplayTextColour[5] = color4.new(0/255, 77/255, 255/255, 1.0) -- Blue
  DisplayTextColour[6] = color4.new(117/255, 7/255, 135/255, 1.0) -- Purple
  
  for DisplayTextRender = 1, DisplayTextLength do
    if DisplayTextColourSpeed == 0 then
      if DisplayTextLetterA[DisplayTextRender] ~= " " then
	    DisplayTextLetterD[DisplayTextRender] = DisplayTextColourCount
	    DisplayTextColourCount = DisplayTextColourCount + 1
	  elseif DisplayTextLetterA[DisplayTextRender] == " " then
	    DisplayTextLetterD[DisplayTextRender] = 0
	  end
	  if DisplayTextColourCount >= #DisplayTextColour + 1 then
	    DisplayTextColourCount = 1
	  end
    end
	graphics.setColorTint(DisplayTextColour[DisplayTextLetterD[DisplayTextRender]])
    graphics.drawFont(fontId, vector3.new(DisplayTextPositionX + DisplayTextPostion, DisplayTextPositionY + DisplayTextLetterC[DisplayTextRender], 0),DisplayTextLetterA[DisplayTextRender])
	DisplayTextPostion = DisplayTextPostion + (graphics.measureFont(fontId, DisplayTextLetterA[DisplayTextRender]) / 2)
  end
	
	DisplayTextColourSpeed = DisplayTextColourSpeed + 1
	if DisplayTextColourSpeed >= 250 * dt then
	  DisplayTextColourSpeed = 0
	end
	
  graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0)) -- Default colour back to white
end

graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0)) -- Default colour back to white

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

        -- Background wallpaper example
        graphics.activateTexture(backgroundTextureId);
        graphics.activateMesh(screenMeshId, 0);
        graphics.drawMesh(0, 6)
        
        -- Message
    
	
	
    --fontId = graphics.loadFont("assets:fonts\\Mobile_79px.fnt")
	
	DisplayText(5, -5, 100, "Press Start To Attack!",dt)
	
	--fontId = graphics.loadFont("assets:fonts\\Mobile_39px.fnt")


  if (controller.isButtonHeld(0, controller.Button['DpadLeft'])) then
    PlaneLMRTrack = 1
	if Player.x > 20 then
      Player.x = Player.x - (Player.speed*dt)
    end  
  elseif (controller.isButtonHeld(0, controller.Button['DpadRight'])) then
    PlaneLMRTrack = 3
	if Player.x < (renderGetWidth() - PlayerMiddleImgWidth - 20) then
      Player.x = Player.x + (Player.speed*dt)
    end
  end	
  if (controller.isButtonHeld(0, controller.Button['DpadDown'])) then
    if Player.y > 20 then
      Player.y = Player.y - (Player.speed*dt)
    end
  elseif (controller.isButtonHeld(0, controller.Button['DpadUp'])) then
    if Player.y < ((renderGetHeight() / 2) - PlayerMiddleImgHeight) then
      Player.y = Player.y + (Player.speed*dt)
    end
  end


--************************************************************************************************ 
-- Create Player Bullet And Play Sound
--************************************************************************************************  

--and CanShoot and IsAlive

  if (controller.isButtonHeld(0, controller.Button['A'])) and CanShoot then
    if PlaneLMRTrack == 1 then
	  newPlayerBulletsL = {x = Player.x + 28, y = Player.y + 32 + PlayerBulletImgHeight, img = nil}
	elseif PlaneLMRTrack > 1 then
	  newPlayerBulletsL = {x = Player.x + 24, y = Player.y + 32 + PlayerBulletImgHeight, img = nil}
	end
	if PlaneLMRTrack < 3 then
	  newPlayerBulletsR = {x = Player.x + 85, y = Player.y + 32 + PlayerBulletImgHeight, img = nil}
	elseif PlaneLMRTrack == 3 then
	  newPlayerBulletsR = {x = Player.x + 81, y = Player.y + 32 + PlayerBulletImgHeight, img = nil}
	end
    table.insert(PlayerBulletsL, newPlayerBulletsL)
	table.insert(PlayerBulletsR, newPlayerBulletsR)
	CanShoot = false
    CanShootTimer = CanShootTimerMax
	--sound.play(GunSound)
  end

  CanShootTimer = CanShootTimer - (1 * dt)
  if CanShootTimer < 0 then
    CanShoot = true
  end

  for i,bullet in ipairs(PlayerBulletsL) do
    bullet.y = bullet.y + (800*dt) 
    if bullet.y > renderGetHeight() then -- remove bullet if is out of screen
      table.remove(PlayerBulletsL, i)
    end
  end
  
  for i,bullet in ipairs(PlayerBulletsR) do
    bullet.y = bullet.y + (800*dt)
    if bullet.y > renderGetHeight() then -- remove bullet if is out of screen
      table.remove(PlayerBulletsR, i)
    end
  end


  for i,bullet in ipairs(PlayerBulletsL) do
    graphics.drawNinePatch(PlayerBulletImg, vector3.new(bullet.x, bullet.y, 0.0), PlayerBulletImgWidth, PlayerBulletImgHeight, 0.0, 0.0)	   
  end
  
  for i,bullet in ipairs(PlayerBulletsR) do
    graphics.drawNinePatch(PlayerBulletImg, vector3.new(bullet.x, bullet.y, 0.0), PlayerBulletImgWidth, PlayerBulletImgHeight, 0.0, 0.0)
  end



  if PlaneLMRTrack == 1 then
    graphics.drawNinePatch(PlayerLeftImg, vector3.new(Player.x, Player.y, 0.0), PlayerMiddleImgWidth, PlayerMiddleImgHeight, 0.0, 0.0)
	PlaneLMRTrack = 2
  elseif PlaneLMRTrack == 2 then
	graphics.drawNinePatch(PlayerMiddleImg, vector3.new(Player.x, Player.y, 0.0), PlayerMiddleImgWidth, PlayerMiddleImgHeight, 0.0, 0.0)
  elseif PlaneLMRTrack == 3 then
	graphics.drawNinePatch(PlayerRightImg, vector3.new(Player.x, Player.y, 0.0), PlayerMiddleImgWidth, PlayerMiddleImgHeight, 0.0, 0.0)
	PlaneLMRTrack = 2
  end

   
  


  sysinfo.getFps(dt)
  --sysinfo.getMemory(dt)
  graphics.endScene()
  graphics.swapBuffers()
end

print("done")