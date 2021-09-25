require("global:Sound")
require("global:Controller")

local musiccontrol = {}
local repeatstatus = false

function musiccontrol.controls()

	-- Music Control
	
	if (Controller.isButtonDown(0, CONTROLLER_A) and Sound.isPlaying(soundIndex1) == false) then
		print("Play Startup.wav")
		Sound.play(soundIndex1)
	end 
	
	if (Controller.isButtonDown(0, CONTROLLER_B) and Sound.isPlaying(soundIndex2) == false) then
		print("Play Intro.wav")
		Sound.play(soundIndex2)
	end

	if (Controller.isButtonDown(0, CONTROLLER_X)) then
		if (repeatstatus) then
			print("Disable Repeat SoundIndex2 intro.wav")
			Sound.setRepeat(soundIndex2, 0)
			Sound.stop(soundIndex2)
			repeatstatus = false
		elseif (not repeatstatus) then
			print("Repeat SoundIndex2 intro.wav")
			Sound.setRepeat(soundIndex2, -1)
			repeatstatus = true
		end
	end

	if (Controller.isButtonDown(0, CONTROLLER_Y)) then
		print("Stop SoundIndex2 intro.wav")
		Sound.stop(soundIndex2)
	end 

	if (Sound.isPlaying(soundIndex2) and count % 300 == 0) then
		print("Do you really have to put me thru this?")
	end


end



return musiccontrol