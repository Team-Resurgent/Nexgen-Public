--###############################################################################################

-- A port of Tetris game clone created by Peter Szollosi, 2016.

-- Author: Team Resurgent.
-- 29/09/2021.

-- The following are shortcut paths to the root folder of current skin.
-- media: skin: scripts: audio: assets:

--###############################################################################################

--###############################################################################################
-- All code below is called exactly once at the beginning of the script
--###############################################################################################

require("global:Globals")
local sysinfo = require("scripts:sysinfo")

local soundIndex2 = sound.load("audio:tetris.ogg")
sound.play(soundIndex2)

--************************************************************************************************
-- Define & Load Fonts.
--************************************************************************************************

fontId = graphics.loadFont("assets:fonts\\Arial_Black_20px.fnt")

--------------------------------------------------------------------------------------------------

local Pixel = graphics.loadTexture("assets:images\\pixel\\Pixel.png")

local blockSize = 28
local areaWidth = 35
local areaHeight = 25

local shapes = {
  {
    {0, 1, 0},
    {1, 1, 0},
    {0, 1, 0}
  },
  {
    {0, 0, 1, 0},
    {0, 0, 1, 0},
    {0, 0, 1, 0},
    {0, 0, 1, 0}
  },
  {
    {1, 1},
    {1, 1}
  },
  {
    {1, 0, 0},
    {1, 1, 0},
    {0, 1, 0}
  },
  {
    {0, 1, 0},
    {1, 1, 0},
    {1, 0, 0}
  },
  {
    {1, 1, 0},
    {0, 1, 0},
    {0, 1, 0}
  },
  {
    {0, 1, 0},
    {0, 1, 0},
    {1, 1, 0}
  }
}

local colors = {
  {1.0, 0.1, 0.1},
  {0.1, 0.9, 0.1},
  {0.1, 0.4, 1.0},
  {1.0, 0.7, 0.1},
  {0.1, 0.7, 0.9},
  {0.9, 0.0, 0.4},
  {0.7, 0.1, 1.0},
  {1.0, 1.0, 1.0}
}

local shape
local shapePosX
local shapePosY
local shapeFall
local nextShape

local blocks

local score
local lines
local level
local gameOver

local timer
local interval = 0.05
local controlTimer
local controlInterval = 0.07
local collectTimer
local collectInterval = 0.15

