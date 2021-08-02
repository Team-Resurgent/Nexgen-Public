require("global:Globals")

local backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\background720.png")
local screenMeshId = graphics.createPlaneXYMeshCollection(0, 0, 0, renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(screenMeshId, 0)

local fontId = graphics.loadFont("assets:fonts\\MobileFont.fnt")

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

function PressStartToAttackText()
  if PressStartToAttackVariables == nil then
    PressStartToAttackVariables = 1
	PressStartToAttackHigh, PressStartToAttackLow, PressStartToAttackSpeed = 10, -10, (math.random(1, 10) / 10.0)
	PressStartToAttackPositionX, PressStartToAttackPositionY = 410 / 2, renderGetHeight() / 2
    PressStartLetter1a, PressStartLetter1b = 10, math.random(-10, 10)
    PressStartLetter2a, PressStartLetter2b = 10, math.random(-10, 10)
    PressStartLetter3a, PressStartLetter3b = 10, math.random(-10, 10)
    PressStartLetter4a, PressStartLetter4b = 10, math.random(-10, 10)
    PressStartLetter5a, PressStartLetter5b = 10, math.random(-10, 10)	
	PressStartLetter6a, PressStartLetter6b = 10, math.random(-10, 10)
	PressStartLetter7a, PressStartLetter7b = 10, math.random(-10, 10)
	PressStartLetter8a, PressStartLetter8b = 10, math.random(-10, 10)
	PressStartLetter9a, PressStartLetter9b = 10, math.random(-10, 10)
	PressStartLetter10a, PressStartLetter10b = 10, math.random(-10, 10)	
	PressStartLetter11a, PressStartLetter11b = 10, math.random(-10, 10)
	PressStartLetter12a, PressStartLetter12b = 10, math.random(-10, 10)	
	PressStartLetter13a, PressStartLetter13b = 10, math.random(-10, 10)
	PressStartLetter14a, PressStartLetter14b = 10, math.random(-10, 10)
	PressStartLetter15a, PressStartLetter15b = 10, math.random(-10, 10)
	PressStartLetter16a, PressStartLetter16b = 10, math.random(-10, 10)
	PressStartLetter17a, PressStartLetter17b = 10, math.random(-10, 10)
	PressStartLetter18a, PressStartLetter18b = 10, math.random(-10, 10)
	PressStartLetter19a, PressStartLetter19b = 10, math.random(-10, 10)
  end

  if PressStartLetter1a == PressStartToAttackHigh and PressStartLetter1b < PressStartToAttackHigh then
    PressStartLetter1b = PressStartLetter1b + PressStartToAttackSpeed
  elseif PressStartLetter1a == PressStartToAttackHigh then
    PressStartLetter1a = PressStartToAttackLow
  elseif PressStartLetter1a == PressStartToAttackLow and PressStartLetter1b > PressStartToAttackLow then
    PressStartLetter1b = PressStartLetter1b - PressStartToAttackSpeed
  elseif PressStartLetter1a == PressStartToAttackLow then
    PressStartLetter1a = PressStartToAttackHigh	
  end
	  
  if PressStartLetter2a == PressStartToAttackHigh and PressStartLetter2b < PressStartToAttackHigh then
    PressStartLetter2b = PressStartLetter2b + PressStartToAttackSpeed
  elseif PressStartLetter2a == PressStartToAttackHigh then
    PressStartLetter2a = PressStartToAttackLow
  elseif PressStartLetter2a == PressStartToAttackLow and PressStartLetter2b > PressStartToAttackLow then
    PressStartLetter2b = PressStartLetter2b - PressStartToAttackSpeed
  elseif PressStartLetter2a == PressStartToAttackLow then
    PressStartLetter2a = PressStartToAttackHigh	
  end
	  
  if PressStartLetter3a == PressStartToAttackHigh and PressStartLetter3b < PressStartToAttackHigh then
    PressStartLetter3b = PressStartLetter3b + PressStartToAttackSpeed
  elseif PressStartLetter3a == PressStartToAttackHigh then
    PressStartLetter3a = PressStartToAttackLow
  elseif PressStartLetter3a == PressStartToAttackLow and PressStartLetter3b > PressStartToAttackLow then
    PressStartLetter3b = PressStartLetter3b - PressStartToAttackSpeed
  elseif PressStartLetter3a == PressStartToAttackLow then
    PressStartLetter3a = PressStartToAttackHigh	
  end
	  
  if PressStartLetter4a == PressStartToAttackHigh and PressStartLetter4b < PressStartToAttackHigh then
    PressStartLetter4b = PressStartLetter4b + PressStartToAttackSpeed
  elseif PressStartLetter4a == PressStartToAttackHigh then
    PressStartLetter4a = PressStartToAttackLow
  elseif PressStartLetter4a == PressStartToAttackLow and PressStartLetter4b > PressStartToAttackLow then
    PressStartLetter4b = PressStartLetter4b - PressStartToAttackSpeed
  elseif PressStartLetter4a == PressStartToAttackLow then
    PressStartLetter4a = PressStartToAttackHigh	
  end
	  
  if PressStartLetter5a == PressStartToAttackHigh and PressStartLetter5b < PressStartToAttackHigh then
    PressStartLetter5b = PressStartLetter5b + PressStartToAttackSpeed
  elseif PressStartLetter5a == PressStartToAttackHigh then
    PressStartLetter5a = PressStartToAttackLow
  elseif PressStartLetter5a == PressStartToAttackLow and PressStartLetter5b > PressStartToAttackLow then
    PressStartLetter5b = PressStartLetter5b - PressStartToAttackSpeed
  elseif PressStartLetter5a == PressStartToAttackLow then
    PressStartLetter5a = PressStartToAttackHigh	
  end
	 
  if PressStartLetter6a == PressStartToAttackHigh and PressStartLetter6b < PressStartToAttackHigh then
    PressStartLetter6b = PressStartLetter6b + PressStartToAttackSpeed
  elseif PressStartLetter6a == PressStartToAttackHigh then
    PressStartLetter6a = PressStartToAttackLow
  elseif PressStartLetter6a == PressStartToAttackLow and PressStartLetter6b > PressStartToAttackLow then
    PressStartLetter6b = PressStartLetter6b - PressStartToAttackSpeed
  elseif PressStartLetter6a == PressStartToAttackLow then
    PressStartLetter6a = PressStartToAttackHigh	
  end
  
  if PressStartLetter7a == PressStartToAttackHigh and PressStartLetter7b < PressStartToAttackHigh then
    PressStartLetter7b = PressStartLetter7b + PressStartToAttackSpeed
  elseif PressStartLetter7a == PressStartToAttackHigh then
    PressStartLetter7a = PressStartToAttackLow
  elseif PressStartLetter7a == PressStartToAttackLow and PressStartLetter7b > PressStartToAttackLow then
    PressStartLetter7b = PressStartLetter7b - PressStartToAttackSpeed
  elseif PressStartLetter7a == PressStartToAttackLow then
    PressStartLetter7a = PressStartToAttackHigh	
  end
  
  if PressStartLetter8a == PressStartToAttackHigh and PressStartLetter8b < PressStartToAttackHigh then
    PressStartLetter8b = PressStartLetter8b + PressStartToAttackSpeed
  elseif PressStartLetter8a == PressStartToAttackHigh then
    PressStartLetter8a = PressStartToAttackLow
  elseif PressStartLetter8a == PressStartToAttackLow and PressStartLetter8b > PressStartToAttackLow then
    PressStartLetter8b = PressStartLetter8b - PressStartToAttackSpeed
  elseif PressStartLetter8a == PressStartToAttackLow then
    PressStartLetter8a = PressStartToAttackHigh	
  end
  
  if PressStartLetter9a == PressStartToAttackHigh and PressStartLetter9b < PressStartToAttackHigh then
    PressStartLetter9b = PressStartLetter9b + PressStartToAttackSpeed
  elseif PressStartLetter9a == PressStartToAttackHigh then
    PressStartLetter9a = PressStartToAttackLow
  elseif PressStartLetter9a == PressStartToAttackLow and PressStartLetter9b > PressStartToAttackLow then
    PressStartLetter9b = PressStartLetter9b - PressStartToAttackSpeed
  elseif PressStartLetter9a == PressStartToAttackLow then
    PressStartLetter9a = PressStartToAttackHigh	
  end

  if PressStartLetter10a == PressStartToAttackHigh and PressStartLetter10b < PressStartToAttackHigh then
    PressStartLetter10b = PressStartLetter10b + PressStartToAttackSpeed
  elseif PressStartLetter10a == PressStartToAttackHigh then
    PressStartLetter10a = PressStartToAttackLow
  elseif PressStartLetter10a == PressStartToAttackLow and PressStartLetter10b > PressStartToAttackLow then
    PressStartLetter10b = PressStartLetter10b - PressStartToAttackSpeed
  elseif PressStartLetter10a == PressStartToAttackLow then
    PressStartLetter10a = PressStartToAttackHigh	
  end

  if PressStartLetter11a == PressStartToAttackHigh and PressStartLetter11b < PressStartToAttackHigh then
    PressStartLetter11b = PressStartLetter11b + PressStartToAttackSpeed
  elseif PressStartLetter11a == PressStartToAttackHigh then
    PressStartLetter11a = PressStartToAttackLow
  elseif PressStartLetter11a == PressStartToAttackLow and PressStartLetter11b > PressStartToAttackLow then
    PressStartLetter11b = PressStartLetter11b - PressStartToAttackSpeed
  elseif PressStartLetter11a == PressStartToAttackLow then
    PressStartLetter11a = PressStartToAttackHigh	
  end
  
  if PressStartLetter12a == PressStartToAttackHigh and PressStartLetter12b < PressStartToAttackHigh then
    PressStartLetter12b = PressStartLetter12b + PressStartToAttackSpeed
  elseif PressStartLetter12a == PressStartToAttackHigh then
    PressStartLetter12a = PressStartToAttackLow
  elseif PressStartLetter12a == PressStartToAttackLow and PressStartLetter12b > PressStartToAttackLow then
    PressStartLetter12b = PressStartLetter12b - PressStartToAttackSpeed
  elseif PressStartLetter12a == PressStartToAttackLow then
    PressStartLetter12a = PressStartToAttackHigh	
  end

  if PressStartLetter13a == PressStartToAttackHigh and PressStartLetter13b < PressStartToAttackHigh then
    PressStartLetter13b = PressStartLetter13b + PressStartToAttackSpeed
  elseif PressStartLetter13a == PressStartToAttackHigh then
    PressStartLetter13a = PressStartToAttackLow
  elseif PressStartLetter13a == PressStartToAttackLow and PressStartLetter13b > PressStartToAttackLow then
    PressStartLetter13b = PressStartLetter13b - PressStartToAttackSpeed
  elseif PressStartLetter13a == PressStartToAttackLow then
    PressStartLetter13a = PressStartToAttackHigh	
  end
  
  if PressStartLetter14a == PressStartToAttackHigh and PressStartLetter14b < PressStartToAttackHigh then
    PressStartLetter14b = PressStartLetter14b + PressStartToAttackSpeed
  elseif PressStartLetter14a == PressStartToAttackHigh then
    PressStartLetter14a = PressStartToAttackLow
  elseif PressStartLetter14a == PressStartToAttackLow and PressStartLetter14b > PressStartToAttackLow then
    PressStartLetter14b = PressStartLetter14b - PressStartToAttackSpeed
  elseif PressStartLetter14a == PressStartToAttackLow then
    PressStartLetter14a = PressStartToAttackHigh	
  end
  
  if PressStartLetter15a == PressStartToAttackHigh and PressStartLetter15b < PressStartToAttackHigh then
    PressStartLetter15b = PressStartLetter15b + PressStartToAttackSpeed
  elseif PressStartLetter15a == PressStartToAttackHigh then
    PressStartLetter15a = PressStartToAttackLow
  elseif PressStartLetter15a == PressStartToAttackLow and PressStartLetter15b > PressStartToAttackLow then
    PressStartLetter15b = PressStartLetter15b - PressStartToAttackSpeed
  elseif PressStartLetter15a == PressStartToAttackLow then
    PressStartLetter15a = PressStartToAttackHigh	
  end
  
  if PressStartLetter16a == PressStartToAttackHigh and PressStartLetter16b < PressStartToAttackHigh then
    PressStartLetter16b = PressStartLetter16b + PressStartToAttackSpeed
  elseif PressStartLetter16a == PressStartToAttackHigh then
    PressStartLetter16a = PressStartToAttackLow
  elseif PressStartLetter16a == PressStartToAttackLow and PressStartLetter16b > PressStartToAttackLow then
    PressStartLetter16b = PressStartLetter16b - PressStartToAttackSpeed
  elseif PressStartLetter16a == PressStartToAttackLow then
    PressStartLetter16a = PressStartToAttackHigh	
  end
  
  if PressStartLetter17a == PressStartToAttackHigh and PressStartLetter17b < PressStartToAttackHigh then
    PressStartLetter17b = PressStartLetter17b + PressStartToAttackSpeed
  elseif PressStartLetter17a == PressStartToAttackHigh then
    PressStartLetter17a = PressStartToAttackLow
  elseif PressStartLetter17a == PressStartToAttackLow and PressStartLetter17b > PressStartToAttackLow then
    PressStartLetter17b = PressStartLetter17b - PressStartToAttackSpeed
  elseif PressStartLetter17a == PressStartToAttackLow then
    PressStartLetter17a = PressStartToAttackHigh	
  end
  
  if PressStartLetter18a == PressStartToAttackHigh and PressStartLetter18b < PressStartToAttackHigh then
    PressStartLetter18b = PressStartLetter18b + PressStartToAttackSpeed
  elseif PressStartLetter18a == PressStartToAttackHigh then
    PressStartLetter18a = PressStartToAttackLow
  elseif PressStartLetter18a == PressStartToAttackLow and PressStartLetter18b > PressStartToAttackLow then
    PressStartLetter18b = PressStartLetter18b - PressStartToAttackSpeed
  elseif PressStartLetter18a == PressStartToAttackLow then
    PressStartLetter18a = PressStartToAttackHigh	
  end
  
  if PressStartLetter19a == PressStartToAttackHigh and PressStartLetter19b < PressStartToAttackHigh then
    PressStartLetter19b = PressStartLetter19b + PressStartToAttackSpeed
  elseif PressStartLetter19a == PressStartToAttackHigh then
    PressStartLetter19a = PressStartToAttackLow
  elseif PressStartLetter19a == PressStartToAttackLow and PressStartLetter19b > PressStartToAttackLow then
    PressStartLetter19b = PressStartLetter19b - PressStartToAttackSpeed
  elseif PressStartLetter19a == PressStartToAttackLow then
    PressStartLetter19a = PressStartToAttackHigh	
  end

  graphics.setColorTint(color4.new(math.random(1,255)/255, math.random(1,255)/255, math.random(1,255)/255, 1.0)) --Set text colour
	 
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX, PressStartToAttackPositionY + PressStartLetter1b, 0),"P")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 55, PressStartToAttackPositionY + PressStartLetter2b, 0),"r")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 94, PressStartToAttackPositionY + PressStartLetter3b, 0),"e")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 142, PressStartToAttackPositionY + PressStartLetter4b, 0),"s")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 181, PressStartToAttackPositionY + PressStartLetter5b, 0),"s")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 237, PressStartToAttackPositionY + PressStartLetter6b, 0),"S")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 285, PressStartToAttackPositionY + PressStartLetter7b, 0),"t")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 317, PressStartToAttackPositionY + PressStartLetter8b, 0),"a")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 365, PressStartToAttackPositionY + PressStartLetter9b, 0),"r")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 404, PressStartToAttackPositionY + PressStartLetter10b, 0),"t")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 453, PressStartToAttackPositionY + PressStartLetter11b, 0),"T")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 508, PressStartToAttackPositionY + PressStartLetter12b, 0),"o")  
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 573, PressStartToAttackPositionY + PressStartLetter13b, 0),"A")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 636, PressStartToAttackPositionY + PressStartLetter14b, 0),"t")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 668, PressStartToAttackPositionY + PressStartLetter15b, 0),"t")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 700, PressStartToAttackPositionY + PressStartLetter16b, 0),"a")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 748, PressStartToAttackPositionY + PressStartLetter17b, 0),"c")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 787, PressStartToAttackPositionY + PressStartLetter18b, 0),"k")
  graphics.drawFont(fontId, vector3.new(PressStartToAttackPositionX + 835, PressStartToAttackPositionY + PressStartLetter19b, 0),"!")
	
  graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0)) -- Default colour back to white
end


function onRender(dt)
    graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0)) -- Default colour back to white
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
    
	
	PressStartToAttackText()
    
    
    


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
    bullet.y = bullet.y + (600*dt) 
    if bullet.y > renderGetHeight() then -- remove bullet if is out of screen
      table.remove(PlayerBulletsL, i)
    end
  end
  
  for i,bullet in ipairs(PlayerBulletsR) do
    bullet.y = bullet.y + (600*dt)
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

   
  


  
  graphics.endScene()
  graphics.swapBuffers()
end

print("done")