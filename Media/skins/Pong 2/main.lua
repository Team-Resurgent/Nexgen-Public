--###############################################################################################

-- Pong V2.0
-- Use the Dpad & Left + RIght triggers to move the Players on screen.

-- Author: Team Resurgent.
-- 19/09/2021.

-- The following are shortcut paths to the root folder of current skin.
-- media: skin: scripts: audio: assets:

--###############################################################################################

--###############################################################################################
-- All code below is called exactly once at the beginning of the script
--###############################################################################################

require("global:Globals")
local bouncingText = require("scripts:bouncingText")

--************************************************************************************************
-- Define & Load Game Assets. Player1 & Player2 texture & store width & height into variables.
--************************************************************************************************

local player1Img = graphics.loadTexture("assets:images\\paddles\\1.png")
player1ImgWidth, player1ImgHeight = graphics.getTextureSize(player1Img)

local player2Img = graphics.loadTexture("assets:images\\paddles\\2.png")
player2ImgWidth, player2ImgHeight = graphics.getTextureSize(player2Img)

local ballImg = graphics.loadTexture("assets:images\\balls\\ball.png")
ballImgWidth, ballImgHeight = graphics.getTextureSize(ballImg)

--************************************************************************************************
-- Define & Load Fonts.
--************************************************************************************************

fontId = graphics.loadFont("assets:fonts\\Mobile_39px.fnt")

--------------------------------------------------------------------------------------------------

--************************************************************************************************
-- Define & Load 2D Background.
--************************************************************************************************

local backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\universe.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(screenMeshId, 0)

--------------------------------------------------------------------------------------------------

--************************************************************************************************
-- Define & Load Audio.
--************************************************************************************************
local paddlehit = sound.load("audio:sounds\\paddle_hit.wav")
local wallhit = sound.load("audio:sounds\\wall_hit.wav")
local scores = sound.load("audio:sounds\\score.wav")

--------------------------------------------------------------------------------------------------

--************************************************************************************************
-- Create tables & Store X & Y Positions Movement Speed & Score .
--************************************************************************************************

player1 = {
      x = 0 + player1ImgWidth,
      y = renderGetHeight() - player1ImgHeight,
      speed = 500,
      score = 0
}

player2 = {
      x = renderGetWidth() - player2ImgWidth * 2,
      y = renderGetHeight() - player2ImgHeight,
      speed = 500,
      score = 0
}

--------------------------------------------------------------------------------------------------

--************************************************************************************************
-- Function to reset Ball position. Call on startup one to initialize then get called during game
--************************************************************************************************

function ballReset()
      ball = {
            x = renderGetWidth() / 2,
            y = renderGetHeight() / 2,
            velX = 8,
            velY = 3
      }
end

ballReset()

local autoAI = require("scripts:AI")

--------------------------------------------------------------------------------------------------

--###############################################################################################

--###############################################################################################
-- All code located in the onRender callback function is used to update the state of the game
-- every frame (dt).

-- Do not use loadTexture, loadFont, loadMeshCollection, sound.load or any other load commands
-- here as this will cause the file to continuously load a new instance in memory,(leak).
--###############################################################################################

