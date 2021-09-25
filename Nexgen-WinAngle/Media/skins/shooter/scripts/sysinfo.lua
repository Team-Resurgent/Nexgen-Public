local sysinfo = {}


TextColour1 = color4.new(255/255, 204/255, 0/255, 1.0)
TextColour1Default = color4.new(1.0, 1.0, 1.0, 1.0)

TextColour2 = color4.new(1.0, 1.0, 1.0, 1.0)
TextColour2Default = color4.new(1.0, 1.0, 1.0, 1.0)
 

--************************************************************************************************ 
-- System Memory
--************************************************************************************************ 

function sysinfo.getMemory()

		local totalPhysical = systemGetTotalPhysicalMemory()
		local physicalTextPosition = vector3.new(65,500, 0)
		--local physicalTextPosition = vector3.new(65,500, 0).invertY()
		graphics.setColorTint(TextColour1)
		--graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical / 1073741824) .." GB" )
		graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical / 1048576) .." MB" )
		--graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical / 1024) .." KB" )
		--graphics.drawFont(fontId, physicalTextPosition, "Physical Memory: " .. math.floor(totalPhysical) .." B" )
		graphics.setColorTint(TextColour1Default)
		
		local freePhysical = systemGetFreePhysicalMemory()
        local physicalFreeTextPosition = vector3.new(65, 480, 0)
		graphics.setColorTint(TextColour1)
		-- graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical / 1073741824) .." GB" )
		graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical / 1048576) .." MB" )
		--graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical / 1024) .." KB" )
		--graphics.drawFont(fontId, physicalFreeTextPosition, "Free Physical Memory: " .. math.floor(freePhysical) .." B" )
		graphics.setColorTint(TextColour1Default)  	
		
		local physicalUsedTextPosition = vector3.new(65, 460, 0)
		graphics.setColorTint(TextColour1)
		--graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical / 1073741824) - math.floor(freePhysical / 1073741824) .." GB" )
		graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical / 1048576) - math.floor(freePhysical / 1048576) .." MB" )
        --graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical / 1024) - math.floor(freePhysical / 1024)  .." KB" )
		--graphics.drawFont(fontId, physicalUsedTextPosition, "Used Physical Memory: " .. math.floor(totalPhysical) - math.floor(freePhysical) .." B" )
		graphics.setColorTint(TextColour1Default)  

		local totalVirtual = systemGetTotalVirtualMemory()
		local vitualTextPosition = vector3.new(65, 440, 0)
		graphics.setColorTint(TextColour1)
		--graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual / 1073741824) .." GB" )
		graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual / 1048576) .." MB" )
		--graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual / 1024) .." KB" )
		--graphics.drawFont(fontId, vitualTextPosition, "Virtual Memory: " .. math.floor(totalVirtual) .." B" )
		graphics.setColorTint(TextColour1Default)  
		
		local freeVirtual = systemGetFreeVirtualMemory()
        local virtualFreeTextPosition = vector3.new(65, 420, 0)
		graphics.setColorTint(TextColour1)
		--graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual / 1073741824) .." GB" )
		graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual / 1048576) .." MB" )
        --graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual / 1024) .." KB" )
		--graphics.drawFont(fontId, virtualFreeTextPosition, "Free Virtual Memory: " .. math.floor(freeVirtual) .." B" )
		graphics.setColorTint(TextColour1Default)  
		
		local virtualUsedTextPosition = vector3.new(65, 400, 0)
		graphics.setColorTint(TextColour1)
		--graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual / 1073741824) - math.floor(freeVirtual / 1073741824) .." GB" )
		graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual / 1048576) - math.floor(freeVirtual / 1048576) .." MB" )
        --graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual / 1024) - math.floor(freeVirtual / 1024)  .." KB" )
		--graphics.drawFont(fontId, virtualUsedTextPosition, "Used Virtual Memory: " .. math.floor(totalVirtual) - math.floor(freeVirtual) .." B" )
		graphics.setColorTint(TextColour1Default)  

		




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
		
		local fpsTextPosition = vector3.new(65, 240, 0)
		graphics.setColorTint(TextColour1) -- tint green

		local fw, fh = graphics.measureFont(fontId, "FPS: ")
		local fpsTextSize = vector3.new(fw, 0, 0)

		graphics.drawFont(fontId, fpsTextPosition, "FPS: ")
		graphics.setColorTint(TextColour2) 
		graphics.drawFont(fontId, fpsTextPosition + fpsTextSize, tostring(fps))
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
end

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- Hard Drive & DVD Drive Status
--************************************************************************************************ 

function sysinfo.getDriveInfo()
		
		local CDriveTextPosition = vector3.new(65, 740, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, CDriveTextPosition, "C:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local DVDDriveTextPosition = vector3.new(65, 720, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, DVDDriveTextPosition, "DVD:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local EDriveTextPosition = vector3.new(65, 700, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, EDriveTextPosition, "E:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local FDriveTextPosition = vector3.new(65, 680, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, FDriveTextPosition, "F:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local GDriveTextPosition = vector3.new(65, 660, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, GDriveTextPosition, "G:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		
end


-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- System Info, Date, Date, Time, Mobo Temp, Cpu Temp, Xbox Version, Encoder, 
--************************************************************************************************ 

function sysinfo.getSysInfo()
		
		local TimeTextPosition = vector3.new(65, 540, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, TimeTextPosition, "Time:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local DateTextPosition = vector3.new(65, 520, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, DateTextPosition, "Date:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local MobeTempTextPosition = vector3.new(65, 380, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, MobeTempTextPosition, "Mobo Temp:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local CPUTempTextPosition = vector3.new(65, 360, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, CPUTempTextPosition, "CPU Temp:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local RevisionTextPosition = vector3.new(65, 340, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, RevisionTextPosition, "Revision:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local EncoderTextPosition = vector3.new(65, 320, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, EncoderTextPosition, "Encoder:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local FanSpeedTextPosition = vector3.new(65, 300, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, FanSpeedTextPosition, "Fan Speed:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local IpAddressTextPosition = vector3.new(65, 280, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, IpAddressTextPosition, "IP:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		local MacAddressTextPosition = vector3.new(65, 260, 0)
		graphics.setColorTint(TextColour1)
		graphics.drawFont(fontId, MacAddressTextPosition, "MAC:")
		graphics.setColorTint(TextColour1Default) -- restore to default 
		
		
		
		
end









return sysinfo