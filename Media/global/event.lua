--[[
$module event

event module
--]]

-- Example usage:

-- -- create generic event handling function for a Cat class
-- function Cat:OnEvent(eventname, ...)
-- 	if eventname == "MOUSE_SPAWNED" and not self.chasing then
-- 		local mouse = ...
-- 		self:ChaseMouse(mouse)
-- 	end
-- end

-- -- use a regular function to process the event as well
-- function PrintWhenMouseSpawns(eventname, mouse)
-- 	print("MOUSE SPAWNED! "..tostring(mouse))
-- end

-- function Mouse:initialize(x, y)
-- 	self:Spawn(x, y)
-- 	Event.Trigger("MOUSE_SPAWNED", self) -- trigger the event and pass any arguments you want
-- end

-- -- register the Cat class and function we created with the MOUSE_SPAWNED event
-- Event.Register(Cat, "MOUSE_SPAWNED")
-- Event.Register(PrintWhenMouseSpawns, "MOUSE_SPAWNED")

-- An 'object' (the thing you register) can be either a function or a table.
-- If it is a table, then when the event it's associated with is triggered, it will
-- first look for a function of the same name as the event in the table, and if it
-- doesn't find one it will fall back to the table's "OnEvent" method, if it exists.

local event = {}

local events = {}

function event.trigger(eventname, ...)

	local eventlist = events[eventname] or {}
	
	for obj, callback in pairs(eventlist) do
		if type(obj) == "function" then
			obj(eventname, ...)
		elseif obj[eventname] then
			obj[eventname](obj, eventname, ...)
		elseif obj.OnEvent then
			obj:OnEvent(eventname, ...)
		end
	end

end

function event.register(obj, ...)

	if not obj then
		return error("event.register error: nil callback object", 2)
	end
	
	local eventnames = type(...) == "table" and ... or {...}
	
	if #eventnames == 0 then
		return error("event.register error: nil event name", 2)
	end
	
	for i, eventname in ipairs(eventnames) do
		if type(eventname) == "string" then
			local eventlist = events[eventname]
			
			if not eventlist then
				eventlist = {}
				setmetatable(eventlist, {__mode="k"}) -- weak keys so garbage collector can clean up properly
			end
			
			if type(obj) ~= "function" and type(obj) ~= "table" then
				return error("event.register error: callback object is not a table or function", 2)
			end
			
			eventlist[obj] = true
			events[eventname] = eventlist
		end
	end
	
	return obj

end

function event.unregister(obj, ...)

	if not obj then
		return error("event.unregister error: nil callback object", 2)
	end
	
	local eventnames = type(...) == "table" and ... or {...}
	
	if #eventnames == 0 then
		return error("event.unregister error: nil event name", 2)
	end
	
	for i, eventname in ipairs(eventnames) do
		local eventlist = events[eventname]
		if eventlist and eventlist[obj] then
			eventlist[obj] = nil
		end
	end

end

function event.lookUp(obj)

	if type(obj) ~= "table" and type(obj) ~= "function" then
		return error("event.lookUp error: callback object is not a table or function", 2)
	end

	local registeredevents = {}

	for eventname, eventlist in pairs(events) do
		for _obj, callback in pairs(eventlist) do
			if obj == _obj then
				table.insert(registeredevents, eventname)
				break
			end
		end
	end

	return registeredevents	

end

return event