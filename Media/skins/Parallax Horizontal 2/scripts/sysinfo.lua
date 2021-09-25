local sysinfo = {}


TextColour1 = color4.new(255/255, 204/255, 0/255, 1.0)
TextColour1Default = color4.new(1.0, 1.0, 1.0, 1.0)

TextColour2 = color4.new(1.0, 1.0, 1.0, 1.0)
TextColour2Default = color4.new(1.0, 1.0, 1.0, 1.0)
 

--************************************************************************************************ 
-- System Memory
--************************************************************************************************ 

function sysinfo.getMemory(FontSelect, MemPositionX, MemPositionY, MemSpacing, dt)

		local totalPhysical = systemGetTotalPhysicalMemory()
		local physicalTextPosition = vector3.new(MemPositionX, renderGetHeight() - MemPositionY, 0)
		graphics.setColorTint(TextColour1)
		local fw, fh = graphics.measureFont(FontSelect, "Physical Memory: ")
		
		local fpsTextSize = vector3.new(fw, 0, 0)		
		graphics.drawFont(FontSelect, physicalTextPosition, "Physical Memory: ")		
		graphics.setColorTint(TextColour2) 
		--graphics.drawFont(FontSelect, physicalTextPosition + fpsTextSize, math.floor(totalPhysical / 1073741824) .." GB")
		graphics.drawFont(FontSelect, physicalTextPosition + fpsTextSize, math.floor(totalPhysical / 1048576) .." MB")
		--graphics.drawFont(FontSelect, physicalTextPosition + fpsTextSize, math.floor(totalPhysical / 1024) .." KB")
		--graphics.drawFont(FontSelect, physicalTextPosition + fpsTextSize, math.floor(totalPhysical) .." B")		
		graphics.setColorTint(TextColour1Default)
		
		local freePhysical = systemGetFreePhysicalMemory()
        local physicalFreeTextPosition = vector3.new(MemPositionX, renderGetHeight() - (MemPositionY + fh - MemSpacing), 0)
		graphics.setColorTint(TextColour1)
		local fw, fh = graphics.measureFont(FontSelect, "Free Physical Memory: ")
		local fpsTextSize = vector3.new(fw, 0, 0)		
		graphics.drawFont(FontSelect, physicalFreeTextPosition, "Free Physical Memory: ")		
		graphics.setColorTint(TextColour2) 
		--graphics.drawFont(FontSelect, physicalFreeTextPosition + fpsTextSize, math.floor(freePhysical / 1073741824) .." GB")
		graphics.drawFont(FontSelect, physicalFreeTextPosition + fpsTextSize, math.floor(freePhysical / 1048576) .." MB")
		--graphics.drawFont(FontSelect, physicalFreeTextPosition + fpsTextSize, math.floor(freePhysical / 1024) .." KB")
		--graphics.drawFont(FontSelect, physicalFreeTextPosition + fpsTextSize, math.floor(freePhysical) .." B")ePhysical) .." B" )
		graphics.setColorTint(TextColour1Default)  	
		
		local physicalUsedTextPosition = vector3.new(MemPositionX, renderGetHeight() - (MemPositionY + (fh * 2) - (MemSpacing * 2)), 0)
		graphics.setColorTint(TextColour1)
		local fw, fh = graphics.measureFont(FontSelect, "Used Physical Memory: ")
		local fpsTextSize = vector3.new(fw, 0, 0)		
		graphics.drawFont(FontSelect, physicalUsedTextPosition, "Used Physical Memory: ")		
		graphics.setColorTint(TextColour2) 
		--graphics.drawFont(FontSelect, physicalUsedTextPosition + fpsTextSize, math.floor(totalPhysical / 1073741824) - math.floor(freePhysical / 1073741824) .." GB")
		graphics.drawFont(FontSelect, physicalUsedTextPosition + fpsTextSize, math.floor(totalPhysical / 1048576) - math.floor(freePhysical / 1048576) .." MB")
		--graphics.drawFont(FontSelect, physicalUsedTextPosition + fpsTextSize, math.floor(totalPhysical / 1024) - math.floor(freePhysical / 1024)  .." KB")
		--graphics.drawFont(FontSelect, physicalUsedTextPosition + fpsTextSize, math.floor(totalPhysical) - math.floor(freePhysical) .." B" )
		graphics.setColorTint(TextColour1Default)  

		local totalVirtual = systemGetTotalVirtualMemory()
		local vitualTextPosition = vector3.new(MemPositionX, renderGetHeight() - (MemPositionY + (fh * 3) - (MemSpacing * 3)), 0)
		graphics.setColorTint(TextColour1)
		local fw, fh = graphics.measureFont(FontSelect, "Virtual Memory: ")
		local fpsTextSize = vector3.new(fw, 0, 0)		
		graphics.drawFont(FontSelect, vitualTextPosition, "Virtual Memory: ")		
		graphics.setColorTint(TextColour2)
		--graphics.drawFont(FontSelect, vitualTextPosition + fpsTextSize, math.floor(totalVirtual / 1073741824) .." GB")
		graphics.drawFont(FontSelect, vitualTextPosition + fpsTextSize, math.floor(totalVirtual / 1048576) .." MB")
		--graphics.drawFont(FontSelect, vitualTextPosition + fpsTextSize, math.floor(totalVirtual / 1024) .." KB")
		--graphics.drawFont(FontSelect, vitualTextPosition + fpsTextSize, math.floor(totalVirtual) .." B")
		graphics.setColorTint(TextColour1Default)  
		
		local freeVirtual = systemGetFreeVirtualMemory()
        local virtualFreeTextPosition = vector3.new(MemPositionX, renderGetHeight() - (MemPositionY + (fh * 4) - (MemSpacing * 4)), 0)
		graphics.setColorTint(TextColour1)
		local fw, fh = graphics.measureFont(FontSelect, "Free Virtual Memory: ")
		local fpsTextSize = vector3.new(fw, 0, 0)		
		graphics.drawFont(FontSelect, virtualFreeTextPosition, "Free Virtual Memory: ")		
		graphics.setColorTint(TextColour2)
		--graphics.drawFont(FontSelect, virtualFreeTextPosition + fpsTextSize, math.floor(freeVirtual / 1073741824) .." GB")
		graphics.drawFont(FontSelect, virtualFreeTextPosition + fpsTextSize, math.floor(freeVirtual / 1048576) .." MB")
		--graphics.drawFont(FontSelect, virtualFreeTextPosition + fpsTextSize, math.floor(freeVirtual / 1024) .." KB")
		--graphics.drawFont(FontSelect, virtualFreeTextPosition + fpsTextSize, math.floor(freeVirtual) .." B")
		graphics.setColorTint(TextColour1Default)  
		
		local virtualUsedTextPosition = vector3.new(MemPositionX, renderGetHeight() - (MemPositionY + (fh * 5) - (MemSpacing * 5)), 0)
		graphics.setColorTint(TextColour1)
		local fw, fh = graphics.measureFont(FontSelect, "Used Virtual Memory: ")
		local fpsTextSize = vector3.new(fw, 0, 0)		
		graphics.drawFont(FontSelect, virtualUsedTextPosition, "Used Virtual Memory: ")		
		graphics.setColorTint(TextColour2)
		--graphics.drawFont(FontSelect, virtualUsedTextPosition + math.floor(totalVirtual / 1073741824) - math.floor(freeVirtual / 1073741824) .." GB")
		graphics.drawFont(FontSelect, virtualUsedTextPosition + fpsTextSize, math.floor(totalVirtual / 1048576) - math.floor(freeVirtual / 1048576) .." MB")
		--graphics.drawFont(FontSelect, virtualUsedTextPosition + fpsTextSize, math.floor(totalVirtual / 1024) - math.floor(freeVirtual / 1024)  .." KB")
		--graphics.drawFont(FontSelect, virtualUsedTextPosition + fpsTextSize, math.floor(totalVirtual) - math.floor(freeVirtual) .." B")
		graphics.setColorTint(TextColour1Default)  
end

-------------------------------------------------------------------------------------------------- 

--************************************************************************************************ 
-- System FPS
--************************************************************************************************ 

fps = 0
fpsCount = 0
fpsInterval = 0



function sysinfo.getFps(FontSelect, FPSPositionX, FPSPositionY, FPSSpacing, dt)

fpsCount = fpsCount + 1
		fpsInterval = fpsInterval + dt
		
		if fpsInterval > 1.0 then
			fps = fpsCount
            fpsCount = 0
            fpsInterval = 0
        end
		
		local fpsTextPosition = vector3.new(renderGetWidth() - FPSPositionX, renderGetHeight() - FPSPositionY, 0)
		graphics.setColorTint(TextColour1) -- tint green

		local fw, fh = graphics.measureFont(FontSelect, "FPS:")
		local fpsTextSize = vector3.new(fw - FPSSpacing, 0, 0)

		graphics.drawFont(FontSelect, fpsTextPosition, "FPS:")
		graphics.setColorTint(TextColour2) 
		graphics.drawFont(FontSelect, fpsTextPosition + fpsTextSize, tostring(fps))
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