--[[
$module timer

timer module
--]]

local timer = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local timerTable = {

	__metatable = 'timer.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

}

function timer.new(interval, enabled, repeated, onElapsed)
	
	this = {}

	function onRefresh(dt)
		if not this.triggered then
			if this.elapsedTime > this.interval then
				if type(this.onElapsed) == "function" then
					this.onElapsed()
				end
				if repeated then
					this.elapsedTime = 0
				else
					this.triggered = true
				end
			elseif this.enabled then
				this.elapsedTime = this.elapsedTime + (dt * 1000)
			end
		end
	end

	this.interval = interval or 0
	this.enabled = enabled or false
	this.repeated = repeated or false
	this.onElapsed = onElapsed	
	this.elapsedTime = 0
	this.triggered = false
	
	systemRegisterCallback(onRefresh)

	return setmetatable(this, timerTable)

end

function timer.setOnElapsed(onElapsed)
	if type(onElapsed) == "function" then
		this.onElapsed = onElapsed
	end
end

function timer.setInterval(interval)
	this.interval = interval or 0
end

function timer.setRepeated(repeated)
	this.repeated = repeated or false
end

function timer.start()
	this.enabled = true
end

function timer.stop()
	this.enabled = false
end

function timer.reset()
	this.elapsedTime = 0
	this.triggered = false
end

return timer