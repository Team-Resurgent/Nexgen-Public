--############################################################################################### 
-- Shooter A Love2d Port 
-- Root.Lua 
-- media: skin: scripts: audio: assets: are the current path shortcuts
-- 03/05/2021
--############################################################################################### 


--************************************************************************************************
-- Load Includes / Requires.
-- These includes Controller Mapping, SysInfo, Music Control 
--************************************************************************************************

require("global:Globals")
local sysinfo = require ("scripts:sysinfo")
local musiccontrol = require ("scripts:musiccontrol")


--************************************************************************************************
-- Configurable Options to turn stuff On & Off
--************************************************************************************************

local Background2DWallpapper = "On"
local InGameMusic= "On"


-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Define & Load Audio.
--************************************************************************************************ 

if InGameMusic == "On" then
IGMusic = sound.load("audio:music\\Cybernoid 2.ogg")
end

GunSound = sound.load("audio:sounds\\gun-sound.ogg")

--************************************************************************************************ 
-- Define & Load Fonts.
--************************************************************************************************ 

fontId = graphics.loadFont("assets:fonts\\Arial_Black_20px.fnt")

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Define & Load 2D Background.
--************************************************************************************************ 

if Background2DWallpapper == "On" then
backgroundTextureId = graphics.loadTexture("assets:images\\backgrounds\\bg.png")
backgroundMeshId = graphics.createPlaneXYMeshCollection(vector3.new(0, 0, 0), renderGetWidth(), renderGetHeight(), 1, 1)
graphics.bindMesh(backgroundMeshId, 0)
end

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Define & Load 9Patch Images.
--************************************************************************************************

local PlayerImg = graphics.loadTexture("assets:images\\game\\plane.png")
local BulletImg = graphics.loadTexture("assets:images\\game\\playerbullet.png")
local EnemyBulletImg = graphics.loadTexture("assets:images\\game\\enemybullet.png")
local EnemyImg = graphics.loadTexture("assets:images\\game\\enemy.png")
local BossImg = graphics.loadTexture("assets:images\\game\\boss.png")

-------------------------------------------------------------------------------------------------- 


local targetRotationX = 0
local targetRotationY = 0
local rotationX = 0
local rotationY = 0

local backgroundColor = color4.new(0.227, 0.227, 0.227, 1.0)



-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Function for collisions
--************************************************************************************************ 

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

--------------------------------------------------------------------------------------------------

--************************************************************************************************ 
-- Image Width & Height
--************************************************************************************************ 

playerWidth = 110
playerHeight = 86

bossWidth = 94
bossHeight = 76

enemyWidth = 110
enemyHeight = 86

bulletWidth = 10
bulletHeight = 26

--------------------------------------------------------------------------------------------------

--************************************************************************************************ 
-- Table For Player
--************************************************************************************************ 

Player = {x = renderGetWidth()/ 2, y = renderGetHeight() - playerHeight, speed = 400, img = nil}

IsAlive = true
Score = 0

--------------------------------------------------------------------------------------------------

--************************************************************************************************ 
-- Table For Boss
--************************************************************************************************ 

boss = {x = 200, y = bossHeight, speed = 100, img = nil, hp = 0, moving = false, direction = 'nil'}

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Timers
-- We declare these here so we don't have to edit them multiple places
--************************************************************************************************ 

CanShoot = true
CanShootTimerMax = 0.2 
CanShootTimer = CanShootTimerMax
EnemyTimerMax = 1
EnemyTimer = EnemyTimerMax

CanShootBoss = true
CanShootTimerMaxBoss = 1
CanShootTimerBoss = CanShootTimerMaxBoss


-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Entity Storage
--************************************************************************************************ 

Bullets = {} -- array of current bullets being drawn and updated
Enemies = {} -- array of current enemies being drawn and updated

bulletsBoss = {} -- array of current boss bullets being drawn and updated
bulletImgBoss = nil

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


leftVol = 0.0
rightVol = 0.0

--************************************************************************************************
-- Render Code Code from this point Loops.
--************************************************************************************************

function onRender(dt)

