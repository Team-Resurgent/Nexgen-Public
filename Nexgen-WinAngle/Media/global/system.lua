--[[
$module system

system module
--]]

local system = {}

--[[
% debugBreak()

Used to aid debugging.
--]]

function system.debugBreak()
	return systemDebugBreak()
end

--[[
% getTotalVirtualMemory()

Used to get amount of virtual memory that is used.

: (integer) Total amount of virtual memory in use.
--]]
function system.getTotalVirtualMemory()
	return systemGetTotalVirtualMemory()
end

--[[
% getFreeVirtualMemory()

Used to get amount of virtual memory that is free.

: (integer) Total amount of virtual memory free.
--]]
function system.getFreeVirtualMemory()
	return systemGetFreeVirtualMemory()
end

--[[
% getTotalPhysicalMemory()

Used to get amount of physical memory that is used.

: (integer) Total amount of physical memory in use.
--]]
function system.getTotalPhysicalMemory()
	return systemGetTotalPhysicalMemory()
end

--[[
% getFreePhysicalMemory()

Used to get amount of physical memory that is free.

: (integer) Total amount of physical memory free.
--]]
function system.getFreePhysicalMemory()
	return systemGetFreePhysicalMemory()
end

--[[
% refreshDrives()

Used to get refresh mounted drives.

: (boolean) Whether or not the operation succeeded
--]]
function system.refreshDrives()
	return systemRefreshDrives()
end

--[[
% getDrives()

Used to get an array of mounted drives.

: (stringArray) Collection of drives
--]]
function system.getDrives()
	return systemGetDrives()
end

--[[
% getFiles(path)

Used to get an array of files in a given path.

@ path (string) path to search

: (stringArray) Collection of files
--]]
function system.getFiles(path)
	return systemGetFiles(path)
end

--[[
% getDirectories(path)

Used to get an array of directories in a given path.

@ path (string) path to search

: (stringArray) Collection of directories
--]]
function system.getDirectories(path)
	return systemGetDirectories(path)
end

--[[
% launch(path)

Used to launch a executable from given path.

@ path (string) path of executable to load

: (boolean) Whether or not the operation succeeded
--]]
function system.launch(path)
	return systemLaunch(path)
end

--[[
% registerCallback(callbackFunction)

Used to register a callback fnction.

@ callbackFunction (function) function to be called on refresh

: (boolean) Whether or not the operation succeeded
--]]
function system.registerCallback(callbackFunction)
	return systemRegisterCallback(callbackFunction)
end

--[[
% unregisterCallback(callbackFunction)

Used to unregister a callback fnction.

@ unregisterCallback (function) function to be removed on refresh

: (boolean) Whether or not the operation succeeded
--]]
function system.unregisterCallback(callbackFunction)
	return systemUnregisterCallback(callbackFunction)
end

return system