function onRender(dt)
      --************************************************************************************************
      -- Check To See If User Has Pressed Start To Begin Game
      --************************************************************************************************

      if startGame == 1 then
            ball.x = ball.x + ball.velX
            ball.y = ball.y + ball.velY
      end

      --------------------------------------------------------------------------------------------------

      --************************************************************************************************
      -- Enable AI  AI = Player1 AI2 = Player2
      --************************************************************************************************
      
	  autoAI.AIupdate(dt)

      autoAI.AI2update(dt)

      --------------------------------------------------------------------------------------------------
	  
      --************************************************************************************************
      -- Bounce Ball Off Wall
      --************************************************************************************************

      if ball.y <= 0 then
            ball:bounce(1, -1)
            sound.play(wallhit)
      end
      if ball.y >= (renderGetHeight()) - ballImgHeight then
            ball:bounce(1, -1)
            sound.play(wallhit)
      end

      function ball:bounce(x, y)
            self.velX = x * self.velX
            self.velY = y * self.velY
      end

      --------------------------------------------------------------------------------------------------

      --************************************************************************************************
      -- Bounce Ball Off Player Paddle
      --************************************************************************************************

      if
            ball.x < (player1.x - player2ImgWidth) + ballImgWidth and ball.y <= player1.y + player1ImgHeight and
                  ball.y >= player1.y - ballImgHeight
       then
            ball:bounce(-1, 1)
            ball.x = ball.x + 10
            sound.play(paddlehit)
      end
      if ball.x > player2.x and ball.y <= player2.y + player2ImgHeight and ball.y >= player2.y - ballImgHeight then
            ball:bounce(-1, 1)
            ball.x = ball.x - 10
            sound.play(paddlehit)
      end

      --------------------------------------------------------------------------------------------------

      --************************************************************************************************
      -- Ball Out Of Bounds, Update Score & Reset Ball
      --************************************************************************************************

      if ball.x <= 0 then
            player1.score = player1.score + 1
            sound.play(scores)
            ballReset()
      end

      if ball.x >= (renderGetWidth()) - ballImgWidth then
            player2.score = player2.score + 1
            sound.play(scores)
            ballReset()
      end

      --------------------------------------------------------------------------------------------------

      --************************************************************************************************
      -- Controller Settings For Player Paddle Movement
      --************************************************************************************************

      if (controller.isButtonHeld(0, controller.Button["DpadDown"])) and player1.y ~= 0 then
            player1.y = player1.y - (player1.speed * dt)
            if player1.y < 0 then
                  player1.y = 0
            end
      end
      if
            (controller.isButtonHeld(0, controller.Button["DpadUp"])) and
                  player1.y ~= (renderGetHeight() - player1ImgHeight)
       then
            player1.y = player1.y + (player1.speed * dt)

            if player1.y > (renderGetHeight() - player1ImgHeight) then
                  player1.y = (renderGetHeight() - player1ImgHeight)
            end
      end

      if (controller.isButtonDown(0, controller.Button["Start"])) then
            startGame = 1
      end

      if (controller.isButtonHeld(0, controller.Button["RightTrigger"])) and player2.y ~= 0 then
            player2.y = player2.y - (player2.speed * dt)
            if player2.y < 0 then
                  player2.y = 0
            end
      end

      if
            (controller.isButtonHeld(0, controller.Button["LeftTrigger"])) and
                  player2.y ~= (renderGetHeight() - player2ImgHeight)
       then
            player2.y = player2.y + (player2.speed * dt)
            if player2.y > (renderGetHeight() - player2ImgHeight) then
                  player2.y = (renderGetHeight() - player2ImgHeight)
            end
      end

      --------------------------------------------------------------------------------------------------

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

            graphics.clear(true, 1.0, true, 0, true, color4.new(0.227, 0.227, 0.227, 1.0))
            graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0)) -- Default color to white atleast once to render screen
            graphics.setModelMatrix(modelMatrix)
            graphics.setViewMatrix(viewMatrix)
            graphics.setProjectionMatrix(orthoMatrix)

            --------------------------------------------------------------------------------------------------

            --************************************************************************************************
            -- Render 2D Background Onto Screen
            --************************************************************************************************

            graphics.activateTexture(backgroundTextureId)
            graphics.activateMesh(screenMeshId, 0)
            graphics.drawMesh(0, 6)

            --------------------------------------------------------------------------------------------------

            --************************************************************************************************
            -- Display Start Message.
            --************************************************************************************************

            if startGame ~= 1 then
                  bouncingText.DisplayText(fontId, 5, -5, 100, "Press Start To Play!", "Backward", "Cycle", 250, 1, dt)
            end

            --------------------------------------------------------------------------------------------------

            --************************************************************************************************
            -- Render Players Onto Screen
            --************************************************************************************************

            graphics.drawNinePatch(
                  player1Img,
                  vector3.new(player1.x, player1.y, 0.0),
                  player1ImgWidth,
                  player1ImgHeight,
                  0.0,
                  0.0
            )

            graphics.drawNinePatch(
                  player2Img,
                  vector3.new(player2.x, player2.y, 0.0),
                  player2ImgWidth,
                  player2ImgHeight,
                  0.0,
                  0.0
            )

            --------------------------------------------------------------------------------------------------

            --************************************************************************************************
            -- Render Ball Onto Screen Only Once Player Has Pressed Start
            --************************************************************************************************
            if startGame == 1 then
                  graphics.drawNinePatch(
                        ballImg,
                        vector3.new(ball.x, ball.y, 0.0),
                        ballImgWidth,
                        ballImgHeight,
                        0.0,
                        0.0
                  )
            end

            --------------------------------------------------------------------------------------------------

            --************************************************************************************************
            -- Render Scores Onto Screen
            --************************************************************************************************

            local textPosition1 = vector3.new(renderGetWidth() / 2, renderGetHeight() - 20, 0)
            graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))

            local scoreWidth, scoreHeight =
                  graphics.measureFont(fontId, "XDK " .. player2.score .. " - " .. player1.score .. " NXDK")
            local scoreTextSize = vector3.new(scoreWidth / 2, 0, 0)

            graphics.drawFont(
                  fontId,
                  textPosition1 - scoreTextSize,
                  "XDK " .. player2.score .. " - " .. player1.score .. " NXDK"
            )
            graphics.setColorTint(color4.new(255 / 255, 255 / 255, 255 / 255, 1.0))

            --------------------------------------------------------------------------------------------------

            graphics.endScene()
            graphics.swapBuffers()
      end
end