if (controller.isButtonDown(0, controller.Button['Y'])) and leftVol < 1.0 then
    leftVol = leftVol + 0.01
	print(leftVol)
    end
	
if (controller.isButtonDown(0, controller.Button['White'])) and leftVol > 0.0 then
    leftVol = leftVol - 0.01
	print(leftVol)
    end	
	
if (controller.isButtonDown(0, controller.Button['B'])) and rightVol < 1.0 then
    rightVol = rightVol + 0.01
	print(rightVol)
    end	

if (controller.isButtonDown(0, controller.Button['Black'])) and rightVol > 0.0 then
    rightVol = rightVol - 0.01
	print(rightVol)
    end	
		

sound.setVolume(IGMusic, leftVol, rightVol)


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

--************************************************************************************************ 
-- Restart Game After Dying & Reset Variables
--************************************************************************************************ 
  if not IsAlive and (controller.isButtonDown(0, controller.Button['Start'])) then
    -- Reset Game
    Bullets = {}
    Enemies = {}
    Player.x = renderGetWidth()/ 2
    Player.y = renderGetHeight() - playerHeight
    IsAlive = true
    
	CanShootTimerMax = 0.2 
    CanShootTimer = CanShootTimerMax
    CanShoot = true
	
    CanShootTimerMaxBoss = 0.2
    CanShootTimerBoss = CanShootTimerMaxBoss
    CanShootBoss = true

	
    EnemyTimerMax = 2
    EnemyTimer = EnemyTimerMax
	
	
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Controller Settings For Airplane Movement
--************************************************************************************************ 

  if (controller.isButtonHeld(0, controller.Button['DpadLeft'])) then
    if Player.x > 0 then -- ensure plane is always in window
      Player.x = Player.x - (Player.speed*dt)
    end
  elseif (controller.isButtonHeld(0, controller.Button['DpadRight'])) then
    --if Player.x < (love.graphics.getWidth() - Player.img:getWidth()) then
	 if Player.x < (renderGetWidth()) then
      Player.x = Player.x + (Player.speed*dt)
    end
  end
  if (controller.isButtonHeld(0, controller.Button['DpadDown'])) then
    if Player.y > (renderGetHeight()/2) then
      Player.y = Player.y - (Player.speed*dt)
    end
  elseif (controller.isButtonHeld(0, controller.Button['DpadUp'])) then
    if Player.y < (renderGetHeight() - playerHeight ) then
      Player.y = Player.y + (Player.speed*dt)
    end
	end
  

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Airplane (Player) Shooting
--************************************************************************************************  
  
  -- Time out how far apart our shots can be.
  CanShootTimer = CanShootTimer - (1 * dt)
  if CanShootTimer < 0 then
    CanShoot = true
  end
 

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Airplane (Boss) Shooting
--************************************************************************************************  

  -- Time out how far apart Boss shots can be.
  CanShootTimerBoss = CanShootTimerBoss - (1 * dt)
  if CanShootTimerBoss < 0 then
    CanShootBoss = true
  end
  
 
-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Create Player Bullet And Play Sound
--************************************************************************************************  
  if (controller.isButtonHeld(0, controller.Button['A'])) and CanShoot and IsAlive then
    --local newBullet = {x = Player.x + (PlayerImg:renderGetWidth()/2), y = Player.y, img = BulletImg}
	local newBullet = {x = Player.x + ((playerWidth / 2) - (bulletWidth / 2)) , y = Player.y, img = bulletImg}
	
    table.insert(Bullets, newBullet)
	

    CanShoot = false
    CanShootTimer = CanShootTimerMax
	
	sound.play(GunSound)
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Boss is Shooting
--************************************************************************************************  
  if boss.hp > 0 and CanShootBoss then
  	newBulletBoss = { x = boss.x + ((bossWidth / 2) - (bulletWidth / 2)), y = boss.y + bossHeight - 10 , img = bulletImg}
	
  	table.insert(bulletsBoss, newBulletBoss)
	--print("Boss is Shooting")
  	CanShootBoss = false
	CanShootTimerMaxBoss = math.random(0, 1) + 0.2	
	  CanShootTimerBoss = CanShootTimerMaxBoss
  end


