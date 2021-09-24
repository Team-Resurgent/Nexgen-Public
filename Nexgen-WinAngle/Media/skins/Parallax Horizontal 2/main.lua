--************************************************************************************************
--
--************************************************************************************************
require("global:Globals")
local sysinfo = require("scripts:sysinfo")

--************************************************************************************************
--
--************************************************************************************************
print (graphics.getHeight())
if graphics.getHeight() > 440 and graphics.getHeight() < 481 then
  backgroundTextureId1 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\1.png")
  backgroundTextureId2 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\2.png")
  backgroundTextureId3 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\3.png")
  backgroundTextureId4 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\4.png")
  backgroundTextureId5 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\5.png")
  backgroundTextureId6 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\6.png")
  backgroundTextureId7 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\7.png")
  backgroundTextureId8 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\8.png")
  
elseif graphics.getHeight() > 680 and graphics.getHeight() < 721 then
  backgroundTextureId1 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\1.png")
  backgroundTextureId2 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\2.png")
  backgroundTextureId3 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\3.png")
  backgroundTextureId4 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\4.png")
  backgroundTextureId5 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\5.png")
  backgroundTextureId6 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\6.png")
  backgroundTextureId7 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\7.png")
  backgroundTextureId8 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\8.png")
elseif graphics.getHeight() > 1040 and graphics.getHeight() < 1081 then
  backgroundTextureId1 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\1.png")
  backgroundTextureId2 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\2.png")
  backgroundTextureId3 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\3.png")
  backgroundTextureId4 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\4.png")
  backgroundTextureId5 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\5.png")
  backgroundTextureId6 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\6.png")
  backgroundTextureId7 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\7.png")
  backgroundTextureId8 = graphics.loadTexture("assets:images\\backgrounds\\Layers\\8.png")
end
--local backgroundWidth, backgroundHeight = graphics.getTextureSize(backgroundTextureId)

-- This is the number of backgrounds
Layer1 = {x = 0, y = 0}
Layer2 = {x = 0, y = 0}
Layer3 = {x = 0, y = 0}
Layer4 = {x = 0, y = 0}
Layer5 = {x = 0, y = 0}
Layer6 = {x = 0, y = 0}
Layer7 = {x = 0, y = 0}
Layer8 = {x = 0, y = 0}

--Set Variabled for Parallax Background Scrolling
VerticalUp = 0
VerticalDown = 1
HorizontalLeft = 2
HorizontalRight = 3

--************************************************************************************************
--
--************************************************************************************************
fontId1 = graphics.loadFont("assets:fonts\\Mobile_39px.fnt")
fontId2 = graphics.loadFont("assets:fonts\\Mobile_59px.fnt")
fontId3 = graphics.loadFont("assets:fonts\\Mobile_79px.fnt")

--************************************************************************************************
--
--************************************************************************************************
local PlayerLeftImg, PlayerLeftImgWidth, PlayerLeftImgHeight = graphics.loadTexture("assets:images\\game\\planeleft.png"), 118, 84
local PlayerMiddleImg, PlayerMiddleImgWidth, PlayerMiddleImgHeight = graphics.loadTexture("assets:images\\game\\planemiddle.png"), 118, 84
local PlayerRightImg, PlayerRightImgWidth, PlayerRightImgHeight = graphics.loadTexture("assets:images\\game\\planeright.png"), 118, 84
local PlayerBulletImg, PlayerBulletImgWidth, PlayerBulletImgHeight = graphics.loadTexture("assets:images\\game\\playerbullet.png"), 10, 26

--************************************************************************************************
--
--************************************************************************************************
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

--************************************************************************************************
--
--************************************************************************************************
DisplayTextPhraseCheck, DisplayTextPaletteCheck = " ", 0