function resetShape()
  local shapeType
  local shapeRot

  if nextShape ~= nil then
    -- Copy next shape
    shapeType = nextShape.type
    shapeRot = nextShape.rot
  else
    -- Generate new
    shapeType = math.random(1, #shapes)
    shapeRot = math.random(1, 4)
  end

  shape = createShape(shapeType, shapeRot)
  shapePosX = math.floor(areaWidth / 2 - (shape.maxX - shape.minX) / 2 - shape.minX + 0.5)
  shapePosY = -shape.minY + 1
  shapeFall = 0

  -- Randomize next shape
  local nextShapeType = math.random(1, #shapes)
  local nextShapeRot = math.random(1, 4)
  nextShape = createShape(nextShapeType, nextShapeRot)

  -- Check if there is no room left
  if isShapeColliding(shapePosX, shapePosY) then
    gameOver = true
  end
end

function restart()
  gameOver = false
  clearBlocks()
  nextShape = nil
  resetShape()
  score = 0
  lines = 0
  level = 0
  timer = 0
  controlTimer = 0
  collectTimer = 0
end

function clearBlocks()
  blocks = {}

  for j = 1, areaHeight do
    blocks[j] = {}

    for i = 1, areaWidth do
      blocks[j][i] = 0
    end
  end
end

function saveShape()
  for j = 1, shape.length do
    for i = 1, shape.length do
      if shape.data[j][i] == 1 then
        local x = shapePosX + i
        local y = shapePosY + j

        -- Copy shape into blocks if inside the area
        if x >= 1 and x <= areaWidth and y >= 1 and y <= areaHeight then
          blocks[y][x] = shape.type
        end
      end
    end
  end
end

function markBlocks()
  -- Create temporary blocks
  local temp = {}

  for j = 1, areaHeight do
    temp[j] = {}

    for i = 1, areaWidth do
      temp[j][i] = 0
    end
  end

  -- Mark blocks for collecting
  local marked = false

  for j = areaHeight, 1, -1 do
    local mark = true

    for i = 1, areaWidth do
      if blocks[j][i] == 0 then
        mark = false
        break
      end
    end

    if mark then
      for i = 1, areaWidth do
        temp[j][i] = 8
      end
      lines = lines + 1
      score = score + areaWidth * 10
      marked = true
    else
      for i = 1, areaWidth do
        temp[j][i] = blocks[j][i]
      end
    end
  end

  -- Level up
  if marked then
    score = score + (level + 1) * areaWidth * 10
    level = level + 1
    collectTimer = 0
  end

  -- Copy temporary blocks
  for j = 1, areaHeight do
    for i = 1, areaWidth do
      blocks[j][i] = temp[j][i]
    end
  end
end

function collectBlocks()
  -- Create temporary blocks
  local temp = {}

  for j = 1, areaHeight do
    temp[j] = {}

    for i = 1, areaWidth do
      temp[j][i] = 0
    end
  end

  -- Collect blocks
  local row = areaHeight

  for j = areaHeight, 1, -1 do
    local copy = false

    for i = 1, areaWidth do
      if blocks[j][i] < 8 then
        copy = true
        break
      end
    end

    if copy then
      for i = 1, areaWidth do
        temp[row][i] = blocks[j][i]
      end
      row = row - 1
    end
  end

  -- Copy temporary blocks
  for j = 1, areaHeight do
    for i = 1, areaWidth do
      blocks[j][i] = temp[j][i]
    end
  end
end

function createShape(t, r)
  local shape = {
    type = t,
    rot = r,
    length = #shapes[t][1],
    minX = 100,
    maxX = -100,
    minY = 100,
    maxY = -100,
    data = {}
  }

  for y = 1, shape.length do
    shape.data[y] = {}

    for x = 1, shape.length do
      local u = x
      local v = y

      -- Rotated shape coordinates
      if r == 2 then
        u = y
        v = shape.length - x + 1
      elseif r == 3 then
        u = shape.length - x + 1
        v = shape.length - y + 1
      elseif r == 4 then
        u = shape.length - y + 1
        v = x
      end

      -- Copy rotated shape
      shape.data[y][x] = shapes[t][v][u]

      -- Check shape min and max values
      if shape.data[y][x] == 1 then
        if x < shape.minX then
          shape.minX = x
        end
        if x > shape.maxX then
          shape.maxX = x
        end
        if y < shape.minY then
          shape.minY = y
        end
        if y > shape.maxY then
          shape.maxY = y
        end
      end
    end
  end

  return shape
end

function isShapeColliding(x, y)
  -- Check the boundaries
  local minX = -shape.minX + 1
  local minY = -shape.minY + 1
  local maxX = areaWidth - shape.maxX
  local maxY = areaHeight - shape.maxY
  if x < minX then
    return true
  end
  if y < minY then
    return true
  end
  if x > maxX then
    return true
  end
  if y > maxY then
    return true
  end

  -- Check if any of its blocks are colliding
  for j = 1, shape.length do
    for i = 1, shape.length do
      if shape.data[j][i] == 1 then
        local px = x + i
        local py = y + j

        if px >= 1 and px <= areaWidth and py >= 1 and py <= areaHeight and blocks[py][px] > 0 then
          return true
        end
      end
    end
  end

  return false
end

restart()

--###############################################################################################

--###############################################################################################
-- All code located in the onRender callback function is used to update the state of the game
-- every frame (dt).

-- Do not use loadTexture, loadFont, loadMeshCollection, sound.load or any other load commands
-- here as this will cause the file to continuously load a new instance in memory,(leak).
--#############################################################################################

function onRender(dt)
  controlTimer = controlTimer + dt
  if controlTimer >= controlInterval then
    controlTimer = 0

    -- Move shape
    if (controller.isButtonHeld(0, controller.Button["DpadLeft"])) and not isShapeColliding(shapePosX - 1, shapePosY) then
      shapePosX = shapePosX - 1
    end

    if (controller.isButtonHeld(0, controller.Button["DpadRight"])) and not isShapeColliding(shapePosX + 1, shapePosY) then
      shapePosX = shapePosX + 1
    end

    if (controller.isButtonHeld(0, controller.Button["DpadDown"])) and not isShapeColliding(shapePosX, shapePosY + 1) then
      shapePosY = shapePosY + 1
      score = score + 10
    end
  end

  if (controller.isButtonDown(0, controller.Button["Start"])) and gameOver then
    restart()
  end
  if (controller.isButtonDown(0, controller.Button["Back"])) then
    restart()
  end

  -- Rotate the shape
  if (controller.isButtonDown(0, controller.Button["A"])) then
    -- Save current stats
    local oldShapePosX = shapePosX
    local oldShapePosY = shapePosY
    local oldShapeType = shape.type
    local oldShapeRot = shape.rot

    if gameOver then
      return
    end

    -- Try to rotate shape
    shape.rot = shape.rot + 1
    if shape.rot > 4 then
      shape.rot = 1
    end
    shape = createShape(shape.type, shape.rot)

    -- Check the boundaries
    local minX = -shape.minX + 1
    local minY = -shape.minY + 1
    local maxX = areaWidth - shape.maxX
    local maxY = areaHeight - shape.maxY
    if shapePosX < minX then
      shapePosX = minX
    end
    if shapePosY < minY then
      shapePosY = minY
    end
    if shapePosX > maxX then
      shapePosX = maxX
    end
    if shapePosY > maxY then
      shapePosY = maxY
    end

    -- Reset shape if collided
    if isShapeColliding(shapePosX, shapePosY) then
      shape = createShape(oldShapeType, oldShapeRot)
      shapePosX = oldShapePosX
      shapePosY = oldShapePosY
    end
  end

  -- Drop the shape
  if (controller.isButtonDown(0, controller.Button["B"])) then
    shapeFall = 0

    while not isShapeColliding(shapePosX, shapePosY + 1) do
      shapePosY = shapePosY + 1
      score = score + 10
    end
    saveShape()
    markBlocks()
    resetShape()
  end

  collectTimer = collectTimer + dt
  if collectTimer >= collectInterval then
    collectTimer = 0
    collectBlocks()
  end

  timer = timer + dt
  while timer >= interval do
    timer = timer - interval

    -- Check if shape is falling
    shapeFall = shapeFall + 1
    if shapeFall >= 20 - level then
      shapeFall = 0

      if isShapeColliding(shapePosX, shapePosY + 1) then
        saveShape()
        markBlocks()
        resetShape()
      else
        shapePosY = shapePosY + 1
        score = score + 10
      end
    end
  end

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

    graphics.clear(true, 1.0, true, 0, true, color4.new(0.1, 0.1, 0.1, 1.0))
    graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0)) -- Default color to white atleast once to render screen
    graphics.setModelMatrix(modelMatrix)
    graphics.setViewMatrix(viewMatrix)
    graphics.setProjectionMatrix(orthoMatrix)

    function drawBlock(t, x, y)
      graphics.setColorTint(
        color4.new(colors[t][1] * 120 / 255, colors[t][2] * 120 / 255, colors[t][3] * 120 / 255, 255 / 255)
      )
      graphics.activateTexture(Pixel)
      graphics.drawQuad(
        vector3.new(blockSize * x, blockSize * y, 0.0).invertY(graphics.getHeight()),
        blockSize,
        blockSize
      )

      graphics.setColorTint(
        color4.new(colors[t][1] * 255 / 255, colors[t][2] * 255 / 255, colors[t][3] * 255 / 255, 255 / 255)
      )

      graphics.drawQuad(
        vector3.new(blockSize * x + 2, blockSize * y - 2, 0.0).invertY(graphics.getHeight()),
        blockSize - 4,
        blockSize - 4
      )

      graphics.setColorTint(
        color4.new(colors[t][1] * 160 / 255, colors[t][2] * 160 / 255, colors[t][3] * 160 / 255, 255 / 255)
      )

      graphics.drawQuad(
        vector3.new(blockSize * x + 6, blockSize * y - 6, 0.0).invertY(graphics.getHeight()),
        blockSize - 12,
        blockSize - 12
      )
    end

    function drawShape(s, x, y)
      for j = 1, s.length do
        for i = 1, s.length do
          if s.data[j][i] == 1 then
            drawBlock(s.type, x + i - 1, y + j - 1)
          end
        end
      end
    end

    function drawArea()
      for j = 1, areaHeight do
        for i = 1, areaWidth do
          if blocks[j][i] == 0 then
            -- Draw empty block
            graphics.setColorTint(color4.new(20 / 255, 20 / 255, 20 / 255, 1))

            graphics.activateTexture(Pixel)
            graphics.drawQuad(
              vector3.new(blockSize * (i - 1) + 2, blockSize * (j - 1) + 2, 0.0).invertY(graphics.getHeight()),
              blockSize - 4,
              blockSize - 4
            )
          else
            -- Draw filled block
            drawBlock(blocks[j][i], i - 1, j - 1)
          end
        end
      end
    end

    function drawGUI()
      local sw = renderGetWidth()
      local aw = blockSize * areaWidth + 60

      local textNextPosition = vector3.new(aw, blockSize * 0.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textNextPosition, "NEXT: ")

      local textScorePosition = vector3.new(aw, blockSize * 7.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textScorePosition, "SCORE: ")

      local textLinesPosition = vector3.new(aw, blockSize * 11.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textLinesPosition, "LINES: ")

      local textLevelPosition = vector3.new(aw, blockSize * 15.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textLevelPosition, "LEVEL: ")

      local textscorePosition = vector3.new(aw, blockSize * 9, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textscorePosition, score)

      local textlinesPosition = vector3.new(aw, blockSize * 13, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textlinesPosition, lines)

      local textlevelPosition = vector3.new(aw, blockSize * 17, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textlevelPosition, level)

      local px = areaWidth + 3.5 - (nextShape.maxX - nextShape.minX) / 2 - nextShape.minX
      drawShape(nextShape, px, 3.5 - nextShape.minY)
    end

    if gameOver then
      local sw = renderGetWidth()
      local sh = renderGetHeight()
      local sw2, sh2 = sw / 2, sh / 2

      local textGameOverPosition = vector3.new(sw2, sh2 - blockSize * 3.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textGameOverPosition, "GAME OVER!")

      local textPressStartPosition = vector3.new(sw2, sh2 + blockSize * 2.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 0 / 255, 0 / 255, 1.0))
      graphics.drawFont(fontId, textPressStartPosition, "Press Start to restart!")

      local textscorePosition = vector3.new(sw2, sh2 - blockSize * 1.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textscorePosition, "Score: " .. score)

      local textlinesPosition = vector3.new(sw2, sh2 - blockSize * 0.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textlinesPosition, "Lines: " .. lines)

      local textlevelPosition = vector3.new(sw2, sh2 + blockSize * 0.5, 0).invertY(graphics.getHeight())
      graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))
      graphics.drawFont(fontId, textlevelPosition, "Level: " .. level)
    else
      drawArea()
      drawShape(shape, shapePosX, shapePosY)
      drawGUI()
    end
    sysinfo.getFps(fontId, 165, 0, 0, dt)
    graphics.endScene()
    graphics.swapBuffers()
  end
end