-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Bullet Movement
--************************************************************************************************  

  for i,bullet in ipairs(Bullets) do
    bullet.y = bullet.y - (250*dt)
    if bullet.y < 0 then -- remove bullet if is out of screen
      table.remove(Bullets, i)
    end
  end
  

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Boss Bullet Movement
--************************************************************************************************  
  
	for i, bulletBoss in ipairs(bulletsBoss) do
		bulletBoss.y = bulletBoss.y + (200 * dt)

  		if bulletBoss.y > renderGetHeight() then
			table.remove(bulletsBoss, i)
		end
	end
  
  
-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Enemy Spawn Timer & Create Enemy
--************************************************************************************************  
  EnemyTimer = EnemyTimer - (1 * dt)
  if EnemyTimer < 0 then
    EnemyTimer = EnemyTimerMax
    
    -- Create Enemy
    local randomNumber = math.random(10, renderGetWidth() - 10)
    local newEnemy = {x = randomNumber, y = -10, img = EnemyImg }
    table.insert(Enemies, newEnemy)  
  end



-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Initiate Boss Fight
--************************************************************************************************  
  if Score == 2 and boss.hp == 0 then
    boss.hp = 10
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Boss Movement Destination
--************************************************************************************************  

  if boss.hp > 0 and boss.moving == false then
    --randommove = math.random((renderGetWidth()) -bossWidth)
	randommove = math.random((renderGetWidth()))
    if randommove < boss.x then
      boss.direction = 'left'
    else
      boss.direction = 'right'
    end
    boss.moving = true
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Boss Movement
--************************************************************************************************  
  if boss.moving == true then
    if boss.direction == 'right' then
      boss.x = boss.x + boss.speed*dt
    else
      boss.x = boss.x - boss.speed*dt
    end

    if boss.direction == 'right' and boss.x > randommove then
      boss.moving = false
    end
    if boss.direction == 'left' and boss.x < randommove then
      boss.moving = false
    end
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Enemy Movement
--************************************************************************************************  

	for i, enemy in ipairs(Enemies) do
		enemy.y = enemy.y + (300 * dt)

		if enemy.y > renderGetHeight() then
			table.remove(Enemies, i)
		end
	end


-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Collision Check For Enemies And Bullets
--************************************************************************************************  

	for i, enemy in ipairs(Enemies) do
		for j, bullet in ipairs(Bullets) do
			if CheckCollision(enemy.x, enemy.y, enemyWidth, enemyHeight, bullet.x, bullet.y, bulletWidth, bulletHeight) then
				table.remove(Bullets, j)
				table.remove(Enemies, i)
				Score = Score + 1
				if boss.hp == 0 and (math.fmod(Score,10) == 0) then
				
				boss.hp = 10

				end		
			end
		end


-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Collision Check For Player With Enemies
--************************************************************************************************  

		if CheckCollision(enemy.x, enemy.y, enemyWidth, enemyHeight, Player.x, Player.y, playerWidth, playerHeight) and IsAlive then
			table.remove(Enemies, i)
			
			print("Colided with Enemy")
			
      boss.hp = 0
			IsAlive = false
		end
	end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Collision Check For Boss With Bullets
--************************************************************************************************  
 
  if boss.hp > 0 then 
  for j, bullet in ipairs(Bullets) do
    if CheckCollision(boss.x, boss.y, bossWidth, bossHeight, bullet.x, bullet.y, bulletWidth, bulletHeight) then
      table.remove(Bullets, j)  
      
	  if boss.hp ~= 0 then
	  boss.hp = boss.hp - 1
	  
	Score = Score + 1
	  end
	  
    end
  end
end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Collision Check For Player With Bullets
--************************************************************************************************  

  for j, bulletBoss in ipairs(bulletsBoss) do
    if CheckCollision(Player.x, Player.y, playerWidth, playerHeight, bulletBoss.x, bulletBoss.y, bulletWidth, bulletHeight) then
      table.remove(bulletsBoss, j)
      boss.hp = 0
      IsAlive = false
    end
  end


--************************************************************************************************
-- Begin RenderScene Code.
--************************************************************************************************