--************************************************************************************************
--
--************************************************************************************************
function DisplayText(DisplayTextHigh, DisplayTextLow, DisplayTextSpeed, DisplayTextPhrase, DisplayTextDirection, DisplayTextGlow, DisplayTextColourCycleSpeed,  DisplayTextPalette, dt)
  if DisplayTextPalette == 1 then
    DisplayTextColour = {}
    DisplayTextColour[0] = color4.new(0 / 255, 0 / 255, 0 / 255, 1.0) -- Black (Must Always Be Here)
    DisplayTextColour[1] = color4.new(228 / 255, 3 / 255, 3 / 255, 1.0) -- Red
    DisplayTextColour[2] = color4.new(255 / 255, 140 / 255, 0 / 255, 1.0) -- Orange
    DisplayTextColour[3] = color4.new(255 / 255, 237 / 255, 0 / 255, 1.0) -- Yellow
    DisplayTextColour[4] = color4.new(0 / 255, 128 / 255, 38 / 255, 1.0) -- Green
    DisplayTextColour[5] = color4.new(0 / 255, 77 / 255, 255 / 255, 1.0) -- Blue
    DisplayTextColour[6] = color4.new(117 / 255, 7 / 255, 135 / 255, 1.0) -- Purple
  elseif DisplayTextPalette == 2 then
    DisplayTextColour = {}
    DisplayTextColour[0] = color4.new(0 / 255, 0 / 255, 0 / 255, 1.0) -- Black  (Must Always Be Here)
    DisplayTextColour[1] = color4.new(0 / 255, 0 / 255, 0 / 255, 1.0) -- Black
    DisplayTextColour[2] = color4.new(228 / 255, 3 / 255, 3 / 255, 1.0) -- Red
  end

  if DisplayTextPhraseCheck ~= DisplayTextPhrase or DisplayTextPaletteCheck ~= DisplayTextPalette then
    DisplayTextPhraseCheck = DisplayTextPhrase
    DisplayTextPaletteCheck = DisplayTextPalette
    DisplayTextLength = string.len(DisplayTextPhrase)
    DisplayTextWidth = graphics.measureFont(fontId3, DisplayTextPhrase) - DisplayTextLength
    DisplayTextPositionX, DisplayTextPositionY = (renderGetWidth() / 2) - (DisplayTextWidth / 2), renderGetHeight() / 2
    DisplayTextLetterA, DisplayTextLetterB, DisplayTextLetterC, DisplayTextLetterD = {}, {}, {}, {}
    if DisplayTextLength % 2 == 1 or #DisplayTextColour % 2 == 1 then
      DisplayTextTotal = math.floor((DisplayTextLength * #DisplayTextColour) + 0.5)
    else
      DisplayTextTotal = math.floor((DisplayTextLength * (#DisplayTextColour / 2)) + 0.5)
    end

    DisplayTextColourSpeed = 0
    if DisplayTextDirection == "Forward" then
      DisplayTextColourAnimation = (DisplayTextTotal * 2) - DisplayTextLength
    elseif DisplayTextDirection == "Backward" then
      DisplayTextColourAnimation = 0
    end
    for DisplayTextTable = 1, DisplayTextLength do
      DisplayTextLetterA[DisplayTextTable] = string.sub(DisplayTextPhrase, DisplayTextTable, DisplayTextTable)
      DisplayTextLetterB[DisplayTextTable], DisplayTextLetterC[DisplayTextTable] =
      DisplayTextHigh,
      math.random(DisplayTextLow, DisplayTextHigh)
    end

    Count = {1, 1, 1}
    for DisplayTextColourTable = 1, DisplayTextTotal * 2 do
      DisplayTextLetterD[DisplayTextColourTable] = Count[1]
      DisplayTextLetterD[DisplayTextColourTable + (DisplayTextTotal * 2)] = #DisplayTextColour - Count[1] + 1
      Count[1], Count[2] = Count[1] + 1, Count[2] + 1
      if Count[1] > #DisplayTextColour then
        Count[1] = 1
      end
      if Count[2] > DisplayTextLength then
        Count[3] = Count[3] + 1
        Count[1], Count[2] = Count[3], 1
      end
    end
  end

  for DisplayTextAnimation = 1, DisplayTextLength do
    if
      DisplayTextLetterB[DisplayTextAnimation] == DisplayTextHigh and
        DisplayTextLetterC[DisplayTextAnimation] < DisplayTextHigh
     then
      DisplayTextLetterC[DisplayTextAnimation] =
        DisplayTextLetterC[DisplayTextAnimation] + math.random(1, DisplayTextSpeed) * dt
    elseif DisplayTextLetterB[DisplayTextAnimation] == DisplayTextHigh then
      DisplayTextLetterB[DisplayTextAnimation] = DisplayTextLow
    elseif
      DisplayTextLetterB[DisplayTextAnimation] == DisplayTextLow and
        DisplayTextLetterC[DisplayTextAnimation] > DisplayTextLow
     then
      DisplayTextLetterC[DisplayTextAnimation] =
        DisplayTextLetterC[DisplayTextAnimation] - math.random(1, DisplayTextSpeed) * dt
    elseif DisplayTextLetterB[DisplayTextAnimation] == DisplayTextLow then
      DisplayTextLetterB[DisplayTextAnimation] = DisplayTextHigh
    end
  end

  DisplayTextPostion = 0
  for DisplayTextRender = 1, DisplayTextLength do
    graphics.setColorTint(DisplayTextColour[DisplayTextLetterD[DisplayTextRender + DisplayTextColourAnimation]])
    graphics.drawFont(fontId3, vector3.new(DisplayTextPositionX + DisplayTextPostion, DisplayTextPositionY + DisplayTextLetterC[DisplayTextRender], 0), DisplayTextLetterA[DisplayTextRender])
    DisplayTextPostion = DisplayTextPostion + (graphics.measureFont(fontId3, DisplayTextLetterA[DisplayTextRender]) / 2)
  end

  if DisplayTextDirection == "Backward" and DisplayTextColourSpeed == 0 then
    if DisplayTextGlow == "Cycle" then
      DisplayTextColourAnimation = DisplayTextColourAnimation + DisplayTextLength
      if DisplayTextColourAnimation > (DisplayTextTotal * 2) - DisplayTextLength then
        DisplayTextColourAnimation = 0
      end
    end
  elseif DisplayTextDirection == "Forward" and DisplayTextColourSpeed == 0 then
    if DisplayTextGlow == "Cycle" then
      DisplayTextColourAnimation = DisplayTextColourAnimation - DisplayTextLength
      if DisplayTextColourAnimation < 0 then
        DisplayTextColourAnimation = (DisplayTextTotal * 2) - DisplayTextLength
      end
    end
  end

  DisplayTextColourSpeed = DisplayTextColourSpeed + 1
  if DisplayTextColourSpeed >= DisplayTextColourCycleSpeed * dt then
    DisplayTextColourSpeed = 0
  end

  graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0)) -- Default colour back to white
end


function ParallaxScrolling(layerID, background , parallaxDirection, parallaxSpeed, dt)
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
      background.x = background.x + renderGetWidth()
    end
    direction = vector3.new(background.x - renderGetWidth(), background.y, 0.0)	
  elseif parallaxDirection == HorizontalRight then
    -- Parallax background scrolling Horizontal Right
    background.x = background.x + parallaxSpeed * dt
    if background.x > 0 then
      background.x = background.x - renderGetWidth()
    end
    direction = vector3.new(background.x + renderGetWidth(), background.y, 0.0) 
  end

  graphics.drawNinePatch(layerID, vector3.new(background.x, background.y, 0.0), renderGetWidth(), renderGetHeight(), 0.0, 0.0)
  graphics.drawNinePatch(layerID, direction, renderGetWidth(), renderGetHeight(), 0.0, 0.0)
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

  ParallaxScrolling(backgroundTextureId1,Layer1,HorizontalLeft, 5, dt)
  ParallaxScrolling(backgroundTextureId2,Layer2,HorizontalLeft, 10, dt)
  ParallaxScrolling(backgroundTextureId3,Layer3,HorizontalLeft, 15, dt)
  ParallaxScrolling(backgroundTextureId4,Layer4,HorizontalLeft, 20, dt)
  ParallaxScrolling(backgroundTextureId5,Layer5,HorizontalLeft, 25, dt)
  ParallaxScrolling(backgroundTextureId6,Layer6,HorizontalLeft, 30, dt)
  ParallaxScrolling(backgroundTextureId7,Layer7,HorizontalLeft, 35, dt)
  ParallaxScrolling(backgroundTextureId8,Layer8,HorizontalLeft, 40, dt)
  
  -- Message

  --DisplayText Function Options
  --How Far To Move Letters Up
  --How Far To Move Letters Down
  --How Fast Letter Move Up And Down
  --Type Text To Display ("Text")
  --Render Text Left To Right Or Right To Left ("Forward" or "Backward")
  --Set Text To Cycle Colour Or Glow From One Colour To The Next ("Cycle" Or "Glow")
  --Set Speed Between Colour Change
  --Set Colour Palette, Other Colour Paletts Must Be Added To The Function

 --DisplayText(5, -5, 100, "Press Start To Attack!", "Forward", "Cycle", 250, 1, dt)

  if (controller.isButtonHeld(0, controller.Button["DpadLeft"])) then
    PlaneLMRTrack = 1
    if Player.x > 20 then
      Player.x = Player.x - (Player.speed * dt)
    end
  elseif (controller.isButtonHeld(0, controller.Button["DpadRight"])) then
    PlaneLMRTrack = 3
    if Player.x < (renderGetWidth() - PlayerMiddleImgWidth - 20) then
      Player.x = Player.x + (Player.speed * dt)
    end
  end
  if (controller.isButtonHeld(0, controller.Button["DpadDown"])) then
    if Player.y > 20 then
      Player.y = Player.y - (Player.speed * dt)
    end
  elseif (controller.isButtonHeld(0, controller.Button["DpadUp"])) then
    if Player.y < ((renderGetHeight() / 2) - PlayerMiddleImgHeight) then
      Player.y = Player.y + (Player.speed * dt)
    end
  end

  --************************************************************************************************
  -- Create Player Bullet And Play Sound
  --************************************************************************************************

  --and CanShoot and IsAlive

  if (controller.isButtonHeld(0, controller.Button["A"])) and CanShoot then
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

  for i, bullet in ipairs(PlayerBulletsL) do
    bullet.y = bullet.y + (800 * dt)
    if bullet.y > renderGetHeight() then -- remove bullet if is out of screen
      table.remove(PlayerBulletsL, i)
    end
  end

  for i, bullet in ipairs(PlayerBulletsR) do
    bullet.y = bullet.y + (800 * dt)
    if bullet.y > renderGetHeight() then -- remove bullet if is out of screen
      table.remove(PlayerBulletsR, i)
    end
  end

  for i, bullet in ipairs(PlayerBulletsL) do
    graphics.drawNinePatch(PlayerBulletImg, vector3.new(bullet.x, bullet.y, 0.0), PlayerBulletImgWidth, PlayerBulletImgHeight, 0.0, 0.0)
  end

  for i, bullet in ipairs(PlayerBulletsR) do
    graphics.drawNinePatch(PlayerBulletImg, vector3.new(bullet.x, bullet.y, 0.0), PlayerBulletImgWidth, PlayerBulletImgHeight, 0.0, 0.0)
  end

  if PlaneLMRTrack == 1 then
    --graphics.drawNinePatch(PlayerLeftImg, vector3.new(Player.x, Player.y, 0.0), PlayerMiddleImgWidth, PlayerMiddleImgHeight, 0.0, 0.0)
    PlaneLMRTrack = 2
  elseif PlaneLMRTrack == 2 then
    --graphics.drawNinePatch(PlayerMiddleImg, vector3.new(Player.x, Player.y, 0.0), PlayerMiddleImgWidth, PlayerMiddleImgHeight, 0.0, 0.0)
  elseif PlaneLMRTrack == 3 then
    --graphics.drawNinePatch(PlayerRightImg, vector3.new(Player.x, Player.y, 0.0), PlayerMiddleImgWidth, PlayerMiddleImgHeight, 0.0, 0.0)
    PlaneLMRTrack = 2
  end

  sysinfo.getFps(fontId1, 165, 20, 15, dt)
  --sysinfo.getMemory(fontId1, 20, 20, 10, dt)
  graphics.endScene()
  graphics.swapBuffers()
end

print("done")
