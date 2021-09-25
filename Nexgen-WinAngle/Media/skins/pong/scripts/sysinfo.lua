local sysinfo = {}

require("global:Vector2")
require("global:Vector3")
require("global:Vector4")
require("global:Color3")
require("global:Color4")
require("global:Matrix4")
require("global:Graphics")
require("global:Maths")



TextColour1 = Color4.new(255/255, 204/255, 0/255, 1.0)
TextColour1Default = Color4.new(1.0, 1.0, 1.0, 1.0)

TextColour2 = Color4.new(1.0, 1.0, 1.0, 1.0)
TextColour2Default = Color4.new(1.0, 1.0, 1.0, 1.0)
 

--************************************************************************************************ 
-- System Memory
--************************************************************************************************ 

function sysinfo.getMemory()

		local totalPhysical = systemGetTotalPhysicalMemory()
		local physicalTextPosition = Vector3.new(65,500, 0)
		--local physicalTextPosition = Vector3.new(65,500, 0).invertY()
		Graphics.setColorTint(TextColour1)
		--Graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical / 1073741824) .." GB" )
		Graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical / 1048576) .." MB" )
		--Graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical / 1024) .." KB" )
		--Graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical) .." B" )
		Graphics.setColorTint(TextColour1Default)
		
		local freePhysical = systemGetFreePhysicalMemory()
        local physicalFreeTextPosition = Vector3.new(65, 480, 0)
		Graphics.setColorTint(TextColour1)
		-- Graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical / 1073741824) .." GB" )
		Graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical / 1048576) .." MB" )
		--Graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical / 1024) .." KB" )
		--Graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical) .." B" )
		Graphics.setColorTint(TextColour1Default)  	
		
		local physicalUsedTextPosition = Vector3.new(65, 460, 0)
		Graphics.setColorTint(TextColour1)
		--Graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical / 1073741824) - math.floor(freePhysical / 1073741824) .." GB" )
		Graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical / 1048576) - math.floor(freePhysical / 1048576) .." MB" )
        --Graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical / 1024) - math.floor(freePhysical / 1024)  .." KB" )
		--Graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical) - math.floor(freePhysical) .." B" )
		Graphics.setColorTint(TextColour1Default)  

		local totalVirtual = systemGetTotalVirtualMemory()
		local vitualTextPosition = Vector3.new(65, 440, 0)
		Graphics.setColorTint(TextColour1)
		--Graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual / 1073741824) .." GB" )
		Graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual / 1048576) .." MB" )
		--Graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual / 1024) .." KB" )
		--Graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual) .." B" )
		Graphics.setColorTint(TextColour1Default)  
		
		local freeVirtual = systemGetFreeVirtualMemory()
        local virtualFreeTextPosition = Vector3.new(65, 420, 0)
		Graphics.setColorTint(TextColour1)
		--Graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual / 1073741824) .." GB" )
		Graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual / 1048576) .." MB" )
        --Graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual / 1024) .." KB" )
		--Graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual) .." B" )
		Graphics.setColorTint(TextColour1Default)  
		
		local virtualUsedTextPosition = Vector3.new(65, 400, 0)
		Graphics.setColorTint(TextColour1)
		--Graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual / 1073741824) - math.floor(freeVirtual / 1073741824) .." GB" )
		Graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual / 1048576) - math.floor(freeVirtual / 1048576) .." MB" )
        --Graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual / 1024) - math.floor(freeVirtual / 1024)  .." KB" )
		--Graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual) - math.floor(freeVirtual) .." B" )
		Graphics.setColorTint(TextColour1Default)  

		




end

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- System FPS
--************************************************************************************************ 

fps = 0
fpsCount = 0
fpsInterval = 0



function sysinfo.getFps(dt)

fpsCount = fpsCount + 1
		fpsInterval = fpsInterval + dt
		
		if fpsInterval > 1.0 then
			fps = fpsCount
            fpsCount = 0
            fpsInterval = 0
        end
		
		local fpsTextPosition = Vector3.new(65, 240, 0)
		Graphics.setColorTint(TextColour1) -- tint green

		local fw, fh = Graphics.measureFont(fontId, "FPS: ")
		local fpsTextSize = Vector3.new(fw, 0, 0)

		Graphics.drawFont(fontId, fpsTextPosition, "FPS: ")
		Graphics.setColorTint(TextColour2) 
		Graphics.drawFont(fontId, fpsTextPosition + fpsTextSize, tostring(fps))
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
end

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Hard Drive & DVD Drive Status
--************************************************************************************************ 

function sysinfo.getDriveInfo()
		
		local CDriveTextPosition = Vector3.new(65, 740, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, CDriveTextPosition, "C:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local DVDDriveTextPosition = Vector3.new(65, 720, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, DVDDriveTextPosition, "DVD:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local EDriveTextPosition = Vector3.new(65, 700, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, EDriveTextPosition, "E:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local FDriveTextPosition = Vector3.new(65, 680, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, FDriveTextPosition, "F:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local GDriveTextPosition = Vector3.new(65, 660, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, GDriveTextPosition, "G:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		
end


-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- System Info, Date, Date, Time, Mobo Temp, Cpu Temp, Xbox Version, Encoder, 
--************************************************************************************************ 

function sysinfo.getSysInfo()
		
		local TimeTextPosition = Vector3.new(65, 540, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, TimeTextPosition, "Time:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local DateTextPosition = Vector3.new(65, 520, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, DateTextPosition, "Date:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local MobeTempTextPosition = Vector3.new(65, 380, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, MobeTempTextPosition, "Mobo Temp:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local CPUTempTextPosition = Vector3.new(65, 360, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, CPUTempTextPosition, "CPU Temp:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local RevisionTextPosition = Vector3.new(65, 340, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, RevisionTextPosition, "Revision:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local EncoderTextPosition = Vector3.new(65, 320, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, EncoderTextPosition, "Encoder:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local FanSpeedTextPosition = Vector3.new(65, 300, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, FanSpeedTextPosition, "Fan Speed:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local IpAddressTextPosition = Vector3.new(65, 280, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, IpAddressTextPosition, "IP:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local MacAddressTextPosition = Vector3.new(65, 260, 0)
		Graphics.setColorTint(TextColour1)
		Graphics.drawFont(fontId, MacAddressTextPosition, "MAC:")
		Graphics.setColorTint(TextColour1Default) -- restore to default 
		
		
		
		
end









return sysinfo