if graphics.beginScene() then

-- Setup Lights
local lightPosition = vector4.new(0.0, 0.0, 2.0, 0.0);
local lightDiffuseColor = color4.new(1.0, 1.0, 1.0, 0.0)

graphics.setAmbientLight(color3.new(0.3, 0.3, 0.3))	
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
				
-- Overlay
graphics.setModelMatrix(orthoModelMatrix)
graphics.setViewMatrix(viewMatrix)
graphics.setProjectionMatrix(orthoMatrix)
		
-------------------------------------------------------------------------------------------------- 

graphics.setColorTint(TextColour1Default)

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Drawing Airplane
--************************************************************************************************

  if IsAlive then
      --love.graphics.draw(Player.img, Player.x, Player.y)
    graphics.activateTexture(PlayerImg)
    graphics.drawQuad(vector3.new(Player.x, Player.y, 0.0), playerWidth, playerHeight)

  else
  --love.graphics.print('Press R to Restart', love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
  local textPosition1 = vector3.new(renderGetWidth()/2, renderGetHeight()/2, 0)
  graphics.setColorTint(color4.new(255/255, 125/255, 180/255, 1.0))
  graphics.drawFont(fontId, textPosition1," Press Start To Restart ")
  Score = 0 
  graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0))
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Drawing Boss
--************************************************************************************************

  if boss.hp > 0 then
    graphics.activateTexture(BossImg)
    graphics.drawQuad(vector3.new(boss.x, boss.y, 0.0), bossWidth, bossHeight)
  end
  
-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Drawing Boss Bullets
--************************************************************************************************ 
  
  for i, bulletBoss in ipairs(bulletsBoss) do
    graphics.activateTexture(EnemyBulletImg)
    graphics.drawQuad(vector3.new(bulletBoss.x, bulletBoss.y, 0.0), bulletWidth, bulletHeight)	
	end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Drawing Score
--************************************************************************************************   
  
  local textScorePosition = vector3.new(0, aspectRatio, 0).invertY(graphics.getHeight())
   
   --local textScorePosition = vector3.new(10, 10, 0).invertY()
  graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0))
  graphics.drawFont(fontId, textScorePosition,"SCORE: " .. tostring(Score))
  graphics.setColorTint(TextColour1Default)
  
-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Drawing Boss Health
--************************************************************************************************ 
  
  
    --if boss.hp > 0 then
   local textHPPosition = vector3.new(200, aspectRatio, 0).invertY(graphics.getHeight())
	  graphics.setColorTint(color4.new(1/255, 255/255, 255/255, 1.0))
    graphics.drawFont(fontId, textHPPosition,"Boss HP: " .. tostring(boss.hp))
	  graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0))
  --end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Drawing Player Bullets
--************************************************************************************************   
  
  for i,bullet in ipairs(Bullets) do
    graphics.activateTexture(BulletImg)
    graphics.drawQuad(vector3.new(bullet.x, bullet.y, 0.0), bulletWidth, bulletHeight)
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Drawing Enemies
--************************************************************************************************ 

  for i,enemy in ipairs(Enemies) do
    graphics.activateTexture(EnemyImg)
    graphics.drawQuad(vector3.new(enemy.x, enemy.y, 0.0), enemyWidth, enemyHeight)
  end

-------------------------------------------------------------------------------------------------- 
 
--************************************************************************************************ 
-- Drawing Misc Display Settings Width Height Aspect Ratio
--************************************************************************************************   
  
     local textHPPosition = vector3.new(aspectRatio, 50, 0).invertY(graphics.getHeight())
	  graphics.setColorTint(color4.new(1/255, 255/255, 255/255, 1.0))
    graphics.drawFont(fontId, textHPPosition,"Width: " .. tostring(renderGetWidth()).. " Height   " .. tostring(renderGetHeight()).. "   ASPECT  " .. tostring(aspectRatio))
	  graphics.setColorTint(color4.new(255/255, 255/255, 255/255, 1.0))

--sysinfo.getMemory()
sysinfo.getFps(dt)
-------------------------------------------------------------------------------------------------- 


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
