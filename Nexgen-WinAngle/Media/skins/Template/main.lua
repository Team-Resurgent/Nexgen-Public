--###############################################################################################

-- Template.

-- Author: Team Resurgent.
-- 17/08/2021.

-- The following are shortcut paths to the root folder of current skin. 
-- media: skin: scripts: audio: assets:

--###############################################################################################

--###############################################################################################
-- All code below is called exactly once at the beginning of the script
--###############################################################################################

require("global:Globals")









--###############################################################################################

--###############################################################################################
-- All code located in the onRender callback function is used to update the state of the game
-- every frame (dt).

-- Do not use loadTexture, loadFont, loadMeshCollection, sound.load or any other load commands
-- here as this will cause the file to continuously load a new instance in memory,(leak).
--###############################################################################################

function onRender(dt)
     
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 

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
			
           
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
            graphics.endScene()
            graphics.swapBuffers()
      end
